# frozen_string_literal: true

RSpec.describe "marmiton.org" do
  subject(:recipe) { scrape_cassette("org/marmiton", url: "https://www.marmiton.org/recettes/recette_ratatouille_23223.aspx") }

  it "reads the title" do
    expect(recipe.title).to eq("Ratatouille : la meilleure recette")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "350 g d'aubergines",
      "350 g de courgettes",
      "350 g de poivrons de couleur rouge et vert",
      "350 g d'oignons",
      "500 g de tomates bien mûres",
      "3 gousses d'ail",
      "6 cuillères à soupe d'huile d'olive",
      "1 brin de thym",
      "1 feuille de laurier",
      "poivre",
      "sel"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 350.0, unit: "g", name: "d'aubergines" },
      { amount: 350.0, unit: "g", name: "courgettes" },
      { amount: 350.0, unit: "g", name: "poivrons de couleur rouge et vert" },
      { amount: 350.0, unit: "g", name: "d'oignons" },
      { amount: 500.0, unit: "g", name: "tomates bien mûres" },
      { amount: 3.0, unit: "gousses", name: "d'ail" },
      { amount: 6.0, unit: "cuillères à soupe", name: "d'huile d'olive" },
      { amount: 1.0, unit: "brin", name: "thym" },
      { amount: 1.0, unit: "feuille", name: "laurier" },
      { amount: nil, unit: nil, name: "poivre" },
      { amount: nil, unit: nil, name: "sel" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Coupez les tomates pelées en quartiers,",
      "les aubergines et les courgettes en rondelles.",
      "Emincez les poivrons en lamelles",
      "et l'oignon en rouelles.",
      "Chauffez 2 cuillères à soupe d'huile dans une poêle",
      "et faites-y fondre les oignons et les poivrons.",
      "Lorsqu'ils sont tendres, ajoutez les tomates, l'ail haché, le thym et le laurier.",
      "Salez, poivrez et laissez mijoter doucement à couvert durant 45 minutes.",
      "Pendant ce temps, préparez les aubergines et les courgettes. Faites les cuire séparemment ou non dans l'huile d'olive pendant 15 minutes.",
      "Vérifiez la cuisson des légumes pour qu'ils ne soient plus fermes. Ajoutez les alors au mélange de tomates et prolongez la cuisson sur tout petit feu pendant 10 min.",
      "Salez et poivrez si besoin."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Coupez les tomates pelées en quartiers,\nles aubergines et les courgettes en rondelles.\nEmincez les poivrons en lamelles\net l'oignon en rouelles.\nChauffez 2 cuillères à soupe d'huile dans une poêle\net faites-y fondre les oignons et les poivrons.\nLorsqu'ils sont tendres, ajoutez les tomates, l'ail haché, le thym et le laurier.\nSalez, poivrez et laissez mijoter doucement à couvert durant 45 minutes.\nPendant ce temps, préparez les aubergines et les courgettes. Faites les cuire séparemment ou non dans l'huile d'olive pendant 15 minutes.\nVérifiez la cuisson des légumes pour qu'ils ne soient plus fermes. Ajoutez les alors au mélange de tomates et prolongez la cuisson sur tout petit feu pendant 10 min.\nSalez et poivrez si besoin.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("marmiton.org")
    expect(recipe.canonical_url).to eq("https://www.marmiton.org/recettes/recette_ratatouille_23223.aspx")
    expect(recipe.site_name).to eq("Marmiton")
    expect(recipe.language).to eq("fr-FR")
    expect(recipe.author).to eq("Mirabelle")
    expect(recipe.description).to eq("Recette Ratatouille : la meilleure recette rapide et facile : 4 personnes, 80 min de préparation. Notée 4.8/5 par 419 membres Marmiton.")
    expect(recipe.image).to eq("https://assets.afcdn.com/recipe/20160624/36724_w1024h1024c1cx2248cy1500.jpg")
    expect(recipe.category).to eq("Plat principal")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(80)
    expect(recipe.prep_time).to eq(25)
    expect(recipe.cook_time).to eq(55)
    expect(recipe.keywords).to eq([
      "Ratatouille",
      "ratatouille",
      "aubergine",
      "courgette",
      "poivron",
      "oignon",
      "tomate",
      "ail",
      "huile d'olive",
      "thym",
      "feuille de laurier",
      "poivre",
      "sel",
      "Facile",
      "Moyen"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(%w[VegetarianDiet VeganDiet GlutenFreeDiet LowLactoseDiet])
    expect(recipe.ratings).to eq(4.8)
    expect(recipe.ratings_count).to eq(419)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "364 calories",
      "servingSize" => "511 grams",
      "carbohydrateContent" => "18.3 g",
      "fatContent" => "27.3 g",
      "fiberContent" => "9 g",
      "proteinContent" => "6 g",
      "saturatedFatContent" => "3.5 g",
      "sodiumContent" => "1.4 g",
      "sugarContent" => "15 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 364.0 },
      { name: "servingSize", unit: "g", amount: 511.0 },
      { name: "carbohydrateContent", unit: "g", amount: 18.3 },
      { name: "fatContent", unit: "g", amount: 27.3 },
      { name: "fiberContent", unit: "g", amount: 9.0 },
      { name: "proteinContent", unit: "g", amount: 6.0 },
      { name: "saturatedFatContent", unit: "g", amount: 3.5 },
      { name: "sodiumContent", unit: "g", amount: 1.4 },
      { name: "sugarContent", unit: "g", amount: 15.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
