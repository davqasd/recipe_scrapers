# frozen_string_literal: true

RSpec.describe "grandfrais.com" do
  subject(:recipe) { scrape_cassette("com/grandfrais", url: "https://www.grandfrais.com/recettes/ecrase-de-pommes-de-terre-et-brocoli-bimi-avec-sauce-au-fromage-de-chevre-et-miel") }

  it "reads the title" do
    expect(recipe.title).to eq("Écrasé de pommes de terre et brocoli Bimi avec sauce au fromage de chèvre et miel")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "200 gr Brocoli Bimi®",
      "500 gr de pommes de terre",
      "4 cuillères à soupe d’huile",
      "Une pincée de sel et de poivre",
      "250 gr de fromage blanc",
      "150 gr de fromage frais de chèvre",
      "50 gr de noix",
      "1 cuillère à soupe de miel",
      "6 dattes",
      "Une pincée de sel et de poivre"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 200.0, unit: "gr", name: "Brocoli Bimi®" },
      { amount: 500.0, unit: "gr", name: "pommes de terre" },
      { amount: 4.0, unit: "cuillères à soupe", name: "d’huile" },
      { amount: nil, unit: nil, name: "Une pincée de sel et de poivre" },
      { amount: 250.0, unit: "gr", name: "fromage blanc" },
      { amount: 150.0, unit: "gr", name: "fromage frais de chèvre" },
      { amount: 50.0, unit: "gr", name: "noix" },
      { amount: 1.0, unit: "cuillère à soupe", name: "miel" },
      { amount: 6.0, unit: nil, name: "dattes" },
      { amount: nil, unit: nil, name: "Une pincée de sel et de poivre" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Préchauffez le four à 180 °C.",
      "Faites bouillir les pommes de terre dans une grande casserole d’eau jusqu’à ce qu’elles soient tendres. Cela devrait prendre environ 20 à 25 minutes, selon la taille des pommes de terre. Égouttez les pommes de terre et séchez-les quelques minutes.",
      "Blanchir les brocolis Bimi® dans de l’eau bouillante pendant deux minutes, puis les déposer sur une plaque de cuisson recouverte de papier sulfurisé.",
      "Placez les pommes de terre sur la plaque à pâtisserie et écrasez-les avec un verre ou un presse-purée. Arrosez d’huile le brocoli et les pommes de terre Bimi® et assaisonnez de sel et de poivre. Cuire au four environ 15 à 20 minutes au milieu du four.",
      "Pendant ce temps, hachez les noix et les dattes. Ensuite, mélangez tous les ingrédients de la sauce au miel et fromage de chèvre dans un bol. Assaisonnez de sel et de poivre.",
      "Dès que les pommes de terre et le brocoli Bimi® sont croustillants, vous pouvez servir !",
      "Crédits photo et recette : tous droits réservés à Bimi®."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Préchauffez le four à 180 °C.\nFaites bouillir les pommes de terre dans une grande casserole d’eau jusqu’à ce qu’elles soient tendres. Cela devrait prendre environ 20 à 25 minutes, selon la taille des pommes de terre. Égouttez les pommes de terre et séchez-les quelques minutes.\nBlanchir les brocolis Bimi® dans de l’eau bouillante pendant deux minutes, puis les déposer sur une plaque de cuisson recouverte de papier sulfurisé.\nPlacez les pommes de terre sur la plaque à pâtisserie et écrasez-les avec un verre ou un presse-purée. Arrosez d’huile le brocoli et les pommes de terre Bimi® et assaisonnez de sel et de poivre. Cuire au four environ 15 à 20 minutes au milieu du four.\nPendant ce temps, hachez les noix et les dattes. Ensuite, mélangez tous les ingrédients de la sauce au miel et fromage de chèvre dans un bol. Assaisonnez de sel et de poivre.\nDès que les pommes de terre et le brocoli Bimi® sont croustillants, vous pouvez servir !\nCrédits photo et recette : tous droits réservés à Bimi®.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("grandfrais.com")
    expect(recipe.canonical_url).to eq("https://www.grandfrais.com/recettes/ecrase-de-pommes-de-terre-et-brocoli-bimi-avec-sauce-au-fromage-de-chevre-et-miel")
    expect(recipe.site_name).to eq("Grand Frais")
    expect(recipe.language).to eq("fr")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("GRAND FRAIS vous propose cette délicieuse recette : Écrasé de pommes de terre et brocoli Bimi avec sauce au fromage de chèvre et miel. Faites le plein d'idées et découvrez nos conseils et astuces pour une préparation inratable. Bon appétit !")
    expect(recipe.image).to eq("https://dam-content.bynder.com/transform/RECETTE_Divers_dispach/102178ce-99ea-409f-98a9-3ff04c3cf34b/DK_462x532_LE-GUMES")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
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
    expect(recipe.links).to include("#")
  end
end
