# frozen_string_literal: true

RSpec.describe "toriavey.com" do
  subject(:recipe) { scrape_cassette("com/toriavey", url: "https://toriavey.com/green-bean-salad-with-walnuts-parmesan-and-mint/") }

  it "reads the title" do
    expect(recipe.title).to eq("Green Bean Salad with Parmesan and Walnuts")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 pound green beans ((young beans are best), washed and trimmed)",
      "1/2 cup chopped walnuts (- you may substitute sliced almonds or pine nuts)",
      "2 tablespoons extra virgin olive oil",
      "2 tablespoons white balsamic vinegar (you may substitute red balsamic vinegar)",
      "1/3 cup chopped fresh mint",
      "1/3 cup shaved parmesan (for vegetarian use cheese with a vegetarian rennet)",
      "1/4 tsp sea salt, (or more to taste)",
      "Freshly ground white pepper or black pepper, (to taste)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "pound", name: "green beans" },
      { amount: 0.5, unit: "cup", name: "chopped walnuts" },
      { amount: 2.0, unit: "tablespoons", name: "extra virgin olive oil" },
      { amount: 2.0, unit: "tablespoons", name: "white balsamic vinegar" },
      { amount: 0.33, unit: "cup", name: "chopped fresh mint" },
      { amount: 0.33, unit: "cup", name: "shaved parmesan" },
      { amount: 0.25, unit: "tsp", name: "sea salt" },
      { amount: nil, unit: nil, name: "Freshly ground white pepper or black pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Cut the green beans into pieces about 4 inches long. If you are using small young beans, there is no need to cut them. Put the green beans into a pan along with 1/2 cup of water. Bring the water to a boil and cover the pan. Turn the heat to medium and let the beans steam for about 5 minutes until tender-crisp. Smaller, younger beans will take less time to steam-- check them after 2-3 minutes.",
      "Drain the green beans and transfer them immediately to a large bowl of ice water. Leave them there to cool.",
      "Put the chopped walnuts into a skillet over medium heat. Let the walnuts toast for a few minutes, stirring frequently, until the nuts are fragrant. Don't let them toast too long, or the skin will burn and the walnuts will taste bitter. When they're nicely toasted, remove from heat and pour them immediately into a bowl.",
      "Drain the green beans and pat them dry with paper towels. Put them into a large bowl. In a small bowl, whisk together the extra virgin olive oil, balsamic, and 1/4 teaspoon of sea salt. Pour the dressing over the green beans and toss to coat.",
      "Add the chopped mint and walnuts to the green beans and toss to coat. Taste the salad. Season with additional sea salt and freshly ground white or black pepper, to taste.",
      "Shave the parmesan cheese with a grater. Break apart the shavings into small pieces.",
      "Sprinkle the shaved parmesan over the salad. Serve."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Cut the green beans into pieces about 4 inches long. If you are using small young beans, there is no need to cut them. Put the green beans into a pan along with 1/2 cup of water. Bring the water to a boil and cover the pan. Turn the heat to medium and let the beans steam for about 5 minutes until tender-crisp. Smaller, younger beans will take less time to steam-- check them after 2-3 minutes.\nDrain the green beans and transfer them immediately to a large bowl of ice water. Leave them there to cool.\nPut the chopped walnuts into a skillet over medium heat. Let the walnuts toast for a few minutes, stirring frequently, until the nuts are fragrant. Don't let them toast too long, or the skin will burn and the walnuts will taste bitter. When they're nicely toasted, remove from heat and pour them immediately into a bowl.\nDrain the green beans and pat them dry with paper towels. Put them into a large bowl. In a small bowl, whisk together the extra virgin olive oil, balsamic, and 1/4 teaspoon of sea salt. Pour the dressing over the green beans and toss to coat.\nAdd the chopped mint and walnuts to the green beans and toss to coat. Taste the salad. Season with additional sea salt and freshly ground white or black pepper, to taste.\nShave the parmesan cheese with a grater. Break apart the shavings into small pieces.\nSprinkle the shaved parmesan over the salad. Serve.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("toriavey.com")
    expect(recipe.canonical_url).to eq("https://toriavey.com/green-bean-salad-with-walnuts-parmesan-and-mint/")
    expect(recipe.site_name).to eq("Tori Avey")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Tori Avey")
    expect(recipe.description).to eq("Easy and flavorful salad with lightly steamed green beans, shaved parmesan, pan-toasted chopped walnuts, fresh mint, extra virgin olive oil, and white balsamic vinegar.")
    expect(recipe.image).to eq("https://toriavey.com/images/2013/07/IMG_0105.jpeg")
    expect(recipe.category).to eq("Salad")
    expect(recipe.cuisine).to eq("Mediterranean")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(15)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq(["green bean salad"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.67)
    expect(recipe.ratings_count).to eq(3)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "157 kcal",
      "carbohydrateContent" => "8 g",
      "proteinContent" => "5 g",
      "fatContent" => "13 g",
      "saturatedFatContent" => "2 g",
      "cholesterolContent" => "4 mg",
      "sodiumContent" => "193 mg",
      "fiberContent" => "3 g",
      "sugarContent" => "4 g",
      "unsaturatedFatContent" => "10 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 157.0 },
      { name: "carbohydrateContent", unit: "g", amount: 8.0 },
      { name: "proteinContent", unit: "g", amount: 5.0 },
      { name: "fatContent", unit: "g", amount: 13.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "cholesterolContent", unit: "mg", amount: 4.0 },
      { name: "sodiumContent", unit: "mg", amount: 193.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "sugarContent", unit: "g", amount: 4.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 10.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://toriavey.com/")
  end
end
