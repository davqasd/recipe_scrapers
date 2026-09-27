# frozen_string_literal: true

RSpec.describe "foodnetwork.co.uk" do
  subject(:recipe) { scrape_cassette("uk/foodnetwork", url: "https://foodnetwork.co.uk/recipes/michel-rouxs-chicken-with-honey-and-rosemary-baked-in-a-salt-crust") }

  it "reads the title" do
    expect(recipe.title).to eq("Michel Roux's Chicken with Honey and Rosemary Baked in a Salt Crust")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "Chicken",
      "1 good quality chicken, about 2.2kg",
      "2 tbsp clear honey",
      "1 tbsp paprika",
      "Cracked black Pepper",
      "6 chicken livers, cleaned and trimmed of any sinew",
      "100g mixed dry mushrooms, soaked overnight",
      "2 tbsp butter",
      "6 pure meat pork sausages, skins removed",
      "2 tbsp fresh breadcrumbs",
      "4 tbsp chives, finely chopped",
      "1 egg",
      "2 tbsp rosemary, finely chopped",
      "1 extra egg yolk for brushing",
      "Salt crust",
      "1kg plain flour",
      "3 large egg whites",
      "3 tbsp chopped rosemary",
      "450ml water",
      "250g fine table salt",
      "400g coarse sea salt"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "Chicken" },
      { amount: 1.0, unit: nil, name: "good quality chicken, about 2.2kg" },
      { amount: 2.0, unit: "tbsp", name: "clear honey" },
      { amount: 1.0, unit: "tbsp", name: "paprika" },
      { amount: nil, unit: nil, name: "Cracked black Pepper" },
      { amount: 6.0, unit: nil, name: "chicken livers, cleaned and trimmed of any sinew" },
      { amount: 100.0, unit: "g", name: "mixed dry mushrooms, soaked overnight" },
      { amount: 2.0, unit: "tbsp", name: "butter" },
      { amount: 6.0, unit: nil, name: "pure meat pork sausages, skins removed" },
      { amount: 2.0, unit: "tbsp", name: "fresh breadcrumbs" },
      { amount: 4.0, unit: "tbsp", name: "chives, finely chopped" },
      { amount: 1.0, unit: nil, name: "egg" },
      { amount: 2.0, unit: "tbsp", name: "rosemary, finely chopped" },
      { amount: 1.0, unit: nil, name: "extra egg yolk for brushing" },
      { amount: nil, unit: nil, name: "Salt crust" },
      { amount: 1.0, unit: "kg", name: "plain flour" },
      { amount: 3.0, unit: nil, name: "large egg whites" },
      { amount: 3.0, unit: "tbsp", name: "chopped rosemary" },
      { amount: 450.0, unit: "ml", name: "water" },
      { amount: 250.0, unit: "g", name: "fine table salt" },
      { amount: 400.0, unit: "g", name: "coarse sea salt" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Mix the honey with the paprika and pepper, then brush all over the chicken. This is best done the day before and repeated 2 or 3 times. Keep in the refrigerator overnight.",
      "Next make your stuffing, so it has a chance to cool down. Clean the livers first, and cut out any sinew. Cut the livers into large dice. Drain the soaked mushrooms, and chop them up roughly.",
      "Add the butter to a frying pan and when it is foaming, add the livers and mushrooms. Continue to cook and stir for 4-5 minutes or until the liver is completely cooked. Season with salt and pepper and then tip the mixture onto a tray to cool quickly.",
      "When cool, add the sausage meat and mix well with a fork. Then add the breadcrumbs, chives, rosemary, and egg, and mix well.",
      "Push the stuffing into the cavity of the chicken until it’s filled up well. Then spin the bird around, fold back any skin around the neck area and push the rest of the stuffing down the neck area.",
      "To make the salt crust, mix all the ingredients together with the water to form a dough. Remove from the bowl and place onto a flat surface and knead until a smooth dough forms. Sprinkle the surface with a little extra flour and remove ¼ of the dough.",
      "Roll this out to 1cm thickness for the base and lay down onto a lined oven tray. Place the chicken on top of the pastry and roll out the remaining dough big enough to cover the chicken. Place it on top and press the dough around to seal to the base of the dough. Cut off any excess with a sharp knife.",
      "Bake in a preheated oven at 200°C for 1 hour and 10 minutes, then leave to rest out of the oven for 30 minutes before breaking open the crust and serving."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Mix the honey with the paprika and pepper, then brush all over the chicken. This is best done the day before and repeated 2 or 3 times. Keep in the refrigerator overnight.\nNext make your stuffing, so it has a chance to cool down. Clean the livers first, and cut out any sinew. Cut the livers into large dice. Drain the soaked mushrooms, and chop them up roughly.\nAdd the butter to a frying pan and when it is foaming, add the livers and mushrooms. Continue to cook and stir for 4-5 minutes or until the liver is completely cooked. Season with salt and pepper and then tip the mixture onto a tray to cool quickly.\nWhen cool, add the sausage meat and mix well with a fork. Then add the breadcrumbs, chives, rosemary, and egg, and mix well.\nPush the stuffing into the cavity of the chicken until it’s filled up well. Then spin the bird around, fold back any skin around the neck area and push the rest of the stuffing down the neck area.\nTo make the salt crust, mix all the ingredients together with the water to form a dough. Remove from the bowl and place onto a flat surface and knead until a smooth dough forms. Sprinkle the surface with a little extra flour and remove ¼ of the dough.\nRoll this out to 1cm thickness for the base and lay down onto a lined oven tray. Place the chicken on top of the pastry and roll out the remaining dough big enough to cover the chicken. Place it on top and press the dough around to seal to the base of the dough. Cut off any excess with a sharp knife.\nBake in a preheated oven at 200°C for 1 hour and 10 minutes, then leave to rest out of the oven for 30 minutes before breaking open the crust and serving.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("foodnetwork.co.uk")
    expect(recipe.canonical_url).to eq("https://foodnetwork.co.uk/recipes/michel-rouxs-chicken-with-honey-and-rosemary-baked-in-a-salt-crust")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Michel Roux")
    expect(recipe.description).to eq("Michel Roux's stunning Sunday lunch main course, a chicken baked in salt crust pastry!")
    expect(recipe.image).to eq("https://d2866mruotsy8w.cloudfront.net/production/media/22875/conversions/225391_Michel_Roux's_Provence_Masterclass_S01_ep01_006-chicken-in-salt-crust-default.jpeg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.8)
    expect(recipe.ratings_count).to eq(25)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#overview")
  end
end
