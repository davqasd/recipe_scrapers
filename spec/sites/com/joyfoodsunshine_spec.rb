# frozen_string_literal: true

RSpec.describe "joyfoodsunshine.com" do
  subject(:recipe) { scrape_cassette("com/joyfoodsunshine", url: "https://joyfoodsunshine.com/hummingbird-cake-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Hummingbird Cake Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 ½ cups all-purpose flour",
      "1 teaspoon baking soda",
      "½ teaspoon baking powder",
      "½ teaspoon fine sea salt",
      "1 teaspoon ground cinnamon",
      "½ cup salted butter (melted)",
      "¾ cup granulated sugar",
      "¼ cup light brown sugar",
      "8 oz crushed pineapple",
      "3 large bananas (mashed (about 1 ½ cups))",
      "2 eggs",
      "2 teaspoons vanilla",
      "1 cup pecans (finely chopped (optional))",
      "cream cheese frosting"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.5, unit: "cups", name: "all-purpose flour" },
      { amount: 1.0, unit: "teaspoon", name: "baking soda" },
      { amount: 0.5, unit: "teaspoon", name: "baking powder" },
      { amount: 0.5, unit: "teaspoon", name: "fine sea salt" },
      { amount: 1.0, unit: "teaspoon", name: "ground cinnamon" },
      { amount: 0.5, unit: "cup", name: "salted butter" },
      { amount: 0.75, unit: "cup", name: "granulated sugar" },
      { amount: 0.25, unit: "cup", name: "light brown sugar" },
      { amount: 8.0, unit: "oz", name: "crushed pineapple" },
      { amount: 3.0, unit: nil, name: "large bananas" },
      { amount: 2.0, unit: nil, name: "eggs" },
      { amount: 2.0, unit: "teaspoons", name: "vanilla" },
      { amount: 1.0, unit: "cup", name: "pecans" },
      { amount: nil, unit: nil, name: "cream cheese frosting" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 350 degrees.",
      "Line 2 round 6” cake pans with parchment paper and grease the sides.",
      "Combine flour, salt, baking powder, baking soda and cinnamon in a small bowl, set aside.",
      "In a large bowl, whisk together melted butter, granulated sugar and brown sugar until the mixture is smooth and there are no lumps.",
      "Add pineapple, mashed banana, eggs, and vanilla and stir to combine.",
      "Add dry ingredient mixture to the wet ingredients and stir until the batter is smooth.",
      "If desired, stir in chopped pecans.",
      "Divide the batter evenly between the two prepared cake pans (about 1 ½ cups of batter per pan) and spread the batter in an even layer in each pan.",
      "Bake in the preheated oven for 30-35 minutes, or until the top is set and a cake tester inserted in the center comes out clean.",
      "Let cool in the cake pans for at least 30 minutes before transferring to a wire rack to cool completely.",
      "Make the Frosting",
      "While the cake is cooling, make the cream cheese frosting: see this recipe: https://joyfoodsunshine.com/cream-cheese-frosting/",
      "For a firmer frosting, add more powdered sugar ¼ cup at a time until you reach the desired consistency.",
      "Assemble, Chill & Serve",
      "When the cake is cooled, spread the frosting in between the cake layers, then all around the outside of the cake. Pipe designs if desired, and garnish with chopped nuts, etc.",
      "Chill for at least 3 hours, or overnight. Then serve cold or at room temperature."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        [nil, 13],
        ["Frosting", 1]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 350 degrees.\nLine 2 round 6” cake pans with parchment paper and grease the sides.\nCombine flour, salt, baking powder, baking soda and cinnamon in a small bowl, set aside.\nIn a large bowl, whisk together melted butter, granulated sugar and brown sugar until the mixture is smooth and there are no lumps.\nAdd pineapple, mashed banana, eggs, and vanilla and stir to combine.\nAdd dry ingredient mixture to the wet ingredients and stir until the batter is smooth.\nIf desired, stir in chopped pecans.\nDivide the batter evenly between the two prepared cake pans (about 1 ½ cups of batter per pan) and spread the batter in an even layer in each pan.\nBake in the preheated oven for 30-35 minutes, or until the top is set and a cake tester inserted in the center comes out clean.\nLet cool in the cake pans for at least 30 minutes before transferring to a wire rack to cool completely.\nMake the Frosting\nWhile the cake is cooling, make the cream cheese frosting: see this recipe: https://joyfoodsunshine.com/cream-cheese-frosting/\nFor a firmer frosting, add more powdered sugar ¼ cup at a time until you reach the desired consistency.\nAssemble, Chill & Serve\nWhen the cake is cooled, spread the frosting in between the cake layers, then all around the outside of the cake. Pipe designs if desired, and garnish with chopped nuts, etc.\nChill for at least 3 hours, or overnight. Then serve cold or at room temperature.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("joyfoodsunshine.com")
    expect(recipe.canonical_url).to eq("https://joyfoodsunshine.com/hummingbird-cake-recipe/")
    expect(recipe.site_name).to eq("JoyFoodSunshine")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Laura Sandford")
    expect(recipe.description).to eq("This hummingbird cake recipe is moist, perfectly sweet, & richly flavored with banana, pineapple, vanilla & cinnamon. Slathered with cream cheese frosting, it's the perfect dessert for any occasion.")
    expect(recipe.image).to eq("https://joyfoodsunshine.com/wp-content/uploads/2024/03/hummingbird-cake-recipe-1x1-1.jpg")
    expect(recipe.category).to eq("cake")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("16 servings")
    expect(recipe.total_time).to eq(110)
    expect(recipe.prep_time).to eq(495)
    expect(recipe.cook_time).to eq(35)
    expect(recipe.keywords).to eq(["homemade hummingbird cake", "how to make hummingbird cake", "hummingbird cake", "hummingbird cake recipe"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["VegetarianDiet"])
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 slice",
      "calories" => "312 kcal",
      "carbohydrateContent" => "44 g",
      "proteinContent" => "3 g",
      "fatContent" => "15 g",
      "saturatedFatContent" => "5 g",
      "transFatContent" => "0.2 g",
      "cholesterolContent" => "36 mg",
      "sodiumContent" => "237 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "31 g",
      "unsaturatedFatContent" => "8 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "slice", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 312.0 },
      { name: "carbohydrateContent", unit: "g", amount: 44.0 },
      { name: "proteinContent", unit: "g", amount: 3.0 },
      { name: "fatContent", unit: "g", amount: 15.0 },
      { name: "saturatedFatContent", unit: "g", amount: 5.0 },
      { name: "transFatContent", unit: "g", amount: 0.2 },
      { name: "cholesterolContent", unit: "mg", amount: 36.0 },
      { name: "sodiumContent", unit: "mg", amount: 237.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 31.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 8.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
