# frozen_string_literal: true

RSpec.describe "hellofresh.lu" do
  subject(:recipe) { scrape_cassette("lu/hellofresh", url: "https://www.hellofresh.lu/recipes/smoothie-banane-epinards-5df9f678ec05895373722f2f") }

  it "reads the title" do
    expect(recipe.title).to eq("Smoothie banane-épinards accompagné d'un kiwi gold et de graines de tournesol")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 pièce(s) Banane",
      "50 g Épinards",
      "250 ml Yaourt à la grecque BIO",
      "20 g Graines de tournesol",
      "1 pièce(s) Kiwi gold"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: nil, name: "pièce Banane" },
      { amount: 50.0, unit: "g", name: "Épinards" },
      { amount: 250.0, unit: "ml", name: "Yaourt à la grecque BIO" },
      { amount: 20.0, unit: "g", name: "Graines de tournesol" },
      { amount: 1.0, unit: nil, name: "pièce Kiwi gold" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Pelez la banane et coupez-la en morceaux. À l'aide d'un blender, mixez les épinards, la banane et le yaourt grec afin d'obtenir un smoothie épais. Épluchez les kiwis, et réduisez-les en purée à l'aide d'une fourchette.",
      "Répartissez le smoothie dans des bols. Garnissez le tout de purée de kiwis et de graines de tournesol."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Pelez la banane et coupez-la en morceaux. À l'aide d'un blender, mixez les épinards, la banane et le yaourt grec afin d'obtenir un smoothie épais. Épluchez les kiwis, et réduisez-les en purée à l'aide d'une fourchette.\nRépartissez le smoothie dans des bols. Garnissez le tout de purée de kiwis et de graines de tournesol.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hellofresh.lu")
    expect(recipe.canonical_url).to eq("https://www.hellofresh.lu/recipes/smoothie-banane-epinards-5df9f678ec05895373722f2f")
    expect(recipe.site_name).to eq("HelloFresh")
    expect(recipe.language).to eq("fr-LU")
    expect(recipe.author).to eq("HelloFresh")
    expect(recipe.description).to eq(".")
    expect(recipe.image).to eq("https://img.hellofresh.com/f_auto,fl_lossy,h_640,q_auto,w_1200/hellofresh_s3/image/5df9f678ec05895373722f2f-be4699b2.jpg")
    expect(recipe.category).to eq("Plat principal")
    expect(recipe.cuisine).to eq("0")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "372 kcal",
      "fatContent" => "19 g",
      "saturatedFatContent" => "8.4 g",
      "carbohydrateContent" => "39 g",
      "sugarContent" => "29.4 g",
      "proteinContent" => "10 g",
      "fiberContent" => "4 g",
      "sodiumContent" => "0.3 g",
      "servingSize" => "330"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 372.0 },
      { name: "fatContent", unit: "g", amount: 19.0 },
      { name: "saturatedFatContent", unit: "g", amount: 8.4 },
      { name: "carbohydrateContent", unit: "g", amount: 39.0 },
      { name: "sugarContent", unit: "g", amount: 29.4 },
      { name: "proteinContent", unit: "g", amount: 10.0 },
      { name: "fiberContent", unit: "g", amount: 4.0 },
      { name: "sodiumContent", unit: "g", amount: 0.3 },
      { name: "servingSize", unit: nil, amount: 330.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#page")
  end
end
