# frozen_string_literal: true

module RecipeScrapers
  module Sources
    class SchemaOrg
      module NutritionFacts
        class << self
          def parse(nutrition)
            return nil if nutrition.nil?

            values = nutrition.filter_map do |name, value|
              text = Text.normalize(value)
              [name, text] if text && !name.empty? && !name.start_with?("@")
            end
            values.empty? ? nil : values.to_h
          end
        end
      end
    end
  end
end
