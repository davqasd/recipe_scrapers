# frozen_string_literal: true

require "faraday"
require "ipaddr"
require "resolv"

module RecipeScrapers
  module Http
    # Refuses a request whose host resolves to no address, or to a loopback, private, link-local,
    # multicast, CGNAT or unspecified one, so a URL from a user cannot reach the internal network. It
    # pins the addresses it checked for {Adapter}, which closes the window where DNS could answer
    # differently the second time. Registered as `:recipe_scrapers_address_guard`.
    class AddressGuard < Faraday::Middleware
      CGNAT = IPAddr.new("100.64.0.0/10")
      MULTICAST_V4 = IPAddr.new("224.0.0.0/4")
      MULTICAST_V6 = IPAddr.new("ff00::/8")
      UNSPECIFIED = [IPAddr.new("0.0.0.0"), IPAddr.new("::")].freeze
      private_constant :CGNAT, :MULTICAST_V4, :MULTICAST_V6, :UNSPECIFIED

      # The key of the request context where the guard pins the addresses it checked.
      #
      # @api private
      PIN_KEY = :recipe_scrapers_resolve

      # @param app [#call]
      # @param allow_private [Boolean] let every address through, for development
      # @param resolver [#call, nil] takes a host and returns IPAddr objects, the system resolver when nil
      def initialize(app, allow_private: false, resolver: nil)
        super(app)
        @allow_private = allow_private
        @resolver = resolver || method(:resolve)
      end

      # @param env [Faraday::Env]
      # @raise [BlockedAddress]
      #
      # @api private
      def on_request(env)
        host = env.url.host.to_s
        addresses = @resolver.call(host)
        raise BlockedAddress, "#{host} did not resolve to any address" if addresses.empty?

        addresses.each { |address| check(host, address) }
        pin(env, addresses)
      end

      private

      def check(host, address)
        return if @allow_private
        return unless blocked?(unwrap(address))

        raise BlockedAddress, "#{host} resolved to #{address}, which is not a public address"
      end

      def blocked?(address)
        return true if address.loopback? || address.private? || address.link_local?
        return true if multicast?(address) || UNSPECIFIED.include?(address)

        address.ipv4? && CGNAT.include?(address)
      end

      def multicast?(address)
        address.ipv4? ? MULTICAST_V4.include?(address) : MULTICAST_V6.include?(address)
      end

      def unwrap(address)
        address.ipv6? && address.ipv4_mapped? ? address.native : address
      end

      def pin(env, addresses)
        env.request.context = (env.request.context || {}).merge(PIN_KEY => addresses.map(&:to_s))
      end

      def resolve(host)
        Resolv.getaddresses(host).filter_map { |address| to_ip(address) }
      end

      def to_ip(address)
        IPAddr.new(address)
      rescue IPAddr::InvalidAddressError
        nil
      end
    end
  end
end

Faraday::Middleware.register_middleware(
  recipe_scrapers_address_guard: RecipeScrapers::Http::AddressGuard
)
