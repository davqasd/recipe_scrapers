# frozen_string_literal: true

module RecipeScrapers
  module Sources
    class SchemaOrg
      module IngredientList
        PROPERTY_VALUE = "PropertyValue"

        class << self
          def parse(value)
            items = value.is_a?(String) ? Text.split_lines(value) : Array(value).flatten(1)
            lines = items.filter_map { |item| Text.normalize(line_for(item)) }
            lines.empty? ? nil : lines
          end

          private

          def line_for(item)
            return item unless item.is_a?(Hash)
            return item.to_s unless property_value?(item)

            measured(item).join(" ")
          end

          def property_value?(item)
            Array(item["@type"]).any? { |name| name.to_s.casecmp?(PROPERTY_VALUE) }
          end

          def measured(item)
            [item["value"], item["unitText"] || item["unitCode"], item["name"]].
              filter_map { |part| part.to_s unless part.to_s.empty? }
          end
        end
      end
    end
  end
end
