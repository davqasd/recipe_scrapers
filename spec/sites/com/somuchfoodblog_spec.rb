# frozen_string_literal: true

RSpec.describe "somuchfoodblog.com" do
  subject(:recipe) { scrape_cassette("com/somuchfoodblog", url: "https://somuchfoodblog.com/best-ever-pumpkin-pie/") }

  it "reads the title" do
    expect(recipe.title).to eq("Best Ever Pumpkin Pie Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 recipe all-butter pie crust (or store bought single layer pie crust)",
      "2 - 15 oz cans pumpkin puree",
      "1/4 cup whole milk powder",
      "14 oz can sweetened condensed milk",
      "1/4 cup pure maple syrup",
      "1 cup heavy cream, (room temperature)",
      "2 eggs, (room temperature)",
      "2 egg yolks, (room temperature)",
      "1 teaspoon vanilla bean paste",
      "1/2 teaspoon kosher salt",
      "1 1/2 teaspoons pumpkin pie spice",
      "1/8 teaspoon freshly ground black pepper"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "recipe all-butter pie crust" },
      { amount: 2.0, unit: "oz", name: "cans pumpkin puree" },
      { amount: 0.25, unit: "cup", name: "whole milk powder" },
      { amount: 14.0, unit: "oz", name: "can sweetened condensed milk" },
      { amount: 0.25, unit: "cup", name: "pure maple syrup" },
      { amount: 1.0, unit: "cup", name: "heavy cream" },
      { amount: 2.0, unit: nil, name: "eggs" },
      { amount: 2.0, unit: nil, name: "egg yolks" },
      { amount: 1.0, unit: "teaspoon", name: "vanilla bean paste" },
      { amount: 0.5, unit: "teaspoon", name: "kosher salt" },
      { amount: 1.5, unit: "teaspoons", name: "pumpkin pie spice" },
      { amount: 0.13, unit: "teaspoon", name: "freshly ground black pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Bake the pumpkin puree. Preheat an oven to 325 F. Line a rimmed baking sheet with parchment paper and spread the pumpkin puree in an even layer over the parchment paper, leaving an inch border or so around all sides. Bake for 35-40 minutes, until the puree is darker in color and somewhat dry to the touch. It should weigh about 500 g (please do consider weighing it!). Remove it from the oven and let it cool completely. This step can be done up to 3 days in advance and stored in an airtight container in the fridge. Just bring it up to room temperature before using.",
      "Brown the milk powder. Add the milk powder to a dry skillet over medium-low heat. Cook, stirring occasionally, until golden brown. Remove from the heat and transfer the milk powder to a small bowl. This can be done 1 day in advance and stored in an airtight container at room temperature.",
      "Roll out the pie crust. Roll the pie dough out to between 1/4 and 1/8th inch into a large round on a lightly floured surface. You shouldn’t need much flour, if your dough is sticking, you likely added too much water. Lay the pie crust into a pie pan, pressing it into the pan, trim the excess, and crimp the edges if desired. Use a fork to dock the pie crust all over and transfer the dough-filled pie pan to the fridge for 30 minutes.",
      "Preheat an oven to 400 F.",
      "Partially blind bake the pie crust. Place the chilled pie pan and crust on a baking sheet. Line the pie crust with crumpled parchment paper or foil and fill with pie weights. Bake for 15 minutes, then gently remove the parchment and pie weights and bake 5 minutes more. Remove from the oven and let the pie crust cool slightly.",
      "Make the pumpkin pie filling. Combine the roasted pumpkin, toasted milk powder, sweetened condensed milk, maple syrup, eggs and yolks, spices, salt, and heavy cream in a food processor and process until the filling is smooth. You can use a whisk and mixing bowl, but the filling will not be as smooth. Don't be alarmed that this filling is thicker than most pumpkin pie fillings.",
      "Bake the pie. Spread the filling evenly in the pie crust and bake for 35-45 minutes, until golden and slightly puffed on the edges, but with a slight jiggle in the center. The internal temperature of the filling should read at least 175°F on an instant read thermometer. If the crust starts getting too dark, tent it with foil. Remove the pie from the oven and let it cool to room temperature before chilling or serving."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Bake the pumpkin puree. Preheat an oven to 325 F. Line a rimmed baking sheet with parchment paper and spread the pumpkin puree in an even layer over the parchment paper, leaving an inch border or so around all sides. Bake for 35-40 minutes, until the puree is darker in color and somewhat dry to the touch. It should weigh about 500 g (please do consider weighing it!). Remove it from the oven and let it cool completely. This step can be done up to 3 days in advance and stored in an airtight container in the fridge. Just bring it up to room temperature before using.\nBrown the milk powder. Add the milk powder to a dry skillet over medium-low heat. Cook, stirring occasionally, until golden brown. Remove from the heat and transfer the milk powder to a small bowl. This can be done 1 day in advance and stored in an airtight container at room temperature.\nRoll out the pie crust. Roll the pie dough out to between 1/4 and 1/8th inch into a large round on a lightly floured surface. You shouldn’t need much flour, if your dough is sticking, you likely added too much water. Lay the pie crust into a pie pan, pressing it into the pan, trim the excess, and crimp the edges if desired. Use a fork to dock the pie crust all over and transfer the dough-filled pie pan to the fridge for 30 minutes.\nPreheat an oven to 400 F.\nPartially blind bake the pie crust. Place the chilled pie pan and crust on a baking sheet. Line the pie crust with crumpled parchment paper or foil and fill with pie weights. Bake for 15 minutes, then gently remove the parchment and pie weights and bake 5 minutes more. Remove from the oven and let the pie crust cool slightly.\nMake the pumpkin pie filling. Combine the roasted pumpkin, toasted milk powder, sweetened condensed milk, maple syrup, eggs and yolks, spices, salt, and heavy cream in a food processor and process until the filling is smooth. You can use a whisk and mixing bowl, but the filling will not be as smooth. Don't be alarmed that this filling is thicker than most pumpkin pie fillings.\nBake the pie. Spread the filling evenly in the pie crust and bake for 35-45 minutes, until golden and slightly puffed on the edges, but with a slight jiggle in the center. The internal temperature of the filling should read at least 175°F on an instant read thermometer. If the crust starts getting too dark, tent it with foil. Remove the pie from the oven and let it cool to room temperature before chilling or serving.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("somuchfoodblog.com")
    expect(recipe.canonical_url).to eq("https://somuchfoodblog.com/best-ever-pumpkin-pie/")
    expect(recipe.site_name).to eq("So Much Food")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Jenny")
    expect(recipe.description).to eq("This is the best pumpkin pie recipe ever. A bold claim, perhaps, but I have spent months perfecting this recipe. What you get is a rich, silky smooth, from-scratch pumpkin filling that's baked up in my all-butter pie crust for an incredibly delicious and complex pumpkin pie that will crush any store bought pie.")
    expect(recipe.image).to eq("https://somuchfoodblog.com/wp-content/uploads/2025/11/Pumpkin-Pie_LowRes-023.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to eq(90)
    expect(recipe.prep_time).to eq(45)
    expect(recipe.cook_time).to eq(45)
    expect(recipe.keywords).to eq(["pie", "pumpkin", "pumpkin pie", "thanksgiving"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 slice",
      "calories" => "364 kcal",
      "carbohydrateContent" => "44 g",
      "proteinContent" => "7 g",
      "fatContent" => "19 g",
      "saturatedFatContent" => "10 g",
      "transFatContent" => "0.003 g",
      "cholesterolContent" => "112 mg",
      "sodiumContent" => "262 mg",
      "fiberContent" => "3 g",
      "sugarContent" => "30 g",
      "unsaturatedFatContent" => "7 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "slice", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 364.0 },
      { name: "carbohydrateContent", unit: "g", amount: 44.0 },
      { name: "proteinContent", unit: "g", amount: 7.0 },
      { name: "fatContent", unit: "g", amount: 19.0 },
      { name: "saturatedFatContent", unit: "g", amount: 10.0 },
      { name: "transFatContent", unit: "g", amount: 0.003 },
      { name: "cholesterolContent", unit: "mg", amount: 112.0 },
      { name: "sodiumContent", unit: "mg", amount: 262.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "sugarContent", unit: "g", amount: 30.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 7.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://somuchfoodblog.com")
  end
end
