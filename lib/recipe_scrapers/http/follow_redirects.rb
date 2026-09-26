# frozen_string_literal: true

require "faraday"
require "uri"

module RecipeScrapers
  module Http
    # Follows 301, 302, 303, 307 and 308 redirects as GET requests. Every hop goes through the
    # middleware after it again, so {AddressGuard} checks each host. The Authorization header is dropped
    # when a redirect leaves the origin. Registered as `:recipe_scrapers_follow_redirects`.
    class FollowRedirects < Faraday::Middleware
      REDIRECTS = [301, 302, 303, 307, 308].freeze
      CLEARED_ON_HOP = %i[status response response_headers].freeze
      UNSAFE_IN_LOCATION = %r{[^\-_.!~*'()a-zA-Z\d;/?:@&=+$,\[\]%]}
      AUTHORIZATION = "Authorization"
      private_constant :REDIRECTS, :CLEARED_ON_HOP, :UNSAFE_IN_LOCATION, :AUTHORIZATION

      # @param app [#call]
      # @param limit [Integer] redirects to follow
      def initialize(app, limit: 3)
        super(app)
        @limit = limit
      end

      # @param env [Faraday::Env]
      # @return [Faraday::Response] the response of the last hop
      # @raise [TooManyRedirects]
      #
      # @api private
      def call(env)
        follow(env, @limit)
      end

      private

      def follow(env, hops_left)
        response = @app.call(env)
        location = redirect_location(response)
        return response if location.nil?
        raise TooManyRedirects, "gave up after #{@limit} redirects at #{env.url}" if hops_left.zero?

        follow(next_hop(response.env.dup, location), hops_left - 1)
      end

      def redirect_location(response)
        return nil unless REDIRECTS.include?(response.status)

        location = response.headers["Location"].to_s.split("#").first.to_s
        location.empty? ? nil : location.gsub(UNSAFE_IN_LOCATION) { |raw| escape(raw) }
      end

      def next_hop(env, location)
        from = env.url
        env.url = from + location
        CLEARED_ON_HOP.each { |key| env.delete(key) }
        env.method = :get
        env.body = nil
        env.request_headers.delete(AUTHORIZATION) unless same_origin?(from, env.url)
        env
      end

      def same_origin?(from, to)
        [from.scheme, from.host, from.port] == [to.scheme, to.host, to.port]
      end

      def escape(raw)
        raw.unpack("C*").map { |byte| format("%%%02X", byte) }.join
      end
    end
  end
end

Faraday::Middleware.register_middleware(
  recipe_scrapers_follow_redirects: RecipeScrapers::Http::FollowRedirects
)
