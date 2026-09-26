# frozen_string_literal: true

RSpec.describe "beyondfrosting.com" do
  subject(:recipe) { scrape_cassette("com/beyondfrosting", url: "https://beyondfrosting.com/lemon-cake-mix-cookies/") }

  it "reads the title" do
    expect(recipe.title).to eq("Lemon Cake Mix Cookies")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 box (15.25oz) Duncan Hines Lemon Cake Mix",
      "½ cup (113g) Unsalted butter, melted",
      "2 Large eggs",
      "1 teaspoon Pure Lemon extract (or fresh lemon juice)",
      "Zest from 1 large lemon",
      "Sparkling Sanding Sugar for coating (1/3-1/2 cup)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "box", name: "Duncan Hines Lemon Cake Mix" },
      { amount: 0.5, unit: "cup", name: "Unsalted butter, melted" },
      { amount: 2.0, unit: nil, name: "Large eggs" },
      { amount: 1.0, unit: "teaspoon", name: "Pure Lemon extract" },
      { amount: nil, unit: nil, name: "Zest from 1 large lemon" },
      { amount: nil, unit: nil, name: "Sparkling Sanding Sugar for coating" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 350°F. Line a baking sheet with parchment paper or a silicone baking sheet",
      "In a large mixing bowl, combine all the ingredients (except the sanding sugar) and mix until well combined. The dough will be thick.",
      "Use a large cookie scoop to portion out the dough. Roll each ball of dough in the sanding sugar then place the dough about 2 inches apart on the prepared baking sheet.",
      "Bake for 11-13 minutes. The center of the cookies should be slightly under-baked but not too gooey. Use a toothpick inserted into the center of a cookie to check for doneness."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 350°F. Line a baking sheet with parchment paper or a silicone baking sheet\nIn a large mixing bowl, combine all the ingredients (except the sanding sugar) and mix until well combined. The dough will be thick.\nUse a large cookie scoop to portion out the dough. Roll each ball of dough in the sanding sugar then place the dough about 2 inches apart on the prepared baking sheet.\nBake for 11-13 minutes. The center of the cookies should be slightly under-baked but not too gooey. Use a toothpick inserted into the center of a cookie to check for doneness.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("beyondfrosting.com")
    expect(recipe.canonical_url).to eq("https://beyondfrosting.com/lemon-cake-mix-cookies/")
    expect(recipe.site_name).to eq("Beyond Frosting")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Julianne Dell")
    expect(recipe.description).to eq("These easy lemon cake mix cookies are quick to make with 5 ingredients! So soft and chewy, they're infused with fresh lemon flavor and rolled in sugar for crunch. Add in white chocolate chips for a delicious sweet-tart treat.")
    expect(recipe.image).to eq("https://beyondfrosting.com/wp-content/uploads/2016/02/Lemon-Cake-Mix-Cookies-5034-2-225x225.jpg")
    expect(recipe.category).to eq("Cookies")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to eq("Oven")
    expect(recipe.yields).to eq("11 servings")
    expect(recipe.total_time).to eq(22)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(12)
    expect(recipe.keywords).to eq([
      "lemon cake mix cookies",
      "lemon cookies from cake mix",
      "lemon cookies from box cake mix",
      "cookies using lemon cake mix"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(3)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 Cookie",
      "calories" => "242 calories",
      "sugarContent" => "0.1 g",
      "sodiumContent" => "114.8 mg",
      "fatContent" => "12.5 g",
      "saturatedFatContent" => "6 g",
      "transFatContent" => "0 g",
      "carbohydrateContent" => "31 g",
      "fiberContent" => "0.1 g",
      "proteinContent" => "2.4 g",
      "cholesterolContent" => "56 mg"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "Cookie", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 242.0 },
      { name: "sugarContent", unit: "g", amount: 0.1 },
      { name: "sodiumContent", unit: "mg", amount: 114.8 },
      { name: "fatContent", unit: "g", amount: 12.5 },
      { name: "saturatedFatContent", unit: "g", amount: 6.0 },
      { name: "transFatContent", unit: "g", amount: 0.0 },
      { name: "carbohydrateContent", unit: "g", amount: 31.0 },
      { name: "fiberContent", unit: "g", amount: 0.1 },
      { name: "proteinContent", unit: "g", amount: 2.4 },
      { name: "cholesterolContent", unit: "mg", amount: 56.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
