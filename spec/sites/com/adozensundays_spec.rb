# frozen_string_literal: true

RSpec.describe "adozensundays.com" do
  subject(:recipe) { scrape_cassette("com/adozensundays", url: "https://adozensundays.com/nutella-stuffed-cookies/") }

  it "reads the title" do
    expect(recipe.title).to eq("Nutella Stuffed Cookies")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "15 teaspoons Nutella (approx 225g) ((3/4 cup) frozen in dollops)",
      "115 g unsalted butter, softened (1/2 cup)",
      "150 g light brown sugar (3/4 cup, packed)",
      "25 g granulated sugar (2 tbsp)",
      "1 tsp vanilla extract",
      "1 medium egg",
      "275 g plain flour (all-purpose flour) (2 1/4 cups)",
      "½ tsp bicarbonate of soda (baking soda)",
      "½ tsp salt",
      "1 tbsp cornflour (cornstarch)",
      "150 g chocolate chips (1 cup)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 15.0, unit: "teaspoons", name: "Nutella" },
      { amount: 115.0, unit: "g", name: "unsalted butter, softened" },
      { amount: 150.0, unit: "g", name: "light brown sugar" },
      { amount: 25.0, unit: "g", name: "granulated sugar" },
      { amount: 1.0, unit: "tsp", name: "vanilla extract" },
      { amount: 1.0, unit: nil, name: "medium egg" },
      { amount: 275.0, unit: "g", name: "plain flour" },
      { amount: 0.5, unit: "tsp", name: "bicarbonate of soda" },
      { amount: 0.5, unit: "tsp", name: "salt" },
      { amount: 1.0, unit: "tbsp", name: "cornflour" },
      { amount: 150.0, unit: "g", name: "chocolate chips" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Line a baking tray with parchment paper.",
      "Scoop 12 heaped teaspoons of Nutella onto the tray and freeze until firm (60 minutes).",
      "Preheat your oven to 190°C (375°F) or 170°C (340°F) Fan.",
      "In a large bowl, beat together the softened butter, brown sugar, and granulated sugar until light and fluffy (about 2 minutes).",
      "Mix in the vanilla extract and egg, beating until smooth.",
      "In a separate bowl, whisk together the flour, baking soda, salt, and cornstarch.",
      "Gradually add the dry ingredients to the wet mixture, mixing until just combined. Avoid overmixing.",
      "Stir in the chocolate chips.",
      "Divide the dough into 12 equal(ish) portions.",
      "Flatten each portion slightly into a disc shape.",
      "Place a frozen Nutella blob in the centre of each dough piece and wrap the dough around it, ensuring it is completely sealed.",
      "Roll each filled dough portion into a smooth ball.",
      "Line 2 large baking trays with parchment paper and space the cookies at least 5cm (2 inches) apart - they will probably spread a little when baking. I like to put them with the seam facing up so the Nutella doesn't ooze out.",
      "Bake for 11-13 minutes or until the edges are lightly golden. The cookies will continue to set as they cool.",
      "Let the cookies cool on the tray for 5-10 minutes, then transfer to a wire rack to cool completely.",
      "Enjoy while warm for an extra gooey center!"
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["For the Cookies:", 11]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Line a baking tray with parchment paper.\nScoop 12 heaped teaspoons of Nutella onto the tray and freeze until firm (60 minutes).\nPreheat your oven to 190°C (375°F) or 170°C (340°F) Fan.\nIn a large bowl, beat together the softened butter, brown sugar, and granulated sugar until light and fluffy (about 2 minutes).\nMix in the vanilla extract and egg, beating until smooth.\nIn a separate bowl, whisk together the flour, baking soda, salt, and cornstarch.\nGradually add the dry ingredients to the wet mixture, mixing until just combined. Avoid overmixing.\nStir in the chocolate chips.\nDivide the dough into 12 equal(ish) portions.\nFlatten each portion slightly into a disc shape.\nPlace a frozen Nutella blob in the centre of each dough piece and wrap the dough around it, ensuring it is completely sealed.\nRoll each filled dough portion into a smooth ball.\nLine 2 large baking trays with parchment paper and space the cookies at least 5cm (2 inches) apart - they will probably spread a little when baking. I like to put them with the seam facing up so the Nutella doesn't ooze out.\nBake for 11-13 minutes or until the edges are lightly golden. The cookies will continue to set as they cool.\nLet the cookies cool on the tray for 5-10 minutes, then transfer to a wire rack to cool completely.\nEnjoy while warm for an extra gooey center!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("adozensundays.com")
    expect(recipe.canonical_url).to eq("https://lifewithholly.co.uk/nutella-stuffed-cookies/")
    expect(recipe.site_name).to eq("Life with Holly")
    expect(recipe.language).to eq("en-GB")
    expect(recipe.author).to eq("lifewithholly")
    expect(recipe.description).to eq("Chocolate chip cookies, but BETTER. These Nutella stuffed cookies give you a deliciously hazelnut flavour in every bite!")
    expect(recipe.image).to eq("https://lifewithholly.co.uk/wp-content/uploads/2025/02/Nutella-Stuffed-Cookies-Life-With-Holly-5.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(91)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(11)
    expect(recipe.keywords).to eq([
      "American Style Cookies",
      "Chewy Cookies",
      "Filled Cookies",
      "Nutella Recipes",
      "Nutella Stuffed Cookies",
      "Nutella Stuffed Cookies UK"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
