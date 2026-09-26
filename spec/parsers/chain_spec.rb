# frozen_string_literal: true

RSpec.describe "parsing a field through a chain of parsers" do
  let(:html) do
    <<~HTML
      <script type="application/ld+json">
        {"@type": "Recipe", "name": "Toast", "inLanguage": "en", "recipeIngredient": ["2 slices bread"],
         "nutrition": {"@type": "NutritionInformation", "calories": "120 kcal", "fatContent": "about four grams"}}
      </script>
    HTML
  end
  let(:shouting) { ->(text, language:) { { name: "#{text.upcase} #{language}" } } }
  let(:silent) { ->(*, **) {} }
  let(:failing) { ->(_text, language:) { raise ArgumentError, "cannot read #{language}" } }

  def recipe(klass = RecipeScrapers::Scraper, declaration: nil)
    klass.new(html, url: "https://example.com/r/1", declaration: declaration)
  end

  after { RecipeScrapers.reset_config! }

  it "parses ingredients and nutrients with the bundled parsers by default" do
    expect(recipe.parsed_ingredients).
      to eq([RecipeScrapers::Models::Ingredient.new(amount: 2.0, unit: "slices", name: "bread")])
    expect(recipe.parsed_nutrients).
      to eq([RecipeScrapers::Models::Nutrient.new(name: "calories", unit: "kcal", amount: 120.0)])
  end

  it "keeps the name a nutrient parser gives over the key the page uses" do
    RecipeScrapers.config.parsers[:nutrients] = [->(text, **) { { name: text } }]
    expect(recipe.parsed_nutrients.map(&:name)).to eq(["120 kcal", "about four grams"])
  end

  it "turns the hash a parser returns into the model of its field" do
    RecipeScrapers.config.parsers[:ingredients] = [->(*, **) { { amount: 1.0, unit: "loaf", name: "bread" } }]
    expect(recipe.parsed_ingredients).
      to eq([RecipeScrapers::Models::Ingredient.new(amount: 1.0, unit: "loaf", name: "bread")])
  end

  it "reports a hash with a key the model does not have and moves on", :aggregate_failures do
    reported = []
    RecipeScrapers.config.error_tracker = ->(error) { reported << error.class }
    RecipeScrapers.config.parsers[:ingredients].unshift(->(*, **) { { weight: 2 } })
    expect(recipe.parsed_ingredients.map(&:unit)).to eq(["slices"])
    expect(reported).to eq([ArgumentError])
  end

  it "hands the parser the recipe language" do
    RecipeScrapers.config.parsers[:ingredients] = [shouting]
    expect(recipe.parsed_ingredients.map(&:name)).to eq(["2 SLICES BREAD en"])
  end

  it "falls through to the next parser when one returns nil" do
    RecipeScrapers.config.parsers[:ingredients].unshift(silent)
    expect(recipe.parsed_ingredients.map(&:unit)).to eq(["slices"])
  end

  it "takes the parser a scraper class sets over the configured one" do
    klass = Class.new(RecipeScrapers::Scraper)
    klass.parser(:ingredients, shouting)
    expect(recipe(klass).parsed_ingredients.map(&:name)).to eq(["2 SLICES BREAD en"])
  end

  it "takes the parser a declaration sets over the configured one" do
    declaration = RecipeScrapers::Declaration.build("example.com")
    declaration.parser(:ingredients, shouting)
    expect(recipe(declaration: declaration).parsed_ingredients.map(&:name)).to eq(["2 SLICES BREAD en"])
  end

  it "reports a failing parser to the error tracker and moves on" do
    reported = []
    RecipeScrapers.config.error_tracker = ->(error) { reported << error.message }
    RecipeScrapers.config.parsers[:ingredients].unshift(failing)
    expect(recipe.parsed_ingredients.map(&:unit)).to eq(["slices"])
    expect(reported).to eq(["cannot read en"])
  end

  it "raises a failing parser through the default error tracker" do
    RecipeScrapers.config.parsers[:ingredients] = [failing]
    expect { recipe.parsed_ingredients }.to raise_error(ArgumentError, "cannot read en")
  end

  it "refuses a parser for a field that has none" do
    expect { Class.new(RecipeScrapers::Scraper).parser(:title, shouting) }.
      to raise_error(ArgumentError, /only for ingredients, nutrients/)
  end
end
