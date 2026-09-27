# frozen_string_literal: true

require "nokogiri"

module RecipeScrapers
  module Text
    MARKUP = /[&<]/
    WHITESPACE = /[[:space:]]+/
    DROPPED = ["​", "‎", "‏", "⠀"].freeze
    TEXTLESS = %w[script style template noscript].freeze
    BLOCKS = %w[
      address article aside blockquote dd details div dl dt fieldset figcaption figure footer form
      h1 h2 h3 h4 h5 h6 header hr li main nav ol p pre section summary table tbody tfoot thead tr ul
    ].freeze
    CELLS = %w[td th].freeze
    LINE_BREAK = "\n"
    CLOSING = /\A[\s.,;:!?)\]}%]/

    class << self
      def content(node)
        return nil if node.nil? || TEXTLESS.include?(node.name)
        return node.text if node.text? || node.cdata?
        return nil unless node.element?

        joined(node.children)
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

      def joined(children)
        previous = nil
        children.each_with_object(+"") do |child, text|
          part = rendered(child)
          next if part.nil?

          text << " " if touching?(previous, child, text, part)
          text << part
          previous = child
        end
      end

      def touching?(previous, current, text, part)
        previous&.element? && current.element? && !text.match?(/\s\z/) && !part.match?(CLOSING)
      end

      def rendered(node)
        inner = content(node)
        return inner unless node.element?
        return LINE_BREAK if node.name == "br"
        return "#{LINE_BREAK}#{inner}#{LINE_BREAK}" if BLOCKS.include?(node.name)
        return " #{inner} " if CELLS.include?(node.name)

        inner
      end

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
