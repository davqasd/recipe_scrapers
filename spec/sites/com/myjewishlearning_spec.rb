# frozen_string_literal: true

RSpec.describe "myjewishlearning.com" do
  subject(:recipe) { scrape_cassette("com/myjewishlearning", url: "https://www.myjewishlearning.com/the-nosher/foolproof-sourdough-challah-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Sourdough Challah")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "300 g (2 cups) all-purpose flour",
      "330 g (2⅓ cups) bread flour, plus a bit more as needed",
      "1½ tsp fine sea salt",
      "100 g (1½ cup) bubbly, active 100% hydration sourdough starter",
      "170 g (¾ cup) warm water",
      "3 whole eggs, at room temperature, divided",
      "1 egg yolk",
      "75 g (6 Tbsp) sugar",
      "100 g (½ cup) olive oil, plus more for coating the bowl",
      "poppy or sesame seeds, for topping (optional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 300.0, unit: "g", name: "all-purpose flour" },
      { amount: 330.0, unit: "g", name: "bread flour, plus a bit more as needed" },
      { amount: 1.5, unit: "tsp", name: "fine sea salt" },
      { amount: 100.0, unit: "g", name: "bubbly, active 100% hydration sourdough starter" },
      { amount: 170.0, unit: "g", name: "warm water" },
      { amount: 3.0, unit: nil, name: "whole eggs, at room temperature, divided" },
      { amount: 1.0, unit: nil, name: "egg yolk" },
      { amount: 75.0, unit: "g", name: "sugar" },
      { amount: 100.0, unit: "g", name: "olive oil, plus more for coating the bowl" },
      { amount: nil, unit: nil, name: "poppy or sesame seeds, for topping" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Day 1 (Morning):",
      "In a medium bowl, whisk together the all-purpose flour, bread flour and salt. Set aside.",
      "In the bowl of a stand mixer fitted with the paddle attachment, mix the starter, water, 2 whole eggs, 1 egg yolk, sugar and olive over low speed until just combined.",
      "Switch the attachment to a dough hook and keep the motor running on low. Gradually add in the flour mixture until a shaggy dough forms. You will need to scrape down the bowl a few times to help it along.",
      "Increase speed to medium and knead for 5-6 minutes, or until the dough is soft and pliable and pulls away from the sides. If the dough is sticking to the bowl, use a dough scraper to scrape it off and use your hands to form it into a ball. The dough should be soft, pliable and tacky, but not sticky. Put it back into the bowl to knead a couple of more minutes with the dough hook. If the dough is really sticky at this point, add additional bread flour a tablespoon at a time with the mixer running on low. Only add additional flour once the previous spoonful has been incorporated and you can see how the dough is transforming.",
      "Scrape dough onto a clean countertop and shape into a ball. Transfer to a well-oiled bowl. Roll it around so it’s lightly coated in oil, then cover and proof in a warm environment (between 70-85°F) until doubled in size, about 8-10 hours.",
      "Day 1 (Evening):",
      "Press down the dough to deflate, then transfer it onto a clean countertop, using a dough scraper if necessary. Divide the dough in half (about 580 g each), then divide each half into three equal pieces (about 193 g each). Cover the dough with a damp towel and rest for 15 mins to relax the gluten. Don’t skip this step.",
      "Prepare a baking sheet with parchment paper. Then, using your hands and the friction of the counter, roll out each piece of dough to an 18-inch strip (or rope). Divide the strands in half so you have two sets of three. If your dough is still shrinking back at this point, let it rest another 10 minutes before continuing.",
      "Braid each loaf of challah, sealing and tucking pieces in at each end. Place the braided dough on the prepared baking sheet, spaced equally apart. Cover with plastic wrap and a warm, damp tea towel and proof in the fridge overnight. The dough will be puffy and, when poked, will take on a slight indent that springs back slowly. To bake the same day, cover with plastic wrap and a warm, damp tea towel and proof about 2-3 hours on the counter then skip to step 10.",
      "Day 2 (Morning):",
      "Remove dough from the fridge and let it come to room temperature for 1-2 hours before baking.",
      "Preheat oven to 375°F. Whisk the remaining egg and brush it evenly over each loaf. Sprinkle with sesame or poppy seeds, if using.",
      "Bake for 25-30 minutes, or until dark brown and shiny.",
      "Transfer to a cooling rack to cool slightly before serving."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Day 1 (Morning):\nIn a medium bowl, whisk together the all-purpose flour, bread flour and salt. Set aside.\nIn the bowl of a stand mixer fitted with the paddle attachment, mix the starter, water, 2 whole eggs, 1 egg yolk, sugar and olive over low speed until just combined.\nSwitch the attachment to a dough hook and keep the motor running on low. Gradually add in the flour mixture until a shaggy dough forms. You will need to scrape down the bowl a few times to help it along.\nIncrease speed to medium and knead for 5-6 minutes, or until the dough is soft and pliable and pulls away from the sides. If the dough is sticking to the bowl, use a dough scraper to scrape it off and use your hands to form it into a ball. The dough should be soft, pliable and tacky, but not sticky. Put it back into the bowl to knead a couple of more minutes with the dough hook. If the dough is really sticky at this point, add additional bread flour a tablespoon at a time with the mixer running on low. Only add additional flour once the previous spoonful has been incorporated and you can see how the dough is transforming.\nScrape dough onto a clean countertop and shape into a ball. Transfer to a well-oiled bowl. Roll it around so it’s lightly coated in oil, then cover and proof in a warm environment (between 70-85°F) until doubled in size, about 8-10 hours.\nDay 1 (Evening):\nPress down the dough to deflate, then transfer it onto a clean countertop, using a dough scraper if necessary. Divide the dough in half (about 580 g each), then divide each half into three equal pieces (about 193 g each). Cover the dough with a damp towel and rest for 15 mins to relax the gluten. Don’t skip this step.\nPrepare a baking sheet with parchment paper. Then, using your hands and the friction of the counter, roll out each piece of dough to an 18-inch strip (or rope). Divide the strands in half so you have two sets of three. If your dough is still shrinking back at this point, let it rest another 10 minutes before continuing.\nBraid each loaf of challah, sealing and tucking pieces in at each end. Place the braided dough on the prepared baking sheet, spaced equally apart. Cover with plastic wrap and a warm, damp tea towel and proof in the fridge overnight. The dough will be puffy and, when poked, will take on a slight indent that springs back slowly. To bake the same day, cover with plastic wrap and a warm, damp tea towel and proof about 2-3 hours on the counter then skip to step 10.\nDay 2 (Morning):\nRemove dough from the fridge and let it come to room temperature for 1-2 hours before baking.\nPreheat oven to 375°F. Whisk the remaining egg and brush it evenly over each loaf. Sprinkle with sesame or poppy seeds, if using.\nBake for 25-30 minutes, or until dark brown and shiny.\nTransfer to a cooling rack to cool slightly before serving.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("myjewishlearning.com")
    expect(recipe.canonical_url).to eq("https://www.myjewishlearning.com/the-nosher/foolproof-sourdough-challah-recipe/")
    expect(recipe.site_name).to eq("My Jewish Learning")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Kris Osborne")
    expect(recipe.description).to eq("Perfect if you already have a starter sitting in your fridge-- try this tangy challah!")
    expect(recipe.image).to eq("https://www.myjewishlearning.com/wp-content/uploads/2023/07/Sourdough-Challah-KO-1-1-225x225.jpg")
    expect(recipe.category).to eq("Bread")
    expect(recipe.cuisine).to eq("Jewish")
    expect(recipe.cooking_method).to eq("Baking")
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(1290)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.7)
    expect(recipe.ratings_count).to eq(6)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#q")
  end
end
