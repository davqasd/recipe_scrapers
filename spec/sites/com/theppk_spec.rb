# frozen_string_literal: true

RSpec.describe "theppk.com" do
  subject(:recipe) { scrape_cassette("com/theppk", url: "https://www.theppk.com/2025/11/pink-grapefruit-cupcakes/") }

  it "reads the title" do
    expect(recipe.title).to eq("Pink Grapefruit Cupcakes")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 large pink grapefruit",
      "1 cup granulated sugar",
      "1/2 cup water",
      "3/4 cup unsweetened almond milk (or other nondairy milk)",
      "1/2 cup fresh grapefruit juice",
      "1/3 cup canola oil",
      "3/4 cup granulated sugar",
      "1 tablespoon grated grapefruit zest",
      "1 teaspoon vanilla extract",
      "1 1/3 cups all-purpose flour",
      "1 teaspoon baking powder",
      "1/2 teaspoon baking soda",
      "1/4 teaspoon salt",
      "3 cups powdered sugar (sifted)",
      "1/2 cup refined coconut oil (melted)",
      "1/4 cup fresh grapefruit juice",
      "1/2 teaspoon vanilla extract",
      "Pinch of salt"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "large pink grapefruit" },
      { amount: 1.0, unit: "cup", name: "granulated sugar" },
      { amount: 0.5, unit: "cup", name: "water" },
      { amount: 0.75, unit: "cup", name: "unsweetened almond milk" },
      { amount: 0.5, unit: "cup", name: "fresh grapefruit juice" },
      { amount: 0.33, unit: "cup", name: "canola oil" },
      { amount: 0.75, unit: "cup", name: "granulated sugar" },
      { amount: 1.0, unit: "tablespoon", name: "grated grapefruit zest" },
      { amount: 1.0, unit: "teaspoon", name: "vanilla extract" },
      { amount: 1.33, unit: "cups", name: "all-purpose flour" },
      { amount: 1.0, unit: "teaspoon", name: "baking powder" },
      { amount: 0.5, unit: "teaspoon", name: "baking soda" },
      { amount: 0.25, unit: "teaspoon", name: "salt" },
      { amount: 3.0, unit: "cups", name: "powdered sugar" },
      { amount: 0.5, unit: "cup", name: "refined coconut oil" },
      { amount: 0.25, unit: "cup", name: "fresh grapefruit juice" },
      { amount: 0.5, unit: "teaspoon", name: "vanilla extract" },
      { amount: 1.0, unit: "Pinch", name: "salt" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Make the candied peel",
      "Cut off the top and bottom ends of the grapefruit. With a paring knife, cut away the peel in wide strips, leaving some of the white pith attached. Slice into strips about 1/4 inch wide.",
      "Place peel strips in a 4-quart pot and cover with cold water. Bring to a boil, then drain. Repeat this process two more times.",
      "Return the peel to the pot. Add sugar and 1/2 cup water. Bring to a boil, then reduce heat and simmer until peel is translucent, 15 to 20 minutes.",
      "Drain, then place the peel on a wire rack to dry, 2 to 4 hours. Store in an airtight container until ready to use.",
      "Make the cupcakes",
      "Preheat oven to 350°F. Line a standard muffin tin with 12 cupcake liners. Lightly coat liners with nonstick spray.",
      "In a large bowl, whisk together almond milk, grapefruit juice, oil, sugar, grapefruit zest, and vanilla.",
      "Sift in flour, baking powder, baking soda, and salt. Mix until smooth.",
      "Fill liners two-thirds full. Bake 18 to 22 minutes, or until a toothpick inserted in the center comes out clean.",
      "Cool cupcakes in the pan for 5 minutes, then transfer to a wire rack to cool completely.",
      "Make the icing",
      "In a bowl, whisk together powdered sugar, melted coconut oil, grapefruit juice, vanilla, and salt until smooth. Refrigerate 30 minutes.",
      "Using a mixer, whip the chilled icing on medium-high speed until light and fluffy.",
      "Frost cooled cupcakes with a knife or piping bag. Garnish with candied grapefruit peel."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["For the Candied Grapefruit Peel", 3],
        ["For the Cupcakes", 10],
        ["For the Icing", 5]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Make the candied peel\nCut off the top and bottom ends of the grapefruit. With a paring knife, cut away the peel in wide strips, leaving some of the white pith attached. Slice into strips about 1/4 inch wide.\nPlace peel strips in a 4-quart pot and cover with cold water. Bring to a boil, then drain. Repeat this process two more times.\nReturn the peel to the pot. Add sugar and 1/2 cup water. Bring to a boil, then reduce heat and simmer until peel is translucent, 15 to 20 minutes.\nDrain, then place the peel on a wire rack to dry, 2 to 4 hours. Store in an airtight container until ready to use.\nMake the cupcakes\nPreheat oven to 350°F. Line a standard muffin tin with 12 cupcake liners. Lightly coat liners with nonstick spray.\nIn a large bowl, whisk together almond milk, grapefruit juice, oil, sugar, grapefruit zest, and vanilla.\nSift in flour, baking powder, baking soda, and salt. Mix until smooth.\nFill liners two-thirds full. Bake 18 to 22 minutes, or until a toothpick inserted in the center comes out clean.\nCool cupcakes in the pan for 5 minutes, then transfer to a wire rack to cool completely.\nMake the icing\nIn a bowl, whisk together powdered sugar, melted coconut oil, grapefruit juice, vanilla, and salt until smooth. Refrigerate 30 minutes.\nUsing a mixer, whip the chilled icing on medium-high speed until light and fluffy.\nFrost cooled cupcakes with a knife or piping bag. Garnish with candied grapefruit peel.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("theppk.com")
    expect(recipe.canonical_url).to eq("https://www.theppk.com/2025/11/pink-grapefruit-cupcakes/")
    expect(recipe.site_name).to eq("Post Punk Kitchen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Isa Chandra")
    expect(recipe.description).to eq("Bright and floral vegan cupcakes bursting with fresh pink grapefruit, topped with fluffy citrus frosting and jeweled candied grapefruit peel. From The Superfun Times Vegan Holiday Cookbook.")
    expect(recipe.image).to eq("https://www.theppk.com/wp-content/uploads/2025/09/GrapefruitCupakes.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Cupcakes"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
