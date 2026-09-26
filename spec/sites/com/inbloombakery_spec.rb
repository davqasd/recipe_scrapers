# frozen_string_literal: true

RSpec.describe "inbloombakery.com" do
  subject(:recipe) { scrape_cassette("com/inbloombakery", url: "https://inbloombakery.com/the-best-cinnamon-rolls-ever/") }

  it "reads the title" do
    expect(recipe.title).to eq("The Best Cinnamon Rolls Ever")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 1/4 cups (300 ml) whole milk, warmed to about 110 degrees",
      "2 1/4 tsp active dry yeast",
      "1 tsp granulated white sugar (to bloom the yeast)",
      "4 3/4 cups (593 g) all-purpose flour, spooned and leveled",
      "1 1/2 tsp salt",
      "2 tbsp (25 g) granulated white sugar",
      "2 eggs, whisked",
      "1 tbsp vanilla",
      "1/2 cup (112 g) unsalted butter, very softened",
      "1/2 cup (112 g) unsalted butter, very softened",
      "1 cup (220 g) light brown sugar, packed",
      "2 tsp cinnamon",
      "1/3 cup (116 g) honey",
      "1/2 tbsp vanilla",
      "3 tbsp (45 ml) heavy cream",
      "1/4 tsp salt",
      "1/2 cup (112 g) unsalted butter, very softened",
      "1 cup (220 g) light brown sugar, packed",
      "2 tbsp cinnamon",
      "1/4 tsp salt",
      "1/4 cup (60 ml) heavy cream (for pouring in between the rolls)",
      "6 tbsp (84 g) unsalted butter, very softened",
      "6 oz (170 g) cream cheese, cold",
      "3/4 cup (97 g) powdered sugar",
      "1/2 tbsp vanilla"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.25, unit: "cups", name: "whole milk, warmed to about 110 degrees" },
      { amount: 2.25, unit: "tsp", name: "active dry yeast" },
      { amount: 1.0, unit: "tsp", name: "granulated white sugar" },
      { amount: 4.75, unit: "cups", name: "all-purpose flour, spooned and leveled" },
      { amount: 1.5, unit: "tsp", name: "salt" },
      { amount: 2.0, unit: "tbsp", name: "granulated white sugar" },
      { amount: 2.0, unit: nil, name: "eggs, whisked" },
      { amount: 1.0, unit: "tbsp", name: "vanilla" },
      { amount: 0.5, unit: "cup", name: "unsalted butter, very softened" },
      { amount: 0.5, unit: "cup", name: "unsalted butter, very softened" },
      { amount: 1.0, unit: "cup", name: "light brown sugar, packed" },
      { amount: 2.0, unit: "tsp", name: "cinnamon" },
      { amount: 0.33, unit: "cup", name: "honey" },
      { amount: 0.5, unit: "tbsp", name: "vanilla" },
      { amount: 3.0, unit: "tbsp", name: "heavy cream" },
      { amount: 0.25, unit: "tsp", name: "salt" },
      { amount: 0.5, unit: "cup", name: "unsalted butter, very softened" },
      { amount: 1.0, unit: "cup", name: "light brown sugar, packed" },
      { amount: 2.0, unit: "tbsp", name: "cinnamon" },
      { amount: 0.25, unit: "tsp", name: "salt" },
      { amount: 0.25, unit: "cup", name: "heavy cream" },
      { amount: 6.0, unit: "tbsp", name: "unsalted butter, very softened" },
      { amount: 6.0, unit: "oz", name: "cream cheese, cold" },
      { amount: 0.75, unit: "cup", name: "powdered sugar" },
      { amount: 0.5, unit: "tbsp", name: "vanilla" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "For the Dough",
      "To start, bloom your yeast. Mix your active dry yeast, sugar, and warm milk together and let sit for 10 minutes until foamy on top.",
      "Next, in a large bowl of a stand mixer with a whisk attachment, mix flour, salt and sugar together.",
      "To the dry ingredients add the whisked eggs, vanilla and softened butter and mix.",
      "Add in the yeast mixture and mix until everything is blended. Switch to a dough hook and knead on medium speed for 7-10 minutes until the dough pulls away from the edges of the bowl, forms a ball and springs back when pressed.",
      "Form the dough into a ball. Place the dough in a large, greased bowl. Cover with plastic wrap or a kitchen towel and place in a warm place to rise, (outside or a cold oven with the light on works well for this), for 1- 1 ½ hours, or until the dough doubles in size.",
      "For the Cinnamon Caramel Sauce",
      "While the dough rises, make the sticky caramel sauce for the bottoms of the rolls, by mixing the butter, brown sugar, cinnamon, honey, vanilla, heavy cream and salt together in a medium bowl.",
      "Grease a 9x13 inch casserole dish. Spread the mixture evenly over the bottom of the pan.",
      "For the Cinnamon Filling",
      "While the dough rises, also make the filling by mixing the butter, brown sugar, cinnamon and salt together in a small bowl. (If the filling is too firm and not spreadable, add heavy cream a tsp at a time until it's easily spreadable.)",
      "Assembling and Baking the Cinnamon Rolls",
      "Once the dough has had a chance to rise, remove from bowl, punch dough to release the air, and roll out on a lightly floured surface. Roll the dough into about an 18 x 12 inch rectangle. It should be about 1/4 inch thick.",
      "Sprinkle the cinnamon sugar filling over the dough and spread it evenly with an offset spatula.",
      "Roll up the dough tightly into a long log shape starting from the end closest to you. Cut of a bit off the ends to make the log even. Cut 12 rolls about 1 1/2 inches wide using unflavored floss or a very sharp knife.",
      "Place the rolls in the prepared casserole dish with the cinnamon caramel sauce mixture and pour room temperature heavy cream in between each roll. Cover them with plastic wrap and let them proof in a warm spot for about an hour, or until they have doubled in size.",
      "Preheat the oven to 350 degrees about 15 minutes before the rolls are done proofing.",
      "Once the rolls have completed their second rise, bake them for 29-32 minutes until golden brown. (30 minutes is usually perfect!)(Cover with aluminum foil for the last 5 minutes if they're getting too brown.)",
      "For the Cream Cheese Frosting",
      "While they bake, make the cream cheese frosting by adding the softened butter to a medium bowl and mixing it on high speed with an electric mixer until pale and fluffy.",
      "Add in the cream cheese and mix until combined on medium speed.",
      "Sift the powdered sugar into the mixture a little at a time and mix on low speed until all is combined.(You can add more powdered sugar if you want the frosting to be sweeter.)",
      "Then add in the vanilla and combine on medium speed until the frosting is smooth.",
      "Let the rolls cool for 10 minutes, then cover the warm rolls with the cream cheese icing. Then serve!"
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["For the Dough", 9],
        ["For the Cinnamon Caramel Sauce", 7],
        ["For the Cinnamon Filling", 5],
        ["For the Cream Cheese Frosting", 4]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("For the Dough\nTo start, bloom your yeast. Mix your active dry yeast, sugar, and warm milk together and let sit for 10 minutes until foamy on top.\nNext, in a large bowl of a stand mixer with a whisk attachment, mix flour, salt and sugar together.\nTo the dry ingredients add the whisked eggs, vanilla and softened butter and mix.\nAdd in the yeast mixture and mix until everything is blended. Switch to a dough hook and knead on medium speed for 7-10 minutes until the dough pulls away from the edges of the bowl, forms a ball and springs back when pressed.\nForm the dough into a ball. Place the dough in a large, greased bowl. Cover with plastic wrap or a kitchen towel and place in a warm place to rise, (outside or a cold oven with the light on works well for this), for 1- 1 ½ hours, or until the dough doubles in size.\nFor the Cinnamon Caramel Sauce\nWhile the dough rises, make the sticky caramel sauce for the bottoms of the rolls, by mixing the butter, brown sugar, cinnamon, honey, vanilla, heavy cream and salt together in a medium bowl.\nGrease a 9x13 inch casserole dish. Spread the mixture evenly over the bottom of the pan.\nFor the Cinnamon Filling\nWhile the dough rises, also make the filling by mixing the butter, brown sugar, cinnamon and salt together in a small bowl. (If the filling is too firm and not spreadable, add heavy cream a tsp at a time until it's easily spreadable.)\nAssembling and Baking the Cinnamon Rolls\nOnce the dough has had a chance to rise, remove from bowl, punch dough to release the air, and roll out on a lightly floured surface. Roll the dough into about an 18 x 12 inch rectangle. It should be about 1/4 inch thick.\nSprinkle the cinnamon sugar filling over the dough and spread it evenly with an offset spatula.\nRoll up the dough tightly into a long log shape starting from the end closest to you. Cut of a bit off the ends to make the log even. Cut 12 rolls about 1 1/2 inches wide using unflavored floss or a very sharp knife.\nPlace the rolls in the prepared casserole dish with the cinnamon caramel sauce mixture and pour room temperature heavy cream in between each roll. Cover them with plastic wrap and let them proof in a warm spot for about an hour, or until they have doubled in size.\nPreheat the oven to 350 degrees about 15 minutes before the rolls are done proofing.\nOnce the rolls have completed their second rise, bake them for 29-32 minutes until golden brown. (30 minutes is usually perfect!)(Cover with aluminum foil for the last 5 minutes if they're getting too brown.)\nFor the Cream Cheese Frosting\nWhile they bake, make the cream cheese frosting by adding the softened butter to a medium bowl and mixing it on high speed with an electric mixer until pale and fluffy.\nAdd in the cream cheese and mix until combined on medium speed.\nSift the powdered sugar into the mixture a little at a time and mix on low speed until all is combined.(You can add more powdered sugar if you want the frosting to be sweeter.)\nThen add in the vanilla and combine on medium speed until the frosting is smooth.\nLet the rolls cool for 10 minutes, then cover the warm rolls with the cream cheese icing. Then serve!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("inbloombakery.com")
    expect(recipe.canonical_url).to eq("https://inbloombakery.com/the-best-cinnamon-rolls-ever/")
    expect(recipe.site_name).to eq("Baking with Butters")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Ginny Dyer")
    expect(recipe.description).to eq("These are the best cinnamon rolls EVER. They're soft and fluffy with a gooey brown sugar cinnamon filling, frosted with cream cheese frosting all while drenched in a rich, buttery brown sugar cinnamon caramel sauce on the bottom.")
    expect(recipe.image).to eq("https://inbloombakery.com/wp-content/uploads/2023/08/Cinnamon-Rolls-21.jpg")
    expect(recipe.category).to eq("Appetizer")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(225)
    expect(recipe.prep_time).to eq(45)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq([
      "best cinnamon rolls",
      "cinnamon",
      "cinnamon rolls",
      "cream cheese frosting"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.88)
    expect(recipe.ratings_count).to eq(442)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
