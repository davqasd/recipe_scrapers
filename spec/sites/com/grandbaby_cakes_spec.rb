# frozen_string_literal: true

RSpec.describe "grandbaby-cakes.com" do
  subject(:recipe) { scrape_cassette("com/grandbaby_cakes", url: "https://grandbaby-cakes.com/crispy-baked-fish-sticks-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Crispy Baked Fish Sticks")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup crushed corn flakes",
      "1 teaspoon paprika",
      "1 teaspoon lemon-pepper seasoning",
      "½- ¾ teaspoon kosher salt",
      "½ teaspoon cayenne pepper",
      "1 cup all-purpose flour",
      "2 large eggs (beaten)",
      "1 pound cod fillets (cut into 1-inch strips)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "crushed corn flakes" },
      { amount: 1.0, unit: "teaspoon", name: "paprika" },
      { amount: 1.0, unit: "teaspoon", name: "lemon-pepper seasoning" },
      { amount: 0.5, unit: "teaspoon", name: "kosher salt" },
      { amount: 0.5, unit: "teaspoon", name: "cayenne pepper" },
      { amount: 1.0, unit: "cup", name: "all-purpose flour" },
      { amount: 2.0, unit: nil, name: "large eggs" },
      { amount: 1.0, unit: "pound", name: "cod fillets" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 400° and cover baking sheet with parchment paper and spray liberally with non-stick cooking spray.",
      "In a shallow bowl, whisk together corn flakes, paprika, lemon pepper, salt and cayenne until combined then place flour and egg in two separate shallow bowls.",
      "To assemble, dip fish in flour to coat both sides then dip into eggs and finally into cornflake mixture then place on baking sheet.",
      "Once done coating all fish, liberally spray tops of fish with additional cooking spray. Bake 12-14 minutes or until fish just begins to flake easily with a fork."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 400° and cover baking sheet with parchment paper and spray liberally with non-stick cooking spray.\nIn a shallow bowl, whisk together corn flakes, paprika, lemon pepper, salt and cayenne until combined then place flour and egg in two separate shallow bowls.\nTo assemble, dip fish in flour to coat both sides then dip into eggs and finally into cornflake mixture then place on baking sheet.\nOnce done coating all fish, liberally spray tops of fish with additional cooking spray. Bake 12-14 minutes or until fish just begins to flake easily with a fork.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("grandbaby-cakes.com")
    expect(recipe.canonical_url).to eq("https://grandbaby-cakes.com/crispy-baked-fish-sticks-recipe/")
    expect(recipe.site_name).to eq("Grandbaby Cakes")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Jocelyn Delk")
    expect(recipe.description).to eq("Crispy Baked Fish Sticks Recipe made from cod and crushed cornflakes, super crispy, and once breaded, the oven does all the work.")
    expect(recipe.image).to eq("https://grandbaby-cakes.com/wp-content/uploads/2017/03/baked-fish-sticks-16.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(27)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(12)
    expect(recipe.keywords).to eq([
      "baked fish sticks",
      "cod fish sticks",
      "crispy fish sticks",
      "fish sticks recipe",
      "homemade fish sticks"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.5)
    expect(recipe.ratings_count).to eq(10)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "304 kcal",
      "carbohydrateContent" => "49 g",
      "proteinContent" => "20 g",
      "fatContent" => "2 g",
      "cholesterolContent" => "94 mg",
      "sodiumContent" => "352 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "3 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 304.0 },
      { name: "carbohydrateContent", unit: "g", amount: 49.0 },
      { name: "proteinContent", unit: "g", amount: 20.0 },
      { name: "fatContent", unit: "g", amount: 2.0 },
      { name: "cholesterolContent", unit: "mg", amount: 94.0 },
      { name: "sodiumContent", unit: "mg", amount: 352.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 3.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
