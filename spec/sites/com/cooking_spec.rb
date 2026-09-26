# frozen_string_literal: true

RSpec.describe "cooking.nytimes.com" do
  subject(:recipe) { scrape_cassette("com/cooking", url: "https://cooking.nytimes.com/recipes/1021128-cacio-e-pepe-crackers") }

  it "reads the title" do
    expect(recipe.title).to eq("Cacio e Pepe Crackers")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 ½ cups/190 grams unbleached all-purpose flour (see Tip)",
      "1 tablespoon freshly ground black pepper, plus more for finishing",
      "½ teaspoon kosher salt",
      "½ teaspoon onion powder (optional)",
      "½ teaspoon ground mustard (optional)",
      "⅛ teaspoon garlic powder (optional)",
      "5 ounces/145 grams white Cheddar, roughly grated (about 1 ¼ cups packed)",
      "3 ounces/85 grams Asiago cheese, roughly grated (about ¾ cup)",
      "5 tablespoons/70 grams unsalted butter, cold and cubed",
      "¼ cup/25 grams finely ground Pecorino Romano cheese (or Parmigiano-Reggiano or more Asiago), for sprinkling"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.5, unit: "cups", name: "unbleached all-purpose flour" },
      { amount: 1.0, unit: "tablespoon", name: "freshly ground black pepper, plus more for finishing" },
      { amount: 0.5, unit: "teaspoon", name: "kosher salt" },
      { amount: 0.5, unit: "teaspoon", name: "onion powder" },
      { amount: 0.5, unit: "teaspoon", name: "ground mustard" },
      { amount: 0.13, unit: "teaspoon", name: "garlic powder" },
      { amount: 5.0, unit: "ounces", name: "white Cheddar, roughly grated" },
      { amount: 3.0, unit: "ounces", name: "Asiago cheese, roughly grated" },
      { amount: 5.0, unit: "tablespoons", name: "unsalted butter, cold and cubed" },
      { amount: 0.25, unit: "cup", name: "finely ground Pecorino Romano cheese, for sprinkling" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In the bowl of a food processor, add the flour, pepper, salt and spices (if using), and pulse to combine.",
      "Add the Cheddar, Asiago and butter, and pulse several times, then let the mixer run until the dough comes mostly together around the blade, 1 to 3 minutes. It’s OK if the dough is a little pebbly, but it should clump easily when you squeeze it. (You can also prepare this dough by hand, though you’ll need to bring the butter to room temperature first. Mix all your dry ingredients in a medium bowl. Then, in a large bowl, mix Cheddar, Asiago and butter to form a paste. Add the flour mixture and knead the dough together.)",
      "Pull your dough out of your bowl onto a flat surface and gently knead it into a smooth ball. Split your dough in half and shape each half into a rectangle. Using a rolling pin, roll each piece until about ½-inch thick, dusting a tiny bit of flour on your pin, if needed, to prevent the dough from sticking. (If you don’t want to bake all the crackers now, you can freeze dough in ½-inch-thick blocks.)",
      "Place a piece of dough in the center of an 18-inch-long piece of parchment paper. Roll the dough on the parchment paper, working from the center outward. (You want the dough to adhere to the bottom layer of parchment, but if your rolling pin sticks to the surface, lightly dust it with flour.) When your dough is about ¼-inch thick, lay another piece of parchment, plastic wrap, or a silicone baking mat over the surface of your dough. Continue to roll the dough out ⅛- to 1/16-inch thick, as thin as your arms will allow, pressing together any cracks that may form. (You can also use an etching motion, moving your pin from the center out toward the edges across your dough.) Rotate the parchment in front of you with every few strokes to ensure you are rolling the dough evenly.",
      "Peel back the top layer of parchment and sprinkle the surface with half the Pecorino Romano and a dozen or so grinds of black pepper across the surface. Lightly roll over once more with your rolling pin so the cheese and pepper adheres to the cracker dough. Transfer this sheeted dough onto a baking sheet and chill in the fridge or freezer until firm, about 15 minutes. (If you let it chill longer, just pull it out and let it temper a bit before proceeding.) Repeat with the second piece of dough.",
      "When the dough is nearly chilled, arrange the racks in the upper and lower third of the oven and heat to 325 degrees. Remove one sheet of dough from the tray and place on a work surface.",
      "Using a pastry wheel (fluted is nice), pizza cutter or a sharp knife and a ruler, cut 1-inch squares across the surface of the dough. (A 1-inch-thick ruler or tracer made from card stock or cardboard comes in handy here.) Transfer crackers to parchment-lined baking sheets with ½-inch space in between. (They will not spread much.) If your dough warms up or is difficult to peel and place, just slip it back into the freezer still attached to your parchment paper and let it firm up, then proceed.",
      "Bake the crackers in the center of your oven for 14 to 20 minutes (depending on thickness), rotating trays midway through baking to ensure they color evenly. Crackers will be just golden at the edges and the surface should be firm to the touch. You want them to dry crisp. (Test by pulling one cracker off the tray, let it quickly cool and break it in half to see how it snaps.) Remove from the oven and cool on trays.",
      "Once fully cooled, store crackers in a tin or covered container for up to 4 weeks."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In the bowl of a food processor, add the flour, pepper, salt and spices (if using), and pulse to combine.\nAdd the Cheddar, Asiago and butter, and pulse several times, then let the mixer run until the dough comes mostly together around the blade, 1 to 3 minutes. It’s OK if the dough is a little pebbly, but it should clump easily when you squeeze it. (You can also prepare this dough by hand, though you’ll need to bring the butter to room temperature first. Mix all your dry ingredients in a medium bowl. Then, in a large bowl, mix Cheddar, Asiago and butter to form a paste. Add the flour mixture and knead the dough together.)\nPull your dough out of your bowl onto a flat surface and gently knead it into a smooth ball. Split your dough in half and shape each half into a rectangle. Using a rolling pin, roll each piece until about ½-inch thick, dusting a tiny bit of flour on your pin, if needed, to prevent the dough from sticking. (If you don’t want to bake all the crackers now, you can freeze dough in ½-inch-thick blocks.)\nPlace a piece of dough in the center of an 18-inch-long piece of parchment paper. Roll the dough on the parchment paper, working from the center outward. (You want the dough to adhere to the bottom layer of parchment, but if your rolling pin sticks to the surface, lightly dust it with flour.) When your dough is about ¼-inch thick, lay another piece of parchment, plastic wrap, or a silicone baking mat over the surface of your dough. Continue to roll the dough out ⅛- to 1/16-inch thick, as thin as your arms will allow, pressing together any cracks that may form. (You can also use an etching motion, moving your pin from the center out toward the edges across your dough.) Rotate the parchment in front of you with every few strokes to ensure you are rolling the dough evenly.\nPeel back the top layer of parchment and sprinkle the surface with half the Pecorino Romano and a dozen or so grinds of black pepper across the surface. Lightly roll over once more with your rolling pin so the cheese and pepper adheres to the cracker dough. Transfer this sheeted dough onto a baking sheet and chill in the fridge or freezer until firm, about 15 minutes. (If you let it chill longer, just pull it out and let it temper a bit before proceeding.) Repeat with the second piece of dough.\nWhen the dough is nearly chilled, arrange the racks in the upper and lower third of the oven and heat to 325 degrees. Remove one sheet of dough from the tray and place on a work surface.\nUsing a pastry wheel (fluted is nice), pizza cutter or a sharp knife and a ruler, cut 1-inch squares across the surface of the dough. (A 1-inch-thick ruler or tracer made from card stock or cardboard comes in handy here.) Transfer crackers to parchment-lined baking sheets with ½-inch space in between. (They will not spread much.) If your dough warms up or is difficult to peel and place, just slip it back into the freezer still attached to your parchment paper and let it firm up, then proceed.\nBake the crackers in the center of your oven for 14 to 20 minutes (depending on thickness), rotating trays midway through baking to ensure they color evenly. Crackers will be just golden at the edges and the surface should be firm to the touch. You want them to dry crisp. (Test by pulling one cracker off the tray, let it quickly cool and break it in half to see how it snaps.) Remove from the oven and cool on trays.\nOnce fully cooled, store crackers in a tin or covered container for up to 4 weeks.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cooking.nytimes.com")
    expect(recipe.canonical_url).to eq("https://cooking.nytimes.com/recipes/1021128-cacio-e-pepe-crackers")
    expect(recipe.site_name).to eq("NYT Cooking")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Laurie Ellen Pellicano")
    expect(recipe.description).to eq("These quick, easy crackers are a crispy twist on the classic pasta dish, and an excellent cocktail hour snack. Rolling the freshly made dough between sheets of parchment expedites chilling, then cutting crackers with a pastry wheel (or pizza cutter) reduces waste. Do grate your own cheese for this instead of using store-bought, pre-grated cheese, as it plays an integral role in making the dough moist. These cheesy crackers can be kept simple, allowing cheese and pepper to dominate, or gussied up with any combination of onion powder, ground mustard or garlic powder, depending on your preference. This recipe makes a large batch, but the crackers will keep for up to one month, depending on your snack habits.")
    expect(recipe.image).to eq("https://static01.nyt.com/images/2020/05/28/dining/lp-cacio-e-pepe-crackers/merlin_172657737_693784a8-529d-4496-9e60-3ff2af3c7735-videoSixteenByNineJumbo1600.jpg")
    expect(recipe.category).to eq("Crackers and Chips, Finger Foods, Snack")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to eq("Bake")
    expect(recipe.yields).to eq("5 items")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["All-Purpose Flour", "Butter", "Cheddar"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.0)
    expect(recipe.ratings_count).to eq(254)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "290.75",
      "carbohydrateContent" => "20 grams",
      "cholesterolContent" => "49.1 milligrams",
      "fatContent" => "17.6 grams",
      "fiberContent" => "0.9 grams",
      "proteinContent" => "12.7 grams",
      "saturatedFatContent" => "10.4 grams",
      "sodiumContent" => "326.7 milligrams",
      "sugarContent" => "0.2 grams",
      "unsaturatedFatContent" => "0.6 grams"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: nil, amount: 290.75 },
      { name: "carbohydrateContent", unit: "g", amount: 20.0 },
      { name: "cholesterolContent", unit: "mg", amount: 49.1 },
      { name: "fatContent", unit: "g", amount: 17.6 },
      { name: "fiberContent", unit: "g", amount: 0.9 },
      { name: "proteinContent", unit: "g", amount: 12.7 },
      { name: "saturatedFatContent", unit: "g", amount: 10.4 },
      { name: "sodiumContent", unit: "mg", amount: 326.7 },
      { name: "sugarContent", unit: "g", amount: 0.2 },
      { name: "unsaturatedFatContent", unit: "g", amount: 0.6 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://cooking.nytimes.com/68861692-nyt-cooking/13395693-our-50-most-popular-recipes-of-all-time-so-far")
  end
end
