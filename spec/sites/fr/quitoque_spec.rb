# frozen_string_literal: true

RSpec.describe "quitoque.fr" do
  subject(:recipe) { scrape_cassette("fr/quitoque", url: "https://www.quitoque.fr/recettes/burger-brioche-au-butternut-a-la-sauce-hoisin-cacahuetes-et-sauce-fraiche-a-la-coriandre") }

  it "reads the title" do
    expect(recipe.title).to eq("Burger brioché au butternut à la sauce hoisin, cacahuètes et sauce fraîche à la coriandre")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 pomme de terre",
      "20 ml sauce hoisin",
      "2 pain burger brioché",
      "qq brins coriandre",
      "600 g courge butternut",
      "100 g fromage blanc",
      "25 g cacahuètes grillées sans sel",
      "0.25 oignon rouge",
      "1 sucrine"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: nil, name: "pomme de terre" },
      { amount: 20.0, unit: "ml", name: "sauce hoisin" },
      { amount: 2.0, unit: nil, name: "pain burger brioché" },
      { amount: nil, unit: nil, name: "qq brins coriandre" },
      { amount: 600.0, unit: "g", name: "courge butternut" },
      { amount: 100.0, unit: "g", name: "fromage blanc" },
      { amount: 25.0, unit: "g", name: "cacahuètes grillées sans sel" },
      { amount: 0.25, unit: nil, name: "oignon rouge" },
      { amount: 1.0, unit: nil, name: "sucrine" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "1. Les frites",
      "Préchauffez votre four à 220°C en chaleur tournante ! Pendant ce temps, épluchez et coupez les pommes de terre en frites. Épluchez le butternut et retirez les graines à l'aide d'une cuillère. Coupez le butternut de manière à obtenir 1 à 2 palets par personne et réservez-les. Coupez le reste en frites. Déposez les frites de pommes de terre et de butternut sur une plaque allant au four. Versez un filet d'huile, salez, poivrez et mélangez bien pour tout enrober. Enfournez 15 à 20 min. En parallèle, préparez les palets de butternut.",
      "2. Les palets de butternut",
      "Dans un bol, mélangez l'eau et la sauce hoisin. Dans une sauteuse, faites chauffer un filet d'huile de cuisson à feu moyen à vif. Faites dorer les palets de butternut 1 à 2 min sur chaque face. Ajoutez ensuite le mélangez eau et sauce hoisin et poursuivez la cuisson 15 min à couvert à feu moyen. En parallèle, préparez le reste des ingrédients.",
      "3. Les burgers",
      "Ouvrez les pains à burger et faites les dorer 5 minutes au four. Coupez l'oignon rouge en rondelles. Hachez grossièrement les cacahuètes. Retirez la base de la sucrine et effeuillez-la. Gardez 1 à 2 feuille de sucrine par personne et assaisonnez le reste d'un filet d'huile d'olive et de vinaigre. Ciselez (en entier, les tiges se consomment) la coriandre. Mélangez la coriandre et le fromage blanc. Salez, poivrez. Sur la base de chaque pain à burger, répartissez les palets de butternut, les feuilles de sucrine, l'oignon rouge, la sauce au fromage blanc et les cacahuètes. Refermez les burgers."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("1. Les frites\nPréchauffez votre four à 220°C en chaleur tournante ! Pendant ce temps, épluchez et coupez les pommes de terre en frites. Épluchez le butternut et retirez les graines à l'aide d'une cuillère. Coupez le butternut de manière à obtenir 1 à 2 palets par personne et réservez-les. Coupez le reste en frites. Déposez les frites de pommes de terre et de butternut sur une plaque allant au four. Versez un filet d'huile, salez, poivrez et mélangez bien pour tout enrober. Enfournez 15 à 20 min. En parallèle, préparez les palets de butternut.\n2. Les palets de butternut\nDans un bol, mélangez l'eau et la sauce hoisin. Dans une sauteuse, faites chauffer un filet d'huile de cuisson à feu moyen à vif. Faites dorer les palets de butternut 1 à 2 min sur chaque face. Ajoutez ensuite le mélangez eau et sauce hoisin et poursuivez la cuisson 15 min à couvert à feu moyen. En parallèle, préparez le reste des ingrédients.\n3. Les burgers\nOuvrez les pains à burger et faites les dorer 5 minutes au four. Coupez l'oignon rouge en rondelles. Hachez grossièrement les cacahuètes. Retirez la base de la sucrine et effeuillez-la. Gardez 1 à 2 feuille de sucrine par personne et assaisonnez le reste d'un filet d'huile d'olive et de vinaigre. Ciselez (en entier, les tiges se consomment) la coriandre. Mélangez la coriandre et le fromage blanc. Salez, poivrez. Sur la base de chaque pain à burger, répartissez les palets de butternut, les feuilles de sucrine, l'oignon rouge, la sauce au fromage blanc et les cacahuètes. Refermez les burgers.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("quitoque.fr")
    expect(recipe.canonical_url).to eq("https://www.quitoque.fr/recettes/burger-brioche-au-butternut-a-la-sauce-hoisin-cacahuetes-et-sauce-fraiche-a-la-coriandre")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("fr")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("La sauce hoisin, douce et légèrement épicée, sublime notre burger brioché au butternut, accompagné de cacahuètes et d'une sauce fraîche à la coriandre")
    expect(recipe.image).to eq("https://www.quitoque.fr/media/cache/resolve/sylius_shop_product_cover_2x/e1/ca/63cb2c3a09344de99be3a1e2bc52.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(25)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.1612903225806)
    expect(recipe.ratings_count).to eq(31)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
