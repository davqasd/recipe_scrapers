# frozen_string_literal: true

RSpec.describe "recette.plus" do
  subject(:recipe) { scrape_cassette("plus/recette", url: "https://www.recette.plus/recettes/plat-principal/2330-pignons-de-poulet-a-la-creme.html") }

  it "reads the title" do
    expect(recipe.title).to eq("Pignons de poulet à la crème")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 Oignon jaune",
      "2 Tomate",
      "10 g Beurre",
      "1 cuillère à soupe Huile d'olive",
      "4 Pignons",
      "20 cl Crème liquide"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "Oignon jaune" },
      { amount: 2.0, unit: nil, name: "Tomate" },
      { amount: 10.0, unit: "g", name: "Beurre" },
      { amount: 1.0, unit: "cuillère à soupe", name: "Huile d'olive" },
      { amount: 4.0, unit: nil, name: "Pignons" },
      { amount: 20.0, unit: "cl", name: "Crème liquide" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Faites rôtir les pignons au four dans du beurre pendant 1 h.",
      "Émincez l'oignon et faites-le revenir dans une poêle avec un peu d'huile d'olive et mettre de côté.",
      "Une fois cuit, mettre les pignons de poulet dans la poêle avec le beurre, et les pignons qui sortent du four.",
      "Ensuite ajoutez la crème, les tomates coupées en dés et les oignons cuits auparavant. Laissez mijoter 15 min le temps que les tomates se ramollissent.",
      "Servir chaud accompagné par exemple de pommes de terre sautées."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Faites rôtir les pignons au four dans du beurre pendant 1 h.\nÉmincez l'oignon et faites-le revenir dans une poêle avec un peu d'huile d'olive et mettre de côté.\nUne fois cuit, mettre les pignons de poulet dans la poêle avec le beurre, et les pignons qui sortent du four.\nEnsuite ajoutez la crème, les tomates coupées en dés et les oignons cuits auparavant. Laissez mijoter 15 min le temps que les tomates se ramollissent.\nServir chaud accompagné par exemple de pommes de terre sautées.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("recette.plus")
    expect(recipe.canonical_url).to eq("https://www.recette.plus/recettes/plat-principal/2330-pignons-de-poulet-a-la-creme.html")
    expect(recipe.site_name).to eq("Recette Plus : Découvrez toutes les recettes de cuisine française et du monde")
    expect(recipe.language).to eq("fr")
    expect(recipe.author).to eq("Zahra")
    expect(recipe.description).to eq("Découvrez les ingrédients et étapes de préparation de recette Pignons de poulet à la crème, Découvrez comment préparer la recette de Pignons de poulet à la crème facile et rapide")
    expect(recipe.image).to eq("https://www.recette.plus/uploads/posts/2023-08/urecipes_d00e2528110cb18d8c3b33b0e0cf0b6a.webp")
    expect(recipe.category).to eq("Plat principal")
    expect(recipe.cuisine).to eq("Cuisine française")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(95)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(75)
    expect(recipe.keywords).to eq([
      "Pignons de poulet à la crème",
      "oignon jaune",
      "tomate",
      "beurre",
      "huile dolive",
      "pignons",
      "crème liquide",
      "poulet en sauce",
      "facile",
      "bon marché"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "400 kcal",
      "carbohydrateContent" => "10 g",
      "cholesterolContent" => "80 mg",
      "fiberContent" => "2 g",
      "proteinContent" => "30 g",
      "saturatedFatContent" => "10 g",
      "sodiumContent" => "500 mg",
      "sugarContent" => "3 g",
      "fatContent" => "25 g",
      "unsaturatedFatContent" => "15 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 400.0 },
      { name: "carbohydrateContent", unit: "g", amount: 10.0 },
      { name: "cholesterolContent", unit: "mg", amount: 80.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "proteinContent", unit: "g", amount: 30.0 },
      { name: "saturatedFatContent", unit: "g", amount: 10.0 },
      { name: "sodiumContent", unit: "mg", amount: 500.0 },
      { name: "sugarContent", unit: "g", amount: 3.0 },
      { name: "fatContent", unit: "g", amount: 25.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 15.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
