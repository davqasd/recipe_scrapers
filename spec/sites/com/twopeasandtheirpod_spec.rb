# frozen_string_literal: true

RSpec.describe "twopeasandtheirpod.com" do
  subject(:recipe) { scrape_cassette("com/twopeasandtheirpod", url: "https://www.twopeasandtheirpod.com/baked-chicken-taquitos/") }

  it "reads the title" do
    expect(recipe.title).to eq("Chicken Taquitos")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups shredded chicken, (we use rotisserie chicken)",
      "1/2 teaspoon ground cumin",
      "1/2 teaspoon ground chili powder",
      "1/2 teaspoon kosher salt",
      "1/4 teaspoon garlic powder",
      "1/4 teaspoon paprika",
      "2 teaspoons fresh lime juice",
      "1 cup shredded cheddar or Mexican blend cheese",
      "20 corn tortillas",
      "Shredded lettuce",
      "Diced tomatoes",
      "Guacamole",
      "Sour Cream",
      "Chopped Green Onion",
      "Crumbled Queso Fresco",
      "Pico de Gallo",
      "Salsa"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "shredded chicken" },
      { amount: 0.5, unit: "teaspoon", name: "ground cumin" },
      { amount: 0.5, unit: "teaspoon", name: "ground chili powder" },
      { amount: 0.5, unit: "teaspoon", name: "kosher salt" },
      { amount: 0.25, unit: "teaspoon", name: "garlic powder" },
      { amount: 0.25, unit: "teaspoon", name: "paprika" },
      { amount: 2.0, unit: "teaspoons", name: "fresh lime juice" },
      { amount: 1.0, unit: "cup", name: "shredded cheddar or Mexican blend cheese" },
      { amount: 20.0, unit: nil, name: "corn tortillas" },
      { amount: nil, unit: nil, name: "Shredded lettuce" },
      { amount: nil, unit: nil, name: "Diced tomatoes" },
      { amount: nil, unit: nil, name: "Guacamole" },
      { amount: nil, unit: nil, name: "Sour Cream" },
      { amount: nil, unit: nil, name: "Chopped Green Onion" },
      { amount: nil, unit: nil, name: "Crumbled Queso Fresco" },
      { amount: nil, unit: nil, name: "Pico de Gallo" },
      { amount: nil, unit: nil, name: "Salsa" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 425 degrees F. Spray a large baking sheet with nonstick cooking spray and set aside.",
      "In a medium bowl, combine the shredded chicken with the cumin, chili powder, salt, garlic powder, paprika, and fresh lime juice. Stir until chicken is well coated with the seasonings. Stir in the shredded cheese.",
      "Get two paper towels damp and place two tortillas at a time in between the paper towels. Place in the microwave for 20-30 seconds. Remove from the microwave and roll up the taquitos.",
      "Place a heaping tablespoon of the chicken and cheese mixture in the center of the tortilla and roll it up tightly. Place the taquito, seam side down on the prepared baking sheet. Continue rolling taquitos until the tortillas and filling are gone. You should have about 20 taquitos.",
      "Spray the taquitos generously with nonstick cooking spray. Bake for 15-20 minutes or until taquitos are golden brown and crispy. Remove from the oven and serve warm with desired toppings."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["For the Taquitos:", 9],
        ["For the Toppings:", 8]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 425 degrees F. Spray a large baking sheet with nonstick cooking spray and set aside.\nIn a medium bowl, combine the shredded chicken with the cumin, chili powder, salt, garlic powder, paprika, and fresh lime juice. Stir until chicken is well coated with the seasonings. Stir in the shredded cheese.\nGet two paper towels damp and place two tortillas at a time in between the paper towels. Place in the microwave for 20-30 seconds. Remove from the microwave and roll up the taquitos.\nPlace a heaping tablespoon of the chicken and cheese mixture in the center of the tortilla and roll it up tightly. Place the taquito, seam side down on the prepared baking sheet. Continue rolling taquitos until the tortillas and filling are gone. You should have about 20 taquitos.\nSpray the taquitos generously with nonstick cooking spray. Bake for 15-20 minutes or until taquitos are golden brown and crispy. Remove from the oven and serve warm with desired toppings.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("twopeasandtheirpod.com")
    expect(recipe.canonical_url).to eq("https://www.twopeasandtheirpod.com/baked-chicken-taquitos/")
    expect(recipe.site_name).to eq("Two Peas & Their Pod")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Maria Lichty")
    expect(recipe.description).to eq("These easy Baked Chicken Taquitos are stuffed with chicken and cheese and make a great appetizer or meal. These homemade taquitos are a family favorite! Plus, learn how to make taquitos you can freeze for later!")
    expect(recipe.image).to eq("https://www.twopeasandtheirpod.com/wp-content/uploads/2017/03/Baked-Chicken-Taquitos-1.jpg")
    expect(recipe.category).to eq("Appetizer")
    expect(recipe.cuisine).to eq("Mexican")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("20 servings")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(25)
    expect(recipe.keywords).to eq(["taquitos"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.66)
    expect(recipe.ratings_count).to eq(163)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "20 g",
      "calories" => "132 kcal",
      "carbohydrateContent" => "11 g",
      "proteinContent" => "8 g",
      "fatContent" => "5 g",
      "saturatedFatContent" => "2 g",
      "cholesterolContent" => "23 mg",
      "sodiumContent" => "123 mg",
      "fiberContent" => "1 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "g", amount: 20.0 },
      { name: "calories", unit: "kcal", amount: 132.0 },
      { name: "carbohydrateContent", unit: "g", amount: 11.0 },
      { name: "proteinContent", unit: "g", amount: 8.0 },
      { name: "fatContent", unit: "g", amount: 5.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "cholesterolContent", unit: "mg", amount: 23.0 },
      { name: "sodiumContent", unit: "mg", amount: 123.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
