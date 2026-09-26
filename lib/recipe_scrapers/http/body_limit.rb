# frozen_string_literal: true

require "faraday"

module RecipeScrapers
  module Http
    # Refuses a response larger than a limit, checked against Content-Length and against the body
    # itself. Registered as `:recipe_scrapers_body_limit`.
    class BodyLimit < Faraday::Middleware
      # @param app [#call]
      # @param bytes [Integer] the largest body accepted
      def initialize(app, bytes:)
        super(app)
        @bytes = bytes
      end

      # @param env [Faraday::Env]
      # @raise [ResponseTooLarge]
      #
      # @api private
      def on_complete(env)
        refuse(declared_size(env).to_i) if over_limit?(declared_size(env))

        actual = env[:body].to_s.bytesize
        refuse(actual) if actual > @bytes
      end

      private

      def declared_size(env)
        env[:response_headers].to_h.find { |name, _| name.to_s.casecmp?("content-length") }&.last
      end

      def over_limit?(declared)
        !declared.nil? && declared.to_i > @bytes
      end

      def refuse(size)
        raise ResponseTooLarge, "response of #{size} bytes exceeds the limit of #{@bytes}"
      end
    end
  end
end

Faraday::Middleware.register_middleware(recipe_scrapers_body_limit: RecipeScrapers::Http::BodyLimit)
