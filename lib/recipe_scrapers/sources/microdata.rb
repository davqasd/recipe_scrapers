# frozen_string_literal: true

require "nokogiri"

module RecipeScrapers
  module Sources
    class Microdata
      VALUE_ATTRIBUTES = {
        "meta" => "content",
        "audio" => "src", "embed" => "src", "iframe" => "src", "img" => "src",
        "source" => "src", "track" => "src", "video" => "src",
        "a" => "href", "area" => "href", "link" => "href",
        "object" => "data",
        "data" => "value", "meter" => "value",
        "time" => "datetime"
      }.freeze
      INLINE = %w[
        a abbr b bdi bdo big cite code data del dfn em font i img ins kbd label link mark meta
        q s samp small span strong sub sup svg time tt u var wbr
      ].freeze

      def initialize(document)
        @nodes = roots(document).flat_map { |element| flatten(item_for(element)) }
        @by_id = @nodes.select { |node| node["@id"] }.to_h { |node| [node["@id"], node] }
      end

      def recipe = @recipe ||= node_of_type("Recipe")
      def person(id) = entity(id, "Person")
      def rating(id) = entity(id, "AggregateRating")

      def website_name
        site = node_of_type("WebSite")
        site && Text.normalize(site["name"])
      end

      private

      def roots(document)
        document.css("[itemscope]").reject { |element| element.ancestors.any? { |parent| parent.key?("itemscope") } }
      end

      def flatten(node)
        [node] + node.values.flatten.grep(Hash).flat_map { |value| flatten(value) }
      end

      def node_of_type(schema_type)
        @nodes.find { |node| node["@type"].to_s.casecmp?(schema_type) }
      end

      def entity(id, schema_type)
        node = @by_id[id]
        node if node && node["@type"].to_s.casecmp?(schema_type)
      end

      def item_for(element)
        node = {}
        type = type_name(element["itemtype"])
        node["@type"] = type if type
        node["@id"] = element["itemid"] if element["itemid"]
        properties_of(element).each { |name, value| assign(node, name, value) }
        node
      end

      def type_name(itemtype)
        name = itemtype.to_s.split(/\s+/).first.to_s.split("/").last.to_s
        name.empty? ? nil : name
      end

      def properties_of(element)
        element.element_children.flat_map { |child| properties_in(child) }
      end

      def properties_in(element)
        names = element["itemprop"].to_s.split(/\s+/)
        return names.map { |name| [name, item_for(element)] } if element.key?("itemscope")

        names.map { |name| [name, value_of(element)] } + properties_of(element)
      end

      def assign(node, name, value)
        return node[name] = value unless node.key?(name)

        existing = node[name]
        node[name] = existing.is_a?(Array) ? existing + [value] : [existing, value]
      end

      def value_of(element)
        attribute = VALUE_ATTRIBUTES[element.name]
        return element[attribute] if attribute && element[attribute]
        return element["content"] if element["content"]

        lines_of(element)
      end

      def lines_of(element)
        text_of(element).split("\n").map(&:strip).reject(&:empty?).join("\n")
      end

      def text_of(element)
        element.children.filter_map { |child| text_from(child) }.join
      end

      def text_from(child)
        return nil if Text::TEXTLESS.include?(child.name)
        return child.text if child.text? || child.cdata?
        return nil unless child.element?
        return text_of(child) if INLINE.include?(child.name)

        "\n#{text_of(child)}\n"
      end
    end
  end
end
