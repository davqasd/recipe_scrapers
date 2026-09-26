# frozen_string_literal: true

module RecipeScrapers
  # The default {Configuration#error_tracker}. It raises the error again, so a failing parser is
  # never swallowed. An application replaces it with anything that answers call(error), such as a
  # lambda that reports to its error service and returns.
  module ErrorTracker
    # @param exception [StandardError] the error a parser raised
    # @raise [StandardError] always, the error it was given
    def self.call(exception)
      raise exception
    end
  end
end
