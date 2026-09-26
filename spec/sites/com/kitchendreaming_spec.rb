# frozen_string_literal: true

RSpec.describe "kitchendreaming.com" do
  subject(:recipe) { scrape_cassette("com/kitchendreaming", url: "https://kitchendreaming.com/crock-pot-buffalo-chicken-meatballs/") }

  it "reads the title" do
    expect(recipe.title).to eq("Crock Pot Buffalo Chicken Meatballs")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1-1/2 pounds ground chicken ([See Note 1])",
      "1/2 cup panko bread crumbs ( [See Note 2])",
      "1 large egg (, slightly beaten)",
      "1 teaspoon onion powder",
      "1 teaspoon salt",
      "1/2 teaspoon ground black pepper",
      "1 teaspoon garlic powder",
      "4 green onions (, sliced thin)",
      "3/4 cup hot sauce ([See Note 3])",
      "1/2 stick ((4 tbsp) butter)",
      "20 celery sticks ([See Note 4])",
      "20 carrot sticks ([See Note 4])",
      "1/2 cup chunky blue cheese dressing ( [See Note 5] - plus more for serving)",
      "fresh parsley for garnish"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "pounds", name: "ground chicken" },
      { amount: 0.5, unit: "cup", name: "panko bread crumbs" },
      { amount: 1.0, unit: nil, name: "large egg" },
      { amount: 1.0, unit: "teaspoon", name: "onion powder" },
      { amount: 1.0, unit: "teaspoon", name: "salt" },
      { amount: 0.5, unit: "teaspoon", name: "ground black pepper" },
      { amount: 1.0, unit: "teaspoon", name: "garlic powder" },
      { amount: 4.0, unit: nil, name: "green onions" },
      { amount: 0.75, unit: "cup", name: "hot sauce" },
      { amount: 0.5, unit: "stick", name: "butter" },
      { amount: 20.0, unit: nil, name: "celery sticks" },
      { amount: 20.0, unit: nil, name: "carrot sticks" },
      { amount: 0.5, unit: "cup", name: "chunky blue cheese dressing" },
      { amount: nil, unit: nil, name: "fresh parsley for garnish" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 400 degrees F. Line a baking sheet with parchment paper or a silicone baking mat and set aside",
      "In a large bowl, combine ground chicken, Panko, egg, garlic and onion powder, green onions, salt, and pepper. Mix until well combined. With a small scoop or your hands, roll the mixture into 1-inch meatballs, forming about 40 meatballs.",
      "Place meatballs onto prepared baking sheet and bake for 4-5 minutes, or until all sides are browned. Cook until meatballs reach an internal temperature of 165°F.",
      "While the meatballs are in the oven, add the butter and hot sauce into the crock pot to melt; then whisk together.",
      "Remove the meatballs from the oven and place into the slow cooker and gently toss to combine with the sauce. Cover and cook on low heat for 2 hours.",
      "To serve: Either insert a carrot or celery sticks into the meatballs for serving or serve them with the carrots and celery on the side allowing guests to chose their stick for an interactive appetizer."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 400 degrees F. Line a baking sheet with parchment paper or a silicone baking mat and set aside\nIn a large bowl, combine ground chicken, Panko, egg, garlic and onion powder, green onions, salt, and pepper. Mix until well combined. With a small scoop or your hands, roll the mixture into 1-inch meatballs, forming about 40 meatballs.\nPlace meatballs onto prepared baking sheet and bake for 4-5 minutes, or until all sides are browned. Cook until meatballs reach an internal temperature of 165°F.\nWhile the meatballs are in the oven, add the butter and hot sauce into the crock pot to melt; then whisk together.\nRemove the meatballs from the oven and place into the slow cooker and gently toss to combine with the sauce. Cover and cook on low heat for 2 hours.\nTo serve: Either insert a carrot or celery sticks into the meatballs for serving or serve them with the carrots and celery on the side allowing guests to chose their stick for an interactive appetizer.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("kitchendreaming.com")
    expect(recipe.canonical_url).to eq("https://kitchendreaming.com/crock-pot-buffalo-chicken-meatballs/")
    expect(recipe.site_name).to eq("Kitchen Dreaming")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Ronda Eagle | Kitchen Dreaming")
    expect(recipe.description).to eq("Tender homemade buffalo chicken meatballs are baked for flavor, then finished in the crock pot with a buttery buffalo sauce. This easy slow cooker appetizer delivers classic buffalo wing flavor in bite-size meatballs perfect for game day, parties, and casual gatherings.")
    expect(recipe.image).to eq("https://kitchendreaming.com/wp-content/uploads/2018/08/Buffalo-Chicken-Wings-Crock-Pot-Version-IMG-4.png")
    expect(recipe.category).to eq("Appetizer")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("20 servings")
    expect(recipe.total_time).to eq(130)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(120)
    expect(recipe.keywords).to eq([
      "Buffalo chicken recipes",
      "Crock Pot Buffalo Chicken Meatballs",
      "easy gameday appetizers",
      "Football foods",
      "ground chicken recipe"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "2 meatballs",
      "calories" => "34 kcal",
      "sugarContent" => "1 g",
      "sodiumContent" => "474 mg",
      "fatContent" => "2 g",
      "saturatedFatContent" => "1 g",
      "transFatContent" => "1 g",
      "carbohydrateContent" => "2 g",
      "fiberContent" => "1 g",
      "proteinContent" => "3 g",
      "cholesterolContent" => "18 mg"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "meatballs", amount: 2.0 },
      { name: "calories", unit: "kcal", amount: 34.0 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 474.0 },
      { name: "fatContent", unit: "g", amount: 2.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "carbohydrateContent", unit: "g", amount: 2.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "proteinContent", unit: "g", amount: 3.0 },
      { name: "cholesterolContent", unit: "mg", amount: 18.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
