# frozen_string_literal: true

require "nokogiri"

module RecipeScrapers
  module Text
    MARKUP = /[&<]/
    WHITESPACE = /[[:space:]]+/
    DROPPED = ["​", "‎", "‏"].freeze
    TEXTLESS = %w[script style template noscript].freeze

    class << self
      def content(node)
        return nil if node.nil? || TEXTLESS.include?(node.name)
        return node.text if node.text? || node.cdata?
        return nil unless node.element?

        node.children.filter_map { |child| content(child) }.join
      end

      def normalize(value)
        return nil if value.nil?

        cleaned = collapse_parentheses(strip_markup(value.to_s))
        cleaned = DROPPED.reduce(cleaned) { |text, dropped| text.delete(dropped) }
        cleaned = cleaned.gsub(WHITESPACE, " ").strip
        cleaned.empty? ? nil : cleaned
      end

      def recode(html, encoding_name)
        return html if encoding_name.nil?
        return html if html.encoding == ::Encoding::UTF_8 && html.valid_encoding?

        bytes = html.dup.force_encoding(encoding_name)
        bytes.encode(::Encoding::UTF_8, invalid: :replace, undef: :replace)
      rescue ArgumentError
        html
      end

      private

      def strip_markup(value)
        previous = nil
        current = value
        while previous != current && current.match?(MARKUP)
          previous = current
          current = Nokogiri::HTML5.fragment(current).text
        end
        current
      end

      def collapse_parentheses(value)
        return value unless value.include?("((") && value.include?("))")

        value.gsub("((", "(").gsub("))", ")")
      end
    end
  end
end
