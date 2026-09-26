# frozen_string_literal: true

RSpec.describe "joythebaker.com" do
  subject(:recipe) { scrape_cassette("com/joythebaker", url: "https://joythebaker.com/2023/01/jambalaya-biscuits/") }

  it "reads the title" do
    expect(recipe.title).to eq("Jambalaya Biscuits")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 heaping cup cherry tomatoes, halved and roasted until bubbling with a bit of olive oil, salt, and pepper",
      "2 tablespoons olive oil",
      "1/2 cup diced yellow onion",
      "1/2 cup diced green bell pepper",
      "7 ounces (1 sausage link) Zatarain’s Cajun-Style Smoke Sausage, sliced into 1/4-inch rounds",
      "3 cups all-purpose flour",
      "1 tablespoon granulated sugar",
      "1 tablespoon plus 1 teaspoon baking powder",
      "1/2 teaspoon baking soda",
      "3/4 teaspoon salt",
      "3/4 cup cold unsalted butter, cut into small chunks",
      "1 large egg, lightly beaten",
      "3/4 cup cold buttermilk, plus more for topping the biscuits",
      "Sea salt and fresh cracked black pepper, for topping",
      "Melted butter and chopped chives, for topping"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "cherry tomatoes, halved and roasted until bubbling with a bit of olive oil, salt, and pepper" },
      { amount: 2.0, unit: "tablespoons", name: "olive oil" },
      { amount: 0.5, unit: "cup", name: "diced yellow onion" },
      { amount: 0.5, unit: "cup", name: "diced green bell pepper" },
      { amount: 7.0, unit: "ounces", name: "Zatarain’s Cajun-Style Smoke Sausage, sliced into 1/4-inch rounds" },
      { amount: 3.0, unit: "cups", name: "all-purpose flour" },
      { amount: 1.0, unit: "tablespoon", name: "granulated sugar" },
      { amount: 1.0, unit: "tablespoon", name: "plus 1 teaspoon baking powder" },
      { amount: 0.5, unit: "teaspoon", name: "baking soda" },
      { amount: 0.75, unit: "teaspoon", name: "salt" },
      { amount: 0.75, unit: "cup", name: "cold unsalted butter, cut into small chunks" },
      { amount: 1.0, unit: nil, name: "large egg, lightly beaten" },
      { amount: 0.75, unit: "cup", name: "cold buttermilk, plus more for topping the biscuits" },
      { amount: nil, unit: nil, name: "Sea salt and fresh cracked black pepper, for topping" },
      { amount: nil, unit: nil, name: "Melted butter and chopped chives, for topping" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "First make the jambalaya filling. In a medium saucepan, heat oil over medium heat. Add onion and peppers and cook until softened, about 5-7 minutes. Add the sliced sausage and toss to combine, about 1 minute. Transfer to a bowl along with the roasted tomatoes and refrigerate while you make the biscuit dough.",
      "In a large bowl whisk together flour, sugar, baking powder, baking soda, and salt. Add the cold butter and work into the dry ingredients into smaller butter chunks using fast hands or a pastry blender. Butter will be the size of peas when broken down. Place the mixture in the freezer for 15 minutes to re-chill.",
      "In a small bowl whisk together egg and cold buttermilk. Keep chilled.",
      "Take the flour mixture out of the freezer and drizzle in the buttermilk. Stir into a shaggy dough. Add the chilled jambalaya filling and toss to combine. Turn the dough out onto a clean counter and gently knead together into a cohesive rectangle.",
      "Gently roll the dough into a 1-inch thick rectangle on a lightly floured surface. At the short end of the dough closest to you, fold the dough over until the edge of the dough meets the center of the dough. If it feels like there are chunks of meat everywhere – yes, that’s right. Fold the top edge of the dough towards the center over the first fold. An envelope fold. Slice the dough in half through the vertical center, stack the two pieces of dough and again gently roll the dough into a 1-inch rectangle and repeat the folding process again. Loosely wrap the envelope of dough in plastic wrap and freeze for 15 minutes.",
      "Place a rack in the upper third of the oven and preheat oven to 425 degrees F. Line a rimmed baking sheet with parchment paper.",
      "Remove the dough from the freezer and roll to a generous 1-inch thickness. Use a sharp knife to slice into 8 squares. Place a few inches apart on the prepared baking sheet and brush the top of each biscuit with buttermilk. Sprinkle with salt and pepper.",
      "Bake for 15-18 minutes until golden brown. Set aside for a few minutes to cool slightly before serving. I like to brush with butter and sprinkle with a bit of chives before serving.",
      "Biscuits are best enjoyed the day they’re made but keep, well wrapped, in the refrigerator for 2 days. Just wrap in foil and toast in the oven before serving."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("First make the jambalaya filling. In a medium saucepan, heat oil over medium heat. Add onion and peppers and cook until softened, about 5-7 minutes. Add the sliced sausage and toss to combine, about 1 minute. Transfer to a bowl along with the roasted tomatoes and refrigerate while you make the biscuit dough.\nIn a large bowl whisk together flour, sugar, baking powder, baking soda, and salt. Add the cold butter and work into the dry ingredients into smaller butter chunks using fast hands or a pastry blender. Butter will be the size of peas when broken down. Place the mixture in the freezer for 15 minutes to re-chill.\nIn a small bowl whisk together egg and cold buttermilk. Keep chilled.\nTake the flour mixture out of the freezer and drizzle in the buttermilk. Stir into a shaggy dough. Add the chilled jambalaya filling and toss to combine. Turn the dough out onto a clean counter and gently knead together into a cohesive rectangle.\nGently roll the dough into a 1-inch thick rectangle on a lightly floured surface. At the short end of the dough closest to you, fold the dough over until the edge of the dough meets the center of the dough. If it feels like there are chunks of meat everywhere – yes, that’s right. Fold the top edge of the dough towards the center over the first fold. An envelope fold. Slice the dough in half through the vertical center, stack the two pieces of dough and again gently roll the dough into a 1-inch rectangle and repeat the folding process again. Loosely wrap the envelope of dough in plastic wrap and freeze for 15 minutes.\nPlace a rack in the upper third of the oven and preheat oven to 425 degrees F. Line a rimmed baking sheet with parchment paper.\nRemove the dough from the freezer and roll to a generous 1-inch thickness. Use a sharp knife to slice into 8 squares. Place a few inches apart on the prepared baking sheet and brush the top of each biscuit with buttermilk. Sprinkle with salt and pepper.\nBake for 15-18 minutes until golden brown. Set aside for a few minutes to cool slightly before serving. I like to brush with butter and sprinkle with a bit of chives before serving.\nBiscuits are best enjoyed the day they’re made but keep, well wrapped, in the refrigerator for 2 days. Just wrap in foil and toast in the oven before serving.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("joythebaker.com")
    expect(recipe.canonical_url).to eq("https://joythebaker.com/2023/01/jambalaya-biscuits/")
    expect(recipe.site_name).to eq("Joy the Baker")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Joy the Baker")
    expect(recipe.description).to eq("A tender, savory, and stacked Mardi Gras biscuit!")
    expect(recipe.image).to eq("https://joythebaker.com/wp-content/uploads/2023/01/JambBiscuits-45-225x225.jpg")
    expect(recipe.category).to eq("breakfast")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to eq("baking")
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(40)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq(["jambalaya", "biscuits", "mardi gras", "bell peppers", "roasted tomato"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(6)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
