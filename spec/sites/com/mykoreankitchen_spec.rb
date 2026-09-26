# frozen_string_literal: true

RSpec.describe "mykoreankitchen.com" do
  subject(:recipe) { scrape_cassette("com/mykoreankitchen", url: "https://mykoreankitchen.com/korean-sweet-rice-with-dried-fruit-and-nuts/") }

  it "reads the title" do
    expect(recipe.title).to eq("Yaksik (Korean Sweet Rice with Dried Fruit and Nuts)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 cups* sweet rice (short grain glutinous rice)",
      "2 cups* water",
      "2 Tbsp pine nuts",
      "15 chestnuts",
      "1/4 cup raisins",
      "1/4 cup dried cranberries",
      "10 pitted dried jujube (red dates – rinsed and halved)",
      "1/3 cup dark brown sugar",
      "1 Tbsp soy sauce",
      "2 Tbsp honey",
      "2 Tbsp sesame oil",
      "1/2 tsp cinnamon powder",
      "1/8 tsp fine sea salt",
      "1 Tbsp pine nuts",
      "2 to 3 pitted dried jujube"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "cups", name: "* sweet rice" },
      { amount: 2.0, unit: "cups", name: "* water" },
      { amount: 2.0, unit: "Tbsp", name: "pine nuts" },
      { amount: 15.0, unit: nil, name: "chestnuts" },
      { amount: 0.25, unit: "cup", name: "raisins" },
      { amount: 0.25, unit: "cup", name: "dried cranberries" },
      { amount: 10.0, unit: nil, name: "pitted dried jujube" },
      { amount: 0.33, unit: "cup", name: "dark brown sugar" },
      { amount: 1.0, unit: "Tbsp", name: "soy sauce" },
      { amount: 2.0, unit: "Tbsp", name: "honey" },
      { amount: 2.0, unit: "Tbsp", name: "sesame oil" },
      { amount: 0.5, unit: "tsp", name: "cinnamon powder" },
      { amount: 0.13, unit: "tsp", name: "fine sea salt" },
      { amount: 1.0, unit: "Tbsp", name: "pine nuts" },
      { amount: 2.0, unit: nil, name: "pitted dried jujube" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Combine the seasoning sauce ingredients in a bowl and mix them well.",
      "Rinse the sweet rice under cold running water a couple of times until the water runs clear. Drain the water and allow the rice to sit in the sieve for 10 to 20 minutes to ensure it's fully drained.",
      "Add the sweet rice, the water and the seasoning sauce into the rice cooker or multi cooker pot and mix them well.",
      "Add the nuts and dried fruit on top. Mix them well to make sure these are evenly spread in the pot.",
      "(For Rice Cooker) Set the “multi steam” function for 35 mins and cook. - This is based on my cuckoo rice cooker setting. (For Instant Pot) Select the ‘rice’ setting and set it to ‘high pressure’. Make sure the steam release handle is in the ‘sealing’ position. The Instant Pot will automatically adjust the cooking duration. Upon completion of the cooking cycle (approximately 20 minutes), cautiously shift the steam release handle from 'sealing' to 'venting'.",
      "Prepare a medium-sized square or rectangular container for molding. I used a Pyrex container, but a baking tray works well too. Optionally, you can cover the mold with cling wrap to make it easier to remove the rice later. Once everything is cooked, gently stir and mix the rice, dried fruit, and nuts using a rice scoop. Then, transfer the rice mixture into your prepared mold. Press this mixture down firmly to make sure it's packed tightly. Finally, allow the rice to cool in the mold for 20 to 30 minutes.",
      "Tip the mold over the cutting board or gently lift the cling wrap to release the yaksik. If you wish, you can garnish the yaksik with pine nuts and sliced jujube, spacing them out generously. (Decoration is optional. Before you start decorating, envision the size of each cut portion to ensure there is enough room for both decoration and slicing. If you plan to make smaller food portions, you'll need to spend more time on decoration.)",
      "Slice the yaksik into your preferred size. (If you decorated, that will influence the size.)",
      "Serve the yaksik. If not consuming immediately, wrap each piece individually in food wrap, store them in a container, and refrigerate it for a few days or freeze it for up to a few months."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["Main", 7],
        ["Seasoning sauce (mix these in a bowl)", 6],
        ["Decoration (number of required ingredients will vary depending on the size of each bar piece.)", 2]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Combine the seasoning sauce ingredients in a bowl and mix them well.\nRinse the sweet rice under cold running water a couple of times until the water runs clear. Drain the water and allow the rice to sit in the sieve for 10 to 20 minutes to ensure it's fully drained.\nAdd the sweet rice, the water and the seasoning sauce into the rice cooker or multi cooker pot and mix them well.\nAdd the nuts and dried fruit on top. Mix them well to make sure these are evenly spread in the pot.\n(For Rice Cooker) Set the “multi steam” function for 35 mins and cook. - This is based on my cuckoo rice cooker setting. (For Instant Pot) Select the ‘rice’ setting and set it to ‘high pressure’. Make sure the steam release handle is in the ‘sealing’ position. The Instant Pot will automatically adjust the cooking duration. Upon completion of the cooking cycle (approximately 20 minutes), cautiously shift the steam release handle from 'sealing' to 'venting'.\nPrepare a medium-sized square or rectangular container for molding. I used a Pyrex container, but a baking tray works well too. Optionally, you can cover the mold with cling wrap to make it easier to remove the rice later. Once everything is cooked, gently stir and mix the rice, dried fruit, and nuts using a rice scoop. Then, transfer the rice mixture into your prepared mold. Press this mixture down firmly to make sure it's packed tightly. Finally, allow the rice to cool in the mold for 20 to 30 minutes.\nTip the mold over the cutting board or gently lift the cling wrap to release the yaksik. If you wish, you can garnish the yaksik with pine nuts and sliced jujube, spacing them out generously. (Decoration is optional. Before you start decorating, envision the size of each cut portion to ensure there is enough room for both decoration and slicing. If you plan to make smaller food portions, you'll need to spend more time on decoration.)\nSlice the yaksik into your preferred size. (If you decorated, that will influence the size.)\nServe the yaksik. If not consuming immediately, wrap each piece individually in food wrap, store them in a container, and refrigerate it for a few days or freeze it for up to a few months.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("mykoreankitchen.com")
    expect(recipe.canonical_url).to eq("https://mykoreankitchen.com/korean-sweet-rice-with-dried-fruit-and-nuts/")
    expect(recipe.site_name).to eq("My Korean Kitchen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Sue | My Korean Kitchen")
    expect(recipe.description).to eq("Korean sweet rice dessert (Yaksik) recipe")
    expect(recipe.image).to eq("https://mykoreankitchen.com/wp-content/uploads/2016/01/1.-Korean-Sweet-Rice-with-Dried-Fruit-and-Nuts.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("Korean")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("9 servings")
    expect(recipe.total_time).to eq(70)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(60)
    expect(recipe.keywords).to eq(%w[yakbap yaksik])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.88)
    expect(recipe.ratings_count).to eq(8)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "439 kcal",
      "carbohydrateContent" => "89 g",
      "proteinContent" => "6 g",
      "fatContent" => "7 g",
      "saturatedFatContent" => "1 g",
      "sodiumContent" => "151 mg",
      "fiberContent" => "3 g",
      "sugarContent" => "14 g",
      "unsaturatedFatContent" => "5 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 439.0 },
      { name: "carbohydrateContent", unit: "g", amount: 89.0 },
      { name: "proteinContent", unit: "g", amount: 6.0 },
      { name: "fatContent", unit: "g", amount: 7.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 151.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "sugarContent", unit: "g", amount: 14.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 5.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
