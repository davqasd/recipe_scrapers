# frozen_string_literal: true

RSpec.describe "sundaysuppermovement.com" do
  subject(:recipe) { scrape_cassette("com/sundaysuppermovement", url: "https://sundaysuppermovement.com/best-chicken-cordon-bleu-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Chicken Cordon Bleu Recipe with Sauce")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 chicken breasts",
      "8 slices Swiss cheese",
      "4 slices thinly sliced ham",
      "salt and pepper",
      "2 beaten eggs",
      "¾ cup of flour",
      "¾ dry breadcrumbs",
      "4 Tbsp. butter",
      "¼ cup flour",
      "1½ cups 2% milk",
      "½ cup grated Parmesan"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: nil, name: "chicken breasts" },
      { amount: 8.0, unit: "slices", name: "Swiss cheese" },
      { amount: 4.0, unit: "slices", name: "thinly sliced ham" },
      { amount: nil, unit: nil, name: "salt and pepper" },
      { amount: 2.0, unit: nil, name: "beaten eggs" },
      { amount: 0.75, unit: "cup", name: "flour" },
      { amount: 0.75, unit: nil, name: "dry breadcrumbs" },
      { amount: 4.0, unit: "Tbsp", name: "butter" },
      { amount: 0.25, unit: "cup", name: "flour" },
      { amount: 1.5, unit: "cups", name: "2% milk" },
      { amount: 0.5, unit: "cup", name: "grated Parmesan" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Baking Chicken Cordon Bleu",
      "bake",
      "Preheat oven to 350°F. Tip ¾ dry breadcrumbs onto a baking sheet, and spread them out evenly. Place the baking sheet in the center of the preheated oven and bake for 10 minutes or until golden brown. At the 5 minute mark, stir the breadcrumbs.",
      "flatten",
      "Pat 4 chicken breasts dry, then place them on a sheet of plastic wrap and cover them with another sheet of plastic wrap on top. Use a meat mallet or a rolling pin to pound the chicken breasts flat. You can also butterfly them by cutting them in half horizontally if you prefer. Once flat, season on both sides with salt and pepper.",
      "layer",
      "Lay out the flat chicken breasts side by side, and top each one with a layer of 2 slices of Swiss cheese, then a layer of 1 slice of ham. You will need a total of 8 slices Swiss cheese and 4 slices thinly sliced ham.",
      "roll",
      "Roll up each breast into a pinwheel with the cheese and ham on the inside.",
      "dredge",
      "You need 3 large shallow bowls. Place ¾ cup of flour in the first dish, 2 beaten eggs in the second dish, and toasted breadcrumbs in the third dish. Carefully take each chicken breast and, one at a time, roll in the flour until fully coated.",
      "roll",
      "Roll the floured chicken in the whisked egg.",
      "coat",
      "Finally, place into the breadcrumbs and fully coat all over.",
      "refrigerate",
      "Next, place each chicken breast onto its own piece of plastic wrap. Use the wrap to roll up tightly and seal off each end. Once sealed, roll the chicken into a nice round cylinder shape. Chill the chicken in the refrigerator for at least 30 minutes so the shape will set and hold while cooking. If you are preparing the recipe in advance, you can leave it in the fridge all day before cooking.",
      "bake",
      "Preheat the oven to 350°F when ready to bake. Unwrap the chicken and place on a baking tray. Bake for 35 minutes, or until chicken is piping hot and cooked through.",
      "Creating the Cordon Bleu Sauce",
      "stir",
      "While the chicken bakes, place a small pan on medium-low heat. Add 4 Tbsp. butter and allow to melt. Once it melts, add ¼ cup flour and stir into a paste.",
      "add",
      "Slowly begin adding the 1½ cups 2% milk. Add the milk gradually and continuously stir to prevent lumps from forming. After each addition of milk, stir the sauce well. Allow it to thicken again before adding more milk. Continue to stir after adding milk until the sauce thickens.",
      "simmer",
      "When the sauce simmers, remove from the heat. While the sauce is still hot, add ½ cup grated Parmesan and stir in until it melts and the sauce is smooth.",
      "serve",
      "Once the chicken is cooked remove from the oven and slice. Plate up and drizzle over the creamy Parmesan sauce. Serve and enjoy!"
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["For the chicken cordon bleu:", 7],
        ["For the cordon bleu sauce:", 4]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Baking Chicken Cordon Bleu\nbake\nPreheat oven to 350°F. Tip ¾ dry breadcrumbs onto a baking sheet, and spread them out evenly. Place the baking sheet in the center of the preheated oven and bake for 10 minutes or until golden brown. At the 5 minute mark, stir the breadcrumbs.\nflatten\nPat 4 chicken breasts dry, then place them on a sheet of plastic wrap and cover them with another sheet of plastic wrap on top. Use a meat mallet or a rolling pin to pound the chicken breasts flat. You can also butterfly them by cutting them in half horizontally if you prefer. Once flat, season on both sides with salt and pepper.\nlayer\nLay out the flat chicken breasts side by side, and top each one with a layer of 2 slices of Swiss cheese, then a layer of 1 slice of ham. You will need a total of 8 slices Swiss cheese and 4 slices thinly sliced ham.\nroll\nRoll up each breast into a pinwheel with the cheese and ham on the inside.\ndredge\nYou need 3 large shallow bowls. Place ¾ cup of flour in the first dish, 2 beaten eggs in the second dish, and toasted breadcrumbs in the third dish. Carefully take each chicken breast and, one at a time, roll in the flour until fully coated.\nroll\nRoll the floured chicken in the whisked egg.\ncoat\nFinally, place into the breadcrumbs and fully coat all over.\nrefrigerate\nNext, place each chicken breast onto its own piece of plastic wrap. Use the wrap to roll up tightly and seal off each end. Once sealed, roll the chicken into a nice round cylinder shape. Chill the chicken in the refrigerator for at least 30 minutes so the shape will set and hold while cooking. If you are preparing the recipe in advance, you can leave it in the fridge all day before cooking.\nbake\nPreheat the oven to 350°F when ready to bake. Unwrap the chicken and place on a baking tray. Bake for 35 minutes, or until chicken is piping hot and cooked through.\nCreating the Cordon Bleu Sauce\nstir\nWhile the chicken bakes, place a small pan on medium-low heat. Add 4 Tbsp. butter and allow to melt. Once it melts, add ¼ cup flour and stir into a paste.\nadd\nSlowly begin adding the 1½ cups 2% milk. Add the milk gradually and continuously stir to prevent lumps from forming. After each addition of milk, stir the sauce well. Allow it to thicken again before adding more milk. Continue to stir after adding milk until the sauce thickens.\nsimmer\nWhen the sauce simmers, remove from the heat. While the sauce is still hot, add ½ cup grated Parmesan and stir in until it melts and the sauce is smooth.\nserve\nOnce the chicken is cooked remove from the oven and slice. Plate up and drizzle over the creamy Parmesan sauce. Serve and enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("sundaysuppermovement.com")
    expect(recipe.canonical_url).to eq("https://sundaysuppermovement.com/best-chicken-cordon-bleu-recipe/")
    expect(recipe.site_name).to eq("Sunday Supper Movement")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Isabel Laessig")
    expect(recipe.description).to eq("Crispy on the outside and filled with nutty cheese and salty ham on the inside, this delicious Chicken Cordon Bleu recipe with sauce is a must-try dinner.")
    expect(recipe.image).to eq("https://sundaysuppermovement.com/wp-content/uploads/2019/10/Chicken-Cordon-Bleu-hero.jpg")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(80)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(35)
    expect(recipe.keywords).to eq(["baked", "breaded", "cheese sauce", "chicken breasts", "chicken cordon bleu"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.8)
    expect(recipe.ratings_count).to eq(49)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 chicken breast",
      "calories" => "793 kcal",
      "carbohydrateContent" => "32 g",
      "proteinContent" => "80 g",
      "fatContent" => "36 g",
      "saturatedFatContent" => "19 g",
      "cholesterolContent" => "318 mg",
      "sodiumContent" => "805 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "6 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "chicken", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 793.0 },
      { name: "carbohydrateContent", unit: "g", amount: 32.0 },
      { name: "proteinContent", unit: "g", amount: 80.0 },
      { name: "fatContent", unit: "g", amount: 36.0 },
      { name: "saturatedFatContent", unit: "g", amount: 19.0 },
      { name: "cholesterolContent", unit: "mg", amount: 318.0 },
      { name: "sodiumContent", unit: "mg", amount: 805.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 6.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-content")
  end
end
