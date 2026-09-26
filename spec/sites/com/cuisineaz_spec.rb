# frozen_string_literal: true

RSpec.describe "cuisineaz.com" do
  subject(:recipe) { scrape_cassette("com/cuisineaz", url: "https://www.cuisineaz.com/recettes/filet-de-saumon-au-four-63049.aspx") }

  it "reads the title" do
    expect(recipe.title).to eq("Filet de saumon au four")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "600 g Filet de saumon",
      "30 ml Huile d'olive",
      "4 g Origan séché",
      "1 pincée(s) Sel",
      "1 pincée(s) Poivre"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 600.0, unit: "g", name: "Filet de saumon" },
      { amount: 30.0, unit: "ml", name: "Huile d'olive" },
      { amount: 4.0, unit: "g", name: "Origan séché" },
      { amount: 1.0, unit: "pincée", name: "Sel" },
      { amount: 1.0, unit: "pincée", name: "Poivre" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Préparation des pavés de saumon",
      "Préchauffez le four th.7 (210°C). Coupez le filet en pavés de saumon de même taille, correspondant au nombre de parts désirées, et déposez-les sur une plaque huilée ou dans un plat à four. Arrosez-les d'huile d'olive. Salez et poivrez à votre convenance et parsemez d'origan.",
      "Cuisson au four",
      "Disposez le plat ou la plaque au centre du four. Comptez environ 10 min pour un filet de 2 à 2,5 cm d'épaisseur. Le temps nécessaire à la bonne cuisson du saumon dépend non seulement de l'épaisseur des pavés mais aussi de la température réelle de votre four, c'est pourquoi il est important de vérifier régulièrement la cuisson du saumon à l'aide d'une fourchette.",
      "Service",
      "Lorsque vos pavés de saumon sont cuits, servez-les immédiatement, accompagnés d'une bonne salade bien assaisonnée, et éventuellement d'une belle timbale de riz basmati."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Préparation des pavés de saumon\nPréchauffez le four th.7 (210°C). Coupez le filet en pavés de saumon de même taille, correspondant au nombre de parts désirées, et déposez-les sur une plaque huilée ou dans un plat à four. Arrosez-les d'huile d'olive. Salez et poivrez à votre convenance et parsemez d'origan.\nCuisson au four\nDisposez le plat ou la plaque au centre du four. Comptez environ 10 min pour un filet de 2 à 2,5 cm d'épaisseur. Le temps nécessaire à la bonne cuisson du saumon dépend non seulement de l'épaisseur des pavés mais aussi de la température réelle de votre four, c'est pourquoi il est important de vérifier régulièrement la cuisson du saumon à l'aide d'une fourchette.\nService\nLorsque vos pavés de saumon sont cuits, servez-les immédiatement, accompagnés d'une bonne salade bien assaisonnée, et éventuellement d'une belle timbale de riz basmati.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cuisineaz.com")
    expect(recipe.canonical_url).to eq("https://www.cuisineaz.com/recettes/filet-de-saumon-au-four-63049.aspx")
    expect(recipe.site_name).to eq("Cuisine AZ")
    expect(recipe.language).to eq("fr")
    expect(recipe.author).to eq("Cuisine AZ")
    expect(recipe.description).to eq("Toujours savoureux, jamais décevant, le filet de saumon au four est le succès assuré ! Bon pour la santé avec ses oméga-3, il marque de sacrés points côté nutrition. Et avec lui, pas besoin de fioritures, il se suffit à lui-même : un filet d'huile d'olive, de l'origan, du sel, du poivre, et hop, on enfourne ! Un délice légèrement croustillant sur le dessus, carrément fondant à l'intérieur, à servir avec une salade verte bien assaisonnée et du riz basmati.")
    expect(recipe.image).to eq("https://img.cuisineaz.com/1200x1200/2014/02/24/i78436-filet-de-saumon-au-four.jpeg")
    expect(recipe.category).to eq("Poissons")
    expect(recipe.cuisine).to eq("French")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(15)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq([
      "Filet de saumon au four",
      "Plats",
      "Poissons",
      "Recette Filet de saumon au four",
      "recettes",
      "Printemps",
      "Eté",
      "Automne",
      "Recette du midi"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.9)
    expect(recipe.ratings_count).to eq(34)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "calories" => "339" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: nil, amount: 339.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
