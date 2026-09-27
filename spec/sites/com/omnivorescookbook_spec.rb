# frozen_string_literal: true

RSpec.describe "omnivorescookbook.com" do
  subject(:recipe) { scrape_cassette("com/omnivorescookbook", url: "https://omnivorescookbook.com/pickled-watermelon-radish/") }

  it "reads the title" do
    expect(recipe.title).to eq("Three-Ingredient Quick Pickled Watermelon Radish (糖醋红心萝卜)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 watermelon radish (, peeled and shredded)",
      "1/4 cup rice vinegar (or apple cider vinegar)",
      "2 tablespoons sugar (or maple syrup)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "watermelon radish" },
      { amount: 0.25, unit: "cup", name: "rice vinegar" },
      { amount: 2.0, unit: "tablespoons", name: "sugar" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Combine apple cider vinegar and maple syrup in a large bowl. Mix well. Add radish and toss. Let sit for 10 minutes in the fridge.",
      "Add a pinch of salt onto the radish and toss again right before serving.",
      "Store the rest of the radish in an airtight jar for up to a week."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Combine apple cider vinegar and maple syrup in a large bowl. Mix well. Add radish and toss. Let sit for 10 minutes in the fridge.\nAdd a pinch of salt onto the radish and toss again right before serving.\nStore the rest of the radish in an airtight jar for up to a week.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("omnivorescookbook.com")
    expect(recipe.canonical_url).to eq("https://omnivorescookbook.com/pickled-watermelon-radish/")
    expect(recipe.site_name).to eq("Omnivore's Cookbook")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Maggie Zhu")
    expect(recipe.description).to eq("This pickled watermelon radish is sweet and slightly sour, with a hint of spiciness. It takes only 5 minutes to put together and another 5 minutes to marinate. It works as a fun appetizer by itself and is a great ingredient to add to your salad. {Gluten-Free, Vegan} The traditional Chinese method always uses rice vinegar and sugar. But if you prefer a natural sweetener, I recommend the combination of apple cider vinegar and maple syrup. It gives the dish a fruity taste and works just as well as the traditional method. I enjoy processing the radish with a knife. But feel free to use a peeler to shred it, or use a spiralizer to make it into veggie noodles.")
    expect(recipe.image).to eq("https://omnivorescookbook.com/wp-content/uploads/2017/08/1708_Quick-Pickled-Watermelon-Radish_550.jpg")
    expect(recipe.category).to eq("Appetizer")
    expect(recipe.cuisine).to eq("Chinese")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 of the 4 servings",
      "calories" => "10 kcal",
      "sugarContent" => "2 g",
      "sodiumContent" => "1 mg",
      "carbohydrateContent" => "2.1 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: nil, amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 10.0 },
      { name: "sugarContent", unit: "g", amount: 2.0 },
      { name: "sodiumContent", unit: "mg", amount: 1.0 },
      { name: "carbohydrateContent", unit: "g", amount: 2.1 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#body")
  end
end
