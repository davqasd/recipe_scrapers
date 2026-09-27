# frozen_string_literal: true

RSpec.describe "cookomix.com" do
  subject(:recipe) { scrape_cassette("com/cookomix", url: "https://www.cookomix.com/recettes/lasagnes-au-potiron-thermomix/") }

  it "reads the title" do
    expect(recipe.title).to eq("Lasagnes au potiron au thermomix")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "Échalotes - 4",
      "Lardons fumés - 300 grammes",
      "Huile d'olive - 1 cuillère à soupe",
      "Potiron - 700 grammes",
      "Cube de bouillon de volaille - 1",
      "Crème fraîche épaisse - 120 grammes",
      "Ricotta - 140 grammes",
      "Lait demi-écrémé - 80 grammes",
      "Lasagnes pré-cuites - 12 tranches",
      "Buches de chèvre (facultatif) - 50 grammes",
      "Gruyère rapé - 80 grammes"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: nil, name: "Échalotes" },
      { amount: nil, unit: nil, name: "Lardons fumés - 300 grammes" },
      { amount: 1.0, unit: "cuillère à soupe", name: "Huile d'olive" },
      { amount: nil, unit: nil, name: "Potiron - 700 grammes" },
      { amount: 1.0, unit: nil, name: "Cube de bouillon de volaille" },
      { amount: nil, unit: nil, name: "Crème fraîche épaisse - 120 grammes" },
      { amount: nil, unit: nil, name: "Ricotta - 140 grammes" },
      { amount: nil, unit: nil, name: "Lait demi-écrémé - 80 grammes" },
      { amount: 12.0, unit: "tranches", name: "Lasagnes pré-cuites" },
      { amount: nil, unit: nil, name: "Buches de chèvre - 50 grammes" },
      { amount: nil, unit: nil, name: "Gruyère rapé - 80 grammes" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Ajout d'ingrédient",
      "Mettre 4 échalotes épluchées et coupées en deux dans le bol du Thermomix.",
      "Ajout du couvercle",
      "Ajoutez le couvercle avec le gobelet doseur",
      "Programmation du Thermomix",
      "Mélanger 5 sec/vitesse 5.",
      "Précisions",
      "Racler les parois du bol avec la spatule",
      "Ajout d'ingrédient",
      "Ajouter 300 grammes de lardons fumés dans le bol du Thermomix.",
      "Ajout d'ingrédient",
      "Ajouter 1 cuillère à soupe d'huile d'olive dans le bol du Thermomix.",
      "Ajout du couvercle",
      "Ajoutez le couvercle avec le gobelet doseur",
      "Programmation du Thermomix",
      "Cuire 3 min/Varoma/vitesse 1.",
      "Ajout d'ingrédient",
      "Ajouter 700 grammes de potiron épluchés et coupés en petits morceaux dans le bol du Thermomix.",
      "Ajout d'ingrédient",
      "Ajouter 1 cube de bouillon de volaille émietté dans le bol du Thermomix.",
      "Ajout du couvercle",
      "Ajoutez le couvercle avec le gobelet doseur",
      "Programmation du Thermomix",
      "Cuire 15 min/120°C/vitesse 1.",
      "Ajout d'ingrédient",
      "Ajouter 120 grammes de crème fraîche épaisse dans le bol du Thermomix.",
      "Ajout d'ingrédient",
      "Ajouter 100 grammes de ricotta dans le bol du Thermomix.",
      "Ajout du couvercle",
      "Ajoutez le couvercle avec le gobelet doseur",
      "Programmation du Thermomix",
      "Mélanger 30 sec/vitesse 2.",
      "Ajout d'ingrédient",
      "Mettre 80 grammes de lait demi-écrémé dans un plat à gratin dans le bol du Thermomix.",
      "Ajout d'ingrédient",
      "Mettre 4 tranches de lasagnes pré-cuites sur le lait dans le bol du Thermomix.",
      "Ajout d'ingrédient",
      "Mettre 20 grammes de ricotta à étaler sur les lasagnes dans le bol du Thermomix.",
      "Précisions",
      "Ajouter un tiers de la préparation au potiron.",
      "Ajout d'ingrédient",
      "Mettre 4 tranches de lasagnes pré-cuites sur la préparation dans le bol du Thermomix.",
      "Ajout d'ingrédient",
      "Mettre 20 grammes de ricotta à étaler sur les lasagnes dans le bol du Thermomix.",
      "Précisions",
      "Ajouter le second tiers de la préparation au potiron.",
      "Ajout d'ingrédient",
      "Mettre 50 grammes de buches de chèvre coupées en rondelles et (facultatif) sur la préparation dans le bol du Thermomix.",
      "Ajout d'ingrédient",
      "Mettre 4 tranches de lasagnes pré-cuites sur la préparation dans le bol du Thermomix.",
      "Précisions",
      "Ajouter ce qu'il reste de la preparation au potiron.",
      "Ajout d'ingrédient",
      "Mettre 80 grammes de gruyère rapé sur la préparation dans le bol du Thermomix.",
      "Mise au four",
      "Mettre dans le four pendant 30 min à 150°C.",
      "Dégustation !",
      "Servir immédiatement."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Ajout d'ingrédient\nMettre 4 échalotes épluchées et coupées en deux dans le bol du Thermomix.\nAjout du couvercle\nAjoutez le couvercle avec le gobelet doseur\nProgrammation du Thermomix\nMélanger 5 sec/vitesse 5.\nPrécisions\nRacler les parois du bol avec la spatule\nAjout d'ingrédient\nAjouter 300 grammes de lardons fumés dans le bol du Thermomix.\nAjout d'ingrédient\nAjouter 1 cuillère à soupe d'huile d'olive dans le bol du Thermomix.\nAjout du couvercle\nAjoutez le couvercle avec le gobelet doseur\nProgrammation du Thermomix\nCuire 3 min/Varoma/vitesse 1.\nAjout d'ingrédient\nAjouter 700 grammes de potiron épluchés et coupés en petits morceaux dans le bol du Thermomix.\nAjout d'ingrédient\nAjouter 1 cube de bouillon de volaille émietté dans le bol du Thermomix.\nAjout du couvercle\nAjoutez le couvercle avec le gobelet doseur\nProgrammation du Thermomix\nCuire 15 min/120°C/vitesse 1.\nAjout d'ingrédient\nAjouter 120 grammes de crème fraîche épaisse dans le bol du Thermomix.\nAjout d'ingrédient\nAjouter 100 grammes de ricotta dans le bol du Thermomix.\nAjout du couvercle\nAjoutez le couvercle avec le gobelet doseur\nProgrammation du Thermomix\nMélanger 30 sec/vitesse 2.\nAjout d'ingrédient\nMettre 80 grammes de lait demi-écrémé dans un plat à gratin dans le bol du Thermomix.\nAjout d'ingrédient\nMettre 4 tranches de lasagnes pré-cuites sur le lait dans le bol du Thermomix.\nAjout d'ingrédient\nMettre 20 grammes de ricotta à étaler sur les lasagnes dans le bol du Thermomix.\nPrécisions\nAjouter un tiers de la préparation au potiron.\nAjout d'ingrédient\nMettre 4 tranches de lasagnes pré-cuites sur la préparation dans le bol du Thermomix.\nAjout d'ingrédient\nMettre 20 grammes de ricotta à étaler sur les lasagnes dans le bol du Thermomix.\nPrécisions\nAjouter le second tiers de la préparation au potiron.\nAjout d'ingrédient\nMettre 50 grammes de buches de chèvre coupées en rondelles et (facultatif) sur la préparation dans le bol du Thermomix.\nAjout d'ingrédient\nMettre 4 tranches de lasagnes pré-cuites sur la préparation dans le bol du Thermomix.\nPrécisions\nAjouter ce qu'il reste de la preparation au potiron.\nAjout d'ingrédient\nMettre 80 grammes de gruyère rapé sur la préparation dans le bol du Thermomix.\nMise au four\nMettre dans le four pendant 30 min à 150°C.\nDégustation !\nServir immédiatement.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cookomix.com")
    expect(recipe.canonical_url).to eq("https://www.cookomix.com/recettes/lasagnes-au-potiron-thermomix/")
    expect(recipe.site_name).to eq("Cookomix")
    expect(recipe.language).to eq("fr-FR")
    expect(recipe.author).to eq("Pierrette")
    expect(recipe.description).to eq("Surprenez et charmez votre tablée avec la douceur des potirons combinée à la saveur du fromage ! La farce légèrement orangée s'associe parfaitement à la pâte à lasagne dans ce plat original à préparer avec votre Thermomix :)")
    expect(recipe.image).to eq("https://www.cookomix.com/wp-content/uploads/2017/12/lasagnes-potiron-thermomix-800x600.jpg")
    expect(recipe.category).to eq("Plat principal")
    expect(recipe.cuisine).to eq("Monde")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(25)
    expect(recipe.cook_time).to eq(73)
    expect(recipe.keywords).to eq(%w[Pâtes Carnivore Automne Hiver])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.91)
    expect(recipe.ratings_count).to eq(914)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "739 kcal"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 739.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#more-comments")
  end
end
