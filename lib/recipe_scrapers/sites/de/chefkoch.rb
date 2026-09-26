# frozen_string_literal: true

module RecipeScrapers
  module Sites
    module De
      class Chefkoch < Scraper
        class SchemaReader < Sources::SchemaOrg
          private

          def section_steps(value) = steps_in(value["itemListElement"])

          def step_heading(value)
            return nil unless value["name"].is_a?(String)

            super
          end
        end

        host "chefkoch.de"
        schema_reader SchemaReader
      end
    end
  end
end

RecipeScrapers::Registry.register_class(RecipeScrapers::Sites::De::Chefkoch)
