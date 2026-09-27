# frozen_string_literal: true

RSpec.describe "handletheheat.com" do
  subject(:recipe) { scrape_cassette("com/handletheheat", url: "https://handletheheat.com/deep-dish-pizza/") }

  it "reads the title" do
    expect(recipe.title).to eq("Deep Dish Pizza")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 cups (17 ounces) all-purpose flour",
      "3 tablespoons yellow cornmeal",
      "1 3/4 teaspoons fine sea salt",
      "2 3/4 teaspoons (1 package) instant yeast",
      "2 tablespoons olive oil",
      "4 tablespoons butter, melted and cooled",
      "2 tablespoons vegetable oil",
      "1 cup plus 2 tablespoons lukewarm water",
      "3/4 pound mozzarella cheese, sliced",
      "1 pound Italian sweet or hot sausage",
      "1 (28-ounce) can diced tomatoes",
      "2 garlic cloves, minced",
      "1 tablespoon sugar",
      "1 1/2 teaspoons dried Italian herbs",
      "1 cup freshly grated Parmesan cheese"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: "cups", name: "all-purpose flour" },
      { amount: 3.0, unit: "tablespoons", name: "yellow cornmeal" },
      { amount: 1.75, unit: "teaspoons", name: "fine sea salt" },
      { amount: 2.75, unit: "teaspoons", name: "instant yeast" },
      { amount: 2.0, unit: "tablespoons", name: "olive oil" },
      { amount: 4.0, unit: "tablespoons", name: "butter, melted and cooled" },
      { amount: 2.0, unit: "tablespoons", name: "vegetable oil" },
      { amount: 1.0, unit: "cup", name: "plus 2 tablespoons lukewarm water" },
      { amount: 0.75, unit: "pound", name: "mozzarella cheese, sliced" },
      { amount: 1.0, unit: "pound", name: "Italian sweet or hot sausage" },
      { amount: 1.0, unit: "can", name: "diced tomatoes" },
      { amount: 2.0, unit: nil, name: "garlic cloves, minced" },
      { amount: 1.0, unit: "tablespoon", name: "sugar" },
      { amount: 1.5, unit: "teaspoons", name: "dried Italian herbs" },
      { amount: 1.0, unit: "cup", name: "freshly grated Parmesan cheese" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "For the crust:",
      "In the bowl of an electric mixer fitted with the dough hook, combine all the crust ingredients. Knead on medium-low speed until the dough becomes smooth and soft, about 7 minutes. The dough can also be kneaded by hand or with a bread machine.",
      "Place the dough in a lightly oiled bowl, cover, and let rise until very puffy, about 1 hour.",
      "While the dough is rising, grease one large 14-inch deep dish pizza pan or two 9-inch cake pans with non-stick vegetable oil spray, then pour in 3 to 4 tablespoons olive oil, tilting it to cover the bottom of the pan, and partway up the sides.",
      "Once the dough is risen, use your hands to stretch it out into a circle that is slightly larger than the pizza pan or two circles slightly larger than the cake pans. Lay the dough in the pan(s), and stretch it towards the edges until it starts to shrink back. Cover, and let it rest for 15 minutes. Preheat the oven to 425°F while the dough rests.",
      "Continue stretching the dough until it covers the bottom of the pan, then gently push it up the sides of the pan. Let the crust rest for an additional 10 to 15 minutes. Bake the crust for 10 minutes, until it's set and barely beginning to brown.",
      "For the filling:",
      "Meanwhile, drain the tomatoes thoroughly. In a medium bowl combine the tomatoes, garlic, sugar, and Italian herbs. Cover the bottom of the crust with the sliced mozzarella. Add the sausage then the tomato mixture. Sprinkle with the grated Parmesan.",
      "Bake the pizza for about 20 to 25 minutes, or until the filling is bubbly and the topping is golden brown. Remove it from the oven, and use a large spatula to carefully lift it out of the pan onto a rack. Allow the pizza to cool for about 10 to 15 minutes before cutting and serving."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["Crust:", 8],
        ["Filling:", 7]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("For the crust:\nIn the bowl of an electric mixer fitted with the dough hook, combine all the crust ingredients. Knead on medium-low speed until the dough becomes smooth and soft, about 7 minutes. The dough can also be kneaded by hand or with a bread machine.\nPlace the dough in a lightly oiled bowl, cover, and let rise until very puffy, about 1 hour.\nWhile the dough is rising, grease one large 14-inch deep dish pizza pan or two 9-inch cake pans with non-stick vegetable oil spray, then pour in 3 to 4 tablespoons olive oil, tilting it to cover the bottom of the pan, and partway up the sides.\nOnce the dough is risen, use your hands to stretch it out into a circle that is slightly larger than the pizza pan or two circles slightly larger than the cake pans. Lay the dough in the pan(s), and stretch it towards the edges until it starts to shrink back. Cover, and let it rest for 15 minutes. Preheat the oven to 425°F while the dough rests.\nContinue stretching the dough until it covers the bottom of the pan, then gently push it up the sides of the pan. Let the crust rest for an additional 10 to 15 minutes. Bake the crust for 10 minutes, until it's set and barely beginning to brown.\nFor the filling:\nMeanwhile, drain the tomatoes thoroughly. In a medium bowl combine the tomatoes, garlic, sugar, and Italian herbs. Cover the bottom of the crust with the sliced mozzarella. Add the sausage then the tomato mixture. Sprinkle with the grated Parmesan.\nBake the pizza for about 20 to 25 minutes, or until the filling is bubbly and the topping is golden brown. Remove it from the oven, and use a large spatula to carefully lift it out of the pan onto a rack. Allow the pizza to cool for about 10 to 15 minutes before cutting and serving.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("handletheheat.com")
    expect(recipe.canonical_url).to eq("https://handletheheat.com/deep-dish-pizza/")
    expect(recipe.site_name).to eq("Handle the Heat")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Tessa Arias")
    expect(recipe.description).to eq("Get that thick, slightly crisp, and buttery Chicago restaurant-style deep dish pizza at home with this recipe!")
    expect(recipe.image).to eq("https://handletheheat.com/wp-content/uploads/2013/09/Deep-Dish-Pizza.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to eq(140)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(35)
    expect(recipe.keywords).to be_nil
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
