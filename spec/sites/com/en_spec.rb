# frozen_string_literal: true

RSpec.describe "en.petitchef.com" do
  subject(:recipe) { scrape_cassette("com/en", url: "https://en.petitchef.com/recipes/main-dish/steamed-chinese-chicken-with-ginger-ultra-tender-and-fragrant-fid-1614626") }

  it "reads the title" do
    expect(recipe.title).to eq("Steamed chinese chicken with ginger: ultra-tender and fragrant")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 chicken thighs",
      "4 jujubes (red Chinese dates)",
      "2 green onions (green parts only)",
      "1 oz fresh ginger",
      "2 green onions (chopped, green parts only)",
      "1 oz fresh ginger (chopped)",
      "3 tbsp neutral oil",
      "1 tsp chili flakes (or gochugaru)",
      "1 tsp soy sauce",
      "1 tsp oyster sauce",
      "1 tsp sugar",
      "½ tsp sesame oil, optional",
      "Salt to taste",
      "Black pepper to taste",
      "⅔ cup rice (basmati, Thai, or jasmine)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: nil, name: "chicken thighs" },
      { amount: 4.0, unit: nil, name: "jujubes" },
      { amount: 2.0, unit: nil, name: "green onions" },
      { amount: 1.0, unit: "oz", name: "fresh ginger" },
      { amount: 2.0, unit: nil, name: "green onions" },
      { amount: 1.0, unit: "oz", name: "fresh ginger" },
      { amount: 3.0, unit: "tbsp", name: "neutral oil" },
      { amount: 1.0, unit: "tsp", name: "chili flakes" },
      { amount: 1.0, unit: "tsp", name: "soy sauce" },
      { amount: 1.0, unit: "tsp", name: "oyster sauce" },
      { amount: 1.0, unit: "tsp", name: "sugar" },
      { amount: 0.5, unit: "tsp", name: "sesame oil, optional" },
      { amount: nil, unit: nil, name: "Salt to taste" },
      { amount: nil, unit: nil, name: "Black pepper to taste" },
      { amount: 0.67, unit: "cup", name: "rice" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Bring water to a boil in a sauté pan. Add a rack to raise a soup plate; the water should not rise above the rack. Place the plate on top and set a small bowl upside down in the center of the plate.",
      "Arrange the chicken, jujubes, half of the green onions (green parts), and ginger (all cut into large pieces) on the plate around the bowl.",
      "Cover the pan and cook for at least 20 minutes over medium heat. Cut into a piece of chicken to check for doneness; cook longer if necessary.",
      "Meanwhile, prepare the rice and the sauce to serve with the chicken: chop the remaining green onions (the green parts) and ginger into very small pieces and place them in a dish or bowl.",
      "Heat the oil in a skillet, then pour it into the dish and mix everything well.",
      "Add the soy sauce, oyster sauce, sugar, salt, pepper, and chili, and mix well.",
      "When the chicken is cooked, remove the skin and bones and roughly shred the meat.",
      "Remove the pieces of ginger, green onions, and jujubes, and collect the broth from the inverted bowl.",
      "Pour the broth into the sauce and add the chicken. Mix everything together well.",
      "Serve the chicken with rice and be sure to add plenty of sauce. It's ready!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Bring water to a boil in a sauté pan. Add a rack to raise a soup plate; the water should not rise above the rack. Place the plate on top and set a small bowl upside down in the center of the plate.\nArrange the chicken, jujubes, half of the green onions (green parts), and ginger (all cut into large pieces) on the plate around the bowl.\nCover the pan and cook for at least 20 minutes over medium heat. Cut into a piece of chicken to check for doneness; cook longer if necessary.\nMeanwhile, prepare the rice and the sauce to serve with the chicken: chop the remaining green onions (the green parts) and ginger into very small pieces and place them in a dish or bowl.\nHeat the oil in a skillet, then pour it into the dish and mix everything well.\nAdd the soy sauce, oyster sauce, sugar, salt, pepper, and chili, and mix well.\nWhen the chicken is cooked, remove the skin and bones and roughly shred the meat.\nRemove the pieces of ginger, green onions, and jujubes, and collect the broth from the inverted bowl.\nPour the broth into the sauce and add the chicken. Mix everything together well.\nServe the chicken with rice and be sure to add plenty of sauce. It's ready!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("en.petitchef.com")
    expect(recipe.canonical_url).to eq("https://en.petitchef.com/recipes/main-dish/steamed-chinese-chicken-with-ginger-ultra-tender-and-fragrant-fid-1614626")
    expect(recipe.site_name).to eq("Petitchef")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Juliette Hess")
    expect(recipe.description).to eq("Tender chicken and a fragrant sauce you’ll want to pour over rice! This Chinese steamed chicken with ginger keeps the meat juicy and delicately flavored with ginger and green onions. The finishing touch is a hot oil sauce made with fresh ginger, soy sauce, oyster sauce and a hint of chili. The cooking juices enrich the sauce before being mixed with the shredded chicken, so every bite is full of flavor. Serve with hot rice for a comforting dish that’s a delicious change from pan-fried chicken.")
    expect(recipe.image).to eq("https://en.petitchef.com/imgupl/recipe/steamed-chinese-chicken-with-ginger-ultra-tender-and-fragrant--503582p908203.webp")
    expect(recipe.category).to eq("Main Dish")
    expect(recipe.cuisine).to eq("En")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq(["steamed", "chicken", "ginger", "steamed chicken recipes", "main dish"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "549g",
      "calories" => "1109Kcal",
      "carbohydrateContent" => "73.1g",
      "fatContent" => "50.8g",
      "saturatedFatContent" => "10.8g",
      "proteinContent" => "91.5g",
      "fiberContent" => "6.2g",
      "sugarContent" => "8.3g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "g", amount: 549.0 },
      { name: "calories", unit: "kcal", amount: 1109.0 },
      { name: "carbohydrateContent", unit: "g", amount: 73.1 },
      { name: "fatContent", unit: "g", amount: 50.8 },
      { name: "saturatedFatContent", unit: "g", amount: 10.8 },
      { name: "proteinContent", unit: "g", amount: 91.5 },
      { name: "fiberContent", unit: "g", amount: 6.2 },
      { name: "sugarContent", unit: "g", amount: 8.3 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#rd-carousel")
  end
end
