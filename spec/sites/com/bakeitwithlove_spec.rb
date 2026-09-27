# frozen_string_literal: true

RSpec.describe "bakeitwithlove.com" do
  subject(:recipe) { scrape_cassette("com/bakeitwithlove", url: "https://bakeitwithlove.com/texas-roadhouse-dinner-rolls-cinnamon-honey-butter-copycat-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Texas Roadhouse Rolls Copycat Recipe with Cinnamon Honey Butter")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1¼ cups milk (warmed to 110-115°F/43-46°C)",
      "⅓ cup sugar",
      "1 packet active dry yeast (each packet of yeast is 2¼ teaspoons, ¼ ounce, or 7 grams)",
      "¼ cup butter (unsalted, softened, at room temperature - plus 3 tablespoons melted butter for brushing the baked rolls)",
      "3½ cups all-purpose flour (plus more for your work surface)",
      "1 tsp salt",
      "1 large egg (beaten, at room temperature)",
      "1/2 cup butter (softened at room temperature)",
      "1/3 cup honey",
      "1 tsp ground cinnamon",
      "2 Tbsp confectioners sugar (optional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.25, unit: "cups", name: "milk" },
      { amount: 0.33, unit: "cup", name: "sugar" },
      { amount: 1.0, unit: "packet", name: "active dry yeast" },
      { amount: 0.25, unit: "cup", name: "butter" },
      { amount: 3.5, unit: "cups", name: "all-purpose flour" },
      { amount: 1.0, unit: "tsp", name: "salt" },
      { amount: 1.0, unit: nil, name: "large egg" },
      { amount: 0.5, unit: "cup", name: "butter" },
      { amount: 0.33, unit: "cup", name: "honey" },
      { amount: 1.0, unit: "tsp", name: "ground cinnamon" },
      { amount: 2.0, unit: "Tbsp", name: "confectioners sugar" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Texas Roadhouse Dinner Rolls",
      "Yeast",
      "In a large mixing bowl, combine 1¼ cups milk and ⅓ cup sugar. Then, sprinkle one packet of 1 packet active dry yeast over the top and let it sit for about 5 minutes or until foamy.",
      "Add",
      "To the same bowl with the yeast mixture, add ¼ cup (57 grams) of softened butter, 1 large egg (50 grams), 1 teaspoon (5.6 grams) of salt, and only 2 cups (240 grams) of your all-purpose flour.",
      "Dough",
      "Add the proofed yeast mixture to the dry ingredients, then add the melted butter and beaten egg. Combine until you have a smooth dough that is a bit wetter than the usual bread dough. Turn the dough into an oiled large bowl, turning the dough to coat it with the oil on all sides. Cover with plastic wrap or a damp towel and allow it to rise until doubled in size, about 90 minutes.",
      "Punch the risen dough down a little less than half way, and turn out onto a well floured work surface. Knead just enough to incorporate some of the flour so that the dough is not as sticky, about 2 minutes. Let the dough rest for 10 minutes.",
      "Divide",
      "Roll the dough out into roughly a 14x12 square a bit over a 1/2 inch in thickness and, using a sharp knife, cut into 12 equal portions. Double the portions over and place them onto a parchment paper lined baking sheet about a 1/2 inch from each other and the baking sheet edges. Cover with a damp towel or oil coated plastic wrap and allow to rise for 25-30 minutes.",
      "Preheat your oven to 350°F (175°C) and coat the rolls with half of the second portion of melted unsalted butter.",
      "Bake the rolls for 15-18 minutes, remove from the oven when lightly golden browned, and coat with the remaining melted butter. Serve immediately.",
      "Cinnamon Honey Butter",
      "Combine",
      "Whip together the room temperature butter, cinnamon, honey and (optional) confectioners sugar with a fork. Serve with the dinner rolls at room temperature."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["Texas Roadhouse Dinner Rolls", 7],
        ["Cinnamon Honey Butter", 4]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Texas Roadhouse Dinner Rolls\nYeast\nIn a large mixing bowl, combine 1¼ cups milk and ⅓ cup sugar. Then, sprinkle one packet of 1 packet active dry yeast over the top and let it sit for about 5 minutes or until foamy.\nAdd\nTo the same bowl with the yeast mixture, add ¼ cup (57 grams) of softened butter, 1 large egg (50 grams), 1 teaspoon (5.6 grams) of salt, and only 2 cups (240 grams) of your all-purpose flour.\nDough\nAdd the proofed yeast mixture to the dry ingredients, then add the melted butter and beaten egg. Combine until you have a smooth dough that is a bit wetter than the usual bread dough. Turn the dough into an oiled large bowl, turning the dough to coat it with the oil on all sides. Cover with plastic wrap or a damp towel and allow it to rise until doubled in size, about 90 minutes.\nPunch the risen dough down a little less than half way, and turn out onto a well floured work surface. Knead just enough to incorporate some of the flour so that the dough is not as sticky, about 2 minutes. Let the dough rest for 10 minutes.\nDivide\nRoll the dough out into roughly a 14x12 square a bit over a 1/2 inch in thickness and, using a sharp knife, cut into 12 equal portions. Double the portions over and place them onto a parchment paper lined baking sheet about a 1/2 inch from each other and the baking sheet edges. Cover with a damp towel or oil coated plastic wrap and allow to rise for 25-30 minutes.\nPreheat your oven to 350°F (175°C) and coat the rolls with half of the second portion of melted unsalted butter.\nBake the rolls for 15-18 minutes, remove from the oven when lightly golden browned, and coat with the remaining melted butter. Serve immediately.\nCinnamon Honey Butter\nCombine\nWhip together the room temperature butter, cinnamon, honey and (optional) confectioners sugar with a fork. Serve with the dinner rolls at room temperature.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("bakeitwithlove.com")
    expect(recipe.canonical_url).to eq("https://bakeitwithlove.com/texas-roadhouse-dinner-rolls-cinnamon-honey-butter-copycat-recipe/")
    expect(recipe.site_name).to eq("Bake It With Love")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Angela Latimer")
    expect(recipe.description).to eq("These Texas Roadhouse rolls with cinnamon honey butter are my household's number one requested bread roll! The Texas Roadhouse restaurant is known for these fabulous yeast dinner rolls that are light and fluffy with just a hint of sweetness that is complimented perfectly by the cinnamon honey butter. Best of all, they're easy to make!")
    expect(recipe.image).to eq("https://bakeitwithlove.com/wp-content/uploads/2023/10/Texas_Roadhouse_Rolls_h.jpg")
    expect(recipe.category).to eq("Bread Recipes")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(110)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(["best Texas Roadhouse dinner roll copycat recipe", "cinnamon butter", "copycat", "dinner rolls", "how to make Texas Roadhouse dinner rolls", "texas roadhouse"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(4)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "298 kcal",
      "carbohydrateContent" => "39 g",
      "proteinContent" => "5 g",
      "fatContent" => "14 g",
      "saturatedFatContent" => "9 g",
      "cholesterolContent" => "50 mg",
      "sodiumContent" => "129 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "15 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 298.0 },
      { name: "carbohydrateContent", unit: "g", amount: 39.0 },
      { name: "proteinContent", unit: "g", amount: 5.0 },
      { name: "fatContent", unit: "g", amount: 14.0 },
      { name: "saturatedFatContent", unit: "g", amount: 9.0 },
      { name: "cholesterolContent", unit: "mg", amount: 50.0 },
      { name: "sodiumContent", unit: "mg", amount: 129.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 15.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-content")
  end
end
