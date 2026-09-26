# frozen_string_literal: true

RSpec.describe "izzycooking.com" do
  subject(:recipe) { scrape_cassette("com/izzycooking", url: "https://izzycooking.com/oreo-cheesecake-bites/") }

  it "reads the title" do
    expect(recipe.title).to eq("Oreo Cheesecake Bites Recipe (+Video)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "22 Oreo cookies (Chop 6 of them into small pieces)",
      "16 ounces cream cheese (softened)",
      "1/2 cup granulated sugar",
      "1/2 tsp vanilla extract",
      "2 eggs",
      "1/2 cup sour cream (or plain Greek yogurt)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 22.0, unit: nil, name: "Oreo cookies" },
      { amount: 16.0, unit: "ounces", name: "cream cheese" },
      { amount: 0.5, unit: "cup", name: "granulated sugar" },
      { amount: 0.5, unit: "tsp", name: "vanilla extract" },
      { amount: 2.0, unit: nil, name: "eggs" },
      { amount: 0.5, unit: "cup", name: "sour cream" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 325°F. (Make sure your oven temperature is accurate, as a higher temp can cause the cheesecake to crack.)",
      "Place cupcake paper liners into a muffin tin pan. Add one Oreo cookie into each paper cup. Set aside.",
      "Add softened cream cheese and sugar to a medium mixing bowl. Beat on medium speed using a hand mixer.",
      "Then add vanilla and eggs. Mixing well until smooth without lumps.",
      "Add sour cream, mix until combined. Tap bowl against your countertop a few times to release any large air bubbles.",
      "Stir in chopped cookies, and mix generally using a spatula. (Be careful not to crush oreos into smaller crumbs.)",
      "Spoon the batter on top of the oreo, filling each to almost the top. Note that cheesecake won't rise as much as a regular cupcake.",
      "Place in the lower third of the oven and bake for about 20-25 minutes until the edges just start to turn brown. Note that classic cheesecake is supposed to look pale, so you're not looking for golden brown.",
      "Remove from oven and transfer to cooling racks.",
      "Chill in the fridge for 4 hours or overnight. Serve and enjoy! (You can store them in the fridge for up to 5 days.)"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 325°F. (Make sure your oven temperature is accurate, as a higher temp can cause the cheesecake to crack.)\nPlace cupcake paper liners into a muffin tin pan. Add one Oreo cookie into each paper cup. Set aside.\nAdd softened cream cheese and sugar to a medium mixing bowl. Beat on medium speed using a hand mixer.\nThen add vanilla and eggs. Mixing well until smooth without lumps.\nAdd sour cream, mix until combined. Tap bowl against your countertop a few times to release any large air bubbles.\nStir in chopped cookies, and mix generally using a spatula. (Be careful not to crush oreos into smaller crumbs.)\nSpoon the batter on top of the oreo, filling each to almost the top. Note that cheesecake won't rise as much as a regular cupcake.\nPlace in the lower third of the oven and bake for about 20-25 minutes until the edges just start to turn brown. Note that classic cheesecake is supposed to look pale, so you're not looking for golden brown.\nRemove from oven and transfer to cooling racks.\nChill in the fridge for 4 hours or overnight. Serve and enjoy! (You can store them in the fridge for up to 5 days.)")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("izzycooking.com")
    expect(recipe.canonical_url).to eq("https://izzycooking.com/oreo-cheesecake-bites/")
    expect(recipe.site_name).to eq("IzzyCooking")
    expect(recipe.language).to eq("en-CA")
    expect(recipe.author).to eq("Izzy Yu")
    expect(recipe.description).to eq("Oreo Cheesecake Bites are creamy and soft mini cheesecakes with a delicious oreo crust at the bottom. They are so easy to make and a guaranteed hit at any party.")
    expect(recipe.image).to eq("https://izzycooking.com/wp-content/uploads/2018/06/Oreo-Cheesecake-Bites-Featured-Image.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("16 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(25)
    expect(recipe.keywords).to eq(["mini cheesecakes", "oreo cheesecake bites", "oreo cheesecake cupcakes"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.95)
    expect(recipe.ratings_count).to eq(17)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "carbohydrateContent" => "19 g",
      "proteinContent" => "3 g",
      "fatContent" => "15 g",
      "saturatedFatContent" => "8 g",
      "cholesterolContent" => "55 mg",
      "sodiumContent" => "181 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "14 g",
      "calories" => "221 kcal",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "carbohydrateContent", unit: "g", amount: 19.0 },
      { name: "proteinContent", unit: "g", amount: 3.0 },
      { name: "fatContent", unit: "g", amount: 15.0 },
      { name: "saturatedFatContent", unit: "g", amount: 8.0 },
      { name: "cholesterolContent", unit: "mg", amount: 55.0 },
      { name: "sodiumContent", unit: "mg", amount: 181.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 14.0 },
      { name: "calories", unit: "kcal", amount: 221.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
