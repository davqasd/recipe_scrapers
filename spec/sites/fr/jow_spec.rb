# frozen_string_literal: true

RSpec.describe "jow.fr" do
  subject(:recipe) { scrape_cassette("fr/jow", url: "https://jow.fr/recipes/tartine-a-la-provencale-et-oeuf-mollet-8xrr5dkz6fc002uv0ihv") }

  it "reads the title" do
    expect(recipe.title).to eq("Tartine à la provençale & œuf mollet")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 tran. Pain de campagne (tranché)",
      "30 g Fromage frais",
      "80 g Ratatouille",
      "1 Œuf",
      "1 poignée Salade (Mélange)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "tran", name: "Pain de campagne" },
      { amount: 30.0, unit: "g", name: "Fromage frais" },
      { amount: 80.0, unit: "g", name: "Ratatouille" },
      { amount: 1.0, unit: nil, name: "Œuf" },
      { amount: 1.0, unit: "poignée", name: "Salade" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Faites cuire les œufs pendant 6 minutes dans une casserole d'eau bouillante. Une fois cuits, plongez-les dans de l'eau froide pour stopper la cuisson. Enlevez la coquille délicatement. Réservez.",
      "Pendant ce temps, réchauffez la ratatouille à la casserole ou au micro-ondes. Mélangez.",
      "Faites toaster les tranches de pain au grille-pain ou à la poêle.",
      "Tartinez les tranches de pain de fromage frais, puis ajoutez la ratatouille par-dessus.",
      "Servez les tartines avec une salade verte et l'œuf mollet par-dessus. Salez, poivrez et ajoutez un filet d'huile d'olive. C'est prêt !"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Faites cuire les œufs pendant 6 minutes dans une casserole d'eau bouillante. Une fois cuits, plongez-les dans de l'eau froide pour stopper la cuisson. Enlevez la coquille délicatement. Réservez.\nPendant ce temps, réchauffez la ratatouille à la casserole ou au micro-ondes. Mélangez.\nFaites toaster les tranches de pain au grille-pain ou à la poêle.\nTartinez les tranches de pain de fromage frais, puis ajoutez la ratatouille par-dessus.\nServez les tartines avec une salade verte et l'œuf mollet par-dessus. Salez, poivrez et ajoutez un filet d'huile d'olive. C'est prêt !")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("jow.fr")
    expect(recipe.canonical_url).to eq("https://jow.fr/recipes/tartine-a-la-provencale-et-oeuf-mollet-8xrr5dkz6fc002uv0ihv")
    expect(recipe.site_name).to eq("Jow")
    expect(recipe.language).to eq("fr-FR")
    expect(recipe.author).to eq("Jow")
    expect(recipe.description).to eq("Un petit goût de Provence pour un repas sur le pouce ! Tartine à la provençale & œuf mollet par Jow en 5 étapes, en 8 minutes et avec 5 ingrédients.")
    expect(recipe.image).to eq("https://static.jow.fr/1024x1024/recipes/EVyHVWPc7u4cFQ.jpg")
    expect(recipe.category).to eq("Sandwich/Toast/Tartines (froid)")
    expect(recipe.cuisine).to eq("Internationale")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("1 servings")
    expect(recipe.total_time).to eq(8)
    expect(recipe.prep_time).to eq(2)
    expect(recipe.cook_time).to eq(6)
    expect(recipe.keywords).to eq([
      "sandwich",
      "tartine",
      "toast",
      "bruschetta",
      "brunch",
      "ratatouille",
      "fromage frais",
      "œuf",
      "salade",
      "rapide",
      "facile",
      "express",
      "sans-porc",
      "végé",
      "veggie",
      "vegie",
      "végétarien",
      "rapide",
      "express",
      "fast",
      "petit budget",
      "pas cher",
      "cheap",
      "low budget"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.8)
    expect(recipe.ratings_count).to eq(1488)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "316 kcal",
      "fatContent" => "15 g",
      "proteinContent" => "14 g",
      "carbohydrateContent" => "25 g",
      "fiberContent" => "4 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 316.0 },
      { name: "fatContent", unit: "g", amount: 15.0 },
      { name: "proteinContent", unit: "g", amount: 14.0 },
      { name: "carbohydrateContent", unit: "g", amount: 25.0 },
      { name: "fiberContent", unit: "g", amount: 4.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
