# frozen_string_literal: true

RSpec.describe "weightwatchers.com" do
  subject(:recipe) { scrape_cassette("com/weightwatchers", url: "https://www.weightwatchers.com/us/recipe/grilled-berry-s-mores-slab/578386c4fab48a3f4e9cf811") }

  it "reads the title" do
    expect(recipe.title).to eq("Grilled berry s’mores slab")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "8 whole Reduced-fat graham crackers",
      "1.25 cup(s) Mini marshmallows, roughly chopped",
      "1.5 oz 60-69% dark chocolate, thinly shaved",
      "1 cup(s) Fresh raspberries"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 8.0, unit: nil, name: "whole Reduced-fat graham crackers" },
      { amount: 1.25, unit: "cup", name: "Mini marshmallows, roughly chopped" },
      { amount: 1.5, unit: "oz", name: "60-69% dark chocolate, thinly shaved" },
      { amount: 1.0, unit: "cup", name: "Fresh raspberries" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat gas grill to medium, or prepare medium fire in charcoal grill for indirect heat.",
      "Arrange graham crackers side by side in 2 rows on rimmed baking sheet to form 9-inch square. Sprinkle graham crackers with marshmallows, then chocolate.",
      "Transfer baking sheet to grill over indirect heat (off to side of heat source). Close lid and cook until chocolate melts and marshmallows soften, about 3 minutes. Transfer to platter. Gently press raspberries on top and serve immediately. Store leftovers in airtight container at room temperature for up to 2 days.",
      "Serving size: 1 whole graham cracker with topping"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat gas grill to medium, or prepare medium fire in charcoal grill for indirect heat.\nArrange graham crackers side by side in 2 rows on rimmed baking sheet to form 9-inch square. Sprinkle graham crackers with marshmallows, then chocolate.\nTransfer baking sheet to grill over indirect heat (off to side of heat source). Close lid and cook until chocolate melts and marshmallows soften, about 3 minutes. Transfer to platter. Gently press raspberries on top and serve immediately. Store leftovers in airtight container at room temperature for up to 2 days.\nServing size: 1 whole graham cracker with topping")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("weightwatchers.com")
    expect(recipe.canonical_url).to eq("https://www.weightwatchers.com/us/recipe/berry-smores-slab/578386c4fab48a3f4e9cf811")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("WeightWatchers")
    expect(recipe.description).to eq("Open-faced grilled s’mores are a sophisticated way to finish off any summer BBQ. This recipe is prepared in the same fashion as classic slab pie with all the ingredients arranged on a baking sheet or rectangular surface—only this sweet treat is grilled, not baked. Coat your knife with cooking spray before chopping the marshmallows so they don't stick to the blade.")
    expect(recipe.image).to eq("https://v.cdn.ww.com/media/system/wine/585ad05dc0d19f4f72259e9e/3b5e1b66-9209-48e8-9a07-28a81b7b5bbc/u1njjxlgetbac4cttmve.jpg?width=50")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(15)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(5)
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
    expect(recipe.links).to include("#main-content")
  end
end
