# frozen_string_literal: true

module RecipeScrapers
  module Sources
    module IngredientGroups
      LAYOUTS = [
        { heading: ".wprm-recipe-ingredient-group-name",
          item: ".wprm-recipe-ingredient" },
        { heading: ".tasty-recipes-ingredients p strong, .tasty-recipes-ingredients h4",
          item: ".tasty-recipes-ingredients li" },
        { heading: ".mv-create-ingredients h4, .mv-create-ingredients h3:not(.mv-create-ingredients-title)",
          item: ".mv-create-ingredients li" }
      ].freeze
      SEPARATOR = /\A[^\p{L}\p{N}]*\z/
      HEADING = /\A(?<purpose>\D+?)\s*:\z/

      class << self
        def sections(lines)
          found = lines.grep_v(SEPARATOR).each_with_object([]) do |line, sections|
            purpose = line[HEADING, :purpose]
            next sections << [purpose, []] if purpose

            sections << [nil, []] if sections.empty?
            sections.last.last << line
          end
          found.reject { |_, section_lines| section_lines.empty? }
        end

        def from_sections(sections)
          sections.map { |purpose, lines| Models::IngredientGroup.new(purpose: purpose, ingredients: lines) }
        end

        def detect(document:, ingredients:)
          named = LAYOUTS.lazy.
                  map { |layout| call(document: document, ingredients: ingredients, **layout) }.
                  find { |groups| groups.any?(&:purpose) }

          named || [ungrouped(ingredients)]
        end

        def call(document:, ingredients:, heading:, item:)
          headings = document.css(heading)
          return [ungrouped(ingredients)] if headings.empty?
          return [ungrouped(ingredients)] unless document.css(item).size == ingredients.size

          build(document.css("#{heading}, #{item}"), headings.to_a, ingredients)
        end

        private

        def ungrouped(ingredients)
          Models::IngredientGroup.new(purpose: nil, ingredients: ingredients)
        end

        def build(nodes, headings, ingredients)
          remaining = ingredients.dup
          sections = []

          nodes.each { |node| absorb(sections, node, headings, remaining) }

          sections.reject { |_, lines| lines.empty? }.
            map { |purpose, lines| Models::IngredientGroup.new(purpose: purpose, ingredients: lines) }
        end

        def absorb(sections, node, headings, remaining)
          return sections << [Text.normalize(node.text), []] if headings.include?(node)

          sections << [nil, []] if sections.empty?
          sections.last.last << (remaining.shift || Text.normalize(node.text))
        end
      end
    end
  end
end
