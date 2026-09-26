# frozen_string_literal: true

module RecipeScrapers
  module Parsers
    # The bundled parser of ingredient lines. It reads the amount, the unit and the name with the
    # words of the recipe language. Put it after your own parser to keep it as the fallback.
    #
    # @example
    #   RecipeScrapers::Parsers::Ingredients.call("1 1/2 cups flour", language: "en").to_h
    #   # => { amount: 1.5, unit: "cups", name: "flour" }
    class Ingredients
      QUANTITY = Quantity::QUANTITY
      SUM = Quantity::SUM
      UPPER_BOUND = /(?:(?:\s*[-–—]\s*|\s+(?:to|or|o|a|à|bis|до|или)\s+)#{QUANTITY})?/o
      WORD_END = /(?![\p{L}\d'’-])/
      PREPARATION = /\p{Ll}[\p{L}-]*(?:\s+\p{Ll}[\p{L}-]*)?/
      CONNECTOR = /\A(?:(?:of|de|di)\s+)?(?:an?\s+)?/i
      PARENTHESES = /\([^()]*\)/
      SPACE_BEFORE_PUNCTUATION = /\s+([,.;:])/
      EDGE_PUNCTUATION = /\A[\s,;:.]+|[\s,;:]+\z/
      BULLET = /\A[♥♡＊*•·]+\s*/
      ARTICLES = %w[a an].freeze
      LOCK = Mutex.new
      private_constant :QUANTITY, :SUM, :UPPER_BOUND, :WORD_END, :PREPARATION, :CONNECTOR, :PARENTHESES,
                       :SPACE_BEFORE_PUNCTUATION, :EDGE_PUNCTUATION, :BULLET, :ARTICLES, :LOCK

      class << self
        # @param line [String] one ingredient line
        # @param language [String, nil] the language tag of the recipe
        # @return [Models::Ingredient]
        def call(line, language: nil)
          for_language(language).call(line)
        end

        # @param language [String, nil]
        # @return [Ingredients] a parser for the vocabulary of the language, built once per vocabulary
        #
        # @api private
        def for_language(language)
          names = Vocabulary.names_for(language)
          LOCK.synchronize { instances[names] ||= new(Vocabulary.combine(names)) }
        end

        private

        def instances
          @instances ||= {}
        end
      end

      # @return [Vocabulary] the words this parser reads
      #
      # @api private
      attr_reader :vocabulary

      # @param vocabulary [Vocabulary]
      #
      # @api private
      def initialize(vocabulary)
        @vocabulary = vocabulary
        @patterns = build_patterns
      end

      # @param line [String] one ingredient line
      # @return [Models::Ingredient]
      #
      # @api private
      def call(line, **)
        parsed = parse_text(without_parentheses(line.to_s))
        return parsed unless parsed.name.nil? && line.to_s.include?("(")

        parse_text(tidy(line.to_s.gsub(PARENTHESES, " ").delete("()")))
      end

      private

      def build_patterns
        [
          /\A#{qualifier}#{measure}\s*(?<ingredient>.*)\z/,
          /\A(?:#{adjective})?(?<unit>#{pinch_word})\s+(?:of\s+)?(?<ingredient>.+)\z/i,
          /\A(?<note>#{PREPARATION})\s+(?<amount>#{SUM})#{UPPER_BOUND}\s*#{unit}\s+(?<ingredient>.+)\z/,
          /\A(?<ingredient>[^:]+?)\s*:\s*#{qualifier}#{numeric_measure}(?:\.?\s+(?<note>\D+?))?\.?\z/,
          /\A(?<ingredient>.+?)(?:\s*[,\-–—]\s*|\s+)#{qualifier}#{numeric_measure}\z/,
          /\A(?<ingredient>.+?)\s*[:,\-–—]\s*(?<unit>#{pinch_word})\z/i,
          /\A(?<ingredient>.+?)\s+(?<unit>#{unit_word})\s*(?<amount>#{QUANTITY})\z/
        ].freeze
      end

      def words(list) = Vocabulary.alternation(list)
      def unit_word = @unit_word ||= /(?:#{words(vocabulary.units)})/i
      def pinch_word = @pinch_word ||= /(?:#{words(vocabulary.pinches)})#{WORD_END}/i
      def adjective = @adjective ||= /(?:#{words(vocabulary.sizes)})\s+/i
      def qualifier = @qualifier ||= /(?:(?:#{words(vocabulary.qualifiers)})\s+|~\s*)*/i
      def size = @size ||= /#{QUANTITY}#{UPPER_BOUND}\s*-?\s*#{unit_word}\.?(?:-|\s)\s*/
      def unit_lead = @unit_lead ||= /(?:#{size})?(?:#{adjective})?/
      def alternative = @alternative ||= %r{(?:\s*[/+]\s*|\s+)#{QUANTITY}#{UPPER_BOUND}\s*#{unit_word}\.?#{WORD_END}}
      def unit = @unit ||= /#{unit_lead}(?<unit>#{unit_word})\.?#{WORD_END}(?:#{alternative})*/
      def counted_word = /(?:#{words(vocabulary.number_words.keys - ARTICLES)})(?=\s)/i
      def article = /an?(?=\s+#{unit_lead}#{unit_word}#{WORD_END})/i
      def numeric_measure = /(?<amount>#{SUM})#{UPPER_BOUND}\s*(?:#{unit})?/
      def measure = /(?<amount>#{SUM}|#{counted_word}|#{article})#{UPPER_BOUND}\s*(?:#{unit})?/

      def parse_text(text)
        @patterns.each do |pattern|
          match = text.match(pattern)
          return measured(match) if match && !match[:ingredient].start_with?("%")
        end
        row(nil, nil, text)
      end

      def measured(match)
        names = match.names
        unit = match[:unit]&.squeeze(" ")
        ingredient = match[:ingredient]
        ingredient = ingredient.sub(CONNECTOR, "") if match.begin(:ingredient).positive?
        ingredient = [ingredient, match[:note]].compact.join(", ") if names.include?("note")
        row(names.include?("amount") ? amount(match[:amount]) : 1.0, unit, ingredient)
      end

      def row(amount, unit, ingredient)
        cleaned = ingredient.gsub(EDGE_PUNCTUATION, "")
        Models::Ingredient.new(amount: amount, unit: unit, name: cleaned.empty? ? nil : cleaned)
      end

      def amount(quantity)
        word = vocabulary.number_words[quantity.downcase]
        return word.to_f if word

        Quantity.value(quantity)
      end

      def without_parentheses(text)
        reduced = text.gsub(PARENTHESES, " ")
        return tidy(reduced) if reduced == text

        without_parentheses(reduced)
      end

      def tidy(text)
        text.gsub(SPACE_BEFORE_PUNCTUATION, "\\1").squeeze(" ").strip.sub(BULLET, "")
      end
    end
  end
end
