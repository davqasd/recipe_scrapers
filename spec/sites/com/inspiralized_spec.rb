# frozen_string_literal: true

RSpec.describe "inspiralized.com" do
  subject(:recipe) { scrape_cassette("com/inspiralized", url: "https://inspiralized.com/brussels-sprouts-and-apple-salad-with-parmesan/") }

  it "reads the title" do
    expect(recipe.title).to eq("Brussels Sprouts and Apple Salad with Parmesan")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 tablespoons extra virgin olive oil",
      "3 tablespoons apple cider vinegar",
      "2.5 teaspoons honey",
      "salt and pepper",
      "4 cups shredded brussels sprouts",
      "1 medium apple (Blade D)",
      "1/4 cup chopped raw almonds (for extra flavor, toast these first)",
      "1/3 cup shaved Parmesan"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "tablespoons", name: "extra virgin olive oil" },
      { amount: 3.0, unit: "tablespoons", name: "apple cider vinegar" },
      { amount: 2.5, unit: "teaspoons", name: "honey" },
      { amount: nil, unit: nil, name: "salt and pepper" },
      { amount: 4.0, unit: "cups", name: "shredded brussels sprouts" },
      { amount: 1.0, unit: nil, name: "medium apple" },
      { amount: 0.25, unit: "cup", name: "chopped raw almonds" },
      { amount: 0.33, unit: "cup", name: "shaved Parmesan" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large bowl, whisk together the olive oil, apple cider vinegar, honey, and season with salt and pepper. Add the brussels sprouts and apples and toss well. Let sit in the refrigerator for at least 15-20 minutes and then take out and fold in the almonds and half of the Parmesan cheese. Transfer to a serving bowl or plate and top with remaining Parmesan."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large bowl, whisk together the olive oil, apple cider vinegar, honey, and season with salt and pepper. Add the brussels sprouts and apples and toss well. Let sit in the refrigerator for at least 15-20 minutes and then take out and fold in the almonds and half of the Parmesan cheese. Transfer to a serving bowl or plate and top with remaining Parmesan.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("inspiralized.com")
    expect(recipe.canonical_url).to eq("https://inspiralized.com/brussels-sprouts-and-apple-salad-with-parmesan/")
    expect(recipe.site_name).to eq("Inspiralized")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Ali Maffucci")
    expect(recipe.description).to eq("This crunchy sweet salad is perfectly balanced with salty Parmesan cheese for a satisfying bite. Serve this up with your favorite protein or have it as a side salad this Autumn - it's a great way to use up those apple picking apples!")
    expect(recipe.image).to eq("https://inspiralized.com/wp-content/uploads/2019/09/Brussels-Sprouts-and-Apple-Salad-with-Parmesan-2-copy-scaled.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to eq(15)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to be_nil
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
    expect(recipe.links).to include("https://inspiralized.com/cookbooks/feeding-littles-and-beyond/")
  end
end
