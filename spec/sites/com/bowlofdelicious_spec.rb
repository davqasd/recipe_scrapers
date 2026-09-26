# frozen_string_literal: true

RSpec.describe "bowlofdelicious.com" do
  subject(:recipe) { scrape_cassette("com/bowlofdelicious", url: "https://www.bowlofdelicious.com/six-minute-seared-ahi-tuna-steaks/") }

  it "reads the title" do
    expect(recipe.title).to eq("Six-Minute Seared Ahi Tuna Steaks")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 ahi tuna (yellowfin tuna) steaks (about 4 oz. each, 1\" thick - see notes for thinner or thicker)",
      "2 tablespoons soy sauce (preferably low sodium, see notes)",
      "1 tablespoon toasted sesame oil (see notes)",
      "1 tablespoon honey (see notes)",
      "½ teaspoon kosher salt (optional, see notes)",
      "1/4 teaspoon black pepper (to taste)",
      "1/4 teaspoon cayenne pepper (optional)",
      "1 tablespoon oil (canola, olive, or other high-heat cooking oil of preference)",
      "green onions, toasted sesame seeds, and lime wedges (for serving (optional))"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: nil, name: "ahi tuna steaks" },
      { amount: 2.0, unit: "tablespoons", name: "soy sauce" },
      { amount: 1.0, unit: "tablespoon", name: "toasted sesame oil" },
      { amount: 1.0, unit: "tablespoon", name: "honey" },
      { amount: 0.5, unit: "teaspoon", name: "kosher salt" },
      { amount: 0.25, unit: "teaspoon", name: "black pepper" },
      { amount: 0.25, unit: "teaspoon", name: "cayenne pepper" },
      { amount: 1.0, unit: "tablespoon", name: "oil" },
      { amount: nil, unit: nil, name: "green onions, toasted sesame seeds, and lime wedges" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Pat the 2 ahi tuna (yellowfin tuna) steaks dry with a paper towel. Place on a plate or inside a plastic bag.",
      "Mix the 2 tablespoons soy sauce, 1 tablespoon toasted sesame oil, 1 tablespoon honey, ½ teaspoon kosher salt (if using), 1/4 teaspoon black pepper, and 1/4 teaspoon cayenne pepper until honey is fully dissolved. Pour over the ahi tuna steaks and turn over to coat completely. Optional: allow to marinate for at least 10 minutes, or up to overnight in the refrigerator. Also optional: Reserve a spoonful or two of the marinade before coating the fish for drizzling on top after you've cooked it.",
      "Heat a medium skillet (preferably non-stick or a well-seasoned cast iron skillet) on medium-high to high until very hot ( or medium to medium-high for nonstick). I recommend giving cast iron 3-5 minutes to get hot and nonstick about 1 minute, depending on how thick it is.",
      "Add the 1 tablespoon oil to the hot pan. Sear the tuna for 1 - 1½ minutes on each side for medium rare ( 2 -2½ minutes for medium-well to well, 30 seconds for very rare. See notes - this will vary based on thickness of the tuna steaks). (Note: different burners get hotter depending on your stove. Use your best judgement whether you use medium, medium-high, or high heat, as the marinade may burn if too high heat is used)",
      "Remove to a cutting board. Slice into 1/2 inch slices and serve garnished with green onions, toasted sesame seeds, and lime wedges, if desired. If you find it needs more salt, I recommend sprinkling with flaky sea salt when serving."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Pat the 2 ahi tuna (yellowfin tuna) steaks dry with a paper towel. Place on a plate or inside a plastic bag.\nMix the 2 tablespoons soy sauce, 1 tablespoon toasted sesame oil, 1 tablespoon honey, ½ teaspoon kosher salt (if using), 1/4 teaspoon black pepper, and 1/4 teaspoon cayenne pepper until honey is fully dissolved. Pour over the ahi tuna steaks and turn over to coat completely. Optional: allow to marinate for at least 10 minutes, or up to overnight in the refrigerator. Also optional: Reserve a spoonful or two of the marinade before coating the fish for drizzling on top after you've cooked it.\nHeat a medium skillet (preferably non-stick or a well-seasoned cast iron skillet) on medium-high to high until very hot ( or medium to medium-high for nonstick). I recommend giving cast iron 3-5 minutes to get hot and nonstick about 1 minute, depending on how thick it is.\nAdd the 1 tablespoon oil to the hot pan. Sear the tuna for 1 - 1½ minutes on each side for medium rare ( 2 -2½ minutes for medium-well to well, 30 seconds for very rare. See notes - this will vary based on thickness of the tuna steaks). (Note: different burners get hotter depending on your stove. Use your best judgement whether you use medium, medium-high, or high heat, as the marinade may burn if too high heat is used)\nRemove to a cutting board. Slice into 1/2 inch slices and serve garnished with green onions, toasted sesame seeds, and lime wedges, if desired. If you find it needs more salt, I recommend sprinkling with flaky sea salt when serving.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("bowlofdelicious.com")
    expect(recipe.canonical_url).to eq("https://www.bowlofdelicious.com/six-minute-seared-ahi-tuna-steaks/")
    expect(recipe.site_name).to eq("Bowl of Delicious")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Elizabeth Lindemann")
    expect(recipe.description).to eq("These seared ahi tuna steaks take only 6 minutes to make- they're healthy, crispy and seared on the outside, and medium-rare on the inside, and bursting with umami flavor!")
    expect(recipe.image).to eq("https://www.bowlofdelicious.com/wp-content/uploads/2019/09/Ahi-Tuna-Steaks-square.jpg")
    expect(recipe.category).to eq("Fish")
    expect(recipe.cuisine).to eq("Seafood")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(6)
    expect(recipe.prep_time).to eq(1)
    expect(recipe.cook_time).to eq(5)
    expect(recipe.keywords).to eq(["Ahi tuna recipe", "How to cook ahi tuna", "Seared ahi tuna medium rare"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.96)
    expect(recipe.ratings_count).to eq(2020)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "331 kcal",
      "carbohydrateContent" => "10 g",
      "proteinContent" => "28 g",
      "fatContent" => "20 g",
      "saturatedFatContent" => "3 g",
      "cholesterolContent" => "43 mg",
      "sodiumContent" => "1632 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "9 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 331.0 },
      { name: "carbohydrateContent", unit: "g", amount: 10.0 },
      { name: "proteinContent", unit: "g", amount: 28.0 },
      { name: "fatContent", unit: "g", amount: 20.0 },
      { name: "saturatedFatContent", unit: "g", amount: 3.0 },
      { name: "cholesterolContent", unit: "mg", amount: 43.0 },
      { name: "sodiumContent", unit: "mg", amount: 1632.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 9.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
