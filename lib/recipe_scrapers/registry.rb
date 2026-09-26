# frozen_string_literal: true

require "uri"

module RecipeScrapers
  # Maps hosts to the sites the gem supports. A host maps to a {Declaration}, or to a {Scraper}
  # subclass for a site that needs code. A leading "www." is ignored.
  module Registry
    class << self
      # @return [Hash{String => Declaration, Class}] every registered host and what reads it
      #
      # @api private
      def entries
        @entries ||= {}
      end

      # Registers a site by declaration.
      #
      # @param host [String] the host of the site
      # @param also [Array<String>] more hosts read the same way, such as a regional domain
      # @yield the declaration body, evaluated on the {Declaration}
      # @return [Declaration]
      def register(host, also: [], &)
        declaration = Declaration.build(host, &)
        ([host] + Array(also)).each { |name| entries[normalize(name)] = declaration }
        declaration
      end

      # Registers a {Scraper} subclass under the host it declares with {Scraper.host}.
      #
      # @param klass [Class<Scraper>]
      # @return [Class<Scraper>] the class it was given
      def register_class(klass)
        entries[normalize(klass.declared_host)] = klass
        klass
      end

      # Finds what reads a URL.
      #
      # @param url [String]
      # @return [Declaration, Class<Scraper>, nil] nil when the host is not registered or the URL does not parse
      def for(url)
        entries[normalize(URI.parse(url).host.to_s)]
      rescue URI::Error
        nil
      end

      # @return [Array<String>] every supported host
      def hosts
        entries.keys
      end

      # Forgets every registered site.
      #
      # @return [void]
      #
      # @api private
      def clear!
        @entries = {}
      end

      # A copy of the entries, to put back with {restore}. Specs use it to register a site for one example.
      #
      # @return [Hash{String => Declaration, Class}]
      #
      # @api private
      def snapshot
        entries.dup
      end

      # Puts back entries a {snapshot} took.
      #
      # @param saved [Hash{String => Declaration, Class}]
      # @return [void]
      #
      # @api private
      def restore(saved)
        @entries = saved
      end

      private

      def normalize(host)
        host.to_s.downcase.delete_prefix("www.")
      end
    end
  end
end
