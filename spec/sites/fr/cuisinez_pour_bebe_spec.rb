# frozen_string_literal: true

RSpec.describe "cuisinez-pour-bebe.fr" do
  subject(:recipe) { scrape_cassette("fr/cuisinez_pour_bebe", url: "https://www.cuisinez-pour-bebe.fr/riz-et-puree-de-butternut-au-colin/") }

  it "reads the title" do
    expect(recipe.title).to eq("Riz et purée de butternut au colin")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "20 g riz",
      "150 g butternut",
      "15 g colin",
      "1 c. à café huile(s) végétale(s)",
      "citron(s) (facultatif)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 20.0, unit: "g", name: "riz" },
      { amount: 150.0, unit: "g", name: "butternut" },
      { amount: 15.0, unit: "g", name: "colin" },
      { amount: 1.0, unit: "c. à café", name: "huile végétale" },
      { amount: nil, unit: nil, name: "citron" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Laver et éplucher la courge butternut, puis la couper en 2 pour vider les graines. Couper environ 150g de courge en morceaux, et cuire à la vapeur (20 minutes environ).",
      "Dans une casserole (ou un autocuiseur), verser le riz et 2x son volume d’eau froide. Porter à ébullition, puis continuer la cuisson à feu doux et à couvert (15 minutes environ).",
      "Ajouter le morceau de colin dans le panier vapeur avec la butternut, pour le cuire à coeur (minimum 5 minutes).",
      "Lorsqu'elle est cuite, mixer la courge butternut en purée avec 1 c. à café d'huile.",
      "Servir avec le riz (à côté ou mélangé) et ajouter le colin émietté.",
      "(Optionnel) Au moment de servir, arroser le colin d'un peu de jus de citron."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Laver et éplucher la courge butternut, puis la couper en 2 pour vider les graines. Couper environ 150g de courge en morceaux, et cuire à la vapeur (20 minutes environ).\nDans une casserole (ou un autocuiseur), verser le riz et 2x son volume d’eau froide. Porter à ébullition, puis continuer la cuisson à feu doux et à couvert (15 minutes environ).\nAjouter le morceau de colin dans le panier vapeur avec la butternut, pour le cuire à coeur (minimum 5 minutes).\nLorsqu'elle est cuite, mixer la courge butternut en purée avec 1 c. à café d'huile.\nServir avec le riz (à côté ou mélangé) et ajouter le colin émietté.\n(Optionnel) Au moment de servir, arroser le colin d'un peu de jus de citron.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cuisinez-pour-bebe.fr")
    expect(recipe.canonical_url).to eq("https://www.cuisinez-pour-bebe.fr/riz-et-puree-de-butternut-au-colin/")
    expect(recipe.site_name).to eq("Cuisinez pour bébé")
    expect(recipe.language).to eq("fr-FR")
    expect(recipe.author).to eq("Clémence")
    expect(recipe.description).to be_nil
    expect(recipe.image).to eq("https://www.cuisinez-pour-bebe.fr/wp-content/uploads/2021/12/riz-et-puree-de-butternut-au-colin.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("1 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.38)
    expect(recipe.ratings_count).to eq(8)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#comment-108668")
  end
end
