# frozen_string_literal: true

RSpec.describe "staysnatched.com" do
  subject(:recipe) { scrape_cassette("com/staysnatched", url: "https://www.staysnatched.com/beef-and-shells/") }

  it "reads the title" do
    expect(recipe.title).to eq("Creamy Beef and Shells (High Protein Pasta)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 pound ground beef or turkey",
      "1 teaspoon Worcestershire sauce",
      "2 teaspoons Italian Seasoning (Divided into 2 portions; 1 teaspoon each)",
      "1/2 teaspoon garlic powder",
      "1/2 teaspoon smoked paprika",
      "salt and pepper to taste",
      "1/2 cup onions",
      "2 tablespoons tomato paste",
      "6 oz shells pasta",
      "3 cups broth",
      "2 cups fresh spinach",
      "2 cups grated cheddar cheese",
      "1 1/2 cups plain Greek yogurt (Room temperature.)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "pound", name: "ground beef or turkey" },
      { amount: 1.0, unit: "teaspoon", name: "Worcestershire sauce" },
      { amount: 2.0, unit: "teaspoons", name: "Italian Seasoning" },
      { amount: 0.5, unit: "teaspoon", name: "garlic powder" },
      { amount: 0.5, unit: "teaspoon", name: "smoked paprika" },
      { amount: nil, unit: nil, name: "salt and pepper to taste" },
      { amount: 0.5, unit: "cup", name: "onions" },
      { amount: 2.0, unit: "tablespoons", name: "tomato paste" },
      { amount: 6.0, unit: "oz", name: "shells pasta" },
      { amount: 3.0, unit: "cups", name: "broth" },
      { amount: 2.0, unit: "cups", name: "fresh spinach" },
      { amount: 2.0, unit: "cups", name: "grated cheddar cheese" },
      { amount: 1.5, unit: "cups", name: "plain Greek yogurt" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Heat a skillet on medium heat with the ground beef. Break down the ground beef and cook for 4-5 minutes or until fully cooked and no longer pink.",
      "Drain any excess fat from the pan. Add the Worcestershire sauce, onions, 1 teaspoon of Italian Seasoning, smoked paprika, garlic powder, salt, and pepper to taste. Stir and cook until the onions are fragrant.",
      "Add the tomato paste, shells pasta, broth, and 1 teaspoon Italian seasoning to the pan. Ensure the noodles are submerged in liquid. Add additional broth or water if needed. This important for the noodles to soften.",
      "Adjust the heat on the pan to Low. Place the lid on the pan and cook for 10-15 minutes or until the noodles soften.",
      "While the dish simmers, remove the lid and stir every 4-5 minutes to prevent scorching at the bottom of the pan. If the dish appears dry add more broth or water and stir.",
      "Once the shells have softened, remove the lid and add grated cheddar cheese and spinach. Stir and cook until the cheese has melted and the spinach has wilted.",
      "Remove the pan from the heat and allow it to cool for 5-10 minutes. Add in the Greek yogurt and stir. Serve.It's important to add the Greek yogurt after the dish has cooled. If you add it to a hot pan it will curdle."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Heat a skillet on medium heat with the ground beef. Break down the ground beef and cook for 4-5 minutes or until fully cooked and no longer pink.\nDrain any excess fat from the pan. Add the Worcestershire sauce, onions, 1 teaspoon of Italian Seasoning, smoked paprika, garlic powder, salt, and pepper to taste. Stir and cook until the onions are fragrant.\nAdd the tomato paste, shells pasta, broth, and 1 teaspoon Italian seasoning to the pan. Ensure the noodles are submerged in liquid. Add additional broth or water if needed. This important for the noodles to soften.\nAdjust the heat on the pan to Low. Place the lid on the pan and cook for 10-15 minutes or until the noodles soften.\nWhile the dish simmers, remove the lid and stir every 4-5 minutes to prevent scorching at the bottom of the pan. If the dish appears dry add more broth or water and stir.\nOnce the shells have softened, remove the lid and add grated cheddar cheese and spinach. Stir and cook until the cheese has melted and the spinach has wilted.\nRemove the pan from the heat and allow it to cool for 5-10 minutes. Add in the Greek yogurt and stir. Serve.It's important to add the Greek yogurt after the dish has cooled. If you add it to a hot pan it will curdle.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("staysnatched.com")
    expect(recipe.canonical_url).to eq("https://www.staysnatched.com/beef-and-shells/")
    expect(recipe.site_name).to eq("Stay Snatched")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Brandi Crawford")
    expect(recipe.description).to eq("This hearty Beef and Shells recipe is made with ground beef and other high protein ingredients. This dish is a nutritious spin on classic comfort food. Enhanced with Greek yogurt for a creamy texture and added vegetables for extra nutrients, it’s ideal for weeknight dinners or meal prep. Whether you’re looking to fuel your workouts or feed a hungry family, this recipe is a balanced blend of flavors using everyday ingredients that everyone will love.")
    expect(recipe.image).to eq("https://www.staysnatched.com/wp-content/uploads/2024/10/high-protein-pasta-beef-and-shells-recipe-4-1.jpg")
    expect(recipe.category).to eq("dinner")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("5 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(25)
    expect(recipe.keywords).to eq([
      "beef and shells",
      "high protein pasta",
      "high protein pasta recipe",
      "high protein recipes"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.88)
    expect(recipe.ratings_count).to eq(8)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 serving",
      "calories" => "545 kcal",
      "fatContent" => "29 g",
      "carbohydrateContent" => "32 g",
      "proteinContent" => "41 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "serving", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 545.0 },
      { name: "fatContent", unit: "g", amount: 29.0 },
      { name: "carbohydrateContent", unit: "g", amount: 32.0 },
      { name: "proteinContent", unit: "g", amount: 41.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.staysnatched.com/")
  end
end
