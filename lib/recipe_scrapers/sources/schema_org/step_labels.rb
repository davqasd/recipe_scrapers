# frozen_string_literal: true

module RecipeScrapers
  module Sources
    class SchemaOrg
      module StepLabels
        class << self
          def label?(text)
            text.strip.match?(/\A(?:#{Parsers::Vocabulary.alternation(Parsers::Vocabulary.all.steps)})\s*\d+[.:]?\z/i)
          end
        end
      end
    end
  end
end
