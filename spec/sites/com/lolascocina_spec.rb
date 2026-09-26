# frozen_string_literal: true

RSpec.describe "lolascocina.com" do
  subject(:recipe) { scrape_cassette("com/lolascocina", url: "https://lolascocina.com/homemade-apple-bread-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("PAN DE MANZANA (HOMEMADE APPLE BREAD RECIPE)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 cups all-purpose flour (sifted)",
      "1 ½ cups sugar",
      "½ teaspoon salt",
      "1 tablespoons ground cinnamon",
      "1 teaspoon baking soda",
      "¼ teaspoon ground clove (optional)",
      "1 teaspoon baking powder",
      "1 ¼ cup oil (vegetable or canola oil will work)",
      "2 tablespoons pure vanilla extract",
      "4 eggs",
      "3 cups green apple (finely chopped (from about 2 large apples))",
      "1 cup golden raisins (optional)",
      "1 cup chopped pecans ((or walnuts) optional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "cups", name: "all-purpose flour" },
      { amount: 1.5, unit: "cups", name: "sugar" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 1.0, unit: "tablespoons", name: "ground cinnamon" },
      { amount: 1.0, unit: "teaspoon", name: "baking soda" },
      { amount: 0.25, unit: "teaspoon", name: "ground clove" },
      { amount: 1.0, unit: "teaspoon", name: "baking powder" },
      { amount: 1.25, unit: "cup", name: "oil" },
      { amount: 2.0, unit: "tablespoons", name: "pure vanilla extract" },
      { amount: 4.0, unit: nil, name: "eggs" },
      { amount: 3.0, unit: "cups", name: "green apple" },
      { amount: 1.0, unit: "cup", name: "golden raisins" },
      { amount: 1.0, unit: "cup", name: "chopped pecans" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Mix ingredients. Start by heating your oven to 325 degrees Fahrenheit. Next, grease your baking dish. You can use baking spray with flour or simply coat your pan with butter and flour. In a large bowl, mix dry ingredients: flour, sugar, salt, cinnamon, clove (optional), baking soda, and baking powder. Using a large spoon or spatula, mix in oil, vanilla, and eggs. Once dry and wet ingredients are well blended, add chopped apples, raisins (optional), and chopped nuts. Mix again until all of the ingredients are well-incorporated.",
      "Bake. Add mixture to a greased baking dish, leaving 1-inch of space from the top because the bread will rise. I typically have to use two loaf pans for this bread. Smooth out the mixture to ensure that it bakes evenly. Bake for one hour, or until you are able to insert a toothpick into the middle of the bread and it comes out clean. At this point, the top of your bread should be somewhat crispy, but the inside will remain moist. Allow to cool, and then slowly invert the bread onto a separate dish. Use a knife to loosen the edges before flipping it, if necessary.",
      "Serve and enjoy. Serve with a dusting of powdered sugar, chopped pecans, and sliced apples, if desired."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Mix ingredients. Start by heating your oven to 325 degrees Fahrenheit. Next, grease your baking dish. You can use baking spray with flour or simply coat your pan with butter and flour. In a large bowl, mix dry ingredients: flour, sugar, salt, cinnamon, clove (optional), baking soda, and baking powder. Using a large spoon or spatula, mix in oil, vanilla, and eggs. Once dry and wet ingredients are well blended, add chopped apples, raisins (optional), and chopped nuts. Mix again until all of the ingredients are well-incorporated.\nBake. Add mixture to a greased baking dish, leaving 1-inch of space from the top because the bread will rise. I typically have to use two loaf pans for this bread. Smooth out the mixture to ensure that it bakes evenly. Bake for one hour, or until you are able to insert a toothpick into the middle of the bread and it comes out clean. At this point, the top of your bread should be somewhat crispy, but the inside will remain moist. Allow to cool, and then slowly invert the bread onto a separate dish. Use a knife to loosen the edges before flipping it, if necessary.\nServe and enjoy. Serve with a dusting of powdered sugar, chopped pecans, and sliced apples, if desired.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("lolascocina.com")
    expect(recipe.canonical_url).to eq("https://lolascocina.com/homemade-apple-bread-recipe/")
    expect(recipe.site_name).to eq("Lola's Cocina")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("by Lola Dweck")
    expect(recipe.description).to eq("Bursting with tart green apples and cinnamon, this pan de manzana is the perfect treat for crisp mornings or an afternoon snack that kids and adults alike will love!")
    expect(recipe.image).to eq("https://lolascocina.com/wp-content/uploads/2024/10/2024.10.24-Pan-de-Manzana-WEB-15.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("Mexican")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("20 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(60)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 slice",
      "calories" => "337 kcal",
      "carbohydrateContent" => "39 g",
      "proteinContent" => "4 g",
      "fatContent" => "19 g",
      "saturatedFatContent" => "2 g",
      "transFatContent" => "0.1 g",
      "cholesterolContent" => "33 mg",
      "sodiumContent" => "148 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "22 g",
      "unsaturatedFatContent" => "16 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "slice", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 337.0 },
      { name: "carbohydrateContent", unit: "g", amount: 39.0 },
      { name: "proteinContent", unit: "g", amount: 4.0 },
      { name: "fatContent", unit: "g", amount: 19.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "transFatContent", unit: "g", amount: 0.1 },
      { name: "cholesterolContent", unit: "mg", amount: 33.0 },
      { name: "sodiumContent", unit: "mg", amount: 148.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 22.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 16.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
