# frozen_string_literal: true

RSpec.describe "thefirstmess.com" do
  subject(:recipe) { scrape_cassette("com/thefirstmess", url: "https://thefirstmess.com/2018/07/11/vegan-grilled-pizza-portobellos-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Grilled Pizza Portobellos with Lemony Cashew “Ricotta”")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "¼ cup balsamic vinegar",
      "¼ cup avocado or olive oil",
      "1 clove of garlic, finely minced or grated",
      "1 teaspoon tamari or coconut aminos",
      "sea salt and ground black pepper, to taste",
      "6 large portobello mushrooms, stems removed and gills scraped out with a spoon",
      "heaped ½ cup raw cashews, soaked for at least 1 hour",
      "1 tablespoon nutritional yeast",
      "1 teaspoon light miso (I used a chickpea-based one)",
      "½ teaspoon lemon zest",
      "1 tablespoon lemon juice",
      "2-3 drops of maple syrup",
      "¼ teaspoon garlic powder",
      "¼ teaspoon onion powder",
      "5-6 tablespoons of water",
      "tomato sauce, fresh basil & other pizza toppings of choice",
      "fresh ciabatta buns, if making sandwiches"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.25, unit: "cup", name: "balsamic vinegar" },
      { amount: 0.25, unit: "cup", name: "avocado or olive oil" },
      { amount: 1.0, unit: "clove", name: "garlic, finely minced or grated" },
      { amount: 1.0, unit: "teaspoon", name: "tamari or coconut aminos" },
      { amount: nil, unit: nil, name: "sea salt and ground black pepper, to taste" },
      { amount: 6.0, unit: nil, name: "large portobello mushrooms, stems removed and gills scraped out with a spoon" },
      { amount: 0.5, unit: "cup", name: "raw cashews, soaked for at least 1 hour" },
      { amount: 1.0, unit: "tablespoon", name: "nutritional yeast" },
      { amount: 1.0, unit: "teaspoon", name: "light miso" },
      { amount: 0.5, unit: "teaspoon", name: "lemon zest" },
      { amount: 1.0, unit: "tablespoon", name: "lemon juice" },
      { amount: 2.0, unit: "drops", name: "maple syrup" },
      { amount: 0.25, unit: "teaspoon", name: "garlic powder" },
      { amount: 0.25, unit: "teaspoon", name: "onion powder" },
      { amount: 5.0, unit: "tablespoons", name: "water" },
      { amount: nil, unit: nil, name: "tomato sauce, fresh basil & other pizza toppings of choice" },
      { amount: nil, unit: nil, name: "fresh ciabatta buns, if making sandwiches" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large, shallow bowl, whisk together the balsamic vinegar, oil, garlic, tamari, salt, and pepper. Place the portobellos in the balsamic marinade and flip them over to coat. Flip them so that the bottoms are facing up and spoon marinade into the caps. Set aside for 20 minutes, or up to 2 hours.",
      "Make the ricotta. Drain and rinse the cashews. In a food processor combine the cashews, nutritional yeast, miso, lemon zest, lemon juice, maple syrup, garlic powder, onion powder, 5 tablespoons of water and salt to taste. Pulse the mixture until the cashews are finely chopped. Then, run the motor on high until you have a smooth, lightly textured ricotta-like mixture. Add more water by the teaspoon if necessary and scrape down the sides of the food processor bowl. Check ricotta for seasoning and set aside.",
      "Preheat a grill to high. On a tray or large platter bring out your portobellos, the ricotta, any pizza toppings you’re using, and a flipping spatula. Place the portobellos on the grill top side facing down. Close the lid and grill for 3-4 minutes, or until slightly collapsed and charred on the edges. Flip the portobellos over.",
      "Spoon tomato sauce, ricotta, and add any other toppings to the portobellos. Close the lid and cook for 3-4 minutes. Once filling is bubbling and portobellos are totally soft, juicy-looking, and evenly charred, carefully remove them from the grill. Serve pizza portobellos on their own or on fresh toasted ciabatta."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["Portobellos", 6],
        ["Lemony Cashew “Ricotta”", 9],
        ["Assembly", 2]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large, shallow bowl, whisk together the balsamic vinegar, oil, garlic, tamari, salt, and pepper. Place the portobellos in the balsamic marinade and flip them over to coat. Flip them so that the bottoms are facing up and spoon marinade into the caps. Set aside for 20 minutes, or up to 2 hours.\nMake the ricotta. Drain and rinse the cashews. In a food processor combine the cashews, nutritional yeast, miso, lemon zest, lemon juice, maple syrup, garlic powder, onion powder, 5 tablespoons of water and salt to taste. Pulse the mixture until the cashews are finely chopped. Then, run the motor on high until you have a smooth, lightly textured ricotta-like mixture. Add more water by the teaspoon if necessary and scrape down the sides of the food processor bowl. Check ricotta for seasoning and set aside.\nPreheat a grill to high. On a tray or large platter bring out your portobellos, the ricotta, any pizza toppings you’re using, and a flipping spatula. Place the portobellos on the grill top side facing down. Close the lid and grill for 3-4 minutes, or until slightly collapsed and charred on the edges. Flip the portobellos over.\nSpoon tomato sauce, ricotta, and add any other toppings to the portobellos. Close the lid and cook for 3-4 minutes. Once filling is bubbling and portobellos are totally soft, juicy-looking, and evenly charred, carefully remove them from the grill. Serve pizza portobellos on their own or on fresh toasted ciabatta.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thefirstmess.com")
    expect(recipe.canonical_url).to eq("https://thefirstmess.com/2018/07/11/vegan-grilled-pizza-portobellos-recipe/")
    expect(recipe.site_name).to eq("The First Mess")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Laura Wright")
    expect(recipe.description).to eq("Grilled pizza portobellos with lemony cashew \"ricotta\" are an easy vegan summer main. Totally delicious and customizable.")
    expect(recipe.image).to eq("https://thefirstmess.com/wp-content/uploads/2018/07/10-9850-post/vegan-grilled-pizza-portobellos-recipe-2.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("BBQ")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(50)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq(["all seasons", "avocado oil", "balsamic vinegar", "basil", "bread", "cashews", "coconut aminos", "garlic", "garlic powder", "lemon", "maple syrup", "miso", "nutritional yeast", "olive oil", "onion powder", "portobello mushrooms", "quick", "spring", "summer", "tamari", "tomato sauce"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(%w[GlutenFreeDiet VeganDiet VegetarianDiet])
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#recipe")
  end
end
