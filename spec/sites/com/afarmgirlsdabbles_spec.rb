# frozen_string_literal: true

RSpec.describe "afarmgirlsdabbles.com" do
  subject(:recipe) { scrape_cassette("com/afarmgirlsdabbles", url: "https://www.afarmgirlsdabbles.com/autumn-spiced-cheddar-chicken-tacos-with-apples-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Autumn-Spiced Cheddar Chicken Tacos with Apples")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 T. olive oil",
      "half of a small red onion (diced)",
      "4 c. shredded rotisserie chicken",
      "2 tsp. cumin",
      "1 tsp. chili powder",
      "3/4 tsp. cinnamon",
      "1/4 tsp. garlic powder",
      "1/8 tsp. nutmeg",
      "1/2 c. water",
      "1 to 2 c. Crystal Farms® Shredded Cheddar Cheese",
      "kosher salt (to taste)",
      "freshly ground black pepper (to taste)",
      "1 to 2 apples (cored and diced or very thinly sliced)",
      "orange or lemon juice",
      "small tortillas",
      "shredded lettuce",
      "thinly slice red onion",
      "chopped fresh cilantro",
      "taco sauce",
      "pico de gallo",
      "fresh lime wedges (for squeezing over the top)",
      "additional Crystal Farms® Shredded Cheddar Cheese"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "T", name: "olive oil" },
      { amount: 0.5, unit: nil, name: "small red onion" },
      { amount: 4.0, unit: "c", name: "shredded rotisserie chicken" },
      { amount: 2.0, unit: "tsp", name: "cumin" },
      { amount: 1.0, unit: "tsp", name: "chili powder" },
      { amount: 0.75, unit: "tsp", name: "cinnamon" },
      { amount: 0.25, unit: "tsp", name: "garlic powder" },
      { amount: 0.13, unit: "tsp", name: "nutmeg" },
      { amount: 0.5, unit: "c", name: "water" },
      { amount: 1.0, unit: "c", name: "Crystal Farms® Shredded Cheddar Cheese" },
      { amount: nil, unit: nil, name: "kosher salt" },
      { amount: nil, unit: nil, name: "freshly ground black pepper" },
      { amount: 1.0, unit: nil, name: "apples" },
      { amount: nil, unit: nil, name: "orange or lemon juice" },
      { amount: nil, unit: nil, name: "small tortillas" },
      { amount: nil, unit: nil, name: "shredded lettuce" },
      { amount: nil, unit: nil, name: "thinly slice red onion" },
      { amount: nil, unit: nil, name: "chopped fresh cilantro" },
      { amount: nil, unit: nil, name: "taco sauce" },
      { amount: nil, unit: nil, name: "pico de gallo" },
      { amount: nil, unit: nil, name: "fresh lime wedges" },
      { amount: nil, unit: nil, name: "additional Crystal Farms® Shredded Cheddar Cheese" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large skillet over medium heat, warm the olive oil. Add onion and stir to coat. Saute, stirring occasionally, for about 5 minutes or until onion is nicely softened. Do not let the onion brown. Fold in chicken. Sprinkle with cumin, chili powder, cinnamon, garlic powder, and nutmeg, and fold to incorporate.",
      "Stir in water and let simmer, stirring occasionally. When water is no longer present, stir in your desired amount of cheese. One cup will give you a silky texture, nicely flavored with cheddar. Two cups will give a bit more of a chewy-cheesy texture, with a more prominent cheddar flavor. Once cheese has melted, taste test and add salt and pepper as desired.",
      "While chicken is simmering, toss diced apples with a teaspoon or two of orange juice, just enough to coat the apple pieces. This will keep the apples from browning, plus add a nice fresh tangy flavor.",
      "Serve with small tortillas, plus any additional condiments that you like."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        [nil, 15],
        ["optional condiments:", 7]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large skillet over medium heat, warm the olive oil. Add onion and stir to coat. Saute, stirring occasionally, for about 5 minutes or until onion is nicely softened. Do not let the onion brown. Fold in chicken. Sprinkle with cumin, chili powder, cinnamon, garlic powder, and nutmeg, and fold to incorporate.\nStir in water and let simmer, stirring occasionally. When water is no longer present, stir in your desired amount of cheese. One cup will give you a silky texture, nicely flavored with cheddar. Two cups will give a bit more of a chewy-cheesy texture, with a more prominent cheddar flavor. Once cheese has melted, taste test and add salt and pepper as desired.\nWhile chicken is simmering, toss diced apples with a teaspoon or two of orange juice, just enough to coat the apple pieces. This will keep the apples from browning, plus add a nice fresh tangy flavor.\nServe with small tortillas, plus any additional condiments that you like.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("afarmgirlsdabbles.com")
    expect(recipe.canonical_url).to eq("https://www.afarmgirlsdabbles.com/autumn-spiced-cheddar-chicken-tacos-with-apples-recipe/")
    expect(recipe.site_name).to eq("A Farmgirl's Dabbles")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Brenda | A Farmgirl's Dabbles")
    expect(recipe.description).to eq("You'll love the fall spices mingling in these tacos. The cheddar cheese gets all melty with the chicken, a wonderful contrast to the crisp apple bits!")
    expect(recipe.image).to eq("https://www.afarmgirlsdabbles.com/wp-content/uploads/2016/10/autumn-spiced-cheddar-chicken-tacos-with-apples_AFarmgirlsDabbles_AFD-5-1.jpg")
    expect(recipe.category).to eq("Chicken")
    expect(recipe.cuisine).to eq("Mexican")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(["apple", "apples", "chicken", "chili", "cilantro", "cinnamon", "cumin", "nutmeg", "onion", "red onion"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.5)
    expect(recipe.ratings_count).to eq(2)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1",
      "calories" => "558 kcal",
      "carbohydrateContent" => "22 g",
      "proteinContent" => "53 g",
      "fatContent" => "30 g",
      "saturatedFatContent" => "12 g",
      "transFatContent" => "1 g",
      "cholesterolContent" => "187 mg",
      "sodiumContent" => "1014 mg",
      "fiberContent" => "4 g",
      "sugarContent" => "10 g",
      "unsaturatedFatContent" => "14 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: nil, amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 558.0 },
      { name: "carbohydrateContent", unit: "g", amount: 22.0 },
      { name: "proteinContent", unit: "g", amount: 53.0 },
      { name: "fatContent", unit: "g", amount: 30.0 },
      { name: "saturatedFatContent", unit: "g", amount: 12.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 187.0 },
      { name: "sodiumContent", unit: "mg", amount: 1014.0 },
      { name: "fiberContent", unit: "g", amount: 4.0 },
      { name: "sugarContent", unit: "g", amount: 10.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 14.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
