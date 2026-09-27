# frozen_string_literal: true

RSpec.describe "latelierderoxane.com" do
  subject(:recipe) { scrape_cassette("com/latelierderoxane", url: "https://www.latelierderoxane.com/recettes/recette-banana-bread-pepites-de-chocolat/") }

  it "reads the title" do
    expect(recipe.title).to eq("Recette banana bread moelleuse aux pépites de chocolat")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "150 g de lait",
      "4 bananes (bien mûres)",
      "2 càc de jus de citron",
      "120 g de sucre roux",
      "80 g de beurre fondu",
      "2 œufs",
      "200 g de farine",
      "1 càc de levure",
      "100 g de pépites de chocolat noir",
      "1/2 càc de canelle",
      "1 càc de bicarbonate",
      "1 càc d’arôme de vanille",
      "1 pincée de sel"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 150.0, unit: "g", name: "lait" },
      { amount: 4.0, unit: nil, name: "bananes" },
      { amount: 2.0, unit: nil, name: "càc de jus de citron" },
      { amount: 120.0, unit: "g", name: "sucre roux" },
      { amount: 80.0, unit: "g", name: "beurre fondu" },
      { amount: 2.0, unit: nil, name: "œufs" },
      { amount: 200.0, unit: "g", name: "farine" },
      { amount: 1.0, unit: nil, name: "càc de levure" },
      { amount: 100.0, unit: "g", name: "pépites de chocolat noir" },
      { amount: 0.5, unit: nil, name: "càc de canelle" },
      { amount: 1.0, unit: nil, name: "càc de bicarbonate" },
      { amount: 1.0, unit: nil, name: "càc d’arôme de vanille" },
      { amount: 1.0, unit: "pincée", name: "sel" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Préchauffe ton four à 175°",
      "Réalise un babeurre : Dans un bol, verse le lait, le jus de citron et laisse reposer 10 minutes : Cette étape est impérative pour un moelleux réussi !",
      "Dans un bol, écrase 3 bananes à l’aide d’une fourchette pour obtenir une purée de bananes !",
      "Ajoute le sucre, la vanille, la cannelle et mélange brièvement à l’aide d’ un fouet .",
      "Verse le beurre fondu, les œufs , le lait babeurre et fouette énergiquement.",
      "Ajoute la farine, la levure, le bicarbonate, le sel et fouette le tout jusqu’à l’obtention d’un mélange lisse et homogène.",
      "Termine en incorporant, toujours au fouet, les pépites de chocolat.",
      "Beurre et farine un moule à cake .",
      "Remplis ton moule avec la préparation obtenue.",
      "Découpe la banane restante en deux, dans le sens de la longueur, et dépose-la sur le dessus de ton Banana Bread.",
      "Enfourne pendant 55 minutes.",
      "À la sortie du four, laisse ton Banana Bread tiédir avant de le démouler !"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Préchauffe ton four à 175°\nRéalise un babeurre : Dans un bol, verse le lait, le jus de citron et laisse reposer 10 minutes : Cette étape est impérative pour un moelleux réussi !\nDans un bol, écrase 3 bananes à l’aide d’une fourchette pour obtenir une purée de bananes !\nAjoute le sucre, la vanille, la cannelle et mélange brièvement à l’aide d’ un fouet .\nVerse le beurre fondu, les œufs , le lait babeurre et fouette énergiquement.\nAjoute la farine, la levure, le bicarbonate, le sel et fouette le tout jusqu’à l’obtention d’un mélange lisse et homogène.\nTermine en incorporant, toujours au fouet, les pépites de chocolat.\nBeurre et farine un moule à cake .\nRemplis ton moule avec la préparation obtenue.\nDécoupe la banane restante en deux, dans le sens de la longueur, et dépose-la sur le dessus de ton Banana Bread.\nEnfourne pendant 55 minutes.\nÀ la sortie du four, laisse ton Banana Bread tiédir avant de le démouler !")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("latelierderoxane.com")
    expect(recipe.canonical_url).to eq("https://www.latelierderoxane.com/recettes/recette-banana-bread-pepites-de-chocolat/")
    expect(recipe.site_name).to eq("L'Atelier de Roxane")
    expect(recipe.language).to eq("fr-FR")
    expect(recipe.author).to eq("Roxane")
    expect(recipe.description).to eq("Une recette gourmande et facile à réaliser : le banana bread babeurre aux pépites de chocolat !")
    expect(recipe.image).to eq("https://www.latelierderoxane.com/wp-content/uploads/2025/11/RECETTE-BANANA-BREAD-1200x1200-c-default.jpg")
    expect(recipe.category).to eq("Goûters maison")
    expect(recipe.cuisine).to eq("Américaine")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 items")
    expect(recipe.total_time).to eq(85)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(55)
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
    expect(recipe.links).to include("https://www.latelierderoxane.com")
  end
end
