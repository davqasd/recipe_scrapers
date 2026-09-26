# frozen_string_literal: true

RSpec.describe "cakemehometonight.com" do
  subject(:recipe) { scrape_cassette("com/cakemehometonight", url: "https://cakemehometonight.com/brownie-cookies/") }

  it "reads the title" do
    expect(recipe.title).to eq("Brownie Cookies")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup semisweet chocolate chips",
      "6 tbsp unsalted butter",
      "½ cup light brown sugar",
      "½ cup granulated sugar",
      "2 eggs (room temperature)",
      "1 tsp vanilla extract",
      "½ tsp instant espresso powder (optional)",
      "¾ cup all-purpose flour",
      "¼ cup dark cocoa powder",
      "½ tsp salt",
      "flaky sea salt (optional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "semisweet chocolate chips" },
      { amount: 6.0, unit: "tbsp", name: "unsalted butter" },
      { amount: 0.5, unit: "cup", name: "light brown sugar" },
      { amount: 0.5, unit: "cup", name: "granulated sugar" },
      { amount: 2.0, unit: nil, name: "eggs" },
      { amount: 1.0, unit: "tsp", name: "vanilla extract" },
      { amount: 0.5, unit: "tsp", name: "instant espresso powder" },
      { amount: 0.75, unit: "cup", name: "all-purpose flour" },
      { amount: 0.25, unit: "cup", name: "dark cocoa powder" },
      { amount: 0.5, unit: "tsp", name: "salt" },
      { amount: nil, unit: nil, name: "flaky sea salt" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 350℉ (177℃). Prepare baking sheet pans with silicone baking mats or parchment paper.",
      "In a microwave-safe bowl, combine the semisweet chocolate chips and unsalted butter. Heat in the microwave in 30 second intervals, stirring in between each interval until the chocolate is melted and smooth. Set aside to cool while completing the next step.",
      "In the bowl of a stand mixer fitted with a whisk attachment or in a large mixing bowl with an electric hand mixer, whip the brown sugar, granulated sugar, and eggs for about 3 minutes until light and pale. Add in the vanilla extract and instant espresso powder and mix on low until combined.",
      "While mixing on low speed, slowly pour in the melted chocolate to temper the egg mixture. Continue to mix on low until the chocolate is well combined.",
      "If you are using a stand mixer, switch to a paddle attachment. Add the all-purpose flour, dark cocoa powder, and salt. Mix on low speed just until the brownie batter is combined and smooth. Scrape the sides and bottom of the bowl. Do not over mix the brownie batter.",
      "Portion the brownie batter with a large cookie scoop (3 tablespoons) and place on the prepared baking sheet pans allowing room for spreading. Sprinkle with flaky sea salt before baking, if desired.",
      "Bake the cookies for approximately 13 to 14 minutes until the edges of the cookies are set and the centers are soft. Cool the cookies on the pan for 5 minutes and then transfer to a wire rack to cool completely."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 350℉ (177℃). Prepare baking sheet pans with silicone baking mats or parchment paper.\nIn a microwave-safe bowl, combine the semisweet chocolate chips and unsalted butter. Heat in the microwave in 30 second intervals, stirring in between each interval until the chocolate is melted and smooth. Set aside to cool while completing the next step.\nIn the bowl of a stand mixer fitted with a whisk attachment or in a large mixing bowl with an electric hand mixer, whip the brown sugar, granulated sugar, and eggs for about 3 minutes until light and pale. Add in the vanilla extract and instant espresso powder and mix on low until combined.\nWhile mixing on low speed, slowly pour in the melted chocolate to temper the egg mixture. Continue to mix on low until the chocolate is well combined.\nIf you are using a stand mixer, switch to a paddle attachment. Add the all-purpose flour, dark cocoa powder, and salt. Mix on low speed just until the brownie batter is combined and smooth. Scrape the sides and bottom of the bowl. Do not over mix the brownie batter.\nPortion the brownie batter with a large cookie scoop (3 tablespoons) and place on the prepared baking sheet pans allowing room for spreading. Sprinkle with flaky sea salt before baking, if desired.\nBake the cookies for approximately 13 to 14 minutes until the edges of the cookies are set and the centers are soft. Cool the cookies on the pan for 5 minutes and then transfer to a wire rack to cool completely.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cakemehometonight.com")
    expect(recipe.canonical_url).to eq("https://cakemehometonight.com/brownie-cookies/")
    expect(recipe.site_name).to eq("Cake Me Home Tonight")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Courtney")
    expect(recipe.description).to eq("If a brownie and a cookie had a baby, you would get these delicious brownie cookies. The chocolate brownie cookies have a crackly top and are fudgy and chewy on the inside. No need for brownie mix, this is the best brownie cookie recipe if you have a chocolate craving!")
    expect(recipe.image).to eq("https://cakemehometonight.com/wp-content/uploads/2023/01/Brownie-Cookies-09.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("13 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(13)
    expect(recipe.keywords).to eq(%w[brownie chocolate cookie])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.23)
    expect(recipe.ratings_count).to eq(31)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
