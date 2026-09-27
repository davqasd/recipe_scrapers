# frozen_string_literal: true

RSpec.describe "editions-larousse.fr" do
  subject(:recipe) { scrape_cassette("fr/editions_larousse", url: "https://www.editions-larousse.fr/recette/smash-burgers-et-pommes-de-terre-roties-l-ail/") }

  it "reads the title" do
    expect(recipe.title).to eq("Smash burgers et pommes de terre rôties à l 'ail")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "700 g de pommes de terre grenailles coupées en 2",
      "4 gousses d’ail hachées",
      "1 c. à café de cumin",
      "1 c. à café de paprika fumé",
      "1 c. à café de paprika",
      "1/2 c. à café de piment de Cayenne",
      "2 c. à soupe d’huile d’olive",
      "4 pains à burger",
      "650 g de boeuf haché",
      "4 tranches de fromage à burger",
      "1/2 sachet de laitue iceberg",
      "4 tomates en fines tranches",
      "50 g de beurre mou",
      "1/2 oignon jaune haché",
      "100 g de mayonnaise",
      "1 c. à soupe de moutarde jaune",
      "2 c. à café de sauce barbecue",
      "Quelques gouttes de sauce Worcestershire"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 700.0, unit: "g", name: "pommes de terre grenailles coupées en 2" },
      { amount: 4.0, unit: "gousses", name: "d’ail hachées" },
      { amount: 1.0, unit: "c. à café", name: "cumin" },
      { amount: 1.0, unit: "c. à café", name: "paprika fumé" },
      { amount: 1.0, unit: "c. à café", name: "paprika" },
      { amount: 0.5, unit: "c. à café", name: "piment de Cayenne" },
      { amount: 2.0, unit: "c. à soupe", name: "d’huile d’olive" },
      { amount: 4.0, unit: nil, name: "pains à burger" },
      { amount: 650.0, unit: "g", name: "boeuf haché" },
      { amount: 4.0, unit: "tranches", name: "fromage à burger" },
      { amount: 0.5, unit: "sachet", name: "laitue iceberg" },
      { amount: 4.0, unit: nil, name: "tomates en fines tranches" },
      { amount: 50.0, unit: "g", name: "beurre mou" },
      { amount: 0.5, unit: nil, name: "oignon jaune haché" },
      { amount: 100.0, unit: "g", name: "mayonnaise" },
      { amount: 1.0, unit: "c. à soupe", name: "moutarde jaune" },
      { amount: 2.0, unit: "c. à café", name: "sauce barbecue" },
      { amount: nil, unit: nil, name: "Quelques gouttes de sauce Worcestershire" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Préparez les pommes de terre. Mélangez les pommes de terre grenailles avec l’ail, les épices, l’huile, du sel et du poivre. Faites cuire le tout sur la plancha à feu moyen (200 °C) et à couvert pendant 15 à 20 min, en retournant de temps en temps.",
      "Préparez la sauce. Mélangez tous les ingrédients.",
      "Préparez les burgers. Tartinez l’intérieur des pains de beurre mou et faites-les griller 3 min sur le gril, puis réservez.",
      "Mélangez la viande avec 1/2c. à café de sel et du poivre, puis divisez-la en 8 portions d’environ 80g. Faites-les griller sur la plancha à feu vif (250 à 300 °C) dans l’huile chaude en les espaçant bien. Écrasez-les aussitôt à l’aide d’une spatule bien plate et poursuivez la cuisson 2 min sur le premier côte. Retournez-les et ajouter le fromage sur la moitié des steaks pour le faire fondre. Poursuivez la cuisson 2 à 3 min.",
      "Empilez les steaks deux à deux sur ceux couverts de fromage, puis assemblez les burgers : déposez un peu de sauce sur les pains, puis la salade et les tomates. Ajoutez la viande, un peu plus de sauce et refermez. Servez avec les pommes de terre rôties."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["Pour les pommes de terre", 7],
        ["Pour les burgers", 6],
        ["Pour la sauce", 5]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Préparez les pommes de terre. Mélangez les pommes de terre grenailles avec l’ail, les épices, l’huile, du sel et du poivre. Faites cuire le tout sur la plancha à feu moyen (200 °C) et à couvert pendant 15 à 20 min, en retournant de temps en temps.\nPréparez la sauce. Mélangez tous les ingrédients.\nPréparez les burgers. Tartinez l’intérieur des pains de beurre mou et faites-les griller 3 min sur le gril, puis réservez.\nMélangez la viande avec 1/2c. à café de sel et du poivre, puis divisez-la en 8 portions d’environ 80g. Faites-les griller sur la plancha à feu vif (250 à 300 °C) dans l’huile chaude en les espaçant bien. Écrasez-les aussitôt à l’aide d’une spatule bien plate et poursuivez la cuisson 2 min sur le premier côte. Retournez-les et ajouter le fromage sur la moitié des steaks pour le faire fondre. Poursuivez la cuisson 2 à 3 min.\nEmpilez les steaks deux à deux sur ceux couverts de fromage, puis assemblez les burgers : déposez un peu de sauce sur les pains, puis la salade et les tomates. Ajoutez la viande, un peu plus de sauce et refermez. Servez avec les pommes de terre rôties.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("editions-larousse.fr")
    expect(recipe.canonical_url).to eq("https://www.editions-larousse.fr/recette/smash-burgers-et-pommes-de-terre-roties-l-ail/")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("fr")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Envie d'un plat simple et convivial, à réaliser avec votre plancha ? Découvrez cette délicieuse recette de Smash burgers avec ses pommes de terre rôties à l'ail, extraite du livre Plancha!")
    expect(recipe.image).to eq("https://media.hachette.fr/fit-in/800x800/28/2025-07/smash-burger-plancha.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(38)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(28)
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
    expect(recipe.links).to include("/recette/smash-burgers-et-pommes-de-terre-roties-l-ail/#wcag-menu")
  end
end
