# frozen_string_literal: true

RSpec.describe "RecipeScrapers.parse" do
  around do |example|
    saved = RecipeScrapers::Registry.snapshot
    RecipeScrapers::Registry.clear!
    example.run
    RecipeScrapers::Registry.restore(saved)
  end

  let(:schema_page) do
    <<~HTML
      <html><head><script type="application/ld+json">
      {"@context":"https://schema.org","@type":"Recipe","name":"Borscht",
       "recipeIngredient":["1 beet"],"recipeYield":"6 servings"}
      </script></head><body><h1>Wrong title</h1>
      <span class="serves">4</span></body></html>
    HTML
  end

  it "reads a registered site with no declaration straight from json-ld" do
    RecipeScrapers.register("example.com")
    recipe = RecipeScrapers.parse(schema_page, url: "https://example.com/r/1")
    expect([recipe.title, recipe.ingredients, recipe.yields]).
      to eq(["Borscht", ["1 beet"], "6 servings"])
  end

  it "lets a declared field beat json-ld for that field only" do
    RecipeScrapers.register("example.com") { yields ".serves" }
    recipe = RecipeScrapers.parse(schema_page, url: "https://example.com/r/1")
    expect([recipe.title, recipe.yields]).to eq(["Borscht", "4 servings"])
  end

  it "reads a site with no structured data from its declaration", :aggregate_failures do
    html = <<~HTML
      <html><body><h1>Omelette</h1>
      <table id="ingridients">
        <tr class="ingr_tr_0"><td>Eggs</td><td>5</td></tr>
        <tr class="ingr_tr_1"><td>Milk</td><td>300 ml</td></tr>
      </table></body></html>
    HTML
    RecipeScrapers.register("example.com") do
      title "h1"
      ingredients rows: "#ingridients tr.ingr_tr_0, #ingridients tr.ingr_tr_1"
    end
    recipe = RecipeScrapers.parse(html, url: "https://example.com/r/1")
    expect(recipe.title).to eq("Omelette")
    expect(recipe.ingredients).to eq(["Eggs 5", "Milk 300 ml"])
  end

  it "falls through to opengraph for a title nothing else gives" do
    html = <<~HTML
      <html><head><meta property="og:title" content="Kasha"></head>
      <body><li>1 cup buckwheat</li></body></html>
    HTML
    RecipeScrapers.register("example.com") { ingredients rows: "li" }
    recipe = RecipeScrapers.parse(html, url: "https://example.com/r/1")
    expect(recipe.title).to eq("Kasha")
  end

  it "refuses an unregistered host by default" do
    expect { RecipeScrapers.parse(schema_page, url: "https://nowhere.example/r/1") }.
      to raise_error(RecipeScrapers::UnsupportedSite, /nowhere.example/)
  end

  it "reads an unregistered host when supported_only is off" do
    recipe = RecipeScrapers.parse(
      schema_page,
      url: "https://nowhere.example/r/1",
      supported_only: false
    )
    expect(recipe.title).to eq("Borscht")
  end

  it "raises when the page carries no recipe at all" do
    expect do
      RecipeScrapers.parse(
        "<html><body>nothing</body></html>",
        url: "https://nowhere.example/r/1",
        supported_only: false
      )
    end.to raise_error(RecipeScrapers::RecipeNotFound)
  end

  it "uses the declared encoding when the html arrives as bytes" do
    html = "<html><body><h1>Омлет</h1><li>Яйца</li></body></html>".encode("windows-1251").b
    RecipeScrapers.register("example.com") do
      encoding "windows-1251"
      title "h1"
      ingredients rows: "li"
    end
    recipe = RecipeScrapers.parse(html, url: "https://example.com/r/1")
    expect(recipe.title).to eq("Омлет")
  end

  it "groups ingredients when the site declares where the headings are" do
    html = <<~HTML
      <html><body><h1>Salad</h1>
      <h3 class="head">Base</h3><li class="item">400 g kale</li>
      <h3 class="head">Dressing</h3><li class="item">2 tbsp oil</li></body></html>
    HTML
    RecipeScrapers.register("example.com") do
      title "h1"
      ingredients rows: "li.item"
      ingredient_groups heading: "h3.head", item: "li.item"
    end
    recipe = RecipeScrapers.parse(html, url: "https://example.com/r/1")
    expect(recipe.ingredient_groups.map(&:purpose)).to eq(%w[Base Dressing])
  end

  it "uses a registered class when one claims the host" do
    klass = Class.new(RecipeScrapers::Scraper) do
      host "example.com"
      def title = "From the class"
      def ingredients = ["1 beet"]
    end
    RecipeScrapers::Registry.register_class(klass)
    recipe = RecipeScrapers.parse(schema_page, url: "https://example.com/r/1")
    expect(recipe.title).to eq("From the class")
  end
end
