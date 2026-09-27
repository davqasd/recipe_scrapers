# frozen_string_literal: true

RSpec.describe "goldnplump.com" do
  subject(:recipe) { scrape_cassette("com/goldnplump", url: "https://goldnplump.com/recipes/savory-skillet-chicken-farfalle") }

  it "reads the title" do
    expect(recipe.title).to eq("Savory Skillet Chicken Farfalle")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "8 ounces uncooked farfalle (bow-tie) pasta",
      "2 tablespoons olive oil",
      "4 (24 ounces) Gold'n Plump® Boneless Skinless Chicken Breasts, cut into 3/4-inch pieces",
      "4 cloves garlic, finely chopped",
      "1 cup finely chopped onion",
      "1 medium red bell pepper, coarsely chopped (1 cup)",
      "1 medium yellow bell pepper, coarsely chopped (1 cup)",
      "1/4 cup golden raisins",
      "1/4 cup finely chopped fresh mint and/or basil",
      "1 cup (4 ounces) crumbled feta cheese",
      "1/4 cup pine nuts, toasted",
      "Freshly ground pepper to taste"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 8.0, unit: "ounces", name: "uncooked farfalle pasta" },
      { amount: 2.0, unit: "tablespoons", name: "olive oil" },
      { amount: 4.0, unit: nil, name: "Gold'n Plump® Boneless Skinless Chicken Breasts, cut into 3/4-inch pieces" },
      { amount: 4.0, unit: "cloves", name: "garlic, finely chopped" },
      { amount: 1.0, unit: "cup", name: "finely chopped onion" },
      { amount: 1.0, unit: nil, name: "medium red bell pepper, coarsely chopped" },
      { amount: 1.0, unit: nil, name: "medium yellow bell pepper, coarsely chopped" },
      { amount: 0.25, unit: "cup", name: "golden raisins" },
      { amount: 0.25, unit: "cup", name: "finely chopped fresh mint and/or basil" },
      { amount: 1.0, unit: "cup", name: "crumbled feta cheese" },
      { amount: 0.25, unit: "cup", name: "pine nuts, toasted" },
      { amount: nil, unit: nil, name: "Freshly ground pepper to taste" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Cook pasta according to package directions; drain, reserving 1/2 cup cooking liquid.",
      "Meanwhile, heat 1 tablespoon oil in large skillet over medium-high heat. Add chicken and half of garlic, cook, stirring occasionally, 6 to 8 minutes or until chicken is no longer pink in center. Remove from skillet to plate.",
      "Add remaining 1 tablespoon oil and garlic to skillet. Stir in onion, bell peppers, and raisins; cook, stirring occasionally, about 8 minutes or until tender. Stir chicken and pasta with reserved cooking liquid into skillet; cook and stir 1 minute.",
      "Serve chicken and pasta sprinkled with herbs, feta, and pine nuts."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Cook pasta according to package directions; drain, reserving 1/2 cup cooking liquid.\nMeanwhile, heat 1 tablespoon oil in large skillet over medium-high heat. Add chicken and half of garlic, cook, stirring occasionally, 6 to 8 minutes or until chicken is no longer pink in center. Remove from skillet to plate.\nAdd remaining 1 tablespoon oil and garlic to skillet. Stir in onion, bell peppers, and raisins; cook, stirring occasionally, about 8 minutes or until tender. Stir chicken and pasta with reserved cooking liquid into skillet; cook and stir 1 minute.\nServe chicken and pasta sprinkled with herbs, feta, and pine nuts.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("goldnplump.com")
    expect(recipe.canonical_url).to eq("https://www.goldnplump.com/recipes/savory-skillet-chicken-farfalle")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en")
    expect(recipe.author).to be_nil
    expect(recipe.description).to be_nil
    expect(recipe.image).to eq("https://www.goldnplump.com/sites/default/files/GNP_SkilletCknFarfalle_2012Eclub_WEB.jpg")
    expect(recipe.category).to eq("Main Entrees")
    expect(recipe.cuisine).to eq("Mediterranean")
    expect(recipe.cooking_method).to eq("Stovetop")
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "665",
      "fatContent" => "22",
      "saturatedFatContent" => "6",
      "carbohydrateContent" => "70",
      "proteinContent" => "51",
      "sugarContent" => "13",
      "cholesterolContent" => "120",
      "fiberContent" => "5",
      "sodiumContent" => "1180"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: nil, amount: 665.0 },
      { name: "fatContent", unit: nil, amount: 22.0 },
      { name: "saturatedFatContent", unit: nil, amount: 6.0 },
      { name: "carbohydrateContent", unit: nil, amount: 70.0 },
      { name: "proteinContent", unit: nil, amount: 51.0 },
      { name: "sugarContent", unit: nil, amount: 13.0 },
      { name: "cholesterolContent", unit: nil, amount: 120.0 },
      { name: "fiberContent", unit: nil, amount: 5.0 },
      { name: "sodiumContent", unit: nil, amount: 1180.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
