# frozen_string_literal: true

RSpec.describe "momontimeout.com" do
  subject(:recipe) { scrape_cassette("com/momontimeout", url: "https://www.momontimeout.com/giant-cinnamon-roll-cake-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Giant Cinnamon Roll Cake")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1¼ cups whole milk (warmed, 105°F to 110°F)",
      "2¼ teaspoons instant yeast",
      "1 large egg (room temperature)",
      "¼ cup granulated sugar",
      "3 tablespoons unsalted butter (melted)",
      "1 teaspoon salt",
      "4 cups bread flour (or all purpose flour, spooned and leveled, plus extra)",
      "¾ cup unsalted butter (softened)",
      "¾ cup sugar (use white, light or dark brown )",
      "1½ tablespoons ground cinnamon",
      "4 ounces cream cheese",
      "3 tablespoons butter (softened)",
      "2 tablespoons whole milk",
      "1 teaspoon vanilla bean paste (or vanilla extract)",
      "1 cup powdered sugar (sifted)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.25, unit: "cups", name: "whole milk" },
      { amount: 2.25, unit: "teaspoons", name: "instant yeast" },
      { amount: 1.0, unit: nil, name: "large egg" },
      { amount: 0.25, unit: "cup", name: "granulated sugar" },
      { amount: 3.0, unit: "tablespoons", name: "unsalted butter" },
      { amount: 1.0, unit: "teaspoon", name: "salt" },
      { amount: 4.0, unit: "cups", name: "bread flour" },
      { amount: 0.75, unit: "cup", name: "unsalted butter" },
      { amount: 0.75, unit: "cup", name: "sugar" },
      { amount: 1.5, unit: "tablespoons", name: "ground cinnamon" },
      { amount: 4.0, unit: "ounces", name: "cream cheese" },
      { amount: 3.0, unit: "tablespoons", name: "butter" },
      { amount: 2.0, unit: "tablespoons", name: "whole milk" },
      { amount: 1.0, unit: "teaspoon", name: "vanilla bean paste" },
      { amount: 1.0, unit: "cup", name: "powdered sugar" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Prepare the Dough",
      "Warm the milk in the microwave for about 1 minute then stir to disperse any hot spots (see notes). Aim for between 105°F and 110°F.",
      "In the large bowl of a stand mixer, with the dough hook attached, add the warm milk, yeast, egg, granulated sugar and melted butter. Use a handheld whisk to thoroughly combine the ingredients then leave uncovered for 5 minutes.",
      "Add the salt and flour to the mixing bowl and use a wooden spoon or danish whisk to mix the ingredients together until a shaggy dough has formed.",
      "Place the mixing bowl on the stand mixer and mix with the dough hook on the lowest speed for 3 minutes. After this time the dough should look smooth and elastic. If you touch it with a clean dry finger the dough should feel tacky but should not stick to your finger. If any dough sticks add more flour a tablespoon at a time until it doesn’t stick. (This dough can also be made by hand - see notes.)",
      "Transfer the dough into a lightly oiled bowl and cover with plastic wrap. Let rise in a warm location for about an hour, or until the dough has doubled in size.",
      "For the Filling",
      "While the dough is rising, make the filling. Placed the softened butter, sugar and cinnamon into a small bowl and mix thoroughly until uniform in color. Set aside for now.",
      "Assembly",
      "Lightly grease and line a 9 inch springform pan with parchment paper just on the bottom. Set aside.",
      "Once the dough has doubled in size, punch it down in the bowl then lightly flour a surface and turn the dough out on to it.",
      "Roll the dough into a rectangle of about 20 inches by 12 inches.",
      "Spread the filling evenly across the entire surface of the rectangle.",
      "Use a sharp knife or pizza wheel to vertically cut the dough rectangle into 4 even strips. (Refer to images in post if needed.)",
      "Roll the first strip into a spiral then place the rolled spiral on top of the second strip and roll it again. Repeat for the remaining two strips until you have one giant cinnamon roll.",
      "Place the giant roll into the prepared springform pan (or similar), cover and leave somewhere warm for 30 minutes.",
      "Preheat the oven to 350°F.",
      "The cinnamon roll will have puffed up in its baking pan. The middle will keep popping out and that’s normal. Use the palm of your hand or spatula to gently press it back in then place the pan in the center of the preheated oven.",
      "Bake for 30 minutes, cover with foil and bake for another 15 minutes. The middle will have probably popped out again in which case, use a wooden spoon to press it down before adding the foil.",
      "Remove the cake from the oven when it is golden brown and feels dry and hard when touched on the edges. Leave to cool in the pan for 10 minutes.",
      "Prepare the Glaze",
      "In a medium sized mixing bowl, add all the cream cheese glaze ingredients and mix thoroughly until smooth and combined. The cream cheese glaze will be a thinner and runnier consistency than that of typical cream cheese frosting. If you want to thin it out you can add a little extra milk. If you want to thicken, add more powdered sugar.",
      "After the cake has cooled for 10 minutes, pour the cream cheese glaze all over the top.",
      "Slice, serve and enjoy while still warm!"
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["Dough", 7],
        ["Filling", 3],
        ["Glaze", 5]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Prepare the Dough\nWarm the milk in the microwave for about 1 minute then stir to disperse any hot spots (see notes). Aim for between 105°F and 110°F.\nIn the large bowl of a stand mixer, with the dough hook attached, add the warm milk, yeast, egg, granulated sugar and melted butter. Use a handheld whisk to thoroughly combine the ingredients then leave uncovered for 5 minutes.\nAdd the salt and flour to the mixing bowl and use a wooden spoon or danish whisk to mix the ingredients together until a shaggy dough has formed.\nPlace the mixing bowl on the stand mixer and mix with the dough hook on the lowest speed for 3 minutes. After this time the dough should look smooth and elastic. If you touch it with a clean dry finger the dough should feel tacky but should not stick to your finger. If any dough sticks add more flour a tablespoon at a time until it doesn’t stick. (This dough can also be made by hand - see notes.)\nTransfer the dough into a lightly oiled bowl and cover with plastic wrap. Let rise in a warm location for about an hour, or until the dough has doubled in size.\nFor the Filling\nWhile the dough is rising, make the filling. Placed the softened butter, sugar and cinnamon into a small bowl and mix thoroughly until uniform in color. Set aside for now.\nAssembly\nLightly grease and line a 9 inch springform pan with parchment paper just on the bottom. Set aside.\nOnce the dough has doubled in size, punch it down in the bowl then lightly flour a surface and turn the dough out on to it.\nRoll the dough into a rectangle of about 20 inches by 12 inches.\nSpread the filling evenly across the entire surface of the rectangle.\nUse a sharp knife or pizza wheel to vertically cut the dough rectangle into 4 even strips. (Refer to images in post if needed.)\nRoll the first strip into a spiral then place the rolled spiral on top of the second strip and roll it again. Repeat for the remaining two strips until you have one giant cinnamon roll.\nPlace the giant roll into the prepared springform pan (or similar), cover and leave somewhere warm for 30 minutes.\nPreheat the oven to 350°F.\nThe cinnamon roll will have puffed up in its baking pan. The middle will keep popping out and that’s normal. Use the palm of your hand or spatula to gently press it back in then place the pan in the center of the preheated oven.\nBake for 30 minutes, cover with foil and bake for another 15 minutes. The middle will have probably popped out again in which case, use a wooden spoon to press it down before adding the foil.\nRemove the cake from the oven when it is golden brown and feels dry and hard when touched on the edges. Leave to cool in the pan for 10 minutes.\nPrepare the Glaze\nIn a medium sized mixing bowl, add all the cream cheese glaze ingredients and mix thoroughly until smooth and combined. The cream cheese glaze will be a thinner and runnier consistency than that of typical cream cheese frosting. If you want to thin it out you can add a little extra milk. If you want to thicken, add more powdered sugar.\nAfter the cake has cooled for 10 minutes, pour the cream cheese glaze all over the top.\nSlice, serve and enjoy while still warm!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("momontimeout.com")
    expect(recipe.canonical_url).to eq("https://www.momontimeout.com/giant-cinnamon-roll-cake-recipe/")
    expect(recipe.site_name).to eq("Mom On Timeout")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Trish - Mom On Timeout")
    expect(recipe.description).to eq("This impressive giant Cinnamon Roll Cake is a delightful twist on classic cinnamon rolls that transforms your favorite breakfast treat into a stunning cake that's perfect for any occasion. Soft and fluffy with a gooey center and vanilla bean cream cheese glaze, this recipe is sure to be a hit at any gathering with the perfect blend of sweetness, spice and everything nice!")
    expect(recipe.image).to eq("https://www.momontimeout.com/wp-content/uploads/2024/03/giant-cinnamon-roll-square.jpeg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(25)
    expect(recipe.cook_time).to eq(45)
    expect(recipe.keywords).to eq(["cinnamon roll cake", "cinnamon roll cake recipe", "giant cinnamon roll"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "709 kcal",
      "carbohydrateContent" => "91 g",
      "proteinContent" => "12 g",
      "fatContent" => "34 g",
      "saturatedFatContent" => "20 g",
      "transFatContent" => "1 g",
      "cholesterolContent" => "111 mg",
      "sodiumContent" => "400 mg",
      "fiberContent" => "3 g",
      "sugarContent" => "43 g",
      "unsaturatedFatContent" => "11 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 709.0 },
      { name: "carbohydrateContent", unit: "g", amount: 91.0 },
      { name: "proteinContent", unit: "g", amount: 12.0 },
      { name: "fatContent", unit: "g", amount: 34.0 },
      { name: "saturatedFatContent", unit: "g", amount: 20.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 111.0 },
      { name: "sodiumContent", unit: "mg", amount: 400.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "sugarContent", unit: "g", amount: 43.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 11.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#")
  end
end
