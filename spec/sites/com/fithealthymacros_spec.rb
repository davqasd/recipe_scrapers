# frozen_string_literal: true

RSpec.describe "fithealthymacros.com" do
  subject(:recipe) { scrape_cassette("com/fithealthymacros", url: "https://fithealthymacros.com/recipes/high-protein-poppy-seed-chicken-salad/") }

  it "reads the title" do
    expect(recipe.title).to eq("High Protein Poppy Seed Chicken Salad")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups Cooked chicken breast, shredded or chopped",
      "1/2 cup Plain, non-fat Greek yogurt",
      "1/4 cup Celery, finely chopped",
      "1/4 cup Green onions, chopped",
      "2 tbsp Poppy seeds",
      "2 tbsp Lemon juice",
      "1 tsp Honey",
      "1/4 tsp Salt",
      "1/4 tsp Pepper"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "Cooked chicken breast, shredded or chopped" },
      { amount: 0.5, unit: "cup", name: "Plain, non-fat Greek yogurt" },
      { amount: 0.25, unit: "cup", name: "Celery, finely chopped" },
      { amount: 0.25, unit: "cup", name: "Green onions, chopped" },
      { amount: 2.0, unit: "tbsp", name: "Poppy seeds" },
      { amount: 2.0, unit: "tbsp", name: "Lemon juice" },
      { amount: 1.0, unit: "tsp", name: "Honey" },
      { amount: 0.25, unit: "tsp", name: "Salt" },
      { amount: 0.25, unit: "tsp", name: "Pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Shred or chop the cooked chicken breast into bite-sized pieces. You can use rotisserie chicken for convenience or cook chicken breasts yourself.",
      "In a mixing bowl, combine the shredded chicken, Greek yogurt, celery, green onions, and poppy seeds.",
      "In a small bowl, whisk together the lemon juice, honey, salt, and pepper. Pour the dressing over the chicken mixture and stir until everything is evenly coated.",
      "Serve the chicken salad on whole-grain bread, rice cakes, or as a lettuce wrap for a lighter option. You can also serve it on a bed of greens. Alternatively, store in an airtight container in the fridge for up to 3 days."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Shred or chop the cooked chicken breast into bite-sized pieces. You can use rotisserie chicken for convenience or cook chicken breasts yourself.\nIn a mixing bowl, combine the shredded chicken, Greek yogurt, celery, green onions, and poppy seeds.\nIn a small bowl, whisk together the lemon juice, honey, salt, and pepper. Pour the dressing over the chicken mixture and stir until everything is evenly coated.\nServe the chicken salad on whole-grain bread, rice cakes, or as a lettuce wrap for a lighter option. You can also serve it on a bed of greens. Alternatively, store in an airtight container in the fridge for up to 3 days.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("fithealthymacros.com")
    expect(recipe.canonical_url).to eq("https://fithealthymacros.com/recipes/high-protein-poppy-seed-chicken-salad/")
    expect(recipe.site_name).to eq("Fit Healthy Macros")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Tami Smith")
    expect(recipe.description).to eq("This High Protein Poppy Seed Chicken Salad is light, creamy, and ready in minutes - with 27g of protein per serving for a filling, healthy meal you’ll love.")
    expect(recipe.image).to eq("https://fithealthymacros.com/wp-content/uploads/2025/08/High-Protein-Poppy-Seed-Chicken-Salad.jpg")
    expect(recipe.category).to eq("Lunch")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "131 g",
      "calories" => "175 kcal",
      "carbohydrateContent" => "4.9 g",
      "proteinContent" => "27 g",
      "fatContent" => "4.8 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "g", amount: 131.0 },
      { name: "calories", unit: "kcal", amount: 175.0 },
      { name: "carbohydrateContent", unit: "g", amount: 4.9 },
      { name: "proteinContent", unit: "g", amount: 27.0 },
      { name: "fatContent", unit: "g", amount: 4.8 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.simplystrongapp.com/")
  end
end
