# frozen_string_literal: true

RSpec.describe "recipeforperfection.com" do
  subject(:recipe) { scrape_cassette("com/recipeforperfection", url: "https://recipeforperfection.com/thick-and-fluffy-flour-tortillas-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Thick and Fluffy Flour Tortillas Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups all purpose flour (for gluten free see note)",
      "1 1/2 teaspoon baking powder",
      "3/4 teaspoon sea salt",
      "2 teaspoons extra virgin olive oil (or your preferred vegetable oil)",
      "3/4 cup warm milk"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "all purpose flour" },
      { amount: 1.5, unit: "teaspoon", name: "baking powder" },
      { amount: 0.75, unit: "teaspoon", name: "sea salt" },
      { amount: 2.0, unit: "teaspoons", name: "extra virgin olive oil" },
      { amount: 0.75, unit: "cup", name: "warm milk" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Stir together the flour, baking powder, and salt. Drizzle with the olive oil and stir again. Add the milk and stir, scraping down the sides and bottom of the bowl, until dough comes together. It should be a little sticky, but not extremely sticky. If it is extremely sticky, sprinkle on a tiny bit of flour until it is just a little sticky.",
      "Knead dough for 2 minutes, then form it into a large ball. Place in a clean bowl and cover the bowl tightly with plastic wrap. Let the dough rest for 20 minutes.",
      "Cut the dough into 8 equal sections and roll each section into a ball. Place the dough balls back in the bowl, cover tightly with plastic wrap, and let it rest for 15 minutes.",
      "Heat a nonstick skillet on medium low for 5 minutes. While you are preheating the skillet, roll out a dough ball into a round shape, as thin as you can manage without making it so thin it will tear.",
      "Place the tortilla in the skillet. Wait 30 seconds or so until the tortilla puffs up, and the side facing down has little golden brown spots. Flip it. Cook another 30 seconds or so until a few golden brown spots appear. Put on a plate and cover loosely with foil (add your cooked tortillas to this stack as you go, so they stay warm and moist until ready to serve)."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Stir together the flour, baking powder, and salt. Drizzle with the olive oil and stir again. Add the milk and stir, scraping down the sides and bottom of the bowl, until dough comes together. It should be a little sticky, but not extremely sticky. If it is extremely sticky, sprinkle on a tiny bit of flour until it is just a little sticky.\nKnead dough for 2 minutes, then form it into a large ball. Place in a clean bowl and cover the bowl tightly with plastic wrap. Let the dough rest for 20 minutes.\nCut the dough into 8 equal sections and roll each section into a ball. Place the dough balls back in the bowl, cover tightly with plastic wrap, and let it rest for 15 minutes.\nHeat a nonstick skillet on medium low for 5 minutes. While you are preheating the skillet, roll out a dough ball into a round shape, as thin as you can manage without making it so thin it will tear.\nPlace the tortilla in the skillet. Wait 30 seconds or so until the tortilla puffs up, and the side facing down has little golden brown spots. Flip it. Cook another 30 seconds or so until a few golden brown spots appear. Put on a plate and cover loosely with foil (add your cooked tortillas to this stack as you go, so they stay warm and moist until ready to serve).")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("recipeforperfection.com")
    expect(recipe.canonical_url).to eq("https://recipeforperfection.com/thick-and-fluffy-flour-tortillas-recipe/")
    expect(recipe.site_name).to eq("Recipe for Perfection")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Katie Moseman")
    expect(recipe.description).to eq("Thick, fluffy restaurant style tortillas can be made at home with this easy recipe!")
    expect(recipe.image).to eq("https://recipeforperfection.com/wp-content/uploads/2015/06/Restaurant-Style-Flour-Tortillas-on-a-plate.jpg")
    expect(recipe.category).to eq("Bread")
    expect(recipe.cuisine).to eq("Mexican")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(50)
    expect(recipe.prep_time).to eq(40)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.92)
    expect(recipe.ratings_count).to eq(25)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "137 kcal",
      "carbohydrateContent" => "25 g",
      "proteinContent" => "3 g",
      "fatContent" => "2 g",
      "cholesterolContent" => "2 mg",
      "sodiumContent" => "229 mg",
      "sugarContent" => "1 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 137.0 },
      { name: "carbohydrateContent", unit: "g", amount: 25.0 },
      { name: "proteinContent", unit: "g", amount: 3.0 },
      { name: "fatContent", unit: "g", amount: 2.0 },
      { name: "cholesterolContent", unit: "mg", amount: 2.0 },
      { name: "sodiumContent", unit: "mg", amount: 229.0 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
