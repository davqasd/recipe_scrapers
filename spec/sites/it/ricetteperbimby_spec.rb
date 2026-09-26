# frozen_string_literal: true

RSpec.describe "ricetteperbimby.it" do
  subject(:recipe) { scrape_cassette("it/ricetteperbimby", url: "https://www.ricetteperbimby.it/ricette/crema-pasticcera-veloce-bimby") }

  it "reads the title" do
    expect(recipe.title).to eq("Crema pasticcera Bimby densa ricetta in 2 passi")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "500 g latte",
      "120 g zucchero semolato",
      "60 g farina 00",
      "2 tuorli uova",
      "1 bustina vanillina"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 500.0, unit: "g", name: "latte" },
      { amount: 120.0, unit: "g", name: "zucchero semolato" },
      { amount: 60.0, unit: "g", name: "farina 00" },
      { amount: 2.0, unit: nil, name: "tuorli uova" },
      { amount: 1.0, unit: "bustina", name: "vanillina" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Mettere nel boccale tutti gli ingredienti: 7 min. 90° vel. 4.",
      "Versare in una ciotola, coprire con pellicola a contatto e lasciare raffreddare completamente.",
      "Trasferire in frigorifero per almeno un'ora prima di servire come dolce al cucchiaio o utilizzare per farcire dolci e torte."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Mettere nel boccale tutti gli ingredienti: 7 min. 90° vel. 4.\nVersare in una ciotola, coprire con pellicola a contatto e lasciare raffreddare completamente.\nTrasferire in frigorifero per almeno un'ora prima di servire come dolce al cucchiaio o utilizzare per farcire dolci e torte.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("ricetteperbimby.it")
    expect(recipe.canonical_url).to eq("https://www.ricetteperbimby.it/ricette/crema-pasticcera-veloce-bimby")
    expect(recipe.site_name).to eq("Ricetteperbimby.it")
    expect(recipe.language).to eq("it")
    expect(recipe.author).to eq("RicettePerBimby")
    expect(recipe.description).to eq("Prepara la crema pasticcera Bimby, una ricetta veloce in 2 passaggi ideale come dessert o per farcire dolci, una crema Bimby da aromatizzare a piacere.")
    expect(recipe.image).to eq("https://www.ricetteperbimby.it/foto-ricette/crema-pasticcera-veloce-bimby.jpg")
    expect(recipe.category).to eq("Dolci e Dessert")
    expect(recipe.cuisine).to eq("Italiana")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("720 items")
    expect(recipe.total_time).to eq(15)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq(["Senza burro", "Vegetariana", "Senza lievito"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.9)
    expect(recipe.ratings_count).to eq(483)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.ricetteperbimby.it")
  end
end
