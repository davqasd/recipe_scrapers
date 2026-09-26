# frozen_string_literal: true

RSpec.describe "laurenslatest.com" do
  subject(:recipe) { scrape_cassette("com/laurenslatest", url: "https://laurenslatest.com/actually-perfect-chocolate-chip-cookies/") }

  it "reads the title" do
    expect(recipe.title).to eq("Actually Perfect Chocolate Chip Cookies")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup salted butter (melted)",
      "1 cup light brown sugar (packed)",
      "1/2 cup granulated sugar",
      "1 large egg",
      "1 egg yolk",
      "2 teaspoons vanilla extract",
      "2 cups all purpose flour",
      "1/2 teaspoon baking soda",
      "1/2 teaspoon salt",
      "1 cup semi sweet chocolate chips",
      "1 cup milk chocolate chips (reserve a handful for after baking)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "salted butter" },
      { amount: 1.0, unit: "cup", name: "light brown sugar" },
      { amount: 0.5, unit: "cup", name: "granulated sugar" },
      { amount: 1.0, unit: nil, name: "large egg" },
      { amount: 1.0, unit: nil, name: "egg yolk" },
      { amount: 2.0, unit: "teaspoons", name: "vanilla extract" },
      { amount: 2.0, unit: "cups", name: "all purpose flour" },
      { amount: 0.5, unit: "teaspoon", name: "baking soda" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 1.0, unit: "cup", name: "semi sweet chocolate chips" },
      { amount: 1.0, unit: "cup", name: "milk chocolate chips" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 325° F. Line two baking sheets with parchment paper and set aside.",
      "In a large bowl, using an electric hand mixer, mix together melted butter, brown sugar, and granulated sugar until well combined.",
      "Add in egg, egg yolk and vanilla extract. Mix until lighter in color, about 2 minutes.",
      "Mix in the flour, baking soda, and salt. Using a rubber spatula, scrape the sides of the bowl and the bottom really well to ensure a smooth, well combined batter.",
      "Hand stir the chocolate chips into the batter and let it sit 20 minutes to let the flour soak into the rest of the batter.*",
      "Scoop cookie dough onto prepared pans 2 inches apart, using a two tablespoon cookie scoop.",
      "Bake 8-9 minutes, rotating sheets half way through baking. When you pull your cookies out of the oven, they will looked cooked around the edges and undercooked in the center. DO NOT OVER BAKE!",
      "Carefully place a few chocolate chips on top of each cookie immediately after removing from oven, pressing into the warm soft cookie just slightly.",
      "Leave the cookies on the hot baking pans for 5-7 minutes or until you can remove them without falling apart. Place onto cooling racks and cool to room temperature before storing in airtight containers."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 325° F. Line two baking sheets with parchment paper and set aside.\nIn a large bowl, using an electric hand mixer, mix together melted butter, brown sugar, and granulated sugar until well combined.\nAdd in egg, egg yolk and vanilla extract. Mix until lighter in color, about 2 minutes.\nMix in the flour, baking soda, and salt. Using a rubber spatula, scrape the sides of the bowl and the bottom really well to ensure a smooth, well combined batter.\nHand stir the chocolate chips into the batter and let it sit 20 minutes to let the flour soak into the rest of the batter.*\nScoop cookie dough onto prepared pans 2 inches apart, using a two tablespoon cookie scoop.\nBake 8-9 minutes, rotating sheets half way through baking. When you pull your cookies out of the oven, they will looked cooked around the edges and undercooked in the center. DO NOT OVER BAKE!\nCarefully place a few chocolate chips on top of each cookie immediately after removing from oven, pressing into the warm soft cookie just slightly.\nLeave the cookies on the hot baking pans for 5-7 minutes or until you can remove them without falling apart. Place onto cooling racks and cool to room temperature before storing in airtight containers.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("laurenslatest.com")
    expect(recipe.canonical_url).to eq("https://laurenslatest.com/actually-perfect-chocolate-chip-cookies/")
    expect(recipe.site_name).to eq("Lauren's Latest")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Katie Cooksey")
    expect(recipe.description).to eq("This is the best chocolate chip cookie recipe! Soft baked, very chocolatey and impossible to ruin. Made with both semi-sweet AND milk chocolate chips for the ultimate bite.")
    expect(recipe.image).to eq("https://laurenslatest.com/wp-content/uploads/2017/02/Actually-Perfect-Chocolate-Chip-Cookies.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("36 servings")
    expect(recipe.total_time).to eq(39)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(9)
    expect(recipe.keywords).to eq(["chocolate chip cookie recipe", "chocolate chip cookies"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.75)
    expect(recipe.ratings_count).to eq(113)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "151 kcal",
      "carbohydrateContent" => "20 g",
      "proteinContent" => "2 g",
      "fatContent" => "7 g",
      "saturatedFatContent" => "4 g",
      "cholesterolContent" => "22 mg",
      "sodiumContent" => "86 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "14 g",
      "transFatContent" => "0.2 g",
      "unsaturatedFatContent" => "2.3 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 151.0 },
      { name: "carbohydrateContent", unit: "g", amount: 20.0 },
      { name: "proteinContent", unit: "g", amount: 2.0 },
      { name: "fatContent", unit: "g", amount: 7.0 },
      { name: "saturatedFatContent", unit: "g", amount: 4.0 },
      { name: "cholesterolContent", unit: "mg", amount: 22.0 },
      { name: "sodiumContent", unit: "mg", amount: 86.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 14.0 },
      { name: "transFatContent", unit: "g", amount: 0.2 },
      { name: "unsaturatedFatContent", unit: "g", amount: 2.3 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://laurenslatest.com/")
  end
end
