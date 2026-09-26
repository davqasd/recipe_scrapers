# frozen_string_literal: true

RSpec.describe "dashfordinner.com" do
  subject(:recipe) { scrape_cassette("com/dashfordinner", url: "https://dashfordinner.com/caramel-apple-dip/") }

  it "reads the title" do
    expect(recipe.title).to eq("Caramel Apple Dip")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "8 ounces cream cheese (softened*)",
      "1/4 cup powdered sugar (or granulated sugar)",
      "1 1/4 cup caramel sauce",
      "1/2-3/4 cup toffee bits"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 8.0, unit: "ounces", name: "cream cheese" },
      { amount: 0.25, unit: "cup", name: "powdered sugar" },
      { amount: 1.25, unit: "cup", name: "caramel sauce" },
      { amount: 0.5, unit: "cup", name: "toffee bits" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Add the softened cream cheese, powdered sugar (or white sugar), and ¼ cup of the caramel sauce to a large bowl.",
      "Beat the cream cheese, caramel, and sugar together with an electric mixer on medium speed until smooth.",
      "Spread the cream cheese mixture into the bottom of a medium baking dish (7.5 X 10” or 8X8”).",
      "Pour the remaining 1 cup of caramel sauce on top of the cream cheese layer. Spread it out evenly, so all of the cream cheese is covered.",
      "Sprinkle the surface of the caramel with the toffee bits.",
      "Serve immediately, or refrigerate until needed (set it out at room temperature for 10-30 minutes before serving).",
      "Serve with apple slices, graham crackers, gingersnaps, etc."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Add the softened cream cheese, powdered sugar (or white sugar), and ¼ cup of the caramel sauce to a large bowl.\nBeat the cream cheese, caramel, and sugar together with an electric mixer on medium speed until smooth.\nSpread the cream cheese mixture into the bottom of a medium baking dish (7.5 X 10” or 8X8”).\nPour the remaining 1 cup of caramel sauce on top of the cream cheese layer. Spread it out evenly, so all of the cream cheese is covered.\nSprinkle the surface of the caramel with the toffee bits.\nServe immediately, or refrigerate until needed (set it out at room temperature for 10-30 minutes before serving).\nServe with apple slices, graham crackers, gingersnaps, etc.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("dashfordinner.com")
    expect(recipe.canonical_url).to eq("https://dashfordinner.com/caramel-apple-dip/")
    expect(recipe.site_name).to eq("Dash for Dinner")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Dorothy Bigelow")
    expect(recipe.description).to eq("This easy recipe for Homemade Caramel Apple Dip calls for just 4 ingredients! A yummy dessert dip that's perfect for your next Fall gathering.")
    expect(recipe.image).to eq("https://dashfordinner.com/wp-content/uploads/2023/09/caramelappledip.jpg")
    expect(recipe.category).to eq("Desserts")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq([
      "Apples",
      "autumn",
      "fall",
      "potluck desserts",
      "potluck recipes",
      "Thanksgiving"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.75)
    expect(recipe.ratings_count).to eq(8)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "218 kcal",
      "carbohydrateContent" => "28 g",
      "proteinContent" => "2 g",
      "fatContent" => "12 g",
      "saturatedFatContent" => "7 g",
      "transFatContent" => "0.1 g",
      "cholesterolContent" => "35 mg",
      "sodiumContent" => "184 mg",
      "sugarContent" => "27 g",
      "unsaturatedFatContent" => "3.5 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 218.0 },
      { name: "carbohydrateContent", unit: "g", amount: 28.0 },
      { name: "proteinContent", unit: "g", amount: 2.0 },
      { name: "fatContent", unit: "g", amount: 12.0 },
      { name: "saturatedFatContent", unit: "g", amount: 7.0 },
      { name: "transFatContent", unit: "g", amount: 0.1 },
      { name: "cholesterolContent", unit: "mg", amount: 35.0 },
      { name: "sodiumContent", unit: "mg", amount: 184.0 },
      { name: "sugarContent", unit: "g", amount: 27.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 3.5 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://dashfordinner.com/")
  end
end
