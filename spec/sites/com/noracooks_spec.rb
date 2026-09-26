# frozen_string_literal: true

RSpec.describe "noracooks.com" do
  subject(:recipe) { scrape_cassette("com/noracooks", url: "https://www.noracooks.com/vegan-chocolate-cake/") }

  it "reads the title" do
    expect(recipe.title).to eq("The Best Vegan Chocolate Cake")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup unsweetened soy milk (or almond)",
      "1 tablespoon apple cider vinegar",
      "2 cups all purpose flour",
      "1 3/4 cups granulated sugar",
      "3/4 cup cocoa powder",
      "2 teaspoons baking powder",
      "1 1/2 teaspoons baking soda",
      "1 teaspoon salt",
      "1/2 cup canola oil (or melted coconut oil)",
      "2/3 cup unsweetened applesauce",
      "1 tablespoon pure vanilla extract",
      "1 cup boiling water",
      "1 cup cocoa powder",
      "1 1/2 cups vegan butter, softened (baking sticks, not the tub )",
      "4-5 cups powdered sugar",
      "2 teaspoons pure vanilla extract",
      "1/4-1/2 cup unsweetened soy milk (or almond )"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "unsweetened soy milk" },
      { amount: 1.0, unit: "tablespoon", name: "apple cider vinegar" },
      { amount: 2.0, unit: "cups", name: "all purpose flour" },
      { amount: 1.75, unit: "cups", name: "granulated sugar" },
      { amount: 0.75, unit: "cup", name: "cocoa powder" },
      { amount: 2.0, unit: "teaspoons", name: "baking powder" },
      { amount: 1.5, unit: "teaspoons", name: "baking soda" },
      { amount: 1.0, unit: "teaspoon", name: "salt" },
      { amount: 0.5, unit: "cup", name: "canola oil" },
      { amount: 0.67, unit: "cup", name: "unsweetened applesauce" },
      { amount: 1.0, unit: "tablespoon", name: "pure vanilla extract" },
      { amount: 1.0, unit: "cup", name: "boiling water" },
      { amount: 1.0, unit: "cup", name: "cocoa powder" },
      { amount: 1.5, unit: "cups", name: "vegan butter, softened" },
      { amount: 4.0, unit: "cups", name: "powdered sugar" },
      { amount: 2.0, unit: "teaspoons", name: "pure vanilla extract" },
      { amount: 0.25, unit: "cup", name: "unsweetened soy milk" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "For the Chocolate Cake",
      "Preheat oven to 350 degrees F and grease two 8 or 9-inch cake pans (8 inch pans will result in taller cakes). I also line them with parchment rounds for easy removal of the cakes later.",
      "Measure 1 cup unsweetened milk and add the tablespoon of vinegar to it. Stir slightly and set aside to curdle.",
      "In a large bowl, add the flour, sugar, cocoa powder, baking powder, baking soda and salt. Whisk well to combine.",
      "Now add the oil, applesauce, vanilla and milk/vinegar mixture. Mix on medium speed with a hand mixer (or stand mixer with the paddle attachment) until well combined.",
      "Lower the speed and carefully pour in the boiling water, continuing to mix into the cake batter until combined. The batter will seem very runny at this point; that is how it should be, trust me!",
      "Divide the batter evenly between your cake pans. Bake for 30-35 minutes, or until a toothpick inserted in the center comes out clean. After 10 minutes of cooling in the pan, carefully remove the cakes from the pans and let cool completely before frosting.",
      "For the Chocolate Buttercream Frosting",
      "Add the cocoa powder to a large bowl (I just wipe out the cake bowl and use it for the frosting). Whisk well to remove any clumps.",
      "Add the softened vegan butter and mix with a hand mixer until creamed and well combined.",
      "Add half of the powdered sugar and half of the milk, and mix until combined. Add the rest of the powdered sugar and vanilla extract. Mix starting on low, and turn to high. Mix until fluffy and combined.",
      "If the frosting seems too dry, add more milk, a tablespoon or two at a time. If the frosting seems too wet and doesn't hold it's shape, add more powdered sugar until it thickens up.",
      "Frost the cake using an icing spatula or just a butter knife."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["Chocolate Cake", 12],
        ["Chocolate Buttercream Frosting", 5]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("For the Chocolate Cake\nPreheat oven to 350 degrees F and grease two 8 or 9-inch cake pans (8 inch pans will result in taller cakes). I also line them with parchment rounds for easy removal of the cakes later.\nMeasure 1 cup unsweetened milk and add the tablespoon of vinegar to it. Stir slightly and set aside to curdle.\nIn a large bowl, add the flour, sugar, cocoa powder, baking powder, baking soda and salt. Whisk well to combine.\nNow add the oil, applesauce, vanilla and milk/vinegar mixture. Mix on medium speed with a hand mixer (or stand mixer with the paddle attachment) until well combined.\nLower the speed and carefully pour in the boiling water, continuing to mix into the cake batter until combined. The batter will seem very runny at this point; that is how it should be, trust me!\nDivide the batter evenly between your cake pans. Bake for 30-35 minutes, or until a toothpick inserted in the center comes out clean. After 10 minutes of cooling in the pan, carefully remove the cakes from the pans and let cool completely before frosting.\nFor the Chocolate Buttercream Frosting\nAdd the cocoa powder to a large bowl (I just wipe out the cake bowl and use it for the frosting). Whisk well to remove any clumps.\nAdd the softened vegan butter and mix with a hand mixer until creamed and well combined.\nAdd half of the powdered sugar and half of the milk, and mix until combined. Add the rest of the powdered sugar and vanilla extract. Mix starting on low, and turn to high. Mix until fluffy and combined.\nIf the frosting seems too dry, add more milk, a tablespoon or two at a time. If the frosting seems too wet and doesn't hold it's shape, add more powdered sugar until it thickens up.\nFrost the cake using an icing spatula or just a butter knife.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("noracooks.com")
    expect(recipe.canonical_url).to eq("https://www.noracooks.com/vegan-chocolate-cake/")
    expect(recipe.site_name).to eq("Nora Cooks")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Nora")
    expect(recipe.description).to eq("The Best Vegan Chocolate Cake- A quick and easy recipe, made in 1 bowl! This really is the best chocolate cake ever, vegan or otherwise. It's super moist, rich and full of chocolate.")
    expect(recipe.image).to eq("https://www.noracooks.com/wp-content/uploads/2018/07/IMG_8885.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("16 servings")
    expect(recipe.total_time).to eq(55)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(35)
    expect(recipe.keywords).to eq(["vegan chocolate cake"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.96)
    expect(recipe.ratings_count).to eq(2184)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "496 kcal",
      "servingSize" => "1 serving",
      "carbohydrateContent" => "71 g",
      "proteinContent" => "4 g",
      "fatContent" => "25 g",
      "saturatedFatContent" => "4 g",
      "sodiumContent" => "408 mg",
      "fiberContent" => "4 g",
      "sugarContent" => "53 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 496.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 },
      { name: "carbohydrateContent", unit: "g", amount: 71.0 },
      { name: "proteinContent", unit: "g", amount: 4.0 },
      { name: "fatContent", unit: "g", amount: 25.0 },
      { name: "saturatedFatContent", unit: "g", amount: 4.0 },
      { name: "sodiumContent", unit: "mg", amount: 408.0 },
      { name: "fiberContent", unit: "g", amount: 4.0 },
      { name: "sugarContent", unit: "g", amount: 53.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
