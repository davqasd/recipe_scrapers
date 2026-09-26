# frozen_string_literal: true

RSpec.describe "farmhouseonboone.com" do
  subject(:recipe) { scrape_cassette("com/farmhouseonboone", url: "https://www.farmhouseonboone.com/easy-homemade-chicken-pot-pie-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Easy Homemade Chicken Pot Pie Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 all butter pie crust",
      "¼ cup butter",
      "1 cup carrots (chopped)",
      "½ cup onions (diced)",
      "½ cup celery (diced)",
      "¼ cup all purpose flour",
      "1 ½ cups chicken broth",
      "¼ teaspoon celery seed",
      "1 teaspoon dried thyme",
      "⅓ cup heavy cream (plus extra for brushing on the pastry before baking)",
      "¾ cup frozen peas",
      "2 cups chopped cooked chicken (from 2 chicken breasts or a store bought rotisserie chicken)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "all butter pie crust" },
      { amount: 0.25, unit: "cup", name: "butter" },
      { amount: 1.0, unit: "cup", name: "carrots" },
      { amount: 0.5, unit: "cup", name: "onions" },
      { amount: 0.5, unit: "cup", name: "celery" },
      { amount: 0.25, unit: "cup", name: "all purpose flour" },
      { amount: 1.5, unit: "cups", name: "chicken broth" },
      { amount: 0.25, unit: "teaspoon", name: "celery seed" },
      { amount: 1.0, unit: "teaspoon", name: "dried thyme" },
      { amount: 0.33, unit: "cup", name: "heavy cream" },
      { amount: 0.75, unit: "cup", name: "frozen peas" },
      { amount: 2.0, unit: "cups", name: "chopped cooked chicken" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Make a batch of All-Butter Pie Crust and refrigerate for several hours to chill.",
      "In a large skillet, melt butter over medium heat. Add chopped carrots, onions, and celery. Cook for 5 - 8 minutes, until softened.",
      "Sprinkle in ¼ cup all-purpose flour and cook, stirring constantly, for 2–3 minutes to eliminate the raw flour taste. Add chicken broth, whisking until smooth. Stir in herbs and heavy cream. Reduce heat to medium-low and simmer for a few minutes until thickened.",
      "Stir in cooked, chopped chicken and frozen peas. Season with salt and pepper to taste. Remove from heat and let the filling cool slightly while you roll out the dough.",
      "Preheat the oven to 400°F (200°C).",
      "Roll out one half of the refrigerated pie crust and place it in a standard 9-inch pie plate. Trim any excess dough. Roll out the second half and set aside.",
      "Pour the chicken pot pie filling into the bottom crust and smooth the top. Cover with the second crust, trim and fold the pie crust edges under, then crimp to seal edges. Cut a few small slits in the top to allow steam to escape.",
      "Using a pastry brush, brush the top of the crust with heavy cream. Place the pie on a cookie sheet to catch any drips that may happen while the pot pie bakes. Bake for 40 - 45 minutes, or until the crust is golden brown.",
      "Let the pie rest for 10 - 15 minutes before slicing. Serve and enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Make a batch of All-Butter Pie Crust and refrigerate for several hours to chill.\nIn a large skillet, melt butter over medium heat. Add chopped carrots, onions, and celery. Cook for 5 - 8 minutes, until softened.\nSprinkle in ¼ cup all-purpose flour and cook, stirring constantly, for 2–3 minutes to eliminate the raw flour taste. Add chicken broth, whisking until smooth. Stir in herbs and heavy cream. Reduce heat to medium-low and simmer for a few minutes until thickened.\nStir in cooked, chopped chicken and frozen peas. Season with salt and pepper to taste. Remove from heat and let the filling cool slightly while you roll out the dough.\nPreheat the oven to 400°F (200°C).\nRoll out one half of the refrigerated pie crust and place it in a standard 9-inch pie plate. Trim any excess dough. Roll out the second half and set aside.\nPour the chicken pot pie filling into the bottom crust and smooth the top. Cover with the second crust, trim and fold the pie crust edges under, then crimp to seal edges. Cut a few small slits in the top to allow steam to escape.\nUsing a pastry brush, brush the top of the crust with heavy cream. Place the pie on a cookie sheet to catch any drips that may happen while the pot pie bakes. Bake for 40 - 45 minutes, or until the crust is golden brown.\nLet the pie rest for 10 - 15 minutes before slicing. Serve and enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("farmhouseonboone.com")
    expect(recipe.canonical_url).to eq("https://www.farmhouseonboone.com/easy-homemade-chicken-pot-pie-recipe/")
    expect(recipe.site_name).to eq("Farmhouse on Boone")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Lisa Bass")
    expect(recipe.description).to eq("This easy chicken pot pie is so incredibly simple to make and absolutely delicious. If you are in need of a dinner that the whole family will enjoy, look no further than this classic recipe.")
    expect(recipe.image).to eq("https://www.farmhouseonboone.com/wp-content/uploads/2025/05/Easy-Chicken-Pot-Pie-143-of-56.jpg")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(85)
    expect(recipe.prep_time).to eq(25)
    expect(recipe.cook_time).to eq(45)
    expect(recipe.keywords).to eq(["Easy Chicken Pot Pie"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.89)
    expect(recipe.ratings_count).to eq(18)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "6 servings",
      "calories" => "373 kcal",
      "carbohydrateContent" => "25 g",
      "proteinContent" => "16 g",
      "fatContent" => "23 g",
      "saturatedFatContent" => "11 g",
      "transFatContent" => "0.3 g",
      "cholesterolContent" => "71 mg",
      "sodiumContent" => "456 mg",
      "fiberContent" => "3 g",
      "sugarContent" => "3 g",
      "unsaturatedFatContent" => "10 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "servings", amount: 6.0 },
      { name: "calories", unit: "kcal", amount: 373.0 },
      { name: "carbohydrateContent", unit: "g", amount: 25.0 },
      { name: "proteinContent", unit: "g", amount: 16.0 },
      { name: "fatContent", unit: "g", amount: 23.0 },
      { name: "saturatedFatContent", unit: "g", amount: 11.0 },
      { name: "transFatContent", unit: "g", amount: 0.3 },
      { name: "cholesterolContent", unit: "mg", amount: 71.0 },
      { name: "sodiumContent", unit: "mg", amount: 456.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "sugarContent", unit: "g", amount: 3.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 10.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
