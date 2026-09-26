# frozen_string_literal: true

RSpec.describe "bitsofcarey.com" do
  subject(:recipe) { scrape_cassette("com/bitsofcarey", url: "https://bitsofcarey.com/asian-style-sweetcorn-fritters/") }

  it "reads the title" do
    expect(recipe.title).to eq("Asian Style Sweetcorn Fritters")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups (260 g) sweetcorn (canned (drained) or frozen (thawed))",
      "2 spring onions (finely chopped)",
      "½ cup fresh coriander (chopped)",
      "¼ cup mint leaves (chopped)",
      "1 ½ tsp sambal oelek (Garlic chilli paste)",
      "1 lime (zest of)",
      "salt and pepper (to taste)",
      "½ cup (65 g) all purpose flour",
      "¼ cup (30 g) corn flour",
      "1 tsp baking powder",
      "125 ml coconut milk (or milk of your choice)",
      "1 large egg (beaten)",
      "½ tsp fish sauce (optional)",
      "olive oil (to grease pan)",
      "sesame oil (a few drops)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "sweetcorn" },
      { amount: 2.0, unit: nil, name: "spring onions" },
      { amount: 0.5, unit: "cup", name: "fresh coriander" },
      { amount: 0.25, unit: "cup", name: "mint leaves" },
      { amount: 1.5, unit: "tsp", name: "sambal oelek" },
      { amount: 1.0, unit: nil, name: "lime" },
      { amount: nil, unit: nil, name: "salt and pepper" },
      { amount: 0.5, unit: "cup", name: "all purpose flour" },
      { amount: 0.25, unit: "cup", name: "corn flour" },
      { amount: 1.0, unit: "tsp", name: "baking powder" },
      { amount: 125.0, unit: "ml", name: "coconut milk" },
      { amount: 1.0, unit: nil, name: "large egg" },
      { amount: 0.5, unit: "tsp", name: "fish sauce" },
      { amount: nil, unit: nil, name: "olive oil" },
      { amount: nil, unit: nil, name: "sesame oil" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Mix all the ingredients together until evenly combined. It should resemble a chunky thick batter.",
      "Lightly grease non stick pan with olive oil and some sesame oil for flavour.",
      "Fry 1 Tbsp portions over moderate heat until golden brown on both sides and the centre in cooked.",
      "1 Tbsp portions make 15 fritters, and 2 Tbsp portions make +- 7 large fritters.",
      "Place on on kitchen paper towel to absorb excess oil.",
      "Serve with a fragrant homemade soy dipping sauce, sweet chilli sauce, sriracha mayo or hot honey.",
      "Garnish with extra herbs.",
      "Eat immediately!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Mix all the ingredients together until evenly combined. It should resemble a chunky thick batter.\nLightly grease non stick pan with olive oil and some sesame oil for flavour.\nFry 1 Tbsp portions over moderate heat until golden brown on both sides and the centre in cooked.\n1 Tbsp portions make 15 fritters, and 2 Tbsp portions make +- 7 large fritters.\nPlace on on kitchen paper towel to absorb excess oil.\nServe with a fragrant homemade soy dipping sauce, sweet chilli sauce, sriracha mayo or hot honey.\nGarnish with extra herbs.\nEat immediately!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("bitsofcarey.com")
    expect(recipe.canonical_url).to eq("https://bitsofcarey.com/asian-style-sweetcorn-fritters/")
    expect(recipe.site_name).to eq("Bits of Carey")
    expect(recipe.language).to eq("en-ZA")
    expect(recipe.author).to eq("Carey Erasmus")
    expect(recipe.description).to eq("These Asian Style Sweetcorn Fritters are made with just a few pantry staples and some fresh herbs. So delicious and utterly moreish.")
    expect(recipe.image).to eq("https://bitsofcarey.com/wp-content/uploads/2022/07/IMG_1412.jpg")
    expect(recipe.category).to eq("Appetizer")
    expect(recipe.cuisine).to eq("Asian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("15 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(%w[Asian Fritters Sweetcorn])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "97 kcal",
      "carbohydrateContent" => "17 g",
      "proteinContent" => "3 g",
      "fatContent" => "3 g",
      "saturatedFatContent" => "2 g",
      "transFatContent" => "0.001 g",
      "cholesterolContent" => "11 mg",
      "sodiumContent" => "51 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "2 g",
      "unsaturatedFatContent" => "0.6 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 97.0 },
      { name: "carbohydrateContent", unit: "g", amount: 17.0 },
      { name: "proteinContent", unit: "g", amount: 3.0 },
      { name: "fatContent", unit: "g", amount: 3.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "transFatContent", unit: "g", amount: 0.001 },
      { name: "cholesterolContent", unit: "mg", amount: 11.0 },
      { name: "sodiumContent", unit: "mg", amount: 51.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 2.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 0.6 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#")
  end
end
