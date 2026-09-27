# frozen_string_literal: true

RSpec.describe "veroniquecloutier.com" do
  subject(:recipe) { scrape_cassette("com/veroniquecloutier", url: "https://veroniquecloutier.com/cuisine/polenta-cremeuse-et-sa-bolognaise-blanche-rapido-de-dan-blake") }

  it "reads the title" do
    expect(recipe.title).to eq("Polenta crémeuse et sa bolognaise blanche rapido, de Dan & Blake")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "55 g (1/4 tasse) de beurre",
      "1 carotte moyenne, hachée finement",
      "2 branches de céleri, hachées finement",
      "1 oignon, haché finement",
      "2 branches de romarin frais",
      "5 ml (1 c. à thé) de sel",
      "1 emballage de 250 à 300 g de cretons",
      "375 ml (1 1/2 tasses) de bouillon de poulet",
      "Sel et poivre du moulin",
      "2 rouleaux de 500 g de polenta du commerce (ou 1 cylindre de 1 kg)",
      "70 g (1 tasse) de parmesan (ou autre fromage à pâte ferme), râpé"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 55.0, unit: "g", name: "beurre" },
      { amount: 1.0, unit: nil, name: "carotte moyenne, hachée finement" },
      { amount: 2.0, unit: nil, name: "branches de céleri, hachées finement" },
      { amount: 1.0, unit: nil, name: "oignon, haché finement" },
      { amount: 2.0, unit: nil, name: "branches de romarin frais" },
      { amount: 5.0, unit: "ml", name: "sel" },
      { amount: 1.0, unit: nil, name: "emballage de 250 à 300 g de cretons" },
      { amount: 375.0, unit: "ml", name: "bouillon de poulet" },
      { amount: nil, unit: nil, name: "Sel et poivre du moulin" },
      { amount: 2.0, unit: nil, name: "rouleaux de 500 g de polenta du commerce" },
      { amount: 70.0, unit: "g", name: "parmesan, râpé" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Préchauffer le four à 230 °C (450 °F) et placer la grille au centre.",
      "Dans une grande poêle, faire fondre le beurre à feu moyen-vif. Ajouter la carotte, le céleri, l’oignon, les branches de romarin et le sel, puis faire sauter pendant 5 min.",
      "Ajouter les cretons et le bouillon de poulet dans la poêle. Saler et poivrer. Défaire délicatement les cretons à l’aide d’une cuillère de bois, puis laisser mijoter à feu doux pendant 10 min.",
      "Pendant ce temps, couper chaque rouleau de polenta en 6 tranches d’épaisseur égale.",
      "Verser les trois quarts de la sauce au fond d’un plat de cuisson de 23 cm x 33 cm (9 po x 13 po). Y déposer les tranches de polenta en les faisant se chevaucher légèrement, puis napper du reste de la sauce et parsemer du parmesan râpé.",
      "Enfourner pendant 20 min. (Activer le gril durant les dernières minutes si on préfère un résultat bien doré et gratiné).",
      "Servir chaud, accompagné d’une salade verte croquante, si désiré."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Préchauffer le four à 230 °C (450 °F) et placer la grille au centre.\nDans une grande poêle, faire fondre le beurre à feu moyen-vif. Ajouter la carotte, le céleri, l’oignon, les branches de romarin et le sel, puis faire sauter pendant 5 min.\nAjouter les cretons et le bouillon de poulet dans la poêle. Saler et poivrer. Défaire délicatement les cretons à l’aide d’une cuillère de bois, puis laisser mijoter à feu doux pendant 10 min.\nPendant ce temps, couper chaque rouleau de polenta en 6 tranches d’épaisseur égale.\nVerser les trois quarts de la sauce au fond d’un plat de cuisson de 23 cm x 33 cm (9 po x 13 po). Y déposer les tranches de polenta en les faisant se chevaucher légèrement, puis napper du reste de la sauce et parsemer du parmesan râpé.\nEnfourner pendant 20 min. (Activer le gril durant les dernières minutes si on préfère un résultat bien doré et gratiné).\nServir chaud, accompagné d’une salade verte croquante, si désiré.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("veroniquecloutier.com")
    expect(recipe.canonical_url).to eq("https://veroniquecloutier.com/cuisine/polenta-cremeuse-et-sa-bolognaise-blanche-rapido-de-dan-blake")
    expect(recipe.site_name).to eq("Véronique Cloutier")
    expect(recipe.language).to eq("fr-CA")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Inspiré des gnocchis à la romaine, ce plat savoureux de polenta se prépare en un tournemain grâce à des raccourcis du commerce bien pensés.")
    expect(recipe.image).to eq("https://s3.amazonaws.com/rose.vero/wp-content/uploads/2026/09/23155523/polenta-dan-blake.jpg")
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
    expect(recipe.links).to include("#_")
  end
end
