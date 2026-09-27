# frozen_string_literal: true

RSpec.describe "dagelijksekost.vrt.be" do
  subject(:recipe) { scrape_cassette("be/dagelijksekost", url: "https://dagelijksekost.vrt.be/gerechten/mouclade") }

  it "reads the title" do
    expect(recipe.title).to eq("Mouclade")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 kg mosselen",
      "1 ui",
      "2 teentjes look",
      "1 scheutje olie",
      "tijm",
      "laurier",
      "peper",
      "2,5 deciliter pineau des charentes",
      "2 Sjalotten",
      "boter",
      "1 snuifje currypoeder",
      "1 snuifje saffraan",
      "1 scheutje Witte wijnazijn",
      "citroen",
      "2 deciliter room",
      "2 eierdooiers",
      "Bieslook",
      "0,5 stokbrood"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "kg", name: "mosselen" },
      { amount: 1.0, unit: nil, name: "ui" },
      { amount: 2.0, unit: "teentjes", name: "look" },
      { amount: 1.0, unit: nil, name: "scheutje olie" },
      { amount: nil, unit: nil, name: "tijm" },
      { amount: nil, unit: nil, name: "laurier" },
      { amount: nil, unit: nil, name: "peper" },
      { amount: 2.5, unit: nil, name: "deciliter pineau des charentes" },
      { amount: 2.0, unit: nil, name: "Sjalotten" },
      { amount: nil, unit: nil, name: "boter" },
      { amount: 1.0, unit: nil, name: "snuifje currypoeder" },
      { amount: 1.0, unit: nil, name: "snuifje saffraan" },
      { amount: 1.0, unit: nil, name: "scheutje Witte wijnazijn" },
      { amount: nil, unit: nil, name: "citroen" },
      { amount: 2.0, unit: nil, name: "deciliter room" },
      { amount: 2.0, unit: nil, name: "eierdooiers" },
      { amount: nil, unit: nil, name: "Bieslook" },
      { amount: 0.5, unit: nil, name: "stokbrood" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Spoel de mosselen grondig in gezouten water, verwijder de baard en laat ze uitlekken.",
      "Snij de ui en de look en stoof ze aan in een beetje olie."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Spoel de mosselen grondig in gezouten water, verwijder de baard en laat ze uitlekken.\nSnij de ui en de look en stoof ze aan in een beetje olie.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("dagelijksekost.vrt.be")
    expect(recipe.canonical_url).to eq("https://dagelijksekost.vrt.be/gerechten/mouclade")
    expect(recipe.site_name).to eq("Dagelijkse kost")
    expect(recipe.language).to eq("nl")
    expect(recipe.author).to eq("Jeroen Meus")
    expect(recipe.description).to eq("Mouclade van Jeroen Meus, een Frans mosselsoepje met pineau des charentes, curry en saffraan, gebonden met room en eierdooier.")
    expect(recipe.image).to eq("https://cdn.dagelijksekost.tv/landscape/recipes/flJ3uHk0PiswGuRVHmXK/1790071810849_1500x1125")
    expect(recipe.category).to eq("Hoofdgerecht")
    expect(recipe.cuisine).to eq("Frans")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq(%w[Vis Klassieker Hoofdgerecht])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(7)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
