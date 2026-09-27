# frozen_string_literal: true

RSpec.describe "cuisine.journaldesfemmes.fr" do
  subject(:recipe) { scrape_cassette("fr/cuisine", url: "https://cuisine.journaldesfemmes.fr/recette/3278731-flan-proteine-au-skyr") }

  it "reads the title" do
    expect(recipe.title).to eq("Flan protéiné au skyr")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "400 g skyr",
      "3 unité oeuf",
      "100 ml lait",
      "40 g sucre",
      "1 c à c extrait de vanille",
      "120 g farine",
      "50 g beurre",
      "30 g sucre glace",
      "1 pincée sel",
      "1 c à s eau"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 400.0, unit: "g", name: "skyr" },
      { amount: 3.0, unit: nil, name: "unité oeuf" },
      { amount: 100.0, unit: "ml", name: "lait" },
      { amount: 40.0, unit: "g", name: "sucre" },
      { amount: 1.0, unit: nil, name: "c à c extrait de vanille" },
      { amount: 120.0, unit: "g", name: "farine" },
      { amount: 50.0, unit: "g", name: "beurre" },
      { amount: 30.0, unit: "g", name: "sucre glace" },
      { amount: 1.0, unit: "pincée", name: "sel" },
      { amount: 1.0, unit: nil, name: "c à s eau" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Préparer la pâte",
      "Mélangez la farine, le sucre glace et le sel. Ajoutez le beurre froid coupé en petits morceaux et travaillez du bout des doigts jusqu’à obtenir une texture sableuse. Ajoutez l’eau et formez rapidement une boule de pâte.",
      "Laisser reposer la pâte",
      "Enveloppez la pâte et placez-la au réfrigérateur pendant 30 minutes afin qu’elle soit plus facile à étaler.",
      "Foncer le moule",
      "Préchauffez le four à 160 °C. Étalez la pâte finement puis déposez-la dans un moule à flan en remontant légèrement sur les bords. Piquez le fond avec une fourchette.",
      "Préparer l’appareil au skyr",
      "Fouettez les œufs avec le sucre. Ajoutez le skyr, le lait et l’extrait de vanille, puis mélangez jusqu’à obtenir une préparation homogène et sans grumeaux.",
      "Verser sur la pâte",
      "Versez délicatement l’appareil au skyr sur le fond de pâte. Lissez légèrement la surface si nécessaire.",
      "Cuire le flan",
      "Placez le moule dans un plat rempli d’eau chaude pour une cuisson au bain-marie. Enfournez environ 35 à 40 minutes à 160 °C, jusqu’à ce que le flan soit pris mais encore légèrement tremblotant au centre.",
      "Refroidir avant de servir",
      "Laissez le flan refroidir à température ambiante, puis placez-le au réfrigérateur pendant au moins 30 minutes avant de le démouler et de le servir bien frais."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Préparer la pâte\nMélangez la farine, le sucre glace et le sel. Ajoutez le beurre froid coupé en petits morceaux et travaillez du bout des doigts jusqu’à obtenir une texture sableuse. Ajoutez l’eau et formez rapidement une boule de pâte.\nLaisser reposer la pâte\nEnveloppez la pâte et placez-la au réfrigérateur pendant 30 minutes afin qu’elle soit plus facile à étaler.\nFoncer le moule\nPréchauffez le four à 160 °C. Étalez la pâte finement puis déposez-la dans un moule à flan en remontant légèrement sur les bords. Piquez le fond avec une fourchette.\nPréparer l’appareil au skyr\nFouettez les œufs avec le sucre. Ajoutez le skyr, le lait et l’extrait de vanille, puis mélangez jusqu’à obtenir une préparation homogène et sans grumeaux.\nVerser sur la pâte\nVersez délicatement l’appareil au skyr sur le fond de pâte. Lissez légèrement la surface si nécessaire.\nCuire le flan\nPlacez le moule dans un plat rempli d’eau chaude pour une cuisson au bain-marie. Enfournez environ 35 à 40 minutes à 160 °C, jusqu’à ce que le flan soit pris mais encore légèrement tremblotant au centre.\nRefroidir avant de servir\nLaissez le flan refroidir à température ambiante, puis placez-le au réfrigérateur pendant au moins 30 minutes avant de le démouler et de le servir bien frais.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cuisine.journaldesfemmes.fr")
    expect(recipe.canonical_url).to eq("https://cuisine.journaldesfemmes.fr/recette/3278731-flan-proteine-au-skyr")
    expect(recipe.site_name).to eq("Journal des Femmes Cuisiner")
    expect(recipe.language).to eq("fr")
    expect(recipe.author).to eq("Morgane")
    expect(recipe.description).to eq("Ce flan riche en protéines se prépare en quelques minutes avec du skyr et quelques ingrédients. Sa texture ferme et sa saveur douce en font une collation idéale après le sport.")
    expect(recipe.image).to eq("https://img-3.journaldesfemmes.fr/rIFtxWuE4ixoeGQf60_HwcuJ_TU=/750x500/1267ccfb1f13422db0cacf227ccd7d33/ccmcms-jdf/40097519.jpg")
    expect(recipe.category).to eq("Flan pâtissier")
    expect(recipe.cuisine).to eq("française")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(60)
    expect(recipe.keywords).to eq(["Recette oeufs", "Recette toute l'année", "Recette protéinée", "Recette skyr"])
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
    expect(recipe.links).to include("#avis")
  end
end
