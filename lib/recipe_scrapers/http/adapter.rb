# frozen_string_literal: true

require "faraday"
require "faraday/net_http"
require_relative "address_guard"

module RecipeScrapers
  # The Faraday adapter and middleware that fetch a page safely.
  module Http
    # Faraday's net/http adapter, connecting to the addresses {AddressGuard} checked instead of
    # resolving the host again. It tries the pinned addresses in order and moves on when one does not
    # answer. The host name still goes into the TLS handshake and the Host header. Registered as
    # `:recipe_scrapers_net_http`, the default {Configuration#adapter}.
    class Adapter < Faraday::Adapter::NetHttp
      PIN_KEY = AddressGuard::PIN_KEY
      ATTEMPT_KEY = :recipe_scrapers_address
      private_constant :PIN_KEY, :ATTEMPT_KEY

      # @param env [Faraday::Env]
      # @return [Faraday::Response]
      # @raise [Faraday::ConnectionFailed] when no pinned address answers
      #
      # @api private
      def call(env)
        addresses = Array(env[:request]&.context&.dig(PIN_KEY))
        return super if addresses.empty?

        addresses.each_with_index do |address, index|
          env[ATTEMPT_KEY] = address
          return super(env)
        rescue Faraday::ConnectionFailed
          raise if index == addresses.size - 1
        end
      end

      # @param env [Faraday::Env]
      # @return [Net::HTTP] the connection, set to the pinned address unless a proxy is in use
      #
      # @api private
      def net_http_connection(env)
        super.tap do |http|
          address = env[ATTEMPT_KEY] || Array(env[:request]&.context&.dig(PIN_KEY)).first
          http.ipaddr = address if address && !http.proxy?
        end
      end
    end
  end
end

Faraday::Adapter.register_middleware(recipe_scrapers_net_http: RecipeScrapers::Http::Adapter)
