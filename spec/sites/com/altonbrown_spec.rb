# frozen_string_literal: true

RSpec.describe "altonbrown.com" do
  subject(:recipe) { scrape_cassette("com/altonbrown", url: "https://altonbrown.com/recipes/reloaded-gold-cake/") }

  it "reads the title" do
    expect(recipe.title).to eq("A Far, Far Better Cake")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup (2 sticks) unsalted butter, at room temperature, plus extra for the pan",
      "1 cup all-purpose flour, plus extra for the pan",
      "1 cup cake flour",
      "1 tablespoon baking powder",
      "1 1/2 cups plus 3 tablespoons sugar",
      "1/4 teaspoon fine sea salt",
      "8 large egg yolks, at room temperature",
      "1 1/4 cups whole milk, at room temperature",
      "1 teaspoon vanilla extract"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "unsalted butter, at room temperature, plus extra for the pan" },
      { amount: 1.0, unit: "cup", name: "all-purpose flour, plus extra for the pan" },
      { amount: 1.0, unit: "cup", name: "cake flour" },
      { amount: 1.0, unit: "tablespoon", name: "baking powder" },
      { amount: 1.5, unit: "cups", name: "plus 3 tablespoons sugar" },
      { amount: 0.25, unit: "teaspoon", name: "fine sea salt" },
      { amount: 8.0, unit: nil, name: "large egg yolks, at room temperature" },
      { amount: 1.25, unit: "cups", name: "whole milk, at room temperature" },
      { amount: 1.0, unit: "teaspoon", name: "vanilla extract" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Place an oven rack in the top third of the oven and crank the box to 350°F. Then prep two 9-inch round aluminum cake pans by rubbing on a thin layer of butter on the bottoms and sides, and then flour. Finally, line the bottoms of both with a round of parchment paper.",
      "SiftYou can use a sifter for this or a fine sieve. the flours together with the baking powder and set aside.",
      "Load the paddle attachment onto your stand mixer and beat the butter on low speed just until smooth, about 1 minute. Follow with the sugar and salt, boosting the speed to medium. Continue to beat until the mixture is light and fluffy, about 4 minutes, stopping to scrape down the sides of the bowl after each minute or so.",
      "With the mixer still on medium, add the egg yolks one at a time, fully incorporating one before adding the next. When all eight are in, kill the mixer and scrape the bowl. Return the speed to low and slowly addI like to use a paper plate to dose in the flour...great multitasker. half the flour mixture.",
      "When the first half of the flour mix is worked in, add half of the milk and all of the vanilla. Stop and scrape the bowl yet again then return to low and slowly add the remaining flour followed by the remaining milk. Scrape one more time, making sure there’s no dry flour hiding in the bottom of the bowl. Congratulations, you’ve conquered the creaming method.",
      "Divide the mixture between the two pans. I use a scale to ensure even distribution and that means about 660 grams per pan. Smooth the tops with a rubber spatula and tap the pans against the counter to remove any air pockets.",
      "Bake until the cakes reach an internal temperature of between 207 and 210°F, which typically takes between 30 and 35 minutes. The cakes should be golden brown and a toothpick inserted into the center of the cakes should come out clean.",
      "Remove from oven and cool cakes on a wire rack for 15 minutes then de-pan onto the rack and cool to room temp before frosting with your icing of choice or our Cocoa Whipped Cream."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Place an oven rack in the top third of the oven and crank the box to 350°F. Then prep two 9-inch round aluminum cake pans by rubbing on a thin layer of butter on the bottoms and sides, and then flour. Finally, line the bottoms of both with a round of parchment paper.\nSiftYou can use a sifter for this or a fine sieve. the flours together with the baking powder and set aside.\nLoad the paddle attachment onto your stand mixer and beat the butter on low speed just until smooth, about 1 minute. Follow with the sugar and salt, boosting the speed to medium. Continue to beat until the mixture is light and fluffy, about 4 minutes, stopping to scrape down the sides of the bowl after each minute or so.\nWith the mixer still on medium, add the egg yolks one at a time, fully incorporating one before adding the next. When all eight are in, kill the mixer and scrape the bowl. Return the speed to low and slowly addI like to use a paper plate to dose in the flour...great multitasker. half the flour mixture.\nWhen the first half of the flour mix is worked in, add half of the milk and all of the vanilla. Stop and scrape the bowl yet again then return to low and slowly add the remaining flour followed by the remaining milk. Scrape one more time, making sure there’s no dry flour hiding in the bottom of the bowl. Congratulations, you’ve conquered the creaming method.\nDivide the mixture between the two pans. I use a scale to ensure even distribution and that means about 660 grams per pan. Smooth the tops with a rubber spatula and tap the pans against the counter to remove any air pockets.\nBake until the cakes reach an internal temperature of between 207 and 210°F, which typically takes between 30 and 35 minutes. The cakes should be golden brown and a toothpick inserted into the center of the cakes should come out clean.\nRemove from oven and cool cakes on a wire rack for 15 minutes then de-pan onto the rack and cool to room temp before frosting with your icing of choice or our Cocoa Whipped Cream.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("altonbrown.com")
    expect(recipe.canonical_url).to eq("https://altonbrown.com/recipes/reloaded-gold-cake/")
    expect(recipe.site_name).to eq("Alton Brown")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Penny McCord Jewell")
    expect(recipe.description).to eq("Way back in 2003, I created a yellow cake that was dry, crumbly, and not nearly the cake the world deserves. After all these years I can finally say: we’re golden...cake that is. All we needed was more moisture and less starch, proof positive that small, balanced changes can radically improve or...disprove a cake.This recipe first appeared in Season 2 of Good Eats: Reloaded.")
    expect(recipe.image).to eq("https://altonbrown.com/wp-content/uploads/2020/08/A-Far-Far-Better-Cake_RecipeImage.jpg")
    expect(recipe.category).to eq("Sweets")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(80)
    expect(recipe.prep_time).to eq(45)
    expect(recipe.cook_time).to eq(35)
    expect(recipe.keywords).to eq(%w[Baking Desserts Entertaining])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.25)
    expect(recipe.ratings_count).to eq(313)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/cook")
  end
end
