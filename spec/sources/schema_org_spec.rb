# frozen_string_literal: true

RSpec.describe RecipeScrapers::Sources::SchemaOrg do
  def build(recipe_json, extra: [])
    nodes = ([recipe_json] + extra).join(",")
    document = Nokogiri::HTML5(<<~HTML)
      <html><head><script type="application/ld+json">
      {"@context":"https://schema.org","@graph":[#{nodes}]}
      </script></head><body></body></html>
    HTML
    described_class.new(RecipeScrapers::Sources::JsonLd.new(document))
  end

  let(:full) do
    build(<<~JSON)
      {"@type":"Recipe",
       "name":" Kale  Salad ",
       "description":"A salad",
       "recipeIngredient":["400 g kale","1 clove garlic"],
       "recipeInstructions":[{"@type":"HowToStep","text":"Wash the kale"},
                             {"@type":"HowToStep","text":"Toss"}],
       "recipeYield":"4 servings",
       "totalTime":"PT30M","prepTime":"PT10M","cookTime":"PT20M",
       "recipeCategory":"Side",
       "recipeCuisine":"Australian",
       "cookingMethod":"Tossing",
       "keywords":"kale, salad",
       "inLanguage":"en",
       "image":{"@type":"ImageObject","url":"https://example.com/a.jpg"},
       "nutrition":{"@type":"NutritionInformation","calories":"120 kcal"},
       "suitableForDiet":"https://schema.org/VegetarianDiet"}
    JSON
  end

  it "normalizes the title" do
    expect(full.title).to eq("Kale Salad")
  end

  it "reads the ingredients as strings" do
    expect(full.ingredients).to eq(["400 g kale", "1 clove garlic"])
  end

  it "reads HowToStep instructions into a list" do
    expect(full.instructions_list).to eq(["Wash the kale", "Toss"])
  end

  it "joins the instructions with newlines" do
    expect(full.instructions).to eq("Wash the kale\nToss")
  end

  it "converts durations to minutes" do
    expect([full.total_time, full.prep_time, full.cook_time]).to eq([30, 10, 20])
  end

  it "normalizes the yield" do
    expect(full.yields).to eq("4 servings")
  end

  it "splits comma separated keywords" do
    expect(full.keywords).to eq(%w[kale salad])
  end

  it "reads the image url out of an ImageObject" do
    expect(full.image).to eq("https://example.com/a.jpg")
  end

  it "reads the nutrition hash without the schema type" do
    expect(full.nutrients).to eq({ "calories" => "120 kcal" })
  end

  it "normalizes every nutrient value to text" do
    scraper = build(<<~JSON)
      {"@type":"Recipe","nutrition":{"calories":" 427  Calories","fatContent":11.7,
       "proteinContent":"27g protein. <b>Diabetic Exchanges</b>"}}
    JSON
    expect(scraper.nutrients).to eq(
      { "calories" => "427 Calories", "fatContent" => "11.7", "proteinContent" => "27g protein. Diabetic Exchanges" }
    )
  end

  it "drops nutrients with no value or no name" do
    scraper = build('{"@type":"Recipe","nutrition":{"calories":"90","sugarContent":"","servingSize":null,"":""}}')
    expect(scraper.nutrients).to eq({ "calories" => "90" })
  end

  it "has no nutrients when every value is blank" do
    scraper = build('{"@type":"Recipe","nutrition":{"@type":"NutritionInformation","calories":""}}')
    expect(scraper.nutrients).to be_nil
  end

  it "reads the nutrition hash out of a list" do
    scraper = build('{"@type":"Recipe","nutrition":[{"@type":"NutritionInformation","calories":"90"}]}')
    expect(scraper.nutrients).to eq({ "calories" => "90" })
  end

  it "reads the diet as a bare name" do
    expect(full.dietary_restrictions).to eq(["VegetarianDiet"])
  end

  it "takes the first image when the page gives a list" do
    scraper = build('{"@type":"Recipe","name":"X","image":["https://example.com/1.jpg","https://example.com/2.jpg"]}')
    expect(scraper.image).to eq("https://example.com/1.jpg")
  end

  it "takes the first url when an ImageObject lists several" do
    scraper = build('{"@type":"Recipe","image":{"@type":"ImageObject","url":["/1.jpg","/2.jpg"]}}')
    expect(scraper.image).to eq("/1.jpg")
  end

  it "splits comma separated keywords inside a list" do
    scraper = build('{"@type":"Recipe","keywords":["pumpkin roll, swiss roll, ","dessert"]}')
    expect(scraper.keywords).to eq(["pumpkin roll", "swiss roll", "dessert"])
  end

  it "drops keywords that carry a facet name" do
    scraper = build('{"@type":"Recipe","keywords":["content-type: Recipe","locale: US","OCCASION: autumn","brie"]}')
    expect(scraper.keywords).to eq(["brie"])
  end

  it "reads plain string instructions split on newlines" do
    scraper = build('{"@type":"Recipe","name":"X","recipeInstructions":"Wash\\nToss"}')
    expect(scraper.instructions_list).to eq(%w[Wash Toss])
  end

  it "reads instructions nested in a HowToSection" do
    scraper = build(<<~JSON)
      {"@type":"Recipe","name":"X","recipeInstructions":[
        {"@type":"HowToSection","itemListElement":[
          {"@type":"HowToStep","text":"Wash"},{"@type":"HowToStep","text":"Toss"}]}]}
    JSON
    expect(scraper.instructions_list).to eq(%w[Wash Toss])
  end

  it "reads the name of a HowToSection as a heading line" do
    scraper = build(<<~JSON)
      {"@type":"Recipe","name":"X","recipeInstructions":[
        {"@type":"HowToSection","name":"Preparation","itemListElement":[
          {"@type":"HowToStep","text":"Wash"},{"@type":"HowToStep","text":"Toss"}]}]}
    JSON
    expect(scraper.instructions_list).to eq(%w[Preparation Wash Toss])
  end

  it "reads the name of a HowToStep as its own line when the text starts elsewhere" do
    scraper = build(<<~JSON)
      {"@type":"Recipe","name":"X","recipeInstructions":[
        {"@type":"HowToStep","name":"Prepare the kale","text":"Wash it well"}]}
    JSON
    expect(scraper.instructions_list).to eq(["Prepare the kale", "Wash it well"])
  end

  it "drops the name of a HowToStep the text already opens with" do
    scraper = build(<<~JSON)
      {"@type":"Recipe","name":"X","recipeInstructions":[
        {"@type":"HowToStep","name":"Wash it.","text":"Wash it well"}]}
    JSON
    expect(scraper.instructions_list).to eq(["Wash it well"])
  end

  it "names every author the page lists" do
    scraper = build('{"@type":"Recipe","author":[{"@type":"Person","name":"Holly"},{"name":"Natalie"}]}')
    expect(scraper.author).to eq("Holly, Natalie")
  end

  it "resolves an author given by reference" do
    scraper = build(
      '{"@type":"Recipe","name":"X","author":{"@id":"#nagi"}}',
      extra: ['{"@type":"Person","@id":"#nagi","name":"Nagi"}']
    )
    expect(scraper.author).to eq("Nagi")
  end

  it "resolves a rating given by reference" do
    scraper = build(
      '{"@type":"Recipe","name":"X","aggregateRating":{"@id":"#r"}}',
      extra: ['{"@type":"AggregateRating","@id":"#r","ratingValue":"4.5","ratingCount":12}']
    )
    expect([scraper.ratings, scraper.ratings_count]).to eq([4.5, 12])
  end

  it "has no rating when the page lists none" do
    scraper = build('{"@type":"Recipe","aggregateRating":[]}')
    expect([scraper.ratings, scraper.ratings_count]).to eq([nil, nil])
  end

  it "reads a rating out of a list" do
    scraper = build('{"@type":"Recipe","aggregateRating":[{"ratingValue":"4,7","ratingCount":"3"}]}')
    expect([scraper.ratings, scraper.ratings_count]).to eq([4.7, 3])
  end

  it "has no rating when nobody has rated the recipe" do
    scraper = build('{"@type":"Recipe","aggregateRating":{"reviewCount":0,"ratingValue":0,"worstRating":1}}')
    expect([scraper.ratings, scraper.ratings_count]).to eq([nil, nil])
  end

  it "counts the reviews when the page gives no rating count" do
    scraper = build('{"@type":"Recipe","aggregateRating":{"ratingValue":"4.5","reviewCount":"8"}}')
    expect(scraper.ratings_count).to eq(8)
  end

  it "returns nil for a field the page omits" do
    scraper = build('{"@type":"Recipe","name":"X"}')
    expect(scraper.cuisine).to be_nil
  end

  it "returns nil everywhere when there is no recipe" do
    document = Nokogiri::HTML5("<html><body></body></html>")
    scraper = described_class.new(RecipeScrapers::Sources::JsonLd.new(document))
    expect(scraper.title).to be_nil
  end
end
