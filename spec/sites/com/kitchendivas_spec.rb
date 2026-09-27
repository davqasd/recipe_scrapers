# frozen_string_literal: true

RSpec.describe "kitchendivas.com" do
  subject(:recipe) { scrape_cassette("com/kitchendivas", url: "https://kitchendivas.com/grilled-baked-jalapeno-poppers-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Bacon Wrapped Cream Cheese Stuffed Jalapeno Poppers")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "8 slices bacon, diced",
      "12 jalapeños, halved lengthwise with stems left intact, seeds and ribs removed, between 3 and 4 inches long",
      "1 cup cheddar cheese, shredded",
      "1 cup Monterey Jack cheese, shredded",
      "4 ounces cream cheese, softened",
      "1 teaspoon garlic powder",
      "2 green onions, thinly sliced",
      "2 tablespoons panko bread crumbs",
      "1 large egg yolk",
      "2 teaspoons lime or lemon juice",
      "2-3 tablespoons minced fresh cilantro or parsley, if desired",
      "1 teaspoon chili powder, taco seasoning, curry powder, ground cumin, paprika or coriander",
      "cayenne pepper, red pepper flakes, dashes of sriracha or hot sauce, to taste",
      "cooked medium shrimp, deveined and shelled (one for each jalapeño half), optional",
      "1/2 pound cooked ground beef, leftover roast beef, sausage, shredded chicken or crab meat",
      "bacon strips (cut in half crosswise to match number of jalapeño halves)",
      "toothpick for each jalapeño half",
      "1/4 cup Barbecue Sauce of choice"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 8.0, unit: "slices", name: "bacon, diced" },
      { amount: 12.0, unit: nil, name: "jalapeños, halved lengthwise with stems left intact, seeds and ribs removed, between 3 and 4 inches long" },
      { amount: 1.0, unit: "cup", name: "cheddar cheese, shredded" },
      { amount: 1.0, unit: "cup", name: "Monterey Jack cheese, shredded" },
      { amount: 4.0, unit: "ounces", name: "cream cheese, softened" },
      { amount: 1.0, unit: "teaspoon", name: "garlic powder" },
      { amount: 2.0, unit: nil, name: "green onions, thinly sliced" },
      { amount: 2.0, unit: "tablespoons", name: "panko bread crumbs" },
      { amount: 1.0, unit: nil, name: "large egg yolk" },
      { amount: 2.0, unit: "teaspoons", name: "lime or lemon juice" },
      { amount: 2.0, unit: "tablespoons", name: "minced fresh cilantro or parsley, if desired" },
      { amount: 1.0, unit: "teaspoon", name: "chili powder, taco seasoning, curry powder, ground cumin, paprika or coriander" },
      { amount: nil, unit: nil, name: "cayenne pepper, red pepper flakes, dashes of sriracha or hot sauce, to taste" },
      { amount: nil, unit: nil, name: "cooked medium shrimp, deveined and shelled, optional" },
      { amount: 0.5, unit: "pound", name: "cooked ground beef, leftover roast beef, sausage, shredded chicken or crab meat" },
      { amount: nil, unit: nil, name: "bacon strips" },
      { amount: nil, unit: nil, name: "toothpick for each jalapeño half" },
      { amount: 0.25, unit: "cup", name: "Barbecue Sauce of choice" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "If using shrimp, sauté in skillet in 1 tablespoon butter or olive oil until pink on both sides. Set aside until ready to use.",
      "If using 1/2 pound ground beef or sausage use a skillet to brown it, then place on a paper towel-lined plate to drain. Allow meat to totally cool before blending with cheese mixture.",
      "Cook diced bacon in 12-inch nonstick skillet over medium heat until crispy, 8 to 9 minutes. Transfer to paper towel–lined plate. Set aside.",
      "Mix cheddar, Monterey Jack, cream cheese, bacon, garlic powder, scallions, cilantro or parsley, panko, egg yolk, lime juice, seasoning of choice, bacon and any extra options you want to include together in bowl until incorporated and nice and creamy.",
      "Not Wrapped in Bacon",
      "Adjust your oven rack to upper-middle position and preheat your oven to 500 degrees. Prepare your rimmed baking sheet with a wire rack lightly coated with cooking spray.",
      "Season jalapeños with sprinkles of salt and place cut side down on top of your wire rack. Bake until just starting t become tender, between 4 and 5 minutes.",
      "Remove jalapeños from oven and set aside to cool.",
      "Set your oven's temperature to 450 degrees.",
      "Once jalapenos are cool enough to handle, flip them over so the cut side is facing up.",
      "Divide cheese mixture among each of your jalapeños, carefully pressing into each. Fill each jalapeño about 2/3 full with cheese mixture and do not overfill them.",
      "Bake until filling is a light golden brown, about 10 minutes. If desired, place under broiler for 2-3 minutes to lightly brown tops. Just keep a close watch because these poppers can burn fast. Allow to cool for 5 minutes before serving.",
      "Wrapped in Bacon",
      "Divide cheese mixture among jalapeños, pressing into cavities. Fill each jalapeño half until it is about 2/3 full. Don’t overfill.",
      "Top each half with a shrimp, if using.",
      "Wrap each jalapeño half with bacon and secure with wooden toothpick.",
      "Brush each half with barbecue sauce if desired.",
      "Oven Option",
      "Preheat oven to 400 degrees.",
      "Place poppers on parchment lined pan.",
      "Bake for 20 to 25 minutes.",
      "If desired, place under broiler for 2-3 minutes to lightly brown tops.",
      "Let sit about 10 minutes before serving.",
      "Grilling Option",
      "Place on hot grill with indirect heat to prevent burning.",
      "Leave on grill 20-25 minutes or until bacon crisps and cheese is melted.",
      "Air Fryer",
      "To cook bacon wrapped jalapeno poppers in your air fryer, prepare as directed, then cook at 325 degrees for 15 to 20 minutes, depending on the size of your peppers.",
      "If not wrapped in bacon only 10 minutes are needed."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        [nil, 10],
        ["Options, If Using", 5],
        ["Bacon Wrapped", 3]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("If using shrimp, sauté in skillet in 1 tablespoon butter or olive oil until pink on both sides. Set aside until ready to use.\nIf using 1/2 pound ground beef or sausage use a skillet to brown it, then place on a paper towel-lined plate to drain. Allow meat to totally cool before blending with cheese mixture.\nCook diced bacon in 12-inch nonstick skillet over medium heat until crispy, 8 to 9 minutes. Transfer to paper towel–lined plate. Set aside.\nMix cheddar, Monterey Jack, cream cheese, bacon, garlic powder, scallions, cilantro or parsley, panko, egg yolk, lime juice, seasoning of choice, bacon and any extra options you want to include together in bowl until incorporated and nice and creamy.\nNot Wrapped in Bacon\nAdjust your oven rack to upper-middle position and preheat your oven to 500 degrees. Prepare your rimmed baking sheet with a wire rack lightly coated with cooking spray.\nSeason jalapeños with sprinkles of salt and place cut side down on top of your wire rack. Bake until just starting t become tender, between 4 and 5 minutes.\nRemove jalapeños from oven and set aside to cool.\nSet your oven's temperature to 450 degrees.\nOnce jalapenos are cool enough to handle, flip them over so the cut side is facing up.\nDivide cheese mixture among each of your jalapeños, carefully pressing into each. Fill each jalapeño about 2/3 full with cheese mixture and do not overfill them.\nBake until filling is a light golden brown, about 10 minutes. If desired, place under broiler for 2-3 minutes to lightly brown tops. Just keep a close watch because these poppers can burn fast. Allow to cool for 5 minutes before serving.\nWrapped in Bacon\nDivide cheese mixture among jalapeños, pressing into cavities. Fill each jalapeño half until it is about 2/3 full. Don’t overfill.\nTop each half with a shrimp, if using.\nWrap each jalapeño half with bacon and secure with wooden toothpick.\nBrush each half with barbecue sauce if desired.\nOven Option\nPreheat oven to 400 degrees.\nPlace poppers on parchment lined pan.\nBake for 20 to 25 minutes.\nIf desired, place under broiler for 2-3 minutes to lightly brown tops.\nLet sit about 10 minutes before serving.\nGrilling Option\nPlace on hot grill with indirect heat to prevent burning.\nLeave on grill 20-25 minutes or until bacon crisps and cheese is melted.\nAir Fryer\nTo cook bacon wrapped jalapeno poppers in your air fryer, prepare as directed, then cook at 325 degrees for 15 to 20 minutes, depending on the size of your peppers.\nIf not wrapped in bacon only 10 minutes are needed.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("kitchendivas.com")
    expect(recipe.canonical_url).to eq("https://kitchendivas.com/grilled-baked-jalapeno-poppers-recipe/")
    expect(recipe.site_name).to eq("Kitchen Divas")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Karin and Ken")
    expect(recipe.description).to eq("Bacon Wrapped Cream Cheese Stuffed Jalapeno Poppers, with or without bacon, are full of flavor, oh so cheesy and baked, fried or grilled.")
    expect(recipe.image).to eq("https://kitchendivas.com/wp-content/uploads/366A0855.jpg")
    expect(recipe.category).to eq("Appetizer")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("24 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(25)
    expect(recipe.keywords).to eq(["bacon wrapped", "easy appetizer", "jalapeno popper"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "143 kcal",
      "carbohydrateContent" => "2 g",
      "proteinContent" => "4 g",
      "fatContent" => "8 g",
      "saturatedFatContent" => "4 g",
      "transFatContent" => "0.01 g",
      "cholesterolContent" => "26 mg",
      "sodiumContent" => "131 mg",
      "fiberContent" => "0.3 g",
      "sugarContent" => "1 g",
      "unsaturatedFatContent" => "4 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 143.0 },
      { name: "carbohydrateContent", unit: "g", amount: 2.0 },
      { name: "proteinContent", unit: "g", amount: 4.0 },
      { name: "fatContent", unit: "g", amount: 8.0 },
      { name: "saturatedFatContent", unit: "g", amount: 4.0 },
      { name: "transFatContent", unit: "g", amount: 0.01 },
      { name: "cholesterolContent", unit: "mg", amount: 26.0 },
      { name: "sodiumContent", unit: "mg", amount: 131.0 },
      { name: "fiberContent", unit: "g", amount: 0.3 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 4.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#feastmobilemenu")
  end
end
