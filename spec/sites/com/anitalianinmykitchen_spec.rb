# frozen_string_literal: true

RSpec.describe "anitalianinmykitchen.com" do
  subject(:recipe) { scrape_cassette("com/anitalianinmykitchen", url: "https://anitalianinmykitchen.com/brown-sugar-shortbread/") }

  it "reads the title" do
    expect(recipe.title).to eq("3 Ingredient Brown Sugar Shortbread Cookies")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup butter salted (softened)",
      "2-2¼ cups all purpose flour (at least 11% protein)",
      "½ cup brown sugar (lightly packed)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "butter salted" },
      { amount: 2.0, unit: "cups", name: "all purpose flour" },
      { amount: 0.5, unit: "cup", name: "brown sugar" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large bowl or stand mixer beat the butter and sugar until creamy, approximately 2 minutes, sift the flour into the bowl and beat on low until almost combined.",
      "Move the dough to a flat surface and gently knead to form a compact ball. Wrap in plastic wrap and chill for 1 hour.",
      "Roll the dough into ¼-⅓ thickness and cut out with medium cookie cutters, place on parchment paper lined baking sheets. Pre-heat oven to 325F/163C, while the oven is pre-heating chill the cookies 15-20 minutes.",
      "Bake the cookies for 10-12 minutes or until starts to brown around the edges. Let cool 5 -8 minutes on the baking sheets then move to a wire rack to cool completely. Enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large bowl or stand mixer beat the butter and sugar until creamy, approximately 2 minutes, sift the flour into the bowl and beat on low until almost combined.\nMove the dough to a flat surface and gently knead to form a compact ball. Wrap in plastic wrap and chill for 1 hour.\nRoll the dough into ¼-⅓ thickness and cut out with medium cookie cutters, place on parchment paper lined baking sheets. Pre-heat oven to 325F/163C, while the oven is pre-heating chill the cookies 15-20 minutes.\nBake the cookies for 10-12 minutes or until starts to brown around the edges. Let cool 5 -8 minutes on the baking sheets then move to a wire rack to cool completely. Enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("anitalianinmykitchen.com")
    expect(recipe.canonical_url).to eq("https://anitalianinmykitchen.com/brown-sugar-shortbread/")
    expect(recipe.site_name).to eq("An Italian in my Kitchen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Rosemary Molloy")
    expect(recipe.description).to eq("Buttery, tender, and perfectly sweet, these 3-ingredient brown sugar shortbread cookies prove that the simplest recipes are often the most delicious.")
    expect(recipe.image).to eq("https://anitalianinmykitchen.com/wp-content/uploads/2025/11/br-sugar-sb-sq-1-of-1.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("22 servings")
    expect(recipe.total_time).to eq(90)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq([
      "3 ingredient shortbread",
      "brown sugar shortbread",
      "cut out cookies",
      "Shortbread Cookies"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "140 kcal",
      "carbohydrateContent" => "15 g",
      "proteinContent" => "1 g",
      "fatContent" => "8 g",
      "saturatedFatContent" => "5 g",
      "transFatContent" => "0.3 g",
      "cholesterolContent" => "22 mg",
      "sodiumContent" => "68 mg",
      "fiberContent" => "0.3 g",
      "sugarContent" => "5 g",
      "unsaturatedFatContent" => "2.4 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 140.0 },
      { name: "carbohydrateContent", unit: "g", amount: 15.0 },
      { name: "proteinContent", unit: "g", amount: 1.0 },
      { name: "fatContent", unit: "g", amount: 8.0 },
      { name: "saturatedFatContent", unit: "g", amount: 5.0 },
      { name: "transFatContent", unit: "g", amount: 0.3 },
      { name: "cholesterolContent", unit: "mg", amount: 22.0 },
      { name: "sodiumContent", unit: "mg", amount: 68.0 },
      { name: "fiberContent", unit: "g", amount: 0.3 },
      { name: "sugarContent", unit: "g", amount: 5.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 2.4 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
