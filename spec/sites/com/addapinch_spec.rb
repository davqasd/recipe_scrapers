# frozen_string_literal: true

RSpec.describe "addapinch.com" do
  subject(:recipe) { scrape_cassette("com/addapinch", url: "https://addapinch.com/the-best-chocolate-cake-recipe-ever/") }

  it "reads the title" do
    expect(recipe.title).to eq("The Best Chocolate Cake Recipe {Ever}")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups all-purpose flour (spoon + level)",
      "2 cups sugar",
      "3/4 cup unsweetened cocoa powder",
      "2 teaspoons baking powder",
      "1 1/2 teaspoons baking soda",
      "1 teaspoon kosher salt",
      "1 teaspoon espresso powder (homemade or store-bought)",
      "1 cup milk (or buttermilk, almond, or coconut milk)",
      "1/2 cup vegetable oil (or canola oil, or melted coconut oil)",
      "2 large eggs",
      "2 teaspoons vanilla extract",
      "1 cup boiling water",
      "Chocolate Buttercream Frosting Recipe"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "all-purpose flour" },
      { amount: 2.0, unit: "cups", name: "sugar" },
      { amount: 0.75, unit: "cup", name: "unsweetened cocoa powder" },
      { amount: 2.0, unit: "teaspoons", name: "baking powder" },
      { amount: 1.5, unit: "teaspoons", name: "baking soda" },
      { amount: 1.0, unit: "teaspoon", name: "kosher salt" },
      { amount: 1.0, unit: "teaspoon", name: "espresso powder" },
      { amount: 1.0, unit: "cup", name: "milk" },
      { amount: 0.5, unit: "cup", name: "vegetable oil" },
      { amount: 2.0, unit: nil, name: "large eggs" },
      { amount: 2.0, unit: "teaspoons", name: "vanilla extract" },
      { amount: 1.0, unit: "cup", name: "boiling water" },
      { amount: nil, unit: nil, name: "Chocolate Buttercream Frosting Recipe" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 350º F. Prepare two 9-inch cake pans by spraying with baking spray, buttering and lightly flouring, or brushing them with homemade chocolate pan release.",
      "For the chocolate cake:",
      "Add flour, sugar, cocoa, baking powder, baking soda, salt and espresso powder to a large bowl or the bowl of a stand mixer. Whisk through to combine or, using your paddle attachment, stir through flour mixture until combined well.",
      "Add milk, vegetable oil, eggs, and vanilla to flour mixture and mix together on medium speed until well combined. Reduce speed and carefully add boiling water to the cake batter until well combined.",
      "Distribute cake batter evenly between the two prepared cake pans. Bake for 30-35 minutes, until a toothpick or cake tester inserted in the center of the chocolate cake comes out clean.",
      "Remove from the oven and allow to cool for about 10 minutes, remove from the pan and cool completely.",
      "Frost the cake with Chocolate Buttercream Frosting."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 350º F. Prepare two 9-inch cake pans by spraying with baking spray, buttering and lightly flouring, or brushing them with homemade chocolate pan release.\nFor the chocolate cake:\nAdd flour, sugar, cocoa, baking powder, baking soda, salt and espresso powder to a large bowl or the bowl of a stand mixer. Whisk through to combine or, using your paddle attachment, stir through flour mixture until combined well.\nAdd milk, vegetable oil, eggs, and vanilla to flour mixture and mix together on medium speed until well combined. Reduce speed and carefully add boiling water to the cake batter until well combined.\nDistribute cake batter evenly between the two prepared cake pans. Bake for 30-35 minutes, until a toothpick or cake tester inserted in the center of the chocolate cake comes out clean.\nRemove from the oven and allow to cool for about 10 minutes, remove from the pan and cool completely.\nFrost the cake with Chocolate Buttercream Frosting.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("addapinch.com")
    expect(recipe.canonical_url).to eq("https://addapinch.com/the-best-chocolate-cake-recipe-ever/")
    expect(recipe.site_name).to eq("Add a Pinch")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Robyn Stone")
    expect(recipe.description).to eq("The Best Chocolate Cake Recipe - A one bowl chocolate cake recipe that is quick, easy, and delicious! Updated with gluten-free, dairy-free, and egg-free options!")
    expect(recipe.image).to eq("https://addapinch.com/wp-content/uploads/2020/04/chocolate-cake-DSC_1768.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("24 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq([
      "best chocolate cake",
      "chocolate cake",
      "chocolate cake recipe",
      "classic chocolate cake",
      "dairy free chocolate cake",
      "easy chocolate cake",
      "egg free chocolate cake",
      "gluten-free chocolate cake"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.99)
    expect(recipe.ratings_count).to eq(5430)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "124 kcal",
      "carbohydrateContent" => "27 g",
      "proteinContent" => "3 g",
      "fatContent" => "1 g",
      "saturatedFatContent" => "1 g",
      "cholesterolContent" => "15 mg",
      "sodiumContent" => "178 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "17 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 124.0 },
      { name: "carbohydrateContent", unit: "g", amount: 27.0 },
      { name: "proteinContent", unit: "g", amount: 3.0 },
      { name: "fatContent", unit: "g", amount: 1.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 15.0 },
      { name: "sodiumContent", unit: "mg", amount: 178.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 17.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
