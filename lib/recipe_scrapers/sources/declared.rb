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
        found = rule(field)
        return nil if found.nil? || found[:rows].nil?

        lines = @document.css(found[:rows]).flat_map { |node| row_lines(readable(node, found[:skip]), found[:split]) }
        lines.empty? ? nil : lines
      end

      def headings_among_rows
        found = rule(:ingredient_groups)
        return [] if found.nil? || found[:item]

        @document.css(found[:heading]).filter_map { |heading| Text.normalize(Text.content(heading)) }
      end

      private

      def readable(node, skipped)
        return node if skipped.nil?

        node.dup.tap { |copy| copy.css(skipped).each(&:remove) }
      end

      def row_lines(node, split)
        lines = split ? Text.lines(node) : [Text.normalize(Text.content(node))].compact
        lines.filter_map { |line| Text.normalize(line.sub(LIST_MARKER, "")) }
      end
    end
  end
end
