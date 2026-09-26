# frozen_string_literal: true

RSpec.describe "paleorunningmomma.com" do
  subject(:recipe) { scrape_cassette("com/paleorunningmomma", url: "https://www.paleorunningmomma.com/paleo-beef-stroganoff-whole30-keto/") }

  it "reads the title" do
    expect(recipe.title).to eq("Paleo Beef Stroganoff {Whole30, Keto}")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "5 Tbsp ghee (divided)",
      "1.5 lb top sirloin or tenderloin (thinly sliced into 1/2” x 2” strips)",
      "1 large onion (thinly sliced)",
      "Sea salt and black pepper to taste",
      "8 oz mushrooms (sliced)",
      "3 cloves garlic (minced)",
      "2 cups beef broth",
      "1 Tbsp coconut aminos",
      "2 Tbsp arrowroot flour (or tapioca)",
      "Salt to taste and black pepper to taste",
      "1 cup coconut cream (canned, unsweetened)",
      "1 Tbsp fresh lemon juice",
      "1 tsp dijon mustard",
      "Pinch Sea salt",
      "Sea salt and black pepper to taste",
      "Minced parsley (for garnish)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 5.0, unit: "Tbsp", name: "ghee" },
      { amount: 1.5, unit: "lb", name: "top sirloin or tenderloin" },
      { amount: 1.0, unit: nil, name: "large onion" },
      { amount: nil, unit: nil, name: "Sea salt and black pepper to taste" },
      { amount: 8.0, unit: "oz", name: "mushrooms" },
      { amount: 3.0, unit: "cloves", name: "garlic" },
      { amount: 2.0, unit: "cups", name: "beef broth" },
      { amount: 1.0, unit: "Tbsp", name: "coconut aminos" },
      { amount: 2.0, unit: "Tbsp", name: "arrowroot flour" },
      { amount: nil, unit: nil, name: "Salt to taste and black pepper to taste" },
      { amount: 1.0, unit: "cup", name: "coconut cream" },
      { amount: 1.0, unit: "Tbsp", name: "fresh lemon juice" },
      { amount: 1.0, unit: "tsp", name: "dijon mustard" },
      { amount: 1.0, unit: "Pinch", name: "Sea salt" },
      { amount: nil, unit: nil, name: "Sea salt and black pepper to taste" },
      { amount: nil, unit: nil, name: "Minced parsley" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large deep skillet, melt 2 tablespoons of the ghee over medium-high heat.",
      "Add the steak in a single layer, season with salt and pepper, and let it cook for 3 minutes to brown. Flip, and cook on the other side until browned, another 2 minutes. Then remove steak from pan with a slotted spoon, transfer to a plate, and set aside.",
      "Lower the heat to medium and the remaining 3 tablespoons of ghee to the skillet. Once it has melted, add the onions and sauté for about 3 minutes, until soft and fragrant. Add mushrooms and sauté for an additional 5-7 minutes, stirring occasionally, or until the mushrooms are cooked and the onions are soft, then add the garlic and sauté 1 minute, stirring occasionally.",
      "In a bowl or large measuring cup, whisk in together the beef broth, coconut aminos and arrowroot until smooth. Pour the mixture into the skillet and stir well to combine. Simmer for about 5 minutes, stirring occasionally. Meanwhile, in a separate small bowl whisk together the coconut cream, lemon juice, mustard and a pinch of sea salt. Stir the coconut cream mixture plus the cooked steak into the skillet and stir until combined. Taste and season with additional salt and pepper if needed, and cook just long enough to heat through.",
      "Garnish with parsley, if desired, and serve over cauliflower rice or your favorite veggie noodles. Enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large deep skillet, melt 2 tablespoons of the ghee over medium-high heat.\nAdd the steak in a single layer, season with salt and pepper, and let it cook for 3 minutes to brown. Flip, and cook on the other side until browned, another 2 minutes. Then remove steak from pan with a slotted spoon, transfer to a plate, and set aside.\nLower the heat to medium and the remaining 3 tablespoons of ghee to the skillet. Once it has melted, add the onions and sauté for about 3 minutes, until soft and fragrant. Add mushrooms and sauté for an additional 5-7 minutes, stirring occasionally, or until the mushrooms are cooked and the onions are soft, then add the garlic and sauté 1 minute, stirring occasionally.\nIn a bowl or large measuring cup, whisk in together the beef broth, coconut aminos and arrowroot until smooth. Pour the mixture into the skillet and stir well to combine. Simmer for about 5 minutes, stirring occasionally. Meanwhile, in a separate small bowl whisk together the coconut cream, lemon juice, mustard and a pinch of sea salt. Stir the coconut cream mixture plus the cooked steak into the skillet and stir until combined. Taste and season with additional salt and pepper if needed, and cook just long enough to heat through.\nGarnish with parsley, if desired, and serve over cauliflower rice or your favorite veggie noodles. Enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("paleorunningmomma.com")
    expect(recipe.canonical_url).to eq("https://www.paleorunningmomma.com/paleo-beef-stroganoff-whole30-keto/")
    expect(recipe.site_name).to eq("The Paleo Running Momma")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Michele")
    expect(recipe.description).to eq("This hearty and savory paleo beef stroganoff is made all in one skillet for a quick, delicious and cozy weeknight meal. It’s Whole30 compliant, low carb and keto and perfect served over sautéed cauliflower rice or your favorite veggie noodles!")
    expect(recipe.image).to eq("https://www.paleorunningmomma.com/wp-content/uploads/2020/12/beef-stroganoff-9.jpg")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to eq("Gluten-free")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(["beef", "dinner", "keto", "low carb", "paleo", "stroganoff", "whole30"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.53)
    expect(recipe.ratings_count).to eq(165)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "422 kcal",
      "carbohydrateContent" => "9 g",
      "proteinContent" => "29 g",
      "fatContent" => "31 g",
      "saturatedFatContent" => "22 g",
      "cholesterolContent" => "99 mg",
      "sodiumContent" => "432 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "2 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 422.0 },
      { name: "carbohydrateContent", unit: "g", amount: 9.0 },
      { name: "proteinContent", unit: "g", amount: 29.0 },
      { name: "fatContent", unit: "g", amount: 31.0 },
      { name: "saturatedFatContent", unit: "g", amount: 22.0 },
      { name: "cholesterolContent", unit: "mg", amount: 99.0 },
      { name: "sodiumContent", unit: "mg", amount: 432.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 2.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
