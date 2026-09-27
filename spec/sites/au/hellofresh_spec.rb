# frozen_string_literal: true

RSpec.describe "hellofresh.com.au" do
  subject(:recipe) { scrape_cassette("au/hellofresh", url: "https://www.hellofresh.com.au/recipes/double-ras-el-hanout-chicken-and-wholemeal-carrot-couscous-64c8b3a6bb558342d15abdc2") }

  it "reads the title" do
    expect(recipe.title).to eq("Ras El Hanout Chicken & Wholemeal Carrot Couscous with Lemony Salsa & Fetta-Yoghurt Sauce")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 olive oil",
      "2 carrot",
      "¾ cup water",
      "1 sachet chicken-style stock powder",
      "1 packet wholemeal couscous",
      "1 tomato",
      "1 cucumber",
      "½ lemon",
      "1 packet Fetta Cubes",
      "1 packet chicken tenderloins",
      "1 sachet ras el hanout",
      "2 tsp honey",
      "1 packet Greek-style yoghurt"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "olive oil" },
      { amount: 2.0, unit: nil, name: "carrot" },
      { amount: 0.75, unit: "cup", name: "water" },
      { amount: 1.0, unit: nil, name: "sachet chicken-style stock powder" },
      { amount: 1.0, unit: "packet", name: "wholemeal couscous" },
      { amount: 1.0, unit: nil, name: "tomato" },
      { amount: 1.0, unit: nil, name: "cucumber" },
      { amount: 0.5, unit: nil, name: "lemon" },
      { amount: 1.0, unit: "packet", name: "Fetta Cubes" },
      { amount: 1.0, unit: "packet", name: "chicken tenderloins" },
      { amount: 1.0, unit: nil, name: "sachet ras el hanout" },
      { amount: 2.0, unit: "tsp", name: "honey" },
      { amount: 1.0, unit: "packet", name: "Greek-style yoghurt" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "• Grate carrot. • In a medium saucepan, heat a drizzle of olive oil over medium-high heat. Cook carrot, stirring, until softened, 2-3 minutes. • Add the water and chicken-style stock powder and bring to the boil. Add wholemeal couscous and stir to combine. Cover with a lid and remove from the heat. • Set aside until the water has absorbed, 5 minutes. Fluff up with a fork.",
      "• While couscous is cooking, roughly chop tomato and cucumber. • Cut lemon into wedges. • To a medium bowl, add tomato, cucumber, a good squeeze of lemon juice and a drizzle of olive oil. Season and toss to combine. • In a small bowl, add Greek-style yoghurt and a drizzle of olive oil. Crumble in fetta cubes and stir combine. Season to taste.",
      "• To a medium bowl, add ras el hanout and a drizzle of olive oil. Add chicken tenderloins, then toss to coat. Season. • In a large frying pan, heat a drizzle of olive oil over medium-high heat. • Cook chicken tenderloins, until browned and cooked through, 3-4 minutes each side. In the last minute of cook time, add the honey and turn to coat. TIP: Chicken is cooked through when it is no longer pink inside.",
      "• Divide wholemeal carrot couscous between bowls. • Top with ras el hanout chicken, lemony salsa and fetta-yoghurt sauce. • Serve with any remaining lemon wedges. Enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("• Grate carrot. • In a medium saucepan, heat a drizzle of olive oil over medium-high heat. Cook carrot, stirring, until softened, 2-3 minutes. • Add the water and chicken-style stock powder and bring to the boil. Add wholemeal couscous and stir to combine. Cover with a lid and remove from the heat. • Set aside until the water has absorbed, 5 minutes. Fluff up with a fork.\n• While couscous is cooking, roughly chop tomato and cucumber. • Cut lemon into wedges. • To a medium bowl, add tomato, cucumber, a good squeeze of lemon juice and a drizzle of olive oil. Season and toss to combine. • In a small bowl, add Greek-style yoghurt and a drizzle of olive oil. Crumble in fetta cubes and stir combine. Season to taste.\n• To a medium bowl, add ras el hanout and a drizzle of olive oil. Add chicken tenderloins, then toss to coat. Season. • In a large frying pan, heat a drizzle of olive oil over medium-high heat. • Cook chicken tenderloins, until browned and cooked through, 3-4 minutes each side. In the last minute of cook time, add the honey and turn to coat. TIP: Chicken is cooked through when it is no longer pink inside.\n• Divide wholemeal carrot couscous between bowls. • Top with ras el hanout chicken, lemony salsa and fetta-yoghurt sauce. • Serve with any remaining lemon wedges. Enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hellofresh.com.au")
    expect(recipe.canonical_url).to eq("https://www.hellofresh.com.au/recipes/ras-el-hanout-chicken-and-wholemeal-carrot-couscous-64c8b112459aba500a5fae8b")
    expect(recipe.site_name).to eq("HelloFresh")
    expect(recipe.language).to eq("en-AU")
    expect(recipe.author).to eq("HelloFresh")
    expect(recipe.description).to eq("Flavour-packed wholemeal carrot couscous meets ras el hanout-laced chicken for the meal of a lifetime. In true HF fashion, we have added a homemade lemony salsa and a fetta-yoghurt sauce to tie it all together! This recipe is under 650kcal per serving.")
    expect(recipe.image).to eq("https://img.hellofresh.com/f_auto,fl_lossy,h_640,q_auto,w_1200/hellofresh_s3/image/64c8b112459aba500a5fae8b-43140ba6.jpeg")
    expect(recipe.category).to eq("main course")
    expect(recipe.cuisine).to eq("Middle East")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(15)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.082764659725359)
    expect(recipe.ratings_count).to eq(293)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "fatContent" => "14 g",
      "saturatedFatContent" => "4.8 g",
      "carbohydrateContent" => "51.2 g",
      "sugarContent" => "22.8 g",
      "proteinContent" => "50.3 g",
      "fiberContent" => "15.4 g",
      "sodiumContent" => "1003 mg",
      "servingSize" => "625"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "fatContent", unit: "g", amount: 14.0 },
      { name: "saturatedFatContent", unit: "g", amount: 4.8 },
      { name: "carbohydrateContent", unit: "g", amount: 51.2 },
      { name: "sugarContent", unit: "g", amount: 22.8 },
      { name: "proteinContent", unit: "g", amount: 50.3 },
      { name: "fiberContent", unit: "g", amount: 15.4 },
      { name: "sodiumContent", unit: "mg", amount: 1003.0 },
      { name: "servingSize", unit: nil, amount: 625.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#page")
  end
end
