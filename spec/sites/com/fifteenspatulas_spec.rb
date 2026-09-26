# frozen_string_literal: true

RSpec.describe "fifteenspatulas.com" do
  subject(:recipe) { scrape_cassette("com/fifteenspatulas", url: "https://www.fifteenspatulas.com/orange-scented-creme-brulee/") }

  it "reads the title" do
    expect(recipe.title).to eq("Creme Brulee Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "zest of 4 oranges* (about 2 tsp)",
      "3 cups heavy cream",
      "5 large egg yolks",
      "1/2 cup sugar +1 tsp for each crème brûlée",
      "1 tsp vanilla extract"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "zest of 4 oranges*" },
      { amount: 3.0, unit: "cups", name: "heavy cream" },
      { amount: 5.0, unit: nil, name: "large egg yolks" },
      { amount: 0.5, unit: "cup", name: "sugar +1 tsp for each crème brûlée" },
      { amount: 1.0, unit: "tsp", name: "vanilla extract" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Combine the orange zest and cream in a saucepan, and let it sit in the fridge for 2 hours.",
      "Preheat the oven to 300 degrees F.",
      "Whisk together the egg yolks and 1/2 cup sugar for 1 minute, until well blended.",
      "Heat the orange zest cream over medium high heat until 180F, bringing it almost to a boil, but not quite. This is known as a scalding temperature. It's best to use a thermometer, but if you don't have one, you'll know the cream is hot enough when bubbles begin forming on the side, but it's not yet boiling.",
      "While whisking constantly, slowly dribble the hot cream into the egg yolk mixture, gradually over a minute.",
      "Add the vanilla extract, then pour the mixture through a sieve to strain out the orange zest and any coagulated egg.",
      "Pour the strained custard into six 4-ounce ramekins until nearly full (you may use other size ramekins, but you'll need to adjust bake time).",
      "Place the ramekins in a large baking pan and add enough boiling water to come halfway up the outsides of the ramekins.",
      "Bake for 35-40 minutes, until the creme brulees jiggle slightly when shaken, and have set. Take the ramekins out of the water bath and let cool to room temperature. Then cover the tops with plastic wrap and refrigerate until they firm up, 4-6 hours.",
      "When you’re ready to serve the creme brulee, sprinkle 1 tsp of sugar evenly on top of each one, to prepare for caramelization.",
      "Torch Option: Ideally, use a handheld blowtorch to quickly caramelize the tops of each creme brulee, and serve immediately. This will give you the crunchy top layer you want, while keeping the creme brulee from getting warm.",
      "Oven broiler option: If you don't have a torch, you can use the broiler of your oven to caramelize the top. Set the oven rack as close as possible to the broiler, and preheat to high. Place the ramekins on a sheet pan, and broil for 1-2 minutes, until the top caramelizes, making sure you keep your eye on the browning (it's easier to burn the sugar using the broiler). If your oven's broiler isn't strong enough to caramelize the sugar without heating the filling, then place the ramekins back into the fridge for an hour before serving, to re-firm the custard. Serve and enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Combine the orange zest and cream in a saucepan, and let it sit in the fridge for 2 hours.\nPreheat the oven to 300 degrees F.\nWhisk together the egg yolks and 1/2 cup sugar for 1 minute, until well blended.\nHeat the orange zest cream over medium high heat until 180F, bringing it almost to a boil, but not quite. This is known as a scalding temperature. It's best to use a thermometer, but if you don't have one, you'll know the cream is hot enough when bubbles begin forming on the side, but it's not yet boiling.\nWhile whisking constantly, slowly dribble the hot cream into the egg yolk mixture, gradually over a minute.\nAdd the vanilla extract, then pour the mixture through a sieve to strain out the orange zest and any coagulated egg.\nPour the strained custard into six 4-ounce ramekins until nearly full (you may use other size ramekins, but you'll need to adjust bake time).\nPlace the ramekins in a large baking pan and add enough boiling water to come halfway up the outsides of the ramekins.\nBake for 35-40 minutes, until the creme brulees jiggle slightly when shaken, and have set. Take the ramekins out of the water bath and let cool to room temperature. Then cover the tops with plastic wrap and refrigerate until they firm up, 4-6 hours.\nWhen you’re ready to serve the creme brulee, sprinkle 1 tsp of sugar evenly on top of each one, to prepare for caramelization.\nTorch Option: Ideally, use a handheld blowtorch to quickly caramelize the tops of each creme brulee, and serve immediately. This will give you the crunchy top layer you want, while keeping the creme brulee from getting warm.\nOven broiler option: If you don't have a torch, you can use the broiler of your oven to caramelize the top. Set the oven rack as close as possible to the broiler, and preheat to high. Place the ramekins on a sheet pan, and broil for 1-2 minutes, until the top caramelizes, making sure you keep your eye on the browning (it's easier to burn the sugar using the broiler). If your oven's broiler isn't strong enough to caramelize the sugar without heating the filling, then place the ramekins back into the fridge for an hour before serving, to re-firm the custard. Serve and enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("fifteenspatulas.com")
    expect(recipe.canonical_url).to eq("https://www.fifteenspatulas.com/orange-scented-creme-brulee/")
    expect(recipe.site_name).to eq("Fifteen Spatulas")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Joanne")
    expect(recipe.description).to eq("This Orange Creme Brulee is a twist on the classic creamy custard, with aromatic and flavorful orange throughout. It's a great make ahead dessert!")
    expect(recipe.image).to eq("https://www.fifteenspatulas.com/wp-content/uploads/2019/05/Orange-Creme-Brulee-Fifteen-Spatulas-16.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("French")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(420)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(40)
    expect(recipe.keywords).to eq(["creme brulee", "orange creme brulee"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(%w[GlutenFreeDiet VegetarianDiet])
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(14)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "458 kcal",
      "carbohydrateContent" => "4 g",
      "proteinContent" => "5 g",
      "fatContent" => "48 g",
      "saturatedFatContent" => "29 g",
      "cholesterolContent" => "317 mg",
      "sodiumContent" => "52 mg",
      "sugarContent" => "1 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 458.0 },
      { name: "carbohydrateContent", unit: "g", amount: 4.0 },
      { name: "proteinContent", unit: "g", amount: 5.0 },
      { name: "fatContent", unit: "g", amount: 48.0 },
      { name: "saturatedFatContent", unit: "g", amount: 29.0 },
      { name: "cholesterolContent", unit: "mg", amount: 317.0 },
      { name: "sodiumContent", unit: "mg", amount: 52.0 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
