# frozen_string_literal: true

require "yaml"

module RecipeScrapers
  module Parsers
    # The words {Ingredients} reads: units, pinch words, size adjectives, qualifiers and number words.
    # The gem bundles one vocabulary per language, plus a common one with the metric units.
    #
    # @api private
    class Vocabulary
      WORD_LISTS = %i[units pinches sizes qualifiers].freeze
      BUNDLED = File.expand_path("vocabulary/*.yml", __dir__)
      NEVER = "(?!)"
      private_constant :WORD_LISTS, :BUNDLED, :NEVER

      # @return [Array<String>] units, where a space matches any run of spaces or none
      attr_reader :units

      # @return [Array<String>] words that are a unit and an amount of one, such as "pinch"
      attr_reader :pinches

      # @return [Array<String>] adjectives that can come before a unit, such as "large"
      attr_reader :sizes

      # @return [Array<String>] words before an amount that are not part of it, such as "about"
      attr_reader :qualifiers

      # @return [Hash{String => Numeric}] amounts written as words, such as "two" => 2
      attr_reader :number_words

      class << self
        # Adds a vocabulary to the catalog, next to the bundled ones.
        #
        # @param name [Symbol]
        # @param languages [Array<String>] the language codes it is used for, such as %w[pl]
        # @param words [Hash] the word lists, as {#initialize} takes them
        # @return [Hash] the catalog entry
        def define(name, languages: [], **words)
          catalog[name] = entry(languages, words)
        end

        # @param language [String, nil] a language tag, such as "en-US"
        # @return [Array<Symbol>] the common vocabulary plus those of the language, or every vocabulary
        #   when no file declares the language
        #
        # @api private
        def names_for(language)
          code = language.to_s.downcase[/\A[a-z]+/]
          spoken = catalog.filter_map { |name, entry| name if entry[:languages].include?(code) }
          spoken.empty? ? catalog.keys.sort : [:common, *spoken.sort]
        end

        # @param language [String, nil]
        # @return [Vocabulary] the vocabularies of the language combined
        def for(language)
          combine(names_for(language))
        end

        # @param names [Array<Symbol>]
        # @return [Vocabulary] the named vocabularies added together
        #
        # @api private
        def combine(names)
          names.map { |name| catalog.fetch(name)[:vocabulary] }.reduce(:+)
        end

        # @return [Hash{Symbol => Hash}] every vocabulary by name, the bundled ones loaded on first use
        #
        # @api private
        def catalog
          @catalog ||= load_bundled
        end

        # @param words [Array<String>]
        # @return [String] a regexp alternation of the words, longest first, that never matches when empty
        #
        # @api private
        def alternation(words)
          return NEVER if words.empty?

          words.sort_by { |word| -word.length }.map { |word| Regexp.escape(word).gsub("\\ ", "\\s*") }.join("|")
        end

        private

        def load_bundled
          Dir[BUNDLED].to_h do |path|
            words = YAML.safe_load_file(path).transform_keys(&:to_sym)
            [File.basename(path, ".yml").to_sym, entry(words.delete(:languages), words)]
          end
        end

        def entry(languages, words)
          { languages: Array(languages), vocabulary: new(**words) }
        end
      end

      # @param units [Array<String>]
      # @param pinches [Array<String>]
      # @param sizes [Array<String>]
      # @param qualifiers [Array<String>]
      # @param number_words [Hash{String => Numeric}]
      def initialize(units: [], pinches: [], sizes: [], qualifiers: [], number_words: {})
        @units = units.uniq.freeze
        @pinches = pinches.uniq.freeze
        @sizes = sizes.uniq.freeze
        @qualifiers = qualifiers.uniq.freeze
        @number_words = number_words.freeze
      end

      # @param other [Vocabulary]
      # @return [Vocabulary] both word lists without repeats. The other one wins for a number word in both
      def +(other)
        lists = WORD_LISTS.to_h { |list| [list, public_send(list) + other.public_send(list)] }
        Vocabulary.new(**lists, number_words: number_words.merge(other.number_words))
      end
    end
  end
end
