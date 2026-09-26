# frozen_string_literal: true

RSpec.describe "justataste.com" do
  subject(:recipe) { scrape_cassette("com/justataste", url: "https://www.justataste.com/healthy-baked-chicken-cheese-taquitos-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Easy Chicken Taquitos")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 Tablespoons extra-virgin olive oil",
      "1 cup diced yellow onion",
      "2 cloves garlic, minced",
      "2 Tablespoons fresh lime juice",
      "1 1/2 teaspoons ground cumin",
      "1 1/2 teaspoons paprika",
      "1/4 teaspoon kosher salt",
      "1/4 teaspoon fresh black pepper",
      "3 cups shredded rotisserie chicken",
      "1 cup shredded cheddar or Mexican blend cheese",
      "12 (6-inch) flour tortillas"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "Tablespoons", name: "extra-virgin olive oil" },
      { amount: 1.0, unit: "cup", name: "diced yellow onion" },
      { amount: 2.0, unit: "cloves", name: "garlic, minced" },
      { amount: 2.0, unit: "Tablespoons", name: "fresh lime juice" },
      { amount: 1.5, unit: "teaspoons", name: "ground cumin" },
      { amount: 1.5, unit: "teaspoons", name: "paprika" },
      { amount: 0.25, unit: "teaspoon", name: "kosher salt" },
      { amount: 0.25, unit: "teaspoon", name: "fresh black pepper" },
      { amount: 3.0, unit: "cups", name: "shredded rotisserie chicken" },
      { amount: 1.0, unit: "cup", name: "shredded cheddar or Mexican blend cheese" },
      { amount: 12.0, unit: nil, name: "flour tortillas" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 425ºF and line a baking sheet with parchment paper. (See Kelly's Notes for air fryer instructions.)",
      "In a large saucepan, heat the olive oil over medium heat. Add the diced onion and cook until it's translucent, 3 to 5 minutes. Add the garlic, and cook, stirring occasionally, for about 3 minutes until it's golden and fragrant.",
      "Reduce the heat to low, and then add the lime juice, cumin, paprika, salt and black pepper to the pan, stirring to combine. Add the shredded chicken, tossing to combine.",
      "Transfer the chicken mixture to a large bowl and let it cool for 10 minutes, and then stir in the shredded cheese.",
      "Arrange the tortillas on work surface then place about 3 tablespoons of the chicken mixture on the lower third of each tortilla. Tightly roll up the tortilla, secure it with a toothpick, and then place it seam-side down on the prepared baking sheet. Repeat the filling and rolling process with the remaining tortillas.",
      "Bake the taquitos for 15 to 20 minutes until golden brown and crispy. (See below for air fryer instructions.) Serve with guacamole and salsa."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 425ºF and line a baking sheet with parchment paper. (See Kelly's Notes for air fryer instructions.)\nIn a large saucepan, heat the olive oil over medium heat. Add the diced onion and cook until it's translucent, 3 to 5 minutes. Add the garlic, and cook, stirring occasionally, for about 3 minutes until it's golden and fragrant.\nReduce the heat to low, and then add the lime juice, cumin, paprika, salt and black pepper to the pan, stirring to combine. Add the shredded chicken, tossing to combine.\nTransfer the chicken mixture to a large bowl and let it cool for 10 minutes, and then stir in the shredded cheese.\nArrange the tortillas on work surface then place about 3 tablespoons of the chicken mixture on the lower third of each tortilla. Tightly roll up the tortilla, secure it with a toothpick, and then place it seam-side down on the prepared baking sheet. Repeat the filling and rolling process with the remaining tortillas.\nBake the taquitos for 15 to 20 minutes until golden brown and crispy. (See below for air fryer instructions.) Serve with guacamole and salsa.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("justataste.com")
    expect(recipe.canonical_url).to eq("https://www.justataste.com/healthy-baked-chicken-cheese-taquitos-recipe/")
    expect(recipe.site_name).to eq("Just a Taste")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Kelly Senyei")
    expect(recipe.description).to eq("These easy chicken taquitos are perfect for busy weeknights or meal prep! Made with shredded rotisserie chicken, melty cheese, and a blend of spices, they’re rolled in tortillas and baked or air-fried until crispy.")
    expect(recipe.image).to eq("https://www.justataste.com/wp-content/uploads/2022/04/best-chicken-taquitos.jpg")
    expect(recipe.category).to eq("Appetizer")
    expect(recipe.cuisine).to eq("Mexican")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(55)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(25)
    expect(recipe.keywords).to eq(["chicken", "lime juice", "paprika"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.54)
    expect(recipe.ratings_count).to eq(13)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "319 kcal",
      "carbohydrateContent" => "34 g",
      "proteinContent" => "10 g",
      "fatContent" => "16 g",
      "saturatedFatContent" => "6 g",
      "cholesterolContent" => "19 mg",
      "sodiumContent" => "664 mg",
      "fiberContent" => "3 g",
      "sugarContent" => "4 g",
      "unsaturatedFatContent" => "8 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 319.0 },
      { name: "carbohydrateContent", unit: "g", amount: 34.0 },
      { name: "proteinContent", unit: "g", amount: 10.0 },
      { name: "fatContent", unit: "g", amount: 16.0 },
      { name: "saturatedFatContent", unit: "g", amount: 6.0 },
      { name: "cholesterolContent", unit: "mg", amount: 19.0 },
      { name: "sodiumContent", unit: "mg", amount: 664.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "sugarContent", unit: "g", amount: 4.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 8.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
