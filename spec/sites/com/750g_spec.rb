# frozen_string_literal: true

RSpec.describe "750g.com" do
  subject(:recipe) { scrape_cassette("com/750g", url: "https://www.750g.com/petits-sables-r23034.htm") }

  it "reads the title" do
    expect(recipe.title).to eq("Petits sablés faciles")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "250 g de farine",
      "125 g de beurre",
      "125 g de sucre",
      "1 oeuf",
      "1 pincée de sel ou sel fin"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 250.0, unit: "g", name: "farine" },
      { amount: 125.0, unit: "g", name: "beurre" },
      { amount: 125.0, unit: "g", name: "sucre" },
      { amount: 1.0, unit: nil, name: "oeuf" },
      { amount: 1.0, unit: "pincée", name: "sel ou sel fin" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Mélanger le beurre et le sucre.",
      "Ajouter l’oeuf et mélanger.",
      "Ajouter toute la farine.",
      "Malaxer à la main.",
      "Emballer la pâte dans un film alimentaire.",
      "Réserver la pâte au frais pendant au moins 1 heure.",
      "Étaler au rouleau sur un plan de travail fariné sur une épaisseur de 5 mm environ.",
      "Utiliser des emporte-pièces pour faire les découpes.",
      "Recouvrir la plaque du four avec du papier cuisson.",
      "Enfourner pendant 10 min à 180°C.",
      "Placer aussitôt les sablés sur une grille de refroidissement."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Mélanger le beurre et le sucre.\nAjouter l’oeuf et mélanger.\nAjouter toute la farine.\nMalaxer à la main.\nEmballer la pâte dans un film alimentaire.\nRéserver la pâte au frais pendant au moins 1 heure.\nÉtaler au rouleau sur un plan de travail fariné sur une épaisseur de 5 mm environ.\nUtiliser des emporte-pièces pour faire les découpes.\nRecouvrir la plaque du four avec du papier cuisson.\nEnfourner pendant 10 min à 180°C.\nPlacer aussitôt les sablés sur une grille de refroidissement.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("750g.com")
    expect(recipe.canonical_url).to eq("https://www.750g.com/petits-sables-r23034.htm")
    expect(recipe.site_name).to eq("750g")
    expect(recipe.language).to eq("fr")
    expect(recipe.author).to eq("Cécilou")
    expect(recipe.description).to eq("Vous voulez faire des petits gâteaux maison pour le petit déjeuner ou le goûter ? Ces petits sablés gourmands sont parfaits. Pour réussir la pâte de ces petits sablés, vous avez besoin d'ingrédients basiques tels que de la farine, de beurre (doux ou demi-sel), de quelques œufs et de sucre. Et si le cœur vous en dit, vous pouvez rajouter de la pâte à tartiner, de la confiture ainsi des arômes (vanille ou bien cannelle). Une fois prête, laissez la pâte au frigidaire pendant une petite heure. Ensuite, vous allez vous amusez avec les emporte-pièces afin de donner une forme sympathique à vos petits sablés. Vous devriez obtenir une trentaine de biscuits. Cuits durant une dizaine de minutes, vos petits sablés croquants et gourmands se conservent plusieurs jours dans une boite hermétique.")
    expect(recipe.image).to eq("https://static.750g.com/images/1200-675/1510306f7e73846c2de772d8e1a770e6/petits-sables.jpg")
    expect(recipe.category).to eq("Biscuits")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("24 items")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq([
      "petits sablés",
      "sables ausstecherle",
      "sablés",
      "enfants",
      "classiques",
      "cuisine facile",
      "Noël",
      "goûter",
      "biscuits secs",
      "biscuits",
      "desserts",
      "biscuits de Noël"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.3)
    expect(recipe.ratings_count).to eq(859)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "99 kcal",
      "carbohydrateContent" => "12.3 g",
      "fatContent" => "4.7 g",
      "proteinContent" => "1.8 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 99.0 },
      { name: "carbohydrateContent", unit: "g", amount: 12.3 },
      { name: "fatContent", unit: "g", amount: 4.7 },
      { name: "proteinContent", unit: "g", amount: 1.8 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
