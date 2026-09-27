# frozen_string_literal: true

module RecipeScrapers
  module Sources
    class Declared
      LIST_MARKER = /\A(?:[-–*•]|\d+[.)])\s+/

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
        line = Text.normalize(Text.content(node))
        line && Text.normalize(line.sub(LIST_MARKER, ""))
      end
    end
  end
end
