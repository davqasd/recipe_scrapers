# frozen_string_literal: true

module RecipeScrapers
  # Tells the gem where the recipe fields are on a site whose markup is missing or wrong. A
  # declaration is built by {RecipeScrapers.register}. Inside its block, each recipe field is a
  # method that takes a CSS selector:
  #
  # - `title "h1.recipe-title"` reads the text of the first match.
  # - `ingredients rows: "ul.ingredients li"` reads one line per match, for ingredients,
  #   instructions, keywords and equipment.
  # - `ingredient_groups heading: "h3", item: "li"` splits the ingredients under their headings.
  #
  # A declared field wins over the schema.org value. Every field left out falls back to it.
  #
  # @example
  #   RecipeScrapers.register "example.com" do
  #     title "h1.recipe-title"
  #     ingredients rows: ".ingredients li"
  #     instructions rows: ".steps li"
  #     encoding "windows-1251"
  #   end
  class Declaration
    DECLARABLE = (Scraper::CONTRACT - %i[host]).freeze
    private_constant :DECLARABLE

    # @return [String] the host the declaration was registered for
    attr_reader :host

    # @return [String, nil] the encoding the site sends without saying so, set with {#encoding}
    attr_reader :encoding_name

    # @param host [String]
    # @yield the declaration body, evaluated on the new declaration
    # @return [Declaration]
    def self.build(host, &block)
      new(host).tap { |declaration| declaration.instance_eval(&block) if block }
    end

    def initialize(host)
      @host = host
      @rules = {}
      @parsers = {}
      @encoding_name = nil
    end

    # @param field [Symbol] a field of {Scraper::CONTRACT}
    # @return [Hash, nil] what the declaration says about the field: `{selector:}`, `{rows:}`, or
    #   `{heading:, item:}` for ingredient groups
    #
    # @api private
    def rule(field)
      @rules[field]
    end

    # Declares the encoding of pages that send no charset, or the wrong one.
    #
    # @param name [String] an encoding Ruby knows, such as "windows-1251"
    def encoding(name)
      @encoding_name = name
    end

    # Sets the parsers of a field for this site, in the order they are tried.
    #
    # @param field [Symbol] :ingredients or :nutrients
    # @param parsers [Array<#call>]
    # @raise [ArgumentError] for a field that takes no parser
    def parser(field, *parsers)
      @parsers[Parsers::Chain.field!(field)] = parsers
    end

    # @param field [Symbol]
    # @return [Array<#call>, nil] the parsers this site sets for the field
    #
    # @api private
    def parsers_for(field)
      @parsers[field]
    end

    DECLARABLE.each do |field|
      define_method(field) do |selector = nil, **options|
        @rules[field] = selector ? { selector: selector } : options
      end
    end
  end
end
