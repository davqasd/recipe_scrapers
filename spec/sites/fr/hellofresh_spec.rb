# frozen_string_literal: true

RSpec.describe "hellofresh.fr" do
  subject(:recipe) { scrape_cassette("fr/hellofresh", url: "https://www.hellofresh.fr/recipes/riz-jaune-et-curry-depinards-a-la-noix-de-coco-5be5b2ce30006c07ac356442") }

  it "reads the title" do
    expect(recipe.title).to eq("Riz jaune et curry d'épinards à la noix de coco Avec des tomates, des noix de cajou et un œuf au plat")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 pièce(s) Oignon jaune",
      "2 pièce(s) Gousse d'ail",
      "2 pièce(s) Tomate",
      "1 cc Curcuma en poudre",
      "170 g Riz au pandan",
      "20 g Noix de cajou grillées et non salées",
      "10 g Noix de coco râpée",
      "2 cc Curry en poudre",
      "100 ml Lait de coco",
      "2 pièce(s) Œuf de poule élevée en plein air",
      "200 g Épinards",
      "400 ml Cube de bouillon de légumes",
      "2 cs Huile d'olive",
      "1 cs Huile de tournesol",
      "selon le goût Poivre et sel"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "pièce Oignon jaune" },
      { amount: 2.0, unit: nil, name: "pièce Gousse d'ail" },
      { amount: 2.0, unit: nil, name: "pièce Tomate" },
      { amount: 1.0, unit: "cc", name: "Curcuma en poudre" },
      { amount: 170.0, unit: "g", name: "Riz au pandan" },
      { amount: 20.0, unit: "g", name: "Noix de cajou grillées et non salées" },
      { amount: 10.0, unit: "g", name: "Noix de coco râpée" },
      { amount: 2.0, unit: "cc", name: "Curry en poudre" },
      { amount: 100.0, unit: "ml", name: "Lait de coco" },
      { amount: 2.0, unit: nil, name: "pièce Œuf de poule élevée en plein air" },
      { amount: 200.0, unit: "g", name: "Épinards" },
      { amount: 400.0, unit: "ml", name: "Cube de bouillon de légumes" },
      { amount: 2.0, unit: "cs", name: "Huile d'olive" },
      { amount: 1.0, unit: "cs", name: "Huile de tournesol" },
      { amount: nil, unit: nil, name: "selon le goût Poivre et sel" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Préparez le bouillon. Émincez l’oignon et écrasez l’ail ou hachez-le finement. Coupez la tomate en dés.",
      "Chauffez la moitié de l’huile d’olive dans la casserole à feu moyen et faites-y revenir l’oignon 2 minutes. Ajoutez le curcuma et poursuivez la cuisson 1 minute. Ajoutez le riz et le bouillon, puis faites cuire 12 à 15 minutes à couvert. Ajoutez éventuellement un peu d’eau s’il s'assèche trop vite. Réservez sans couvercle.",
      "Pendant ce temps, faites chauffer le wok ou la sauteuse à feu moyen-vif et faites griller les noix de cajou à sec. Ajoutez la noix de coco râpée après 1 minute. Réservez les deux hors de la poêle.",
      "Laissez refroidir le wok 2 minutes (pour éviter que l’huile de tournesol ne brûle directement). Faites chauffer l’huile de tournesol et faites-y revenir l’ail et le curry 1 à 2 minutes à feu moyen. Ajoutez la tomate et touillez 4 minutes. Ajoutez le lait de coco, salez et poivrez, puis portez le curry à ébullition.",
      "Pendant ce temps, faites chauffer le reste de l’huile d’olive dans la poêle et faites-y cuire un œuf au plat par personne. Déchirez les épinards au dessus du wok, laissez réduire en remuant, puis faites mijoter 1 à 2 minutes.",
      "Servez le riz et les épinards sur les assiettes et disposez l’œuf au plat par-dessus. Garnissez avec les noix de cajou et la noix de coco râpée."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Préparez le bouillon. Émincez l’oignon et écrasez l’ail ou hachez-le finement. Coupez la tomate en dés.\nChauffez la moitié de l’huile d’olive dans la casserole à feu moyen et faites-y revenir l’oignon 2 minutes. Ajoutez le curcuma et poursuivez la cuisson 1 minute. Ajoutez le riz et le bouillon, puis faites cuire 12 à 15 minutes à couvert. Ajoutez éventuellement un peu d’eau s’il s'assèche trop vite. Réservez sans couvercle.\nPendant ce temps, faites chauffer le wok ou la sauteuse à feu moyen-vif et faites griller les noix de cajou à sec. Ajoutez la noix de coco râpée après 1 minute. Réservez les deux hors de la poêle.\nLaissez refroidir le wok 2 minutes (pour éviter que l’huile de tournesol ne brûle directement). Faites chauffer l’huile de tournesol et faites-y revenir l’ail et le curry 1 à 2 minutes à feu moyen. Ajoutez la tomate et touillez 4 minutes. Ajoutez le lait de coco, salez et poivrez, puis portez le curry à ébullition.\nPendant ce temps, faites chauffer le reste de l’huile d’olive dans la poêle et faites-y cuire un œuf au plat par personne. Déchirez les épinards au dessus du wok, laissez réduire en remuant, puis faites mijoter 1 à 2 minutes.\nServez le riz et les épinards sur les assiettes et disposez l’œuf au plat par-dessus. Garnissez avec les noix de cajou et la noix de coco râpée.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hellofresh.fr")
    expect(recipe.canonical_url).to eq("https://www.hellofresh.fr/recipes/riz-jaune-et-curry-depinards-a-la-noix-de-coco-5be5b2ce30006c07ac356442")
    expect(recipe.site_name).to eq("HelloFresh")
    expect(recipe.language).to eq("fr-FR")
    expect(recipe.author).to eq("HelloFresh")
    expect(recipe.description).to eq("Envolez-vous pour l'Inde avec ce curry. L'ingrédient clé de ce mélange d'épices est le curcuma, un condiment important dans la cuisine indienne. Son parfum doux apporte la saveur et la couleur que l'on retrouve dans de nombreux currys. Les noix de cajou apportent du croquant à ce plat.")
    expect(recipe.image).to eq("https://img.hellofresh.com/f_auto,fl_lossy,h_640,q_auto,w_1200/hellofresh_s3/image/5be5b2ce30006c07ac356442-c38e6fad.jpg")
    expect(recipe.category).to eq("Plat principal")
    expect(recipe.cuisine).to eq("Middle East")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(25)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.43181813846935)
    expect(recipe.ratings_count).to eq(11)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "788 kcal",
      "fatContent" => "42 g",
      "saturatedFatContent" => "15.8 g",
      "carbohydrateContent" => "79 g",
      "sugarContent" => "7.7 g",
      "proteinContent" => "21 g",
      "fiberContent" => "7 g",
      "sodiumContent" => "2.6 g",
      "servingSize" => "672"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 788.0 },
      { name: "fatContent", unit: "g", amount: 42.0 },
      { name: "saturatedFatContent", unit: "g", amount: 15.8 },
      { name: "carbohydrateContent", unit: "g", amount: 79.0 },
      { name: "sugarContent", unit: "g", amount: 7.7 },
      { name: "proteinContent", unit: "g", amount: 21.0 },
      { name: "fiberContent", unit: "g", amount: 7.0 },
      { name: "sodiumContent", unit: "g", amount: 2.6 },
      { name: "servingSize", unit: nil, amount: 672.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#page")
  end
end
