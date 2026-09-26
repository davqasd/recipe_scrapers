# frozen_string_literal: true

require "faraday"
require "faraday/retry"

module RecipeScrapers
  # The settings for fetching pages and parsing fields. Read them through {RecipeScrapers.config}
  # and change them with {RecipeScrapers.configure}. Changing a fetch setting rebuilds the connection
  # on its next use, unless an application assigned its own with {#connection=}.
  #
  # @!attribute [rw] user_agent
  #   @return [String] the User-Agent header every request sends
  # @!attribute [rw] timeout
  #   @return [Integer] seconds to wait for a whole response, 15 by default
  # @!attribute [rw] open_timeout
  #   @return [Integer] seconds to wait for the connection to open, 5 by default
  # @!attribute [rw] max_redirects
  #   @return [Integer] redirects to follow before {TooManyRedirects}, 3 by default
  # @!attribute [rw] max_body_bytes
  #   @return [Integer] the largest body accepted before {ResponseTooLarge}, 5 MiB by default
  # @!attribute [rw] allow_private_addresses
  #   @return [Boolean] fetch hosts that resolve to private or loopback addresses, false by default
  # @!attribute [rw] error_tracker
  #   @return [#call] gets the error of a failing parser, {ErrorTracker} by default
  # @!attribute [rw] retry_options
  #   @return [Hash] options for faraday-retry, used on timeouts, refused connections and 5xx
  # @!attribute [rw] adapter
  #   @return [Symbol, Class] the Faraday adapter, `:recipe_scrapers_net_http` ({Http::Adapter}) by default
  # @!attribute [rw] resolver
  #   @return [#call, nil] turns a host into IPAddr addresses, such as a DNS cache. Nil uses the
  #     system resolver
  class Configuration
    DEFAULT_ADAPTER = :recipe_scrapers_net_http
    RETRIED = [Faraday::TimeoutError, Faraday::ConnectionFailed, Faraday::ServerError].freeze

    SETTINGS = %i[
      user_agent timeout open_timeout max_redirects max_body_bytes
      allow_private_addresses error_tracker retry_options adapter resolver
    ].freeze

    SETTINGS.each do |setting|
      attr_reader setting

      define_method(:"#{setting}=") do |value|
        instance_variable_set(:"@#{setting}", value)
        @connection = nil unless @connection_assigned
        value
      end
    end

    DEFAULTS = {
      user_agent: "recipe_scrapers/#{VERSION} (+https://github.com/davqasd/recipe_scrapers)",
      timeout: 15,
      open_timeout: 5,
      max_redirects: 3,
      max_body_bytes: 5 * 1024 * 1024,
      allow_private_addresses: false,
      error_tracker: ErrorTracker,
      retry_options: { max: 2, interval: 1, backoff_factor: 2 },
      adapter: DEFAULT_ADAPTER,
      resolver: nil
    }.freeze

    private_constant :DEFAULT_ADAPTER, :RETRIED, :SETTINGS, :DEFAULTS

    # The parsers of every field that takes them, tried in order. A parser answers
    # `call(text, language:)` with a hash of the model's attributes, or nil for text it cannot read.
    #
    # @example Put a parser in front of the bundled one
    #   RecipeScrapers.config.parsers[:ingredients].unshift(GramsOnly)
    # @return [Hash{Symbol => Array<#call>}]
    attr_reader :parsers

    def initialize
      DEFAULTS.each { |setting, value| instance_variable_set(:"@#{setting}", value.dup) }
      @parsers = Parsers::Chain.defaults
      @connection = nil
      @connection_assigned = false
    end

    # The Faraday connection {RecipeScrapers.scrape} fetches with, built from these settings.
    #
    # @return [Faraday::Connection]
    def connection
      @connection ||= build_connection
    end

    # Replaces the connection with one the application builds. Nil goes back to the built one.
    #
    # @param value [Faraday::Connection, nil]
    def connection=(value)
      @connection_assigned = !value.nil?
      @connection = value
    end

    # Builds a new connection with the retry, redirect, address guard, body limit and encoding
    # middleware, in that order.
    #
    # @return [Faraday::Connection]
    def build_connection
      Faraday.new(headers: { "User-Agent" => user_agent }) do |faraday|
        install_middleware(faraday)
        faraday.options.timeout = timeout
        faraday.options.open_timeout = open_timeout
        faraday.adapter(adapter)
      end
    end

    private

    def install_middleware(faraday)
      faraday.request(:retry, methods: [:get], exceptions: RETRIED, **retry_options)
      faraday.use(:recipe_scrapers_follow_redirects, limit: max_redirects)
      faraday.use(:recipe_scrapers_address_guard, allow_private: allow_private_addresses, resolver: resolver)
      faraday.use(:recipe_scrapers_body_limit, bytes: max_body_bytes)
      faraday.response(:recipe_scrapers_encoding)
    end
  end
end
