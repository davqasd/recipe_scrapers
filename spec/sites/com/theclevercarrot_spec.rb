# frozen_string_literal: true

RSpec.describe "theclevercarrot.com" do
  subject(:recipe) { scrape_cassette("com/theclevercarrot", url: "https://www.theclevercarrot.com/2017/12/how-to-make-sourdough-cinnamon-rolls-step-by-step-guide/") }

  it "reads the title" do
    expect(recipe.title).to eq("Soft & Gooey Sourdough Cinnamon Rolls")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "160 g (2/3 cup) milk, whole or 2%",
      "28 g (2 tbsp) unsalted butter, melted (see notes below for variation)",
      "1 large egg",
      "100 g (1/2 cup) bubbly, active sourdough starter",
      "24 g (2 tbsp) granulated sugar",
      "300 g (2½ cups) King Arthur all-purpose flour",
      "5 g (1 tsp) fine sea salt",
      "cooking spray or oil, for coating",
      "28 g (2 tbsp) unsalted butter (see notes below for variation)",
      "100 g (1/2 cup) granulated sugar",
      "3 tsp. ground cinnamon",
      "1 level tbsp. flour",
      "2 tbsp unsalted butter, softened",
      "⅓ cup whipped cream cheese, room temperature",
      "¼- 1/2 cup powdered sugar, sifted (add more if you like it sweet!)",
      "1-2 tbsp milk",
      "For a richer dough, increase the butter to 115 (8 tbsp) and use 360 g (3 cups) flour total. The texture is incredible.",
      "Make sure the melted butter and milk mixture has cooled slightly before making the dough. If it’s too hot, the dough will become incredibly sticky like cake batter (I’ve experienced this many times). If this happens to you, don’t worry- wait for the dough to cool down before adding more flour, if needed.",
      "Recent recipe update: to prevent the cinnamon sugar filling from leaking while the rolls bake, instead of using 28g (2 tbsp) of melted butter, combine 84 g (6 tbsp) softened butter with the rest of the cinnamon-sugar filling ingredients listed above."
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 160.0, unit: "g", name: "milk, whole or 2%" },
      { amount: 28.0, unit: "g", name: "unsalted butter, melted" },
      { amount: 1.0, unit: nil, name: "large egg" },
      { amount: 100.0, unit: "g", name: "bubbly, active sourdough starter" },
      { amount: 24.0, unit: "g", name: "granulated sugar" },
      { amount: 300.0, unit: "g", name: "King Arthur all-purpose flour" },
      { amount: 5.0, unit: "g", name: "fine sea salt" },
      { amount: nil, unit: nil, name: "cooking spray or oil, for coating" },
      { amount: 28.0, unit: "g", name: "unsalted butter" },
      { amount: 100.0, unit: "g", name: "granulated sugar" },
      { amount: 3.0, unit: "tsp", name: "ground cinnamon" },
      { amount: 1.0, unit: "tbsp", name: "flour" },
      { amount: 2.0, unit: "tbsp", name: "unsalted butter, softened" },
      { amount: 0.33, unit: "cup", name: "whipped cream cheese, room temperature" },
      { amount: 0.25, unit: "cup", name: "powdered sugar, sifted" },
      { amount: 1.0, unit: "tbsp", name: "milk" },
      { amount: nil, unit: nil, name: "For a richer dough, increase the butter to 115 and use 360 g flour total. The texture is incredible." },
      { amount: nil, unit: nil, name: "Make sure the melted butter and milk mixture has cooled slightly before making the dough. If it’s too hot, the dough will become incredibly sticky like cake batter. If this happens to you, don’t worry- wait for the dough to cool down before adding more flour, if needed." },
      { amount: nil, unit: nil, name: "Recent recipe update: to prevent the cinnamon sugar filling from leaking while the rolls bake, instead of using 28g of melted butter, combine 84 g softened butter with the rest of the cinnamon-sugar filling ingredients listed above." }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Baker's Schedule",
      "Overnight Option",
      "Make the dough in the evening and let rise overnight. The following morning, roll, cut and shape the dough. Rest for 1-2 hours (second rise) before baking.",
      "As an alternative, after resting for 1 hour, cover the dough and chill until ready to use. Rest at room temperature before baking. The dough should be plump and puffy before baking.",
      "Make-Ahead Option (Freeze): Place the cut & shaped cinnamon rolls into a parchment lined 9-inch springform pan. Cover with two layers of plastic wrap. Freeze until ready to use. The night before baking, remove the old plastic wrap and replace with fresh wrap (this prevents any condensation from dripping onto the rolls). Defrost overnight, about 10-12 hrs. at room temperature, approximately 67 F. Bake the following morning as directed.",
      "Make the Dough",
      "In the evening: Combine the melted butter and milk in a small bowl. Cool slightly before using.",
      "Add the egg, sourdough starter, and sugar to the bowl of a stand mixer fitted with the paddle attachment. Mix to combine. With the machine running, slowly pour in the milk mixture. Add the flour and salt. Continue mixing until a rough, sticky dough forms, about 1 minute. Scrape down the sides of the bowl. Cover with a damp towel and let rest for 30 minutes.",
      "After the dough has rested, switch to the dough hook. Knead on medium-low speed for 6-8 minutes (I use #2 or #3 on my stand mixer). The dough should feel soft, supple and pull away from the sides of the bowl when ready. If it’s too sticky add a small bit of flour.",
      "Bulk Rise",
      "Transfer the dough to a medium-size bowl coated in butter. Cover with plastic wrap. Let rise overnight until double in size, about 8-12 + hrs. @ 67-68 F, depending on temperature.",
      "Stretch and Fold the Dough (optional step): about 30 minutes- 1 hr. into the bulk rise stretch and fold the dough: grab a portion of the dough and stretch it upward. Fold it over toward the center of the bowl. Give the bowl a 1/4 turn; stretch and fold the dough again. Continue this technique until you’ve come full circle around the bowl (4 folds total). For video guidance, click here. This optional step will increase the overall volume of the rolls and aerate the dough.",
      "Roll the Dough",
      "In the morning: Line a 9-inch springform pan with parchment paper. I like to scrunch the paper into a ball first, open it up, and then line the inside with enough excess to hang over the sides for easy removal. It tends to fit better this way.",
      "Lightly oil and flour your countertop to prevent sticking. Coax the dough out of the bowl. Gently pat into a rough rectangle. Let rest for 10 minutes for easier rolling.",
      "Dust the dough (and your rolling pin) with flour. Roll the dough into a 16 x 12-ish rectangle using a tape measure for accuracy. If the dough resists, let rest for 5-10 minutes and try again.",
      "Make the Cinnamon-Sugar Filling",
      "If using the softened butter variation (listed in the notes above): add 84 g (6 tbsp) softened butter to a small bowl. Mix with the sugar, cinnamon and flour. With an offset spatula, spread onto the dough, leaving a 1/2-inch border around the edges.",
      "If using the melted butter version: brush the entire surface of the dough, including the top, bottom and sides with 28 g (2 tbsp) melted butter. Use all of it. Combine the sugar, cinnamon and flour in a bowl. Sprinkle the mixture onto the dough leaving a 1/2-inch border around the edges. Smooth it out with your hands until it looks wet and sandy.",
      "Shape & Cut the Dough",
      "Starting on the long side of the dough (16-inch), roll it into a log pressing down gently as you go. Take your time with this step. The log needs to be tight so the swirls stay in tact. You should end up seam side down. TIP: if the dough starts to get sticky from the heat of your hands, lightly oil or flour your fingertips, take a deep breath and try again.",
      "Cut the dough into 2-inch sections using a oiled knife or bench scraper. I lightly “mark” the dough first to make sure each piece is roughly the same size.",
      "Second Rise",
      "Place the rolls into the lined pan and let rest for 1- 2 hours, or until the dough puffs up. Alternatively, if you’d like to chill or freeze the rolls, please refer to the “Make-Ahead” option in the Baker’s Schedule at the top of this recipe.",
      "Bake the Cinnamon Rolls",
      "Preheat oven to 350 F. Bake the dough onto the center rack and bake for 35-40 minutes (check at the 30 minute mark). The tops should turn light golden brown when ready.",
      "Remove from the oven and cool in the pan for 15 minutes. This helps the butter to absorb back into the dough. Then lift up the rolls, while still on the parchment paper, and transfer to a wire rack.",
      "Make the Glaze",
      "While the rolls are baking or cooling make the glaze. Add softened butter, whipped cream cheese and sifted powdered sugar to the bowl of a stand mixer. Beat until smooth, thinning out the consistency with a little milk as needed. The ingredients must be soft and at room temperature for best results.",
      "To serve, top the rolls with some of the glaze or lightly dust with powdered sugar. These rolls are best enjoyed slightly warm on the same day they are baked."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["Sweet Dough", 8],
        ["Cinnamon-Sugar Filling", 4],
        ["Glaze", 4],
        ["Notes, Tips & Variations", 3]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Baker's Schedule\nOvernight Option\nMake the dough in the evening and let rise overnight. The following morning, roll, cut and shape the dough. Rest for 1-2 hours (second rise) before baking.\nAs an alternative, after resting for 1 hour, cover the dough and chill until ready to use. Rest at room temperature before baking. The dough should be plump and puffy before baking.\nMake-Ahead Option (Freeze): Place the cut & shaped cinnamon rolls into a parchment lined 9-inch springform pan. Cover with two layers of plastic wrap. Freeze until ready to use. The night before baking, remove the old plastic wrap and replace with fresh wrap (this prevents any condensation from dripping onto the rolls). Defrost overnight, about 10-12 hrs. at room temperature, approximately 67 F. Bake the following morning as directed.\nMake the Dough\nIn the evening: Combine the melted butter and milk in a small bowl. Cool slightly before using.\nAdd the egg, sourdough starter, and sugar to the bowl of a stand mixer fitted with the paddle attachment. Mix to combine. With the machine running, slowly pour in the milk mixture. Add the flour and salt. Continue mixing until a rough, sticky dough forms, about 1 minute. Scrape down the sides of the bowl. Cover with a damp towel and let rest for 30 minutes.\nAfter the dough has rested, switch to the dough hook. Knead on medium-low speed for 6-8 minutes (I use #2 or #3 on my stand mixer). The dough should feel soft, supple and pull away from the sides of the bowl when ready. If it’s too sticky add a small bit of flour.\nBulk Rise\nTransfer the dough to a medium-size bowl coated in butter. Cover with plastic wrap. Let rise overnight until double in size, about 8-12 + hrs. @ 67-68 F, depending on temperature.\nStretch and Fold the Dough (optional step): about 30 minutes- 1 hr. into the bulk rise stretch and fold the dough: grab a portion of the dough and stretch it upward. Fold it over toward the center of the bowl. Give the bowl a 1/4 turn; stretch and fold the dough again. Continue this technique until you’ve come full circle around the bowl (4 folds total). For video guidance, click here. This optional step will increase the overall volume of the rolls and aerate the dough.\nRoll the Dough\nIn the morning: Line a 9-inch springform pan with parchment paper. I like to scrunch the paper into a ball first, open it up, and then line the inside with enough excess to hang over the sides for easy removal. It tends to fit better this way.\nLightly oil and flour your countertop to prevent sticking. Coax the dough out of the bowl. Gently pat into a rough rectangle. Let rest for 10 minutes for easier rolling.\nDust the dough (and your rolling pin) with flour. Roll the dough into a 16 x 12-ish rectangle using a tape measure for accuracy. If the dough resists, let rest for 5-10 minutes and try again.\nMake the Cinnamon-Sugar Filling\nIf using the softened butter variation (listed in the notes above): add 84 g (6 tbsp) softened butter to a small bowl. Mix with the sugar, cinnamon and flour. With an offset spatula, spread onto the dough, leaving a 1/2-inch border around the edges.\nIf using the melted butter version: brush the entire surface of the dough, including the top, bottom and sides with 28 g (2 tbsp) melted butter. Use all of it. Combine the sugar, cinnamon and flour in a bowl. Sprinkle the mixture onto the dough leaving a 1/2-inch border around the edges. Smooth it out with your hands until it looks wet and sandy.\nShape & Cut the Dough\nStarting on the long side of the dough (16-inch), roll it into a log pressing down gently as you go. Take your time with this step. The log needs to be tight so the swirls stay in tact. You should end up seam side down. TIP: if the dough starts to get sticky from the heat of your hands, lightly oil or flour your fingertips, take a deep breath and try again.\nCut the dough into 2-inch sections using a oiled knife or bench scraper. I lightly “mark” the dough first to make sure each piece is roughly the same size.\nSecond Rise\nPlace the rolls into the lined pan and let rest for 1- 2 hours, or until the dough puffs up. Alternatively, if you’d like to chill or freeze the rolls, please refer to the “Make-Ahead” option in the Baker’s Schedule at the top of this recipe.\nBake the Cinnamon Rolls\nPreheat oven to 350 F. Bake the dough onto the center rack and bake for 35-40 minutes (check at the 30 minute mark). The tops should turn light golden brown when ready.\nRemove from the oven and cool in the pan for 15 minutes. This helps the butter to absorb back into the dough. Then lift up the rolls, while still on the parchment paper, and transfer to a wire rack.\nMake the Glaze\nWhile the rolls are baking or cooling make the glaze. Add softened butter, whipped cream cheese and sifted powdered sugar to the bowl of a stand mixer. Beat until smooth, thinning out the consistency with a little milk as needed. The ingredients must be soft and at room temperature for best results.\nTo serve, top the rolls with some of the glaze or lightly dust with powdered sugar. These rolls are best enjoyed slightly warm on the same day they are baked.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("theclevercarrot.com")
    expect(recipe.canonical_url).to eq("https://www.theclevercarrot.com/2017/12/how-to-make-sourdough-cinnamon-rolls-step-by-step-guide/")
    expect(recipe.site_name).to eq("The Clever Carrot")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Emilie Raffa")
    expect(recipe.description).to eq("These soft, overnight sourdough cinnamon rolls are perfect for breakfast, brunch, or holiday treat! Made with a luscious sweet dough and a not-too-sweet cinnamon filing, they are guaranteed to be a huge hit.")
    expect(recipe.image).to eq("https://www.theclevercarrot.com/wp-content/uploads/2017/12/How-to-Make-Sourdough-Cinnamon-Rolls-a-step-by-step-guide-13-225x225.jpg")
    expect(recipe.category).to eq("Sourdough Bread Recipes")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to eq("Oven-Baked")
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(930)
    expect(recipe.prep_time).to eq(900)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq([
      "sourdough",
      "sourdough recipes",
      "sourdough cinnamon rolls",
      "cinnamon rolls",
      "best sourdough cinnamon rolls",
      "sourdough bread",
      "sourdough starter"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["VegetarianDiet"])
    expect(recipe.ratings).to eq(4.9)
    expect(recipe.ratings_count).to eq(606)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://theclevercarrot.myflodesk.com/newsletter")
  end
end
