# frozen_string_literal: true

RSpec.describe "savorynothings.com" do
  subject(:recipe) { scrape_cassette("com/savorynothings", url: "https://www.savorynothings.com/chewy-chocolate-crinkle-cookies/") }

  it "reads the title" do
    expect(recipe.title).to eq("Chewy Chocolate Crinkle Cookies")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup unsweetened cocoa powder (I recommend sifting it if it is very lumpy)",
      "2 cups all-purpose flour",
      "1.5 teaspoons baking powder",
      "1/4 teaspoon salt",
      "1/3 cup butter (softened)",
      "1 1/2 cups white sugar",
      "2 teaspoons vanilla",
      "4 large eggs",
      "1/2 cup powdered sugar"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "unsweetened cocoa powder" },
      { amount: 2.0, unit: "cups", name: "all-purpose flour" },
      { amount: 1.5, unit: "teaspoons", name: "baking powder" },
      { amount: 0.25, unit: "teaspoon", name: "salt" },
      { amount: 0.33, unit: "cup", name: "butter" },
      { amount: 1.5, unit: "cups", name: "white sugar" },
      { amount: 2.0, unit: "teaspoons", name: "vanilla" },
      { amount: 4.0, unit: nil, name: "large eggs" },
      { amount: 0.5, unit: "cup", name: "powdered sugar" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Dry ingredients",
      "Combine dry ingredients: Combine cocoa powder, flour, baking powder and salt in a medium bowl. Set aside.",
      "Wet ingredients",
      "Cream wet ingredients: Place butter, sugar and vanilla in a large mixing bowl and beat with an electric mixer until combined. Add the eggs, one at a time, and mix on medium-low speed just until combined - about 10 seconds each.",
      "Make dough",
      "Make cookie dough: Add the dry ingredients to the egg mixture and mix on low speed until incorporated.",
      "Chill cookie dough: Cover the bowl and chill the dough for at least 1 hour or up to overnight (the longer you chill, the thicker the cookies will be).",
      "Roll cookies: When ready to bake, preheat the oven to 350°F. Place the powdered sugar in a medium bowl. Roll the dough into tablespoon-sized balls and cover them well with the sugar.",
      "Bake cookies: Place on a lined baking sheet with enough space between them (bake in batches) and bake for 10-15 minutes, or until spread and crackled. Cookies will still be soft, so let them cool on the baking sheet for 5 minutes before removing them to a cooling rack to cool completely."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Dry ingredients\nCombine dry ingredients: Combine cocoa powder, flour, baking powder and salt in a medium bowl. Set aside.\nWet ingredients\nCream wet ingredients: Place butter, sugar and vanilla in a large mixing bowl and beat with an electric mixer until combined. Add the eggs, one at a time, and mix on medium-low speed just until combined - about 10 seconds each.\nMake dough\nMake cookie dough: Add the dry ingredients to the egg mixture and mix on low speed until incorporated.\nChill cookie dough: Cover the bowl and chill the dough for at least 1 hour or up to overnight (the longer you chill, the thicker the cookies will be).\nRoll cookies: When ready to bake, preheat the oven to 350°F. Place the powdered sugar in a medium bowl. Roll the dough into tablespoon-sized balls and cover them well with the sugar.\nBake cookies: Place on a lined baking sheet with enough space between them (bake in batches) and bake for 10-15 minutes, or until spread and crackled. Cookies will still be soft, so let them cool on the baking sheet for 5 minutes before removing them to a cooling rack to cool completely.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("savorynothings.com")
    expect(recipe.canonical_url).to eq("https://www.savorynothings.com/chewy-chocolate-crinkle-cookies/")
    expect(recipe.site_name).to eq("Savory Nothings")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Nora")
    expect(recipe.description).to eq("Try these soft and chewy Chocolate Crinkle Cookies for Christmas this year - my simple recipe makes these the best easy treat for your holiday baking!")
    expect(recipe.image).to eq("https://www.savorynothings.com/wp-content/uploads/2018/12/chewy-chocolate-crinkle-cookies-image-hero.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("32 servings")
    expect(recipe.total_time).to eq(105)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(%w[chocolate christmas cookies])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.8)
    expect(recipe.ratings_count).to eq(415)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
