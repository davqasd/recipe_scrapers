# frozen_string_literal: true

RSpec.describe "onceuponachef.com" do
  subject(:recipe) { scrape_cassette("com/onceuponachef", url: "https://www.onceuponachef.com/recipes/spiced-pumpkin-bread.html") }

  it "reads the title" do
    expect(recipe.title).to eq("Pumpkin Bread")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups all-purpose flour, (spooned into measuring cup and leveled-off)",
      "½ teaspoon salt",
      "1 teaspoon baking soda",
      "½ teaspoon baking powder",
      "1 teaspoon ground cloves",
      "1 teaspoon ground cinnamon",
      "1 teaspoon ground nutmeg",
      "3/4 cup (1½ sticks) unsalted butter, softened",
      "2 cups sugar",
      "2 large eggs",
      "1 (15-oz) can 100% pure pumpkin (I use Libby's)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "all-purpose flour" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 1.0, unit: "teaspoon", name: "baking soda" },
      { amount: 0.5, unit: "teaspoon", name: "baking powder" },
      { amount: 1.0, unit: "teaspoon", name: "ground cloves" },
      { amount: 1.0, unit: "teaspoon", name: "ground cinnamon" },
      { amount: 1.0, unit: "teaspoon", name: "ground nutmeg" },
      { amount: 0.75, unit: "cup", name: "unsalted butter, softened" },
      { amount: 2.0, unit: "cups", name: "sugar" },
      { amount: 2.0, unit: nil, name: "large eggs" },
      { amount: 1.0, unit: "can", name: "100% pure pumpkin" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 325°F (165°C )and set an oven rack in the middle position. Generously grease two 8 x 4-in (20 x 10-cm) loaf pans with butter and dust with flour (alternatively, use a baking spray with flour in it, such as Pam with Flour or Baker's Joy).",
      "In a medium bowl, combine the flour, salt, baking soda, baking powder, cloves, cinnamon, and nutmeg. Whisk until well combined; set aside.",
      "In a large bowl of an electric mixer, beat the butter and sugar on medium speed until just blended. Add the eggs one at a time, beating well after each addition. Continue beating until very light and fluffy, a few minutes. Beat in the pumpkin. The mixture might look grainy and curdled at this point—that's okay.",
      "Add the flour mixture and mix on low speed until combined.",
      "Turn the batter into the prepared pans, dividing evenly, and bake for 65 to 75 minutes, or until a cake tester inserted into the center comes out clean. Let the loaves cool in the pans for about 10 minutes, then turn out onto a wire rack to cool completely. Once completely cooled, cover the loaf with aluminum foil or store it in a cake keeper and keep it at room temperature for up to 3 days."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 325°F (165°C )and set an oven rack in the middle position. Generously grease two 8 x 4-in (20 x 10-cm) loaf pans with butter and dust with flour (alternatively, use a baking spray with flour in it, such as Pam with Flour or Baker's Joy).\nIn a medium bowl, combine the flour, salt, baking soda, baking powder, cloves, cinnamon, and nutmeg. Whisk until well combined; set aside.\nIn a large bowl of an electric mixer, beat the butter and sugar on medium speed until just blended. Add the eggs one at a time, beating well after each addition. Continue beating until very light and fluffy, a few minutes. Beat in the pumpkin. The mixture might look grainy and curdled at this point—that's okay.\nAdd the flour mixture and mix on low speed until combined.\nTurn the batter into the prepared pans, dividing evenly, and bake for 65 to 75 minutes, or until a cake tester inserted into the center comes out clean. Let the loaves cool in the pans for about 10 minutes, then turn out onto a wire rack to cool completely. Once completely cooled, cover the loaf with aluminum foil or store it in a cake keeper and keep it at room temperature for up to 3 days.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("onceuponachef.com")
    expect(recipe.canonical_url).to eq("https://www.onceuponachef.com/recipes/spiced-pumpkin-bread.html")
    expect(recipe.site_name).to eq("Once Upon a Chef")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Jennifer Segal")
    expect(recipe.description).to eq("Kids love it, grown-ups love it...this pumpkin bread is hard to beat!")
    expect(recipe.image).to eq("https://www.onceuponachef.com/images/2009/09/Pumpkin-Bread-100.jpg")
    expect(recipe.category).to eq("Breads")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("24 servings")
    expect(recipe.total_time).to eq(90)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(65)
    expect(recipe.keywords).to eq(["pumpkin bread"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.75)
    expect(recipe.ratings_count).to eq(2923)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "166 kcal",
      "fatContent" => "6 g",
      "carbohydrateContent" => "26 g",
      "proteinContent" => "2 g",
      "saturatedFatContent" => "4 g",
      "sugarContent" => "17 g",
      "fiberContent" => "1 g",
      "sodiumContent" => "117 mg",
      "cholesterolContent" => "31 mg",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 166.0 },
      { name: "fatContent", unit: "g", amount: 6.0 },
      { name: "carbohydrateContent", unit: "g", amount: 26.0 },
      { name: "proteinContent", unit: "g", amount: 2.0 },
      { name: "saturatedFatContent", unit: "g", amount: 4.0 },
      { name: "sugarContent", unit: "g", amount: 17.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 117.0 },
      { name: "cholesterolContent", unit: "mg", amount: 31.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.onceuponachef.com")
  end
end
