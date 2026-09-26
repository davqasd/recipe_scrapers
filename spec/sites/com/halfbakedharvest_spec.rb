# frozen_string_literal: true

RSpec.describe "halfbakedharvest.com" do
  subject(:recipe) { scrape_cassette("com/halfbakedharvest", url: "https://www.halfbakedharvest.com/chocolate-chip-banana-bread-french-toast-muffins-with-cinnamon-streusel/") }

  it "reads the title" do
    expect(recipe.title).to eq("Chocolate Chip Banana Bread French Toast Muffins with Cinnamon Streusel.")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 1/2 cups milk",
      "4 large eggs",
      "3 very ripe bananas (mashed)",
      "2 tablespoons honey",
      "1 tablespoons vanilla",
      "2 tablespoons ground flax seed meal (optional)",
      "1 teaspoon cinnamon",
      "8-10 cups cubed [Challah Bread | https://www.halfbakedharvest.com/simple-whole-wheat-challah-bread/]",
      "1 cup semi-sweet or dark chocolate chips (optional)",
      "pure maple syrup (butter + bananas, for serving)",
      "1/4 cup brown sugar",
      "1/4 cup butter (cut into cubes)",
      "1/4 cup flour",
      "1/4 cup walnuts (chopped)",
      "1 teaspoon cinnamon"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.5, unit: "cups", name: "milk" },
      { amount: 4.0, unit: nil, name: "large eggs" },
      { amount: 3.0, unit: nil, name: "very ripe bananas" },
      { amount: 2.0, unit: "tablespoons", name: "honey" },
      { amount: 1.0, unit: "tablespoons", name: "vanilla" },
      { amount: 2.0, unit: "tablespoons", name: "ground flax seed meal" },
      { amount: 1.0, unit: "teaspoon", name: "cinnamon" },
      { amount: 8.0, unit: "cups", name: "cubed [Challah Bread | https://www.halfbakedharvest.com/simple-whole-wheat-challah-bread/]" },
      { amount: 1.0, unit: "cup", name: "semi-sweet or dark chocolate chips" },
      { amount: nil, unit: nil, name: "pure maple syrup" },
      { amount: 0.25, unit: "cup", name: "brown sugar" },
      { amount: 0.25, unit: "cup", name: "butter" },
      { amount: 0.25, unit: "cup", name: "flour" },
      { amount: 0.25, unit: "cup", name: "walnuts" },
      { amount: 1.0, unit: "teaspoon", name: "cinnamon" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Grease a 12 cup muffin tin with cooking spray, butter or canola oil.",
      "In a medium bowl, whisk together the milk, eggs, mashed bananas (I just mash mine with a fork in the bowl) honey, vanilla, ground flax and cinnamon.",
      "To the milk/egg mixture, add the cubed challah bread and the chocolate chips. Gently toss to coat, being careful to not break up the bread cubes too much. Divide the bread among the muffin cups, pouring any remaining milk/egg mixture left in the bowl over the muffins.",
      "Cover the muffins with plastic wrap and refrigerate for 30 minutes or up to overnight.",
      "When ready to bake, preheat the oven to 350 degrees F. and remove the muffins from the fridge. Let sit at room temp.",
      "While the oven preheats make the streusel, in a small bowl, combine butter, brown sugar, flour, cinnamon, and walnuts. Mix together with your hands, until you have a crumbly mixture. Remove the muffins from the refrigerator and sprinkle the muffins evenly with the streusel topping.",
      "Bake for 25-35 minutes or until tops are golden brown. Let the muffins cool for 5 minutes. Use a butter knife to loosen the edges and then pop them out. Serve with maple syrup, butter and bananas if desired."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        [nil, 10],
        ["Cinnamon Streusel", 5]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Grease a 12 cup muffin tin with cooking spray, butter or canola oil.\nIn a medium bowl, whisk together the milk, eggs, mashed bananas (I just mash mine with a fork in the bowl) honey, vanilla, ground flax and cinnamon.\nTo the milk/egg mixture, add the cubed challah bread and the chocolate chips. Gently toss to coat, being careful to not break up the bread cubes too much. Divide the bread among the muffin cups, pouring any remaining milk/egg mixture left in the bowl over the muffins.\nCover the muffins with plastic wrap and refrigerate for 30 minutes or up to overnight.\nWhen ready to bake, preheat the oven to 350 degrees F. and remove the muffins from the fridge. Let sit at room temp.\nWhile the oven preheats make the streusel, in a small bowl, combine butter, brown sugar, flour, cinnamon, and walnuts. Mix together with your hands, until you have a crumbly mixture. Remove the muffins from the refrigerator and sprinkle the muffins evenly with the streusel topping.\nBake for 25-35 minutes or until tops are golden brown. Let the muffins cool for 5 minutes. Use a butter knife to loosen the edges and then pop them out. Serve with maple syrup, butter and bananas if desired.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("halfbakedharvest.com")
    expect(recipe.canonical_url).to eq("https://www.halfbakedharvest.com/chocolate-chip-banana-bread-french-toast-muffins-with-cinnamon-streusel/")
    expect(recipe.site_name).to eq("Half Baked Harvest")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Tieghan Gerard")
    expect(recipe.description).to eq("The honest reason for the french toast muffins?? A really stinkin good reason to get outta bed.")
    expect(recipe.image).to eq("https://www.halfbakedharvest.com/wp-content/uploads/2015/09/Chocolate-Chip-Banana-Bread-French-Toast-Muffins-with-Cinnamon-Streusel-1.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(["banana bread", "chocolate", "cinnamon", "french toast", "muffins"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.33)
    expect(recipe.ratings_count).to eq(43)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "187 kcal",
      "carbohydrateContent" => "88 g",
      "proteinContent" => "15 g",
      "fatContent" => "36 g",
      "saturatedFatContent" => "9 g",
      "cholesterolContent" => "264 mg",
      "sodiumContent" => "1985 mg",
      "fiberContent" => "6 g",
      "sugarContent" => "31 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 187.0 },
      { name: "carbohydrateContent", unit: "g", amount: 88.0 },
      { name: "proteinContent", unit: "g", amount: 15.0 },
      { name: "fatContent", unit: "g", amount: 36.0 },
      { name: "saturatedFatContent", unit: "g", amount: 9.0 },
      { name: "cholesterolContent", unit: "mg", amount: 264.0 },
      { name: "sodiumContent", unit: "mg", amount: 1985.0 },
      { name: "fiberContent", unit: "g", amount: 6.0 },
      { name: "sugarContent", unit: "g", amount: 31.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
