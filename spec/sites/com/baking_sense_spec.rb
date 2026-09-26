# frozen_string_literal: true

RSpec.describe "baking-sense.com" do
  subject(:recipe) { scrape_cassette("com/baking_sense", url: "https://www.baking-sense.com/2020/05/13/sourdough-bundt-cake/") }

  it "reads the title" do
    expect(recipe.title).to eq("Sourdough Bundt Cake with Buttermilk Glaze")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 large eggs (room temperature)",
      "2 large yolks (room temperature)",
      "1 tablespoon vanilla extract",
      "8 oz sourdough discard (1 cup, room temperature)",
      "9 oz cake flour (2 cups, see note)",
      "11 oz granulated sugar (1 1/3 cups)",
      "2 teaspoons baking powder",
      "1/2 teaspoon table salt",
      "6 oz unsalted butter (room temperature, cut into 1\" chunks)",
      "4 oz buttermilk (1/2 cup, room temperature)",
      "8 oz confectioner's sugar (2 cups)",
      "1 teaspoon vanilla",
      "2 oz buttermilk (1/4 cup)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: nil, name: "large eggs" },
      { amount: 2.0, unit: nil, name: "large yolks" },
      { amount: 1.0, unit: "tablespoon", name: "vanilla extract" },
      { amount: 8.0, unit: "oz", name: "sourdough discard" },
      { amount: 9.0, unit: "oz", name: "cake flour" },
      { amount: 11.0, unit: "oz", name: "granulated sugar" },
      { amount: 2.0, unit: "teaspoons", name: "baking powder" },
      { amount: 0.5, unit: "teaspoon", name: "table salt" },
      { amount: 6.0, unit: "oz", name: "unsalted butter" },
      { amount: 4.0, unit: "oz", name: "buttermilk" },
      { amount: 8.0, unit: "oz", name: "confectioner's sugar" },
      { amount: 1.0, unit: "teaspoon", name: "vanilla" },
      { amount: 2.0, unit: "oz", name: "buttermilk" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 350°F. Generously butter and flour a 12 cup Bundt pan.",
      "Make the batter",
      "Whisk together the eggs, yolks, vanilla and the discard, set aside.",
      "Sift the flour, sugar, baking powder and salt into a mixer bowl. Mix on low speed to combine the dry ingredients. With the mixer running, toss the chunks of butter into the flour mixture.",
      "Add the buttermilk and increase the speed to medium. Mix on medium high for 2 minutes to aerate the batter. Scrape the bowl and beater.",
      "Add the egg mixture in 3 batches, scraping the bowl between each addition. Pour the batter into the prepared pan.",
      "Bake until the cake springs back when lightly pressed or a toothpick inserted into the center comes out clean, about 40 minutes.",
      "Cool for 10 minutes in the pan. Invert the cake onto a cooling rack set over a clean sheet pan. Cool until slightly warm before glazing.",
      "Make the Glaze",
      "Combine the sugar, vanilla and buttermilk in a small bowl and whisk until smooth.",
      "Pour the glaze over the still slightly warm cake. You can scoop up the glaze from the sheet pan and use it to fill in any gaps in the glaze or leave it with the drips.",
      "Cool completely and allow the glaze to set. Transfer to a serving plate."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["Sourdough Cake", 10],
        ["Buttermilk Glaze", 3]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 350°F. Generously butter and flour a 12 cup Bundt pan.\nMake the batter\nWhisk together the eggs, yolks, vanilla and the discard, set aside.\nSift the flour, sugar, baking powder and salt into a mixer bowl. Mix on low speed to combine the dry ingredients. With the mixer running, toss the chunks of butter into the flour mixture.\nAdd the buttermilk and increase the speed to medium. Mix on medium high for 2 minutes to aerate the batter. Scrape the bowl and beater.\nAdd the egg mixture in 3 batches, scraping the bowl between each addition. Pour the batter into the prepared pan.\nBake until the cake springs back when lightly pressed or a toothpick inserted into the center comes out clean, about 40 minutes.\nCool for 10 minutes in the pan. Invert the cake onto a cooling rack set over a clean sheet pan. Cool until slightly warm before glazing.\nMake the Glaze\nCombine the sugar, vanilla and buttermilk in a small bowl and whisk until smooth.\nPour the glaze over the still slightly warm cake. You can scoop up the glaze from the sheet pan and use it to fill in any gaps in the glaze or leave it with the drips.\nCool completely and allow the glaze to set. Transfer to a serving plate.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("baking-sense.com")
    expect(recipe.canonical_url).to eq("https://www.baking-sense.com/2020/05/13/sourdough-bundt-cake/")
    expect(recipe.site_name).to eq("Baking Sense®")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Eileen Gray")
    expect(recipe.description).to eq("Sourdough Bundt Cake with Buttermilk Glaze is a perfect snack cake. The tangy-sweet buttermilk glaze forms an ultra-thin coating over the melt-in-your-mouth cake.")
    expect(recipe.image).to eq("https://www.baking-sense.com/wp-content/uploads/2020/05/sourdough-bundt-9a.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("16 servings")
    expect(recipe.total_time).to eq(60)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(40)
    expect(recipe.keywords).to eq(%w[buttermilk sourdough])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.88)
    expect(recipe.ratings_count).to eq(8)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "247 kcal",
      "sodiumContent" => "148 mg",
      "sugarContent" => "20 g",
      "fiberContent" => "1 g",
      "cholesterolContent" => "69 mg",
      "transFatContent" => "1 g",
      "saturatedFatContent" => "6 g",
      "fatContent" => "10 g",
      "proteinContent" => "4 g",
      "carbohydrateContent" => "49 g",
      "unsaturatedFatContent" => "4 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 247.0 },
      { name: "sodiumContent", unit: "mg", amount: 148.0 },
      { name: "sugarContent", unit: "g", amount: 20.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 69.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "saturatedFatContent", unit: "g", amount: 6.0 },
      { name: "fatContent", unit: "g", amount: 10.0 },
      { name: "proteinContent", unit: "g", amount: 4.0 },
      { name: "carbohydrateContent", unit: "g", amount: 49.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 4.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
