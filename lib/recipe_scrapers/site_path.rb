# frozen_string_literal: true

module RecipeScrapers
  module SitePath
    class << self
      def for(host)
        "#{directory(host)}/#{slug(host)}"
      end

      private

      def directory(host)
        host.split(".").last
      end

      def slug(host)
        host.split(".").first.tr("-", "_")
      end
    end
  end
end
