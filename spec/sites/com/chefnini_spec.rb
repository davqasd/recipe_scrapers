# frozen_string_literal: true

RSpec.describe "chefnini.com" do
  subject(:recipe) { scrape_cassette("com/chefnini", url: "https://www.chefnini.com/entrecote-au-porto-tomates-roties-au-four/") }

  it "reads the title" do
    expect(recipe.title).to eq("Entrecôte au porto, tomates rôties au four")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 entrecôte de 300 g",
      "3 cl de porto",
      "4 tomates rondes",
      "4 cc de pesto basilic",
      "Quelques branches de thym",
      "Huile d’olive",
      "Sel, poivre"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "entrecôte de 300 g" },
      { amount: 3.0, unit: "cl", name: "porto" },
      { amount: 4.0, unit: nil, name: "tomates rondes" },
      { amount: 4.0, unit: "cc", name: "pesto basilic" },
      { amount: nil, unit: nil, name: "Quelques branches de thym" },
      { amount: nil, unit: nil, name: "Huile d’olive" },
      { amount: nil, unit: nil, name: "Sel, poivre" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "1- Lavez les tomates et tranchez la partie supérieure pour obtenir des chapeaux.",
      "2- Recouvrez les tomates de pesto.",
      "3- Placez-les, ainsi que les chapeaux dans un plat à gratin. Salez, poivrez et arrosez d’un peu d’huile.",
      "4- Faites préchauffer votre four à 180°C et enfournez pour 40 minutes. Les tomates doivent être fripées, un peu confites.",
      "5- Lorsque les tomates vous semblent prêtes, laissez-les dans le four éteint et passez à la cuisson de la viande.",
      "6- Faites chauffer une poêle sur feu vif et faites saisir la viande sur les 2 faces rapidement (cela dépend aussi de la cuisson que vous aimez pour le bœuf).",
      "7- Coupez la viande en deux, déposez-la dans le plat avec les tomates pour la garder au chaud.",
      "8- Déglacez la poêle avec le porto, ajoutez le thym, mettez sur feu vif, mélangez pour récupérer les sucs de cuisson et arrêtez le feu.",
      "9- Servez la viande et les tomates arrosées du jus au porto."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("1- Lavez les tomates et tranchez la partie supérieure pour obtenir des chapeaux.\n2- Recouvrez les tomates de pesto.\n3- Placez-les, ainsi que les chapeaux dans un plat à gratin. Salez, poivrez et arrosez d’un peu d’huile.\n4- Faites préchauffer votre four à 180°C et enfournez pour 40 minutes. Les tomates doivent être fripées, un peu confites.\n5- Lorsque les tomates vous semblent prêtes, laissez-les dans le four éteint et passez à la cuisson de la viande.\n6- Faites chauffer une poêle sur feu vif et faites saisir la viande sur les 2 faces rapidement (cela dépend aussi de la cuisson que vous aimez pour le bœuf).\n7- Coupez la viande en deux, déposez-la dans le plat avec les tomates pour la garder au chaud.\n8- Déglacez la poêle avec le porto, ajoutez le thym, mettez sur feu vif, mélangez pour récupérer les sucs de cuisson et arrêtez le feu.\n9- Servez la viande et les tomates arrosées du jus au porto.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("chefnini.com")
    expect(recipe.canonical_url).to eq("https://www.chefnini.com/entrecote-au-porto-tomates-roties-au-four/")
    expect(recipe.site_name).to eq("chefNini")
    expect(recipe.language).to eq("fr-FR")
    expect(recipe.author).to eq("Virginie Fouquet")
    expect(recipe.description).to eq("Pour un soir, en rentrant du travail, cette recette vous régalera sans y passer des heures. Elle nécessite en plus peu d’ingrédients.")
    expect(recipe.image).to eq("https://static.chefnini.com/wp-content/uploads/2014/07/entrecote-tomate-roties10.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#site-content")
  end
end
