# frozen_string_literal: true

RSpec.describe "sallysbakingaddiction.com" do
  subject(:recipe) { scrape_cassette("com/sallysbakingaddiction", url: "https://sallysbakingaddiction.com/recipe-round-2-cake-batter-chocolate-chip-cookies/") }

  it "reads the title" do
    expect(recipe.title).to eq("Cake Batter Chocolate Chip Cookies")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 and 1/3 cup (167g) all-purpose flour (spooned & leveled)",
      "1 and 1/4 cups (190g) vanilla, yellow, or white boxed cake mix (just the DRY mix, and not the entire box)*",
      "1/2 teaspoon baking soda",
      "1/2 teaspoon salt",
      "3/4 cup (12 Tbsp; 170g) unsalted butter, softened to room temperature",
      "1/2 cup (100g) granulated sugar",
      "1/2 cup (100g) packed light brown sugar",
      "1 egg, at room temperature",
      "1 and 1/2 teaspoons pure vanilla extract",
      "1 cup (180g) chocolate chips (I use 1/2 cup white and 1/2 cup semi-sweet)",
      "1/2 cup (80g) sprinkles"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.33, unit: "cup", name: "all-purpose flour" },
      { amount: 1.25, unit: "cups", name: "vanilla, yellow, or white boxed cake mix *" },
      { amount: 0.5, unit: "teaspoon", name: "baking soda" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 0.75, unit: "cup", name: "unsalted butter, softened to room temperature" },
      { amount: 0.5, unit: "cup", name: "granulated sugar" },
      { amount: 0.5, unit: "cup", name: "packed light brown sugar" },
      { amount: 1.0, unit: nil, name: "egg, at room temperature" },
      { amount: 1.5, unit: "teaspoons", name: "pure vanilla extract" },
      { amount: 1.0, unit: "cup", name: "chocolate chips" },
      { amount: 0.5, unit: "cup", name: "sprinkles" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large bowl, sift flour, cake mix, salt, and baking soda together. Set aside.",
      "Using a hand mixer or a stand mixer fitted with paddle attachment, beat the softened butter and both sugars together on medium-high speed until light and fluffy, about 3 minutes. (Here’s a helpful tutorial if you need guidance on how to cream butter and sugar.) Add the egg and vanilla and mix on medium-high until combined, about 1 minute. Scrape down the sides and bottom of the bowl as needed. Add the flour mixture to the wet ingredients and mix on medium-low speed until just combined. Add the chocolate chips and sprinkles. Mix on low speed until the add-ins are evenly combined.",
      "Cover tightly with plastic wrap and refrigerate dough for at least 2 hours, or up to 3–4 days. This step is imperative. The dough is fairly sticky, so chilling the dough is required in order to avoid the cookies from spreading too much. If you chill longer than 2 hours, make sure you roll the cookie dough into balls after the 2-hour mark. Place dough balls on a plate, cover tightly, and store in the refrigerator until ready to bake. You may also freeze the balls at this point for up to 3 months. (Then bake as directed adding 1 minute to the bake time without thawing.)",
      "Once dough has been chilled, preheat oven to 350°F (177°C). Line large cookie sheets with parchment paper or silicone baking mats (always recommended for cookies).",
      "Scoop rounded balls of the cold dough onto the prepared baking sheets, around 1.5 Tablespoons (about 35g) of cookie dough per cookie. A medium cookie scoop is helpful for this. Shape your cookie dough balls to be “taller” than they are wide, as pictured above. Make sure to keep dough refrigerated when working in batches.",
      "Bake the cookies for 13–15 minutes, or until the edges are lightly browned. The centers will still appear very soft, but the cookies will continue to set as they cool. While the cookies are still warm, I like to press a few more chocolate chips into the tops of the cookies. This is optional and only for looks.",
      "Allow the cookies to cool on the baking sheet for 5 minutes, then transfer to a wire rack to cool completely.",
      "Cookies stay fresh covered at room temperature for up to 1 week."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large bowl, sift flour, cake mix, salt, and baking soda together. Set aside.\nUsing a hand mixer or a stand mixer fitted with paddle attachment, beat the softened butter and both sugars together on medium-high speed until light and fluffy, about 3 minutes. (Here’s a helpful tutorial if you need guidance on how to cream butter and sugar.) Add the egg and vanilla and mix on medium-high until combined, about 1 minute. Scrape down the sides and bottom of the bowl as needed. Add the flour mixture to the wet ingredients and mix on medium-low speed until just combined. Add the chocolate chips and sprinkles. Mix on low speed until the add-ins are evenly combined.\nCover tightly with plastic wrap and refrigerate dough for at least 2 hours, or up to 3–4 days. This step is imperative. The dough is fairly sticky, so chilling the dough is required in order to avoid the cookies from spreading too much. If you chill longer than 2 hours, make sure you roll the cookie dough into balls after the 2-hour mark. Place dough balls on a plate, cover tightly, and store in the refrigerator until ready to bake. You may also freeze the balls at this point for up to 3 months. (Then bake as directed adding 1 minute to the bake time without thawing.)\nOnce dough has been chilled, preheat oven to 350°F (177°C). Line large cookie sheets with parchment paper or silicone baking mats (always recommended for cookies).\nScoop rounded balls of the cold dough onto the prepared baking sheets, around 1.5 Tablespoons (about 35g) of cookie dough per cookie. A medium cookie scoop is helpful for this. Shape your cookie dough balls to be “taller” than they are wide, as pictured above. Make sure to keep dough refrigerated when working in batches.\nBake the cookies for 13–15 minutes, or until the edges are lightly browned. The centers will still appear very soft, but the cookies will continue to set as they cool. While the cookies are still warm, I like to press a few more chocolate chips into the tops of the cookies. This is optional and only for looks.\nAllow the cookies to cool on the baking sheet for 5 minutes, then transfer to a wire rack to cool completely.\nCookies stay fresh covered at room temperature for up to 1 week.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("sallysbakingaddiction.com")
    expect(recipe.canonical_url).to eq("https://sallysbakingaddiction.com/recipe-round-2-cake-batter-chocolate-chip-cookies/")
    expect(recipe.site_name).to eq("Sally's Baking")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Sally")
    expect(recipe.description).to eq("These cake batter chocolate chip cookies are a cross between delicious, soft-baked chocolate chip cookies and sprinkle-filled funfetti cake. If you like chocolate chip cookies and you like the flavor of cake batter, you will love these soft & chewy cookies!")
    expect(recipe.image).to eq("https://sallysbakingaddiction.com/wp-content/uploads/2012/12/cake-batter-chocolate-chip-cookies-photo-2-225x225.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to eq("Baking")
    expect(recipe.yields).to eq("28 servings")
    expect(recipe.total_time).to eq(180)
    expect(recipe.prep_time).to eq(135)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq(["cake batter chocolate chip cookies"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.9)
    expect(recipe.ratings_count).to eq(83)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
