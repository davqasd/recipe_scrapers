# frozen_string_literal: true

module RecipeScrapers
  module Sources
    class OpenGraph
      def initialize(document)
        @document = document
      end

      def title
        property("og:title") || Text.normalize(@document.at_css("title")&.text)
      end

      def image = property("og:image")
      def description = property("og:description")
      def site_name = property("og:site_name")

      private

      def property(name)
        tag = @document.at_css(%(meta[property="#{name}"][content]))
        tag && Text.normalize(tag["content"])
      end
    end
  end
end
