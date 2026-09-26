# frozen_string_literal: true

module RecipeScrapers
  module Sites
    module Com
      class SamsungFood < Scraper
        class SchemaReader < Sources::SchemaOrg
          LIST_MARKER = /\A(?:[-*•]|\d+\.)\s+/

          def ingredients = strip_markers(super)
          def instructions_list = strip_markers(super)

          private

          def strip_markers(lines)
            lines&.map { |line| line.sub(LIST_MARKER, "") }
          end
        end

        host "app.samsungfood.com"
        schema_reader SchemaReader
      end
    end
  end
end

RecipeScrapers::Registry.register_class(RecipeScrapers::Sites::Com::SamsungFood)
