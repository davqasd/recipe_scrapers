# frozen_string_literal: true

RSpec.describe "ourbestbites.com" do
  subject(:recipe) { scrape_cassette("com/ourbestbites", url: "https://ourbestbites.com/banana-cream-pie/") }

  it "reads the title" do
    expect(recipe.title).to eq("Banana Cream Pie")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 3.4- ounce package instant vanilla pudding (do not use \"cook and serve\")",
      "1 cup cold water",
      "1 14-ounce can sweetened condensed milk",
      "2 8-serving graham cracker or cookie crusts",
      "bananas (4-5 small bananas, or 2-3 large ones)",
      "1 pint heavy whipping cream",
      "⅓ cup powdered sugar"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "package", name: "instant vanilla pudding" },
      { amount: 1.0, unit: "cup", name: "cold water" },
      { amount: 1.0, unit: "can", name: "sweetened condensed milk" },
      { amount: 2.0, unit: nil, name: "8-serving graham cracker or cookie crusts" },
      { amount: nil, unit: nil, name: "bananas" },
      { amount: 1.0, unit: "pint", name: "heavy whipping cream" },
      { amount: 0.33, unit: "cup", name: "powdered sugar" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a medium bowl, combine pudding mix, cold water, and sweetened condensed milk. Mix well and place in the refrigerator to chill for a few minutes.",
      "In another bowl, whip 1 cup of whipping cream with an electric mixer until soft peaks form.",
      "Slice the bananas (probably 4-5 small bananas or 2-3 large bananas) and layer them on the bottom of the crusts. Set aside. Be sure and save the plastic domes that come with the pie crusts--you'll need them later!",
      "Remove pudding from the fridge and gently dollop the whipped cream on top of the pudding. Gently fold the whipped cream into the pudding mixture until well-combined.",
      "Now divide the mixture between the two pies. Rinse the pudding bowl and beaters and set aside for later.",
      "Place the clear plastic shells back on the pies and allow to chill for several hours. This step is very important, as without it the crust will fall apart, and it will lack flavor.",
      "If possible, immediately before serving, combine the remaining heavy cream and ⅓ cup powdered sugar in the bowl you mixed the pudding in and beat with an electric mixer on high until soft peaks form. Spread over the pies. (If you can't do this immediately before serving, it's okay to do the whipped cream step after you put the pudding mixture in the shells.)"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a medium bowl, combine pudding mix, cold water, and sweetened condensed milk. Mix well and place in the refrigerator to chill for a few minutes.\nIn another bowl, whip 1 cup of whipping cream with an electric mixer until soft peaks form.\nSlice the bananas (probably 4-5 small bananas or 2-3 large bananas) and layer them on the bottom of the crusts. Set aside. Be sure and save the plastic domes that come with the pie crusts--you'll need them later!\nRemove pudding from the fridge and gently dollop the whipped cream on top of the pudding. Gently fold the whipped cream into the pudding mixture until well-combined.\nNow divide the mixture between the two pies. Rinse the pudding bowl and beaters and set aside for later.\nPlace the clear plastic shells back on the pies and allow to chill for several hours. This step is very important, as without it the crust will fall apart, and it will lack flavor.\nIf possible, immediately before serving, combine the remaining heavy cream and ⅓ cup powdered sugar in the bowl you mixed the pudding in and beat with an electric mixer on high until soft peaks form. Spread over the pies. (If you can't do this immediately before serving, it's okay to do the whipped cream step after you put the pudding mixture in the shells.)")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("ourbestbites.com")
    expect(recipe.canonical_url).to eq("https://ourbestbites.com/banana-cream-pie/")
    expect(recipe.site_name).to eq("Our Best Bites")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Kate Jones")
    expect(recipe.description).to eq("This is the best AND the easiest banana cream pie you’ll ever make.")
    expect(recipe.image).to eq("https://ourbestbites.com/wp-content/uploads/2008/03/easy-banana-cream-pie-sq.jpg")
    expect(recipe.category).to eq("Desserts")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("16 servings")
    expect(recipe.total_time).to eq(190)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Banana Cream Pie"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(26)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "140 kcal",
      "sugarContent" => "10 g",
      "sodiumContent" => "58 mg",
      "fatContent" => "11 g",
      "saturatedFatContent" => "7 g",
      "carbohydrateContent" => "11 g",
      "fiberContent" => "0.05 g",
      "proteinContent" => "1 g",
      "cholesterolContent" => "33 mg",
      "unsaturatedFatContent" => "3.5 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 140.0 },
      { name: "sugarContent", unit: "g", amount: 10.0 },
      { name: "sodiumContent", unit: "mg", amount: 58.0 },
      { name: "fatContent", unit: "g", amount: 11.0 },
      { name: "saturatedFatContent", unit: "g", amount: 7.0 },
      { name: "carbohydrateContent", unit: "g", amount: 11.0 },
      { name: "fiberContent", unit: "g", amount: 0.05 },
      { name: "proteinContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 33.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 3.5 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
