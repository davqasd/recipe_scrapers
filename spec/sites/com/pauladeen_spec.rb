# frozen_string_literal: true

RSpec.describe "pauladeen.com" do
  subject(:recipe) { scrape_cassette("com/pauladeen", url: "https://www.pauladeen.com/recipe/roast-lamb-with-bourbon-and-mint/") }

  it "reads the title" do
    expect(recipe.title).to eq("Roast Lamb with Bourbon and Mint")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 small whole leg of lamb (about 7 pounds)",
      "1/2 cup chopped fresh mint or 1/4 cup crumbled dried mint",
      "1/2 cup bourbon",
      "salt",
      "Freshly ground black pepper",
      "1/2 cup Madeira",
      "2 cups beef or lamb broth",
      "2 tablespoons unsalted butter, cut into bits"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "small whole leg of lamb" },
      { amount: 0.5, unit: "cup", name: "chopped fresh mint or 1/4 cup crumbled dried mint" },
      { amount: 0.5, unit: "cup", name: "bourbon" },
      { amount: nil, unit: nil, name: "salt" },
      { amount: nil, unit: nil, name: "Freshly ground black pepper" },
      { amount: 0.5, unit: "cup", name: "Madeira" },
      { amount: 2.0, unit: "cups", name: "beef or lamb broth" },
      { amount: 2.0, unit: "tablespoons", name: "unsalted butter, cut into bits" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Position a rack in the center of the oven and preheat to 500 degrees F. Trim the excess fat from the lamb, but leave a thin layer of at least 1/8 inch. Wipe dry and liberally rub it with salt and several generous grindings of black pepper, then pack the mint over the entire surface. Lightly butter the bottom of a roasting pan and put in the lamb, fat side up.",
      "Roast in the center of the oven for 20 minutes, or until well-seared and lightly browned. Remove and pour the bourbon over it. Return it to the oven, reduce the heat to 375 degrees F. and roast, basting occasionally with pan juices, until done to your taste, from 15 minutes per pound for medium-rare to 25 minutes per pound for medium well.",
      "Put the roasting pan over direct medium high heat. Add 1/2 cup Madeira and bring it to a boil, stirring and scraping the pan to loosen any cooking residue. Boil 1 minute and add the broth and pan juices. Bring to a vigorous boil and cook until reduced by about half, about 3 to 5 minutes.",
      "Turn off the heat and swirl or whisk in the butter until it is incorporated. Taste and adjust the seasonings and pour into a warmed sauceboat."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Position a rack in the center of the oven and preheat to 500 degrees F. Trim the excess fat from the lamb, but leave a thin layer of at least 1/8 inch. Wipe dry and liberally rub it with salt and several generous grindings of black pepper, then pack the mint over the entire surface. Lightly butter the bottom of a roasting pan and put in the lamb, fat side up.\nRoast in the center of the oven for 20 minutes, or until well-seared and lightly browned. Remove and pour the bourbon over it. Return it to the oven, reduce the heat to 375 degrees F. and roast, basting occasionally with pan juices, until done to your taste, from 15 minutes per pound for medium-rare to 25 minutes per pound for medium well.\nPut the roasting pan over direct medium high heat. Add 1/2 cup Madeira and bring it to a boil, stirring and scraping the pan to loosen any cooking residue. Boil 1 minute and add the broth and pan juices. Bring to a vigorous boil and cook until reduced by about half, about 3 to 5 minutes.\nTurn off the heat and swirl or whisk in the butter until it is incorporated. Taste and adjust the seasonings and pour into a warmed sauceboat.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("pauladeen.com")
    expect(recipe.canonical_url).to eq("https://www.pauladeen.com/recipe/roast-lamb-with-bourbon-and-mint/")
    expect(recipe.site_name).to eq("Paula Deen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Paula Deen")
    expect(recipe.description).to eq("This classic roast lamb with bourbon and mint recipe from Paula Deen is perfect for spring entertaining including Easter. Ingredients include leg of lamb, fresh mint and bourbon. Prep time is about 20 minutes and cooking time is 125 minutes at 500°F.")
    expect(recipe.image).to eq("https://cdn.pauladeen.com/wp-content/uploads/2017/10/31070208/roast_lamb_with_bourbon_and_mint_1.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("15 servings")
    expect(recipe.total_time).to eq(145)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(125)
    expect(recipe.keywords).to eq(["Main Course"])
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
    expect(recipe.links).to include("#main-content")
  end
end
