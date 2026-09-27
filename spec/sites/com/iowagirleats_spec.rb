# frozen_string_literal: true

RSpec.describe "iowagirleats.com" do
  subject(:recipe) { scrape_cassette("com/iowagirleats", url: "https://iowagirleats.com/pulled-pork-taquitos-with-chipotle-ranch-dipping-sauce-crock-pot-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Pulled Pork Taquitos with Chipotle-Ranch Dipping Sauce")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 - 3.5 lb boneless pork butt (also called pork shoulder)",
      "14 oz can chicken broth",
      "1 onion (chopped)",
      "6 cloves garlic (peeled and smashed)",
      "2 teaspoons chili powder",
      "2 teaspoons cumin",
      "1 teaspoon salt",
      "8 oz shredded queso fresco (or Monterey Jack or a shredded Mexican cheese blend)",
      "18 gluten free corn tortillas (Mission Super Soft recommended)",
      "For serving: guacamole, salsa",
      "1/2 cup prepared ranch dressing",
      "2 chipotle peppers in adobo sauce + 2 teaspoons sauce"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "lb", name: "boneless pork butt" },
      { amount: 14.0, unit: "oz", name: "can chicken broth" },
      { amount: 1.0, unit: nil, name: "onion" },
      { amount: 6.0, unit: "cloves", name: "garlic" },
      { amount: 2.0, unit: "teaspoons", name: "chili powder" },
      { amount: 2.0, unit: "teaspoons", name: "cumin" },
      { amount: 1.0, unit: "teaspoon", name: "salt" },
      { amount: 8.0, unit: "oz", name: "shredded queso fresco" },
      { amount: 18.0, unit: nil, name: "gluten free corn tortillas" },
      { amount: nil, unit: nil, name: "For serving: guacamole, salsa" },
      { amount: 0.5, unit: "cup", name: "prepared ranch dressing" },
      { amount: 2.0, unit: nil, name: "chipotle peppers in adobo sauce + 2 teaspoons sauce" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Cook pork",
      "Trim fat from pork then cut into 8 pieces and place into the bottom of a 6 quart crock pot. Add chicken broth, onion, garlic, chili powder, cumin, and salt then stir to combine. Cook on high for 5-6 hours or low for 8-10 hours, or until the pork shreds easily with two forks. Shred the pork then place it into a large bowl with 1/2 cup of the cooking liquid and stir to combine. Discard remaining cooking liquid.",
      "Preheat oven to 425 degrees then line a half sheet pan with foil and spray well with nonstick spray. Set aside.",
      "Bake",
      "Wrap 6 tortillas at a time in a damp paper towel then microwave for 30 seconds. Place 3 Tablespoons shredded pork into the center of each warm tortilla (just eyeball it) then top with 1 Tablespoon shredded cheese. Roll then place seam side down on the prepared baking sheet. Repeat with remaining ingredients then spray tops of the tortillas with nonstick spray and bake for 13-15 minutes or until tops are golden brown and crunchy.",
      "For the Chipotle-Ranch Dipping Sauce:",
      "Make sauce",
      "Combine ranch dressing, chipotle peppers, and sauce in a food processor then process until smooth. Alternatively, finely chop peppers then stir ingredients together to combine.",
      "To freeze:",
      "Freeze taquitos on a baking sheet then transfer to a freezer bag. Bake the same way frozen as fresh (ie do not thaw.)"
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        [nil, 10],
        ["For the Chipotle-Ranch Dipping Sauce:", 2]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Cook pork\nTrim fat from pork then cut into 8 pieces and place into the bottom of a 6 quart crock pot. Add chicken broth, onion, garlic, chili powder, cumin, and salt then stir to combine. Cook on high for 5-6 hours or low for 8-10 hours, or until the pork shreds easily with two forks. Shred the pork then place it into a large bowl with 1/2 cup of the cooking liquid and stir to combine. Discard remaining cooking liquid.\nPreheat oven to 425 degrees then line a half sheet pan with foil and spray well with nonstick spray. Set aside.\nBake\nWrap 6 tortillas at a time in a damp paper towel then microwave for 30 seconds. Place 3 Tablespoons shredded pork into the center of each warm tortilla (just eyeball it) then top with 1 Tablespoon shredded cheese. Roll then place seam side down on the prepared baking sheet. Repeat with remaining ingredients then spray tops of the tortillas with nonstick spray and bake for 13-15 minutes or until tops are golden brown and crunchy.\nFor the Chipotle-Ranch Dipping Sauce:\nMake sauce\nCombine ranch dressing, chipotle peppers, and sauce in a food processor then process until smooth. Alternatively, finely chop peppers then stir ingredients together to combine.\nTo freeze:\nFreeze taquitos on a baking sheet then transfer to a freezer bag. Bake the same way frozen as fresh (ie do not thaw.)")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("iowagirleats.com")
    expect(recipe.canonical_url).to eq("https://iowagirleats.com/pulled-pork-taquitos-with-chipotle-ranch-dipping-sauce-crock-pot-recipe/")
    expect(recipe.site_name).to eq("Iowa Girl Eats")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Kristin Porter")
    expect(recipe.description).to eq("Pulled Pork Taquitos with Chipotle-Ranch Dipping Sauce are a delicious and fun crock pot recipe. Perfect for game day, or dinner tonight!")
    expect(recipe.image).to eq("https://iowagirleats.com/wp-content/uploads/2013/09/PulledPorkTaquitos_ChipotleRanchDippingSauce_12_mini.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("Mexican")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("18 servings")
    expect(recipe.total_time).to eq(335)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(315)
    expect(recipe.keywords).to eq(["gluten free"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "247 kcal",
      "carbohydrateContent" => "14 g",
      "proteinContent" => "21 g",
      "fatContent" => "12 g",
      "saturatedFatContent" => "4 g",
      "transFatContent" => "0.1 g",
      "cholesterolContent" => "64 mg",
      "sodiumContent" => "439 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "1 g",
      "unsaturatedFatContent" => "7 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 247.0 },
      { name: "carbohydrateContent", unit: "g", amount: 14.0 },
      { name: "proteinContent", unit: "g", amount: 21.0 },
      { name: "fatContent", unit: "g", amount: 12.0 },
      { name: "saturatedFatContent", unit: "g", amount: 4.0 },
      { name: "transFatContent", unit: "g", amount: 0.1 },
      { name: "cholesterolContent", unit: "mg", amount: 64.0 },
      { name: "sodiumContent", unit: "mg", amount: 439.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 7.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
