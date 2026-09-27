# frozen_string_literal: true

RSpec.describe "africanbites.com" do
  subject(:recipe) { scrape_cassette("com/africanbites", url: "https://www.africanbites.com/easy-churros-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Easy Churros")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "½ cup (100g) white sugar (adjust to taste)",
      "1 teaspoon (3g) ground cinnamon",
      "1½ cup (355ml) water",
      "3 tablespoons (36g) white sugar",
      "½ cup (113g) unsalted butter",
      "½ teaspoon (2-3g) salt",
      "1½ cup (180g) all-purpose flour",
      "2-3 large eggs ((see notes) )",
      "1 teaspoon (5ml) vanilla extract",
      "1-2 quarts (.75-1.9l) oil (for frying )",
      "1 cup (150g) chocolate, (cut into chunks (semi-sweet, milk chocolate, or a mix of both) )",
      "⅓ cup (80g) heavy cream",
      "½ teaspoon (2-3ml) vanilla extract"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.5, unit: "cup", name: "white sugar" },
      { amount: 1.0, unit: "teaspoon", name: "ground cinnamon" },
      { amount: 1.5, unit: "cup", name: "water" },
      { amount: 3.0, unit: "tablespoons", name: "white sugar" },
      { amount: 0.5, unit: "cup", name: "unsalted butter" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 1.5, unit: "cup", name: "all-purpose flour" },
      { amount: 2.0, unit: nil, name: "large eggs" },
      { amount: 1.0, unit: "teaspoon", name: "vanilla extract" },
      { amount: 1.0, unit: "quarts", name: "oil" },
      { amount: 1.0, unit: "cup", name: "chocolate" },
      { amount: 0.33, unit: "cup", name: "heavy cream" },
      { amount: 0.5, unit: "teaspoon", name: "vanilla extract" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Cinnamon Sugar",
      "Combine ½ cup sugar with the cinnamon in a shallow bowl. Set aside.",
      "Churros",
      "Line a plate with paper towels.",
      "Heat water, sugar, butter, and salt over medium heat in a medium-sized saucepan.",
      "Bring it to a boil, then quickly remove the saucepan from the heat. Whisk in the flour and continue mixing with a whisk or wooden spoon until it forms a soft ball. Let it cool for 2-3 minutes. Leave it in the saucepan or transfer to a bowl if the saucepan isn't large enough.",
      "Add eggs and vanilla to the flour mixture and mix with an electric mixer. Don't be alarmed if the mixture starts to break apart. Keep mixing until smooth.",
      "Heat 3-4 inches of vegetable oil in a large, heavy-bottomed pot over medium-high heat until it reaches 375℉ (190℃).",
      "Put the dough into a piping bag with a star tip. Push the dough down to the tip. (If you don't have a piping bag, put the dough in a ziplock or sandwich bag with a fold-over top and cut off a small part of one on the bottom corners. Push the dough to that corner.)",
      "Holding the piping bag a few inches above the oil, carefully pipe the churro dough into ropes 4-5 inches long directly into the oil. Cut the ropes with kitchen scissors or a sharp knife. Be careful because you don't want the oil to splatter as they fall.",
      "Add 3-4 churros, depending on the size of your pot and the amount of oil. You don't want to overcrowd the pan, or it will lower the oil temperature too much, resulting in greasy churros. Let them fry for about 2 minutes per side until golden brown and cooked through.",
      "Remove the churros and place them on the paper-towel-lined plate to drain. Roll them in the cinnamon sugar. Repeat with the rest of the dough.",
      "Chocolate Sauce",
      "Whisk chocolate, cream, and vanilla in a small saucepan over low heat until the chocolate melts and becomes smooth, 3-5 minutes. Serve warm with the fresh churros."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["Cinnamon Sugar", 2],
        ["Churros", 8],
        ["Chocolate Sauce", 3]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Cinnamon Sugar\nCombine ½ cup sugar with the cinnamon in a shallow bowl. Set aside.\nChurros\nLine a plate with paper towels.\nHeat water, sugar, butter, and salt over medium heat in a medium-sized saucepan.\nBring it to a boil, then quickly remove the saucepan from the heat. Whisk in the flour and continue mixing with a whisk or wooden spoon until it forms a soft ball. Let it cool for 2-3 minutes. Leave it in the saucepan or transfer to a bowl if the saucepan isn't large enough.\nAdd eggs and vanilla to the flour mixture and mix with an electric mixer. Don't be alarmed if the mixture starts to break apart. Keep mixing until smooth.\nHeat 3-4 inches of vegetable oil in a large, heavy-bottomed pot over medium-high heat until it reaches 375℉ (190℃).\nPut the dough into a piping bag with a star tip. Push the dough down to the tip. (If you don't have a piping bag, put the dough in a ziplock or sandwich bag with a fold-over top and cut off a small part of one on the bottom corners. Push the dough to that corner.)\nHolding the piping bag a few inches above the oil, carefully pipe the churro dough into ropes 4-5 inches long directly into the oil. Cut the ropes with kitchen scissors or a sharp knife. Be careful because you don't want the oil to splatter as they fall.\nAdd 3-4 churros, depending on the size of your pot and the amount of oil. You don't want to overcrowd the pan, or it will lower the oil temperature too much, resulting in greasy churros. Let them fry for about 2 minutes per side until golden brown and cooked through.\nRemove the churros and place them on the paper-towel-lined plate to drain. Roll them in the cinnamon sugar. Repeat with the rest of the dough.\nChocolate Sauce\nWhisk chocolate, cream, and vanilla in a small saucepan over low heat until the chocolate melts and becomes smooth, 3-5 minutes. Serve warm with the fresh churros.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("africanbites.com")
    expect(recipe.canonical_url).to eq("https://www.africanbites.com/easy-churros-recipe/")
    expect(recipe.site_name).to eq("Immaculate Bites")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Imma Adamu")
    expect(recipe.description).to eq("This classic street food is popular in most Spanish-speaking countries. Sweet dough is piped into hot oil and fried to flaky, warm perfection. Dip them in chocolate sauce or dust them with cinnamon sugar for soul-satisfying goodness.Makes about 2-4 dozen churros")
    expect(recipe.image).to eq("https://www.africanbites.com/wp-content/uploads/2020/04/IMG_3749.jpg")
    expect(recipe.category).to eq("Snacks")
    expect(recipe.cuisine).to eq("Mexican")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("20 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq(["churros"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(3)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 churro",
      "calories" => "201 kcal",
      "carbohydrateContent" => "19 g",
      "proteinContent" => "3 g",
      "fatContent" => "13 g",
      "saturatedFatContent" => "5 g",
      "transFatContent" => "0.2 g",
      "cholesterolContent" => "33 mg",
      "sodiumContent" => "58 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "5 g",
      "unsaturatedFatContent" => "8 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "churro", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 201.0 },
      { name: "carbohydrateContent", unit: "g", amount: 19.0 },
      { name: "proteinContent", unit: "g", amount: 3.0 },
      { name: "fatContent", unit: "g", amount: 13.0 },
      { name: "saturatedFatContent", unit: "g", amount: 5.0 },
      { name: "transFatContent", unit: "g", amount: 0.2 },
      { name: "cholesterolContent", unit: "mg", amount: 33.0 },
      { name: "sodiumContent", unit: "mg", amount: 58.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 5.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 8.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
