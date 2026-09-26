# frozen_string_literal: true

RSpec.describe "gimmesomeoven.com" do
  subject(:recipe) { scrape_cassette("com/gimmesomeoven", url: "https://www.gimmesomeoven.com/sangria/") }

  it "reads the title" do
    expect(recipe.title).to eq("Sangria")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 2 (750 ml) bottles dry Spanish red wine, such as Garnacha, Tempranillo or Rioja",
      "1/2 cup brandy",
      "2 oranges (one juiced and one diced)",
      "1 green apple (diced)",
      "1 lemon (diced)",
      "1 cinnamon stick",
      "optional sweetener: simple syrup* or maple syrup",
      "optional bubbles: lemon-lime soda (ginger ale or sparkling water)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: nil, name: "2 bottles dry Spanish red wine, such as Garnacha, Tempranillo or Rioja" },
      { amount: 0.5, unit: "cup", name: "brandy" },
      { amount: 2.0, unit: nil, name: "oranges" },
      { amount: 1.0, unit: nil, name: "green apple" },
      { amount: 1.0, unit: nil, name: "lemon" },
      { amount: 1.0, unit: nil, name: "cinnamon stick" },
      { amount: nil, unit: nil, name: "optional sweetener: simple syrup* or maple syrup" },
      { amount: nil, unit: nil, name: "optional bubbles: lemon-lime soda" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Add the wine, brandy, orange juice, diced orange, diced apple, diced lemon and cinnamon stick to a large pitcher. Stir to combine. Taste and add in a few tablespoons of sweetener, if desired.",
      "Cover and refrigerate for at least 30 minutes, ideally 2 to 4 hours, to allow the flavors to meld.",
      "Serve the sangria over ice, topping off each glass with a splash of bubbly soda (or sparkling water) if desired."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Add the wine, brandy, orange juice, diced orange, diced apple, diced lemon and cinnamon stick to a large pitcher. Stir to combine. Taste and add in a few tablespoons of sweetener, if desired.\nCover and refrigerate for at least 30 minutes, ideally 2 to 4 hours, to allow the flavors to meld.\nServe the sangria over ice, topping off each glass with a splash of bubbly soda (or sparkling water) if desired.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("gimmesomeoven.com")
    expect(recipe.canonical_url).to eq("https://www.gimmesomeoven.com/sangria/")
    expect(recipe.site_name).to eq("Gimme Some Oven")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Ali")
    expect(recipe.description).to eq("This easy red sangria recipe is made with Spanish red wine, brandy, fresh citrus, apple and cinnamon. It's fruity, refreshing and perfect for entertaining.")
    expect(recipe.image).to eq("https://www.gimmesomeoven.com/wp-content/uploads/2021/07/How-To-Make-Sangria-Recipe-7.jpg")
    expect(recipe.category).to eq("Drinks")
    expect(recipe.cuisine).to eq("Spanish")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["4th of july", "cocktail", "vegetarian"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(19)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
