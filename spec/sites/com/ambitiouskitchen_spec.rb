# frozen_string_literal: true

RSpec.describe "ambitiouskitchen.com" do
  subject(:recipe) { scrape_cassette("com/ambitiouskitchen", url: "https://www.ambitiouskitchen.com/flourless-almond-butter-brownies/") }

  it "reads the title" do
    expect(recipe.title).to eq("Fudgy Flourless Almond Butter Brownies (gluten free + dairy free)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup creamy, natural almond butter (only almonds + salt as the ingredients)",
      "½ cup packed brown sugar (or sub coconut sugar)",
      "¼ cup pure maple syrup",
      "2 eggs",
      "1 tablespoon coconut oil, melted and cooled (can also use melted butter or vegan butter)",
      "⅓ cup unsweetened cocoa powder or cacao powder (use a high-quality -- not Hershey’s)",
      "¼ teaspoon baking soda",
      "⅛ teaspoon salt",
      "¼ cup chocolate chips, dairy free if desired",
      "2 tablespoons chocolate chips, dairy free if desired",
      "½ teaspoon coconut oil",
      "Fancy sea salt, for sprinkling on top"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "creamy, natural almond butter" },
      { amount: 0.5, unit: "cup", name: "packed brown sugar" },
      { amount: 0.25, unit: "cup", name: "pure maple syrup" },
      { amount: 2.0, unit: nil, name: "eggs" },
      { amount: 1.0, unit: "tablespoon", name: "coconut oil, melted and cooled" },
      { amount: 0.33, unit: "cup", name: "unsweetened cocoa powder or cacao powder" },
      { amount: 0.25, unit: "teaspoon", name: "baking soda" },
      { amount: 0.13, unit: "teaspoon", name: "salt" },
      { amount: 0.25, unit: "cup", name: "chocolate chips, dairy free if desired" },
      { amount: 2.0, unit: "tablespoons", name: "chocolate chips, dairy free if desired" },
      { amount: 0.5, unit: "teaspoon", name: "coconut oil" },
      { amount: nil, unit: nil, name: "Fancy sea salt, for sprinkling on top" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 350 degrees Line an 8x8 inch pan with parchment paper.",
      "In a large bowl, mix together the almond butter, brown sugar, maple syrup and eggs until smooth and well combined. Next add melted coconut oil and mix again until smooth. Finally add in the cocoa powder, baking soda and salt and mix until well incorporated. Stir in ¼ cup chocolate chips. The batter should be THICK and that’s the way we want it.",
      "Add the brownie batter to the prepared pan and evenly spread out using a rubber spatula or you may need to your hands to evenly push the batter towards the edges. Bake for 15-20 minutes until tester comes out clean or with just a few crumbs attached. It’s best to underbake these brownies. Allow the brownies to cool in the pan for at least 20-30 minutes before removing or cutting; they will be super fudgy and you want them to completely set first. This will be a true testament of willpower :)",
      "To top the brownies: add chocolate chips and coconut oil to a small microwave safe bowl and microwave in 30 second intervals until chocolate is smooth and melted. Drizzle over brownies, then top with fancy sea salt. Cut into 16 squares and enjoy! These brownies are delicious straight from the fridge. They’re fudgy and perfect if you want to store them in there."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        [nil, 9],
        ["For the topping", 3]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 350 degrees Line an 8x8 inch pan with parchment paper.\nIn a large bowl, mix together the almond butter, brown sugar, maple syrup and eggs until smooth and well combined. Next add melted coconut oil and mix again until smooth. Finally add in the cocoa powder, baking soda and salt and mix until well incorporated. Stir in ¼ cup chocolate chips. The batter should be THICK and that’s the way we want it.\nAdd the brownie batter to the prepared pan and evenly spread out using a rubber spatula or you may need to your hands to evenly push the batter towards the edges. Bake for 15-20 minutes until tester comes out clean or with just a few crumbs attached. It’s best to underbake these brownies. Allow the brownies to cool in the pan for at least 20-30 minutes before removing or cutting; they will be super fudgy and you want them to completely set first. This will be a true testament of willpower :)\nTo top the brownies: add chocolate chips and coconut oil to a small microwave safe bowl and microwave in 30 second intervals until chocolate is smooth and melted. Drizzle over brownies, then top with fancy sea salt. Cut into 16 squares and enjoy! These brownies are delicious straight from the fridge. They’re fudgy and perfect if you want to store them in there.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("ambitiouskitchen.com")
    expect(recipe.canonical_url).to eq("https://www.ambitiouskitchen.com/flourless-almond-butter-brownies/")
    expect(recipe.site_name).to eq("Ambitious Kitchen")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Monique Volz of AmbitiousKitchen.com")
    expect(recipe.description).to eq("Truly one of the best gluten free brownie recipes on the internet: fudgy, flourless almond butter brownies made with simple ingredients like natural creamy almond butter, pure maple syrup, cocoa powder and chocolate chips. Incredible hot from the oven or even straight from the fridge -- you'll love these!")
    expect(recipe.image).to eq("https://www.ambitiouskitchen.com/wp-content/uploads/2019/09/Fudgy-Almond-Butter-Brownies-4-725x725-1-1.jpg")
    expect(recipe.category).to eq("Dairy Free")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("16 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(["almond butter brownies", "flourless almond butter brownies", "gluten free almond butter brownies", "grain free almond butter brownies"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.93)
    expect(recipe.ratings_count).to eq(135)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 brownie",
      "calories" => "175 kcal",
      "sugarContent" => "14.1 g",
      "fatContent" => "10.9 g",
      "saturatedFatContent" => "3.1 g",
      "carbohydrateContent" => "20.8 g",
      "fiberContent" => "2.5 g",
      "proteinContent" => "4.1 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "brownie", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 175.0 },
      { name: "sugarContent", unit: "g", amount: 14.1 },
      { name: "fatContent", unit: "g", amount: 10.9 },
      { name: "saturatedFatContent", unit: "g", amount: 3.1 },
      { name: "carbohydrateContent", unit: "g", amount: 20.8 },
      { name: "fiberContent", unit: "g", amount: 2.5 },
      { name: "proteinContent", unit: "g", amount: 4.1 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#wprm-recipe-container-35223")
  end
end
