# frozen_string_literal: true

require "json"

module RecipeScrapers
  module Sources
    class JsonLd
      SELECTOR = 'script[type="application/ld+json"]'
      ESCAPED_CONTROL = { "\b" => "\\b", "\f" => "\\f", "\n" => "\\n", "\r" => "\\r", "\t" => "\\t" }.freeze

      def initialize(document)
        @nodes = flatten(document.css(SELECTOR).flat_map { |tag| parse(tag.text) })
        @by_id = @nodes.select { |node| node["@id"] }.to_h { |node| [node["@id"], node] }
      end

      def recipe
        @recipe ||= @nodes.find { |node| type?(node, "Recipe") } || main_entity_recipe
      end

      def person(id)
        entity(id, "Person")
      end

      def rating(id)
        entity(id, "AggregateRating")
      end

      def website_name
        site = @nodes.find { |node| type?(node, "WebSite") }
        site && Text.normalize(site["name"])
      end

      private

      def entity(id, schema_type)
        node = @by_id[id]
        node if node && type?(node, schema_type)
      end

      def main_entity_recipe
        page = @nodes.find { |node| type?(node, "WebPage") && node["mainEntity"].is_a?(Hash) }
        return nil unless page

        candidate = page["mainEntity"]
        candidate if type?(candidate, "Recipe")
      end

      def parse(text)
        JSON.parse(text)
      rescue JSON::ParserError
        parse_leniently(text)
      end

      def parse_leniently(text)
        JSON.parse(escape_control_characters(text))
      rescue JSON::ParserError
        []
      end

      def escape_control_characters(text)
        inside = false
        escaped = false
        text.each_char.map do |character|
          next character.tap { escaped = false } if escaped
          next ESCAPED_CONTROL.fetch(character, " ") if inside && character.ord < 0x20

          escaped = inside && character == "\\"
          inside = !inside if character == '"'
          character
        end.join
      end

      def flatten(value)
        case value
        when Array then value.flat_map { |item| flatten(item) }
        when Hash then [value] + flatten(graph_nodes(value)) + flatten(value["mainEntity"])
        else []
        end
      end

      def graph_nodes(value)
        graph = value["@graph"]
        graph.is_a?(Hash) ? graph.values : graph
      end

      def type?(node, schema_type)
        return false unless node.is_a?(Hash)

        Array(node["@type"]).any? { |name| name.to_s.casecmp?(schema_type) }
      end
    end
  end
end
