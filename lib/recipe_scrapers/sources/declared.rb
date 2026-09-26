# frozen_string_literal: true

module RecipeScrapers
  module Sources
    class Declared
      def initialize(document, declaration)
        @document = document
        @declaration = declaration
      end

      def rule(field)
        @declaration&.rule(field)
      end

      def text(field)
        selector = rule(field)&.fetch(:selector, nil)
        return nil if selector.nil?

        Text.normalize(Text.content(@document.at_css(selector)))
      end

      def rows(field)
        selector = rule(field)&.fetch(:rows, nil)
        return nil if selector.nil?

        lines = @document.css(selector).filter_map { |node| row_text(node) }
        lines.empty? ? nil : lines
      end

      private

      def row_text(node)
        parts = node.children.filter_map { |child| Text.normalize(Text.content(child)) }
        parts.empty? ? nil : parts.join(" ")
      end
    end
  end
end
