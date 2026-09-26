# frozen_string_literal: true

RSpec.describe "alltommat.se" do
  subject(:recipe) { scrape_cassette("se/alltommat", url: "https://alltommat.expressen.se/recept/briochehamburgerbrod/") }

  it "reads the title" do
    expect(recipe.title).to eq("Brioche-hamburgerbröd")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2.5 dl vatten",
      "0.5 dl mjölk",
      "25 g jäst",
      "2.5 msk strösocker",
      "1 tsk salt",
      "1 ägg",
      "7.5 dl vetemjöl",
      "50 g smör",
      "1 ägg"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.5, unit: "dl", name: "vatten" },
      { amount: 0.5, unit: "dl", name: "mjölk" },
      { amount: 25.0, unit: "g", name: "jäst" },
      { amount: 2.5, unit: "msk", name: "strösocker" },
      { amount: 1.0, unit: "tsk", name: "salt" },
      { amount: 1.0, unit: nil, name: "ägg" },
      { amount: 7.5, unit: "dl", name: "vetemjöl" },
      { amount: 50.0, unit: "g", name: "smör" },
      { amount: 1.0, unit: nil, name: "ägg" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Värm vatten och mjölk till 37°. Rör ut jästen med lite av vätskan och tillsätt socker, salt, ägg och mjöl, spara ca 1/2 dl till utbakning. Arbeta degen i maskin ca 5 min. Klicka ner smöret mot slutet. Låt jäsa övertäckt ca 1 timme.",
      "Arbeta degen lätt i maskinen. Ta upp på mjölad arbetsbänk. Dela degen i 12 bitar. Forma bitarna till runda bullar och platta ut dem lätt. Lägg dem på en plåt med bakplåtspapper. Låt jäsa övertäckta ytterligare ca 1 timme. Sätt ugnen på 200°.",
      "Pensla bröden med uppvispat ägg och grädda mitt i ugnen ca 15 min. Låt svalna på galler."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Värm vatten och mjölk till 37°. Rör ut jästen med lite av vätskan och tillsätt socker, salt, ägg och mjöl, spara ca 1/2 dl till utbakning. Arbeta degen i maskin ca 5 min. Klicka ner smöret mot slutet. Låt jäsa övertäckt ca 1 timme.\nArbeta degen lätt i maskinen. Ta upp på mjölad arbetsbänk. Dela degen i 12 bitar. Forma bitarna till runda bullar och platta ut dem lätt. Lägg dem på en plåt med bakplåtspapper. Låt jäsa övertäckta ytterligare ca 1 timme. Sätt ugnen på 200°.\nPensla bröden med uppvispat ägg och grädda mitt i ugnen ca 15 min. Låt svalna på galler.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("alltommat.expressen.se")
    expect(recipe.canonical_url).to eq("https://alltommat.expressen.se/recept/briochehamburgerbrod/")
    expect(recipe.site_name).to eq("Allt om Mat")
    expect(recipe.language).to eq("sv")
    expect(recipe.author).to eq("gunilla von heland")
    expect(recipe.description).to eq("Recept på briochehamburgerbröd. Perfekta hamburgerbröd som är lätt söta och fluffiga. Inkråmet är mjukt och luftigt och tar upp smakerna från en saftig ­ham­burgare bra.")
    expect(recipe.image).to eq("https://static.bonniernews.se/images/8b/46/8b46181ad1eb42e98d7b05cfdf21e0a9/1x1/original.jpg")
    expect(recipe.category).to eq("Hamburgare")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(155)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(135)
    expect(recipe.keywords).to eq(%w[recept matbröd bakning hamburgare])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(3.8)
    expect(recipe.ratings_count).to eq(1111)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
