# frozen_string_literal: true

RSpec.describe "scrambledandscrumptious.com" do
  subject(:recipe) { scrape_cassette("com/scrambledandscrumptious", url: "https://www.scrambledandscrumptious.com/recipes/easy-easter-meringue-nests-with-chocolate-mini-eggs") }

  it "reads the title" do
    expect(recipe.title).to eq("Easy Easter Meringue Nests with Chocolate Mini Eggs")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3/8 tsp Cream of Tartar",
      "3 Large egg whites",
      "1 cup Granulated sugar",
      "1 bar Dark chocolate",
      "1 bar White chocolate",
      "1 tsp Coconut oil",
      "18 Mini eggs"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.38, unit: "tsp", name: "Cream of Tartar" },
      { amount: 3.0, unit: nil, name: "Large egg whites" },
      { amount: 1.0, unit: "cup", name: "Granulated sugar" },
      { amount: 1.0, unit: "bar", name: "Dark chocolate" },
      { amount: 1.0, unit: "bar", name: "White chocolate" },
      { amount: 1.0, unit: "tsp", name: "Coconut oil" },
      { amount: 18.0, unit: nil, name: "Mini eggs" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat your oven to 175F and line a baking sheet with parchment paper. Make sure your large mixing bowl is clean and does not have any residue of fat in it. This is important because if there is any residual fat in the bowl, you won't get the fluffy texture and stiff peaks we're after! In a large grease-free bowl, add the cream of tartar to the bottom and then add your egg whites. Using the whisk attachment on your mixer, mix on medium-low speed until the cream of tartar is absorbed and the egg whites have a light foam on the top. Bring the speed on your mixer up to medium and continue to whip egg whites as you slowly add the sugar, one or two spoonful's at a time. Once each little bit of sugar is absorbed into the egg whites, add the next little bit until there is no sugar left. The meringue mixture will start having soft peaks at this point. Bring the speed on your mixer up to medium or high and whip until stiff peaks start to form.",
      "Add your meringue mixture to a pastry bag with the large star nozzle. On your parchment paper-lined baking sheet, pipe your meringue into three-inch rounds with some extra meringue around the top of the outer edge of each meringue. If you are using a spoon, scoop three-inch rounds onto the baking sheet. Using the back of a spoon, press an indent into the center of each meringue nest.",
      "Place the baking sheet with meringues in the oven for one and a half to two hours. Do not open the oven door during the first hour that the meringues are in there. The drying time for the meringues is going to depend on how dense and thick the meringue is as well as your oven. You can check the readiness of the meringue by gently touching the side of it, if the sides of the nest are sticky or bend to your touch, it is not ready and you will need to continue drying in the oven for another 30-60 minutes. You are looking for a crisp meringue where the bottom comes off of the parchment easily. Once your meringues are ready, remove from the oven and let cool on the baking tray on a cooling rack for at least one hour.",
      "Once your meringues are cooled, boil water in a small or medium sized pot and place a heat safe bowl over it to create a bain-marie. When the water reaches a rolling simmer, place the chocolate and coconut oil in the bowl over the pot of hot water and stir until it is melted and fully combined. Let it cool for a few minutes before you decorate your meringues.",
      "Drizzle some of the melted chocolate in the middle of the nest shape of each meringue and place roughly three of the mini chocolate eggs in the melted chocolate so that they are held in place as the chocolate hardens. Let cool until the chocolate is hard and the mini eggs do not move. Serve and enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat your oven to 175F and line a baking sheet with parchment paper. Make sure your large mixing bowl is clean and does not have any residue of fat in it. This is important because if there is any residual fat in the bowl, you won't get the fluffy texture and stiff peaks we're after! In a large grease-free bowl, add the cream of tartar to the bottom and then add your egg whites. Using the whisk attachment on your mixer, mix on medium-low speed until the cream of tartar is absorbed and the egg whites have a light foam on the top. Bring the speed on your mixer up to medium and continue to whip egg whites as you slowly add the sugar, one or two spoonful's at a time. Once each little bit of sugar is absorbed into the egg whites, add the next little bit until there is no sugar left. The meringue mixture will start having soft peaks at this point. Bring the speed on your mixer up to medium or high and whip until stiff peaks start to form.\nAdd your meringue mixture to a pastry bag with the large star nozzle. On your parchment paper-lined baking sheet, pipe your meringue into three-inch rounds with some extra meringue around the top of the outer edge of each meringue. If you are using a spoon, scoop three-inch rounds onto the baking sheet. Using the back of a spoon, press an indent into the center of each meringue nest.\nPlace the baking sheet with meringues in the oven for one and a half to two hours. Do not open the oven door during the first hour that the meringues are in there. The drying time for the meringues is going to depend on how dense and thick the meringue is as well as your oven. You can check the readiness of the meringue by gently touching the side of it, if the sides of the nest are sticky or bend to your touch, it is not ready and you will need to continue drying in the oven for another 30-60 minutes. You are looking for a crisp meringue where the bottom comes off of the parchment easily. Once your meringues are ready, remove from the oven and let cool on the baking tray on a cooling rack for at least one hour.\nOnce your meringues are cooled, boil water in a small or medium sized pot and place a heat safe bowl over it to create a bain-marie. When the water reaches a rolling simmer, place the chocolate and coconut oil in the bowl over the pot of hot water and stir until it is melted and fully combined. Let it cool for a few minutes before you decorate your meringues.\nDrizzle some of the melted chocolate in the middle of the nest shape of each meringue and place roughly three of the mini chocolate eggs in the melted chocolate so that they are held in place as the chocolate hardens. Let cool until the chocolate is hard and the mini eggs do not move. Serve and enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("scrambledandscrumptious.com")
    expect(recipe.canonical_url).to eq("https://www.scrambledandscrumptious.com/recipes/easy-easter-meringue-nests-with-chocolate-mini-eggs")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to be_nil
    expect(recipe.author).to eq("Kirsten")
    expect(recipe.description).to eq("These cute mini meringues make the perfect Easter treat. Drizzling with chocolate and filling with mini eggs means the young ones in your life will enjoy helping you decorate them too!")
    expect(recipe.image).to eq("https://cdn.prod.website-files.com/60d29a175c2cd12b443f0a63/642f5502ba061218b333602b_Easter%20Mini%20Egg%20Nests-08.jpg")
    expect(recipe.category).to eq("Sweets")
    expect(recipe.cuisine).to eq("French")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(150)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Sweets", "Easter Recipes", "Easter Desserts", "Spring Desserts", "Spring Recipes", "Meringue Cookies", "Mini Meringues", "Easy Meringues", "Easy Desserts", "Meringue Nests", "Mini Egg Nests"])
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
    expect(recipe.links).to include("#recipe-card")
  end
end
