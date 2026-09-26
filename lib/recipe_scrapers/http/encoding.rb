# frozen_string_literal: true

require "faraday"

module RecipeScrapers
  module Http
    # Converts a response body to UTF-8, using the charset of the Content-Type header or of the meta
    # tag in the first 4 KiB. Invalid bytes are replaced. Registered as `:recipe_scrapers_encoding`.
    class Encoding < Faraday::Middleware
      HEADER_CHARSET = /charset=([\w-]+)/i
      META_CONTENT = /<meta[^>]+charset=["']?([\w-]+)/i
      SNIFF_BYTES = 4096
      private_constant :HEADER_CHARSET, :META_CONTENT, :SNIFF_BYTES

      # @param env [Faraday::Env]
      # @return [void]
      #
      # @api private
      def on_complete(env)
        body = env[:body]
        return if body.nil? || body.empty?

        env[:body] = to_utf8(body, charset_from(env[:response_headers]) || charset_from_meta(body))
      end

      private

      def charset_from(headers)
        header = headers.to_h.find { |name, _| name.to_s.casecmp?("content-type") }&.last
        header&.[](HEADER_CHARSET, 1)
      end

      def charset_from_meta(body)
        head = body.byteslice(0, SNIFF_BYTES).to_s.force_encoding(::Encoding::BINARY)
        head[META_CONTENT, 1]
      end

      def to_utf8(body, name)
        source = ::Encoding.find(name || "UTF-8")
        body.dup.force_encoding(source).encode(::Encoding::UTF_8, invalid: :replace, undef: :replace)
      rescue ArgumentError
        body.dup.force_encoding(::Encoding::UTF_8).scrub
      end
    end
  end
end

Faraday::Response.register_middleware(recipe_scrapers_encoding: RecipeScrapers::Http::Encoding)
