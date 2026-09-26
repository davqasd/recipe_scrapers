# frozen_string_literal: true

RSpec.describe "garnishandglaze.com" do
  subject(:recipe) { scrape_cassette("com/garnishandglaze", url: "https://www.garnishandglaze.com/maple-donuts-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Maple Donuts")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 1/4 cups all-purpose flour",
      "1/4 cup granulated sugar",
      "1/2 teaspoon salt",
      "2 teaspoons active dry yeast",
      "1/4 teaspoon ground nutmeg",
      "1 large egg",
      "1 cup milk",
      "2 tablespoons butter (melted)",
      "1/2 teaspoon vanilla",
      "vegetable oil (for frying)",
      "1/2 cup brown sugar (light or dark)",
      "1/4 cup butter",
      "3 tablespoons half & half cream",
      "1 tablespoon corn syrup",
      "1 teaspoon maple extract",
      "1/8 teaspoon salt",
      "2 cups powdered sugar"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.25, unit: "cups", name: "all-purpose flour" },
      { amount: 0.25, unit: "cup", name: "granulated sugar" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 2.0, unit: "teaspoons", name: "active dry yeast" },
      { amount: 0.25, unit: "teaspoon", name: "ground nutmeg" },
      { amount: 1.0, unit: nil, name: "large egg" },
      { amount: 1.0, unit: "cup", name: "milk" },
      { amount: 2.0, unit: "tablespoons", name: "butter" },
      { amount: 0.5, unit: "teaspoon", name: "vanilla" },
      { amount: nil, unit: nil, name: "vegetable oil" },
      { amount: 0.5, unit: "cup", name: "brown sugar" },
      { amount: 0.25, unit: "cup", name: "butter" },
      { amount: 3.0, unit: "tablespoons", name: "half & half cream" },
      { amount: 1.0, unit: "tablespoon", name: "corn syrup" },
      { amount: 1.0, unit: "teaspoon", name: "maple extract" },
      { amount: 0.13, unit: "teaspoon", name: "salt" },
      { amount: 2.0, unit: "cups", name: "powdered sugar" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "For the Dough:",
      "Mix dry ingredients together in a the bowl of a stand mixer fitted with the hook attachment. Add the liquid ingredients and mix until well combined. Cover with a towel and let it rest for 8 minutes.",
      "Knead the dough on medium speed for about 5 minutes until a soft smooth dough forms. Place dough in a greased bowl and then turn it so the top of the dough is wet with oil. Cover the bowl with a lid or towel and let rise for 1 1/2 to 2 hours or until double in bulk.",
      "Punch the dough down and empty onto a floured surface and roll out to about 1/3 inch thick and use a biscuit cutter 2 1/2 to 3 inches wide to cut out donuts. Knead scraps together and roll out again and cut until no longer enough dough. Place on parchment lined baking sheets, cover lightly with plastic wrap, and let rise for 30-60 minutes until almost double in size.",
      "Pour oil in a pot until 2 inches deep and heat over medium until 350 degrees F. Fry dough, about 3 at a time until golden and then flip. Should take 30-60 seconds per side. Drain on a paper towel lined baking sheet.",
      "Once cooled enough to handle, dip the most rounded side of the the donut in the frosting and then set on cooling rack.",
      "For the Frosting:",
      "In a small sauce pan, heat butter, brown sugar, half & half, and corn syrup over medium heat until sugar is dissolved, Turn to low and whisk in maple extract, salt, and 1/2 cup powdered sugar at a time until smooth. Remove from heat.",
      "Frosting does start to dry and harden which is what you want but just give it a quick stir before you dip each donut. If it starts to get too thick, set the pan back over low heat and whisk in a teaspoon more of half & half."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["For the Dough:", 10],
        ["For the Frosting:", 7]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("For the Dough:\nMix dry ingredients together in a the bowl of a stand mixer fitted with the hook attachment. Add the liquid ingredients and mix until well combined. Cover with a towel and let it rest for 8 minutes.\nKnead the dough on medium speed for about 5 minutes until a soft smooth dough forms. Place dough in a greased bowl and then turn it so the top of the dough is wet with oil. Cover the bowl with a lid or towel and let rise for 1 1/2 to 2 hours or until double in bulk.\nPunch the dough down and empty onto a floured surface and roll out to about 1/3 inch thick and use a biscuit cutter 2 1/2 to 3 inches wide to cut out donuts. Knead scraps together and roll out again and cut until no longer enough dough. Place on parchment lined baking sheets, cover lightly with plastic wrap, and let rise for 30-60 minutes until almost double in size.\nPour oil in a pot until 2 inches deep and heat over medium until 350 degrees F. Fry dough, about 3 at a time until golden and then flip. Should take 30-60 seconds per side. Drain on a paper towel lined baking sheet.\nOnce cooled enough to handle, dip the most rounded side of the the donut in the frosting and then set on cooling rack.\nFor the Frosting:\nIn a small sauce pan, heat butter, brown sugar, half & half, and corn syrup over medium heat until sugar is dissolved, Turn to low and whisk in maple extract, salt, and 1/2 cup powdered sugar at a time until smooth. Remove from heat.\nFrosting does start to dry and harden which is what you want but just give it a quick stir before you dip each donut. If it starts to get too thick, set the pan back over low heat and whisk in a teaspoon more of half & half.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("garnishandglaze.com")
    expect(recipe.canonical_url).to eq("https://www.garnishandglaze.com/maple-donuts-recipe/")
    expect(recipe.site_name).to eq("Garnish & Glaze")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Melanie")
    expect(recipe.description).to eq("'Tis the season for Maple Donuts! These soft and airy yeast donuts are a fun yummy treat to make with the family this fall and winter.")
    expect(recipe.image).to eq("https://www.garnishandglaze.com/wp-content/uploads/2020/09/maple-donuts-5.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("16 servings")
    expect(recipe.total_time).to eq(220)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq(["Maple Donuts"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.garnishandglaze.com/")
  end
end
