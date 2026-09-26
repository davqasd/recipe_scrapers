# frozen_string_literal: true

RSpec.describe "im-worthy.com" do
  subject(:recipe) { scrape_cassette("com/im_worthy", url: "https://im-worthy.com/almond-flour-pancakes/") }

  it "reads the title" do
    expect(recipe.title).to eq("Vegan Almond Flour Pancakes (Fluffy & Gluten-free)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1/2 cup Almond flour",
      "1 cup *oat flour",
      "1/2-1 cup non-dairy milk (plus more, if needed)",
      "2 tsp baking powder",
      "pinch of salt",
      "1 tbsp maple syrup (optional - can sub for sweetener of choice)",
      "1 tsp vanilla extract",
      "1 tsp coconut oil (for cooking. Add more, if needed. Can sub for avocado oil)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.5, unit: "cup", name: "Almond flour" },
      { amount: 1.0, unit: "cup", name: "*oat flour" },
      { amount: 0.5, unit: "cup", name: "non-dairy milk" },
      { amount: 2.0, unit: "tsp", name: "baking powder" },
      { amount: 1.0, unit: "pinch", name: "salt" },
      { amount: 1.0, unit: "tbsp", name: "maple syrup" },
      { amount: 1.0, unit: "tsp", name: "vanilla extract" },
      { amount: 1.0, unit: "tsp", name: "coconut oil" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In separate bowls: mix the wet & dry ingredients.",
      "Add the wet ingredients to the dry ingredients and stir until combined. Start with 1/2 cup milk and add more until the batter is slightly lumpy & creamy. (It should not be runny. If runny, add more oat/all-purpose flour. If too thick, add more non-dairy milk.)",
      "Let the pancake batter rest for 5 minutes to thicken while you heat the pan according to the next steps below.",
      "Add the oil to a nonstick pan over medium heat. Once the pan is hot pour the batter into the pan using a 1/4 measuring cup (for easy cleanup).",
      "Cook on each side for about 2-5 minutes (depending on your pan) or until you see little bubbles form on top, then flip and let them cook for another couple of minutes.",
      "Serve with your favorite toppings. Some suggestions include maple syrup, coconut whipped cream, fresh berries, or vegan butter."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In separate bowls: mix the wet & dry ingredients.\nAdd the wet ingredients to the dry ingredients and stir until combined. Start with 1/2 cup milk and add more until the batter is slightly lumpy & creamy. (It should not be runny. If runny, add more oat/all-purpose flour. If too thick, add more non-dairy milk.)\nLet the pancake batter rest for 5 minutes to thicken while you heat the pan according to the next steps below.\nAdd the oil to a nonstick pan over medium heat. Once the pan is hot pour the batter into the pan using a 1/4 measuring cup (for easy cleanup).\nCook on each side for about 2-5 minutes (depending on your pan) or until you see little bubbles form on top, then flip and let them cook for another couple of minutes.\nServe with your favorite toppings. Some suggestions include maple syrup, coconut whipped cream, fresh berries, or vegan butter.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("im-worthy.com")
    expect(recipe.canonical_url).to eq("https://im-worthy.com/almond-flour-pancakes/")
    expect(recipe.site_name).to eq("IM-WORTHY")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Shana Thomas")
    expect(recipe.description).to eq("These almond flour pancakes are sweet, fluffy and easy to make. They're vegan, gluten-free and can easily be made keto-friendly. Serve with fresh fruit or maple syrup.")
    expect(recipe.image).to eq("https://im-worthy.com/wp-content/uploads/2020/11/Almond-Flour-Pancakes_Blog4.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(15)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(5)
    expect(recipe.keywords).to eq([
      "almond flour pancakes",
      "almond flour recipes",
      "healthy breakfast pancakes",
      "healthy Breakfast Recipe",
      "pancakes using almond flour",
      "pancakes with almond flour",
      "Vegan Almond Flour Pancakes"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(%w[VeganDiet VegetarianDiet])
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(17)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "calories" => "180 kcal", "servingSize" => "1 serving" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 180.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
