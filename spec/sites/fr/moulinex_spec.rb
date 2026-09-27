# frozen_string_literal: true

RSpec.describe "moulinex.fr" do
  subject(:recipe) { scrape_cassette("fr/moulinex", url: "https://www.moulinex.fr/recette/detail/PRO/couscous/v1/recipes/123432") }

  it "reads the title" do
    expect(recipe.title).to eq("Couscous")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 Pilons de poulet",
      "100g Carottes en tronçons",
      "80g Pois chiches en boîte",
      "200g Courgettes en demi-tronçons",
      "1 Bouillon aux épices MAGGI",
      "50g Oignon émincé",
      "15cl Eau",
      "1càs Concentré de tomate",
      "1càs Huile d'olive"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: nil, name: "Pilons de poulet" },
      { amount: 100.0, unit: "g", name: "Carottes en tronçons" },
      { amount: 80.0, unit: "g", name: "Pois chiches en boîte" },
      { amount: 200.0, unit: "g", name: "Courgettes en demi-tronçons" },
      { amount: 1.0, unit: nil, name: "Bouillon aux épices MAGGI" },
      { amount: 50.0, unit: "g", name: "Oignon émincé" },
      { amount: 15.0, unit: "cl", name: "Eau" },
      { amount: 1.0, unit: nil, name: "càs Concentré de tomate" },
      { amount: 1.0, unit: nil, name: "càs Huile d'olive" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Préparer les ingrédients.",
      "Émincer les oignons.",
      "Couper les carottes en tronçons.",
      "Verser l'huile dans la cuve.",
      "Faire dorer l'oignon et les pilons 5 minutes.",
      "Ajouter tous les ingrédients sauf les pois chiches et poivrer.",
      "Cuisson sous pression",
      "Ajouter les pois chiches. Servir avec de la semoule à la cannelle. Bon appétit !"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Préparer les ingrédients.\nÉmincer les oignons.\nCouper les carottes en tronçons.\nVerser l'huile dans la cuve.\nFaire dorer l'oignon et les pilons 5 minutes.\nAjouter tous les ingrédients sauf les pois chiches et poivrer.\nCuisson sous pression\nAjouter les pois chiches. Servir avec de la semoule à la cannelle. Bon appétit !")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("moulinex.fr")
    expect(recipe.canonical_url).to eq("https://www.moulinex.fr/recette/detail/PRO/couscous/v1/recipes/123432")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("fr-fr")
    expect(recipe.author).to eq("Moulinex")
    expect(recipe.description).to be_nil
    expect(recipe.image).to eq("https://sebplatform.api.groupe-seb.com/statics/a9fa153f-7b9e-45c3-bdb4-a443feac9138.png")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.4)
    expect(recipe.ratings_count).to eq(2552)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
