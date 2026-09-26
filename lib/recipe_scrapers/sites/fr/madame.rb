# frozen_string_literal: true

module RecipeScrapers
  module Sites
    module Fr
      class MadameLeFigaro < Scraper
        class SchemaReader < Sources::SchemaOrg
          private

          def step_steps(value)
            merged = merged_step(value)
            return [merged] if merged

            super
          end

          def merged_step(value)
            return nil unless value["name"].is_a?(String) && value["text"].is_a?(String)

            heading = step_heading(value)
            text = Text.normalize(value["text"])
            return nil if heading.nil? || text.nil?

            "#{heading}: #{text}"
          end
        end

        host "madame.lefigaro.fr"
        schema_reader SchemaReader
      end
    end
  end
end

RecipeScrapers::Registry.register_class(RecipeScrapers::Sites::Fr::MadameLeFigaro)
