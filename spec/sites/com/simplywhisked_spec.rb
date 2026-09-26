# frozen_string_literal: true

RSpec.describe "simplywhisked.com" do
  subject(:recipe) { scrape_cassette("com/simplywhisked", url: "https://www.simplywhisked.com/buffalo-chicken-chili/") }

  it "reads the title" do
    expect(recipe.title).to eq("Buffalo Chicken Chili")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 tablespoons olive oil",
      "1 small onion (chopped (about 1 cup))",
      "2 stalks celery (chopped)",
      "6 garlic cloves (minced)",
      "1 1/2 - 2 pounds ground chicken",
      "1 cup water (or reduced-sodium broth)",
      "1 15- ounce can petite diced tomatoes",
      "2 15- ounce cans chili beans (with sauce)",
      "2 tablespoos chili powder",
      "2 teaspoons ground cumin",
      "2 teaspoons paprika",
      "1 bay leaf",
      "1 teaspoon salt",
      "1/2 teaspoon pepper",
      "1/2 cup buffalo wing sauce"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "tablespoons", name: "olive oil" },
      { amount: 1.0, unit: nil, name: "small onion" },
      { amount: 2.0, unit: "stalks", name: "celery" },
      { amount: 6.0, unit: nil, name: "garlic cloves" },
      { amount: 1.5, unit: "pounds", name: "ground chicken" },
      { amount: 1.0, unit: "cup", name: "water" },
      { amount: 1.0, unit: "can", name: "petite diced tomatoes" },
      { amount: 2.0, unit: "cans", name: "chili beans" },
      { amount: 2.0, unit: nil, name: "tablespoos chili powder" },
      { amount: 2.0, unit: "teaspoons", name: "ground cumin" },
      { amount: 2.0, unit: "teaspoons", name: "paprika" },
      { amount: 1.0, unit: nil, name: "bay leaf" },
      { amount: 1.0, unit: "teaspoon", name: "salt" },
      { amount: 0.5, unit: "teaspoon", name: "pepper" },
      { amount: 0.5, unit: "cup", name: "buffalo wing sauce" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large stockpot or dutch oven, heat olive oil to medium-high. Add the bell pepper, onion, celery and garlic. Sauté until onions are translucent, about 5 minutes.",
      "Add ground chicken. Breaking up the meat as chicken browns, cook until no longer pink, about 5 minutes.",
      "Add water, tomatoes, beans, chili powder, cumin, bay leaf, buffalo sauce, and salt & pepper. Bring to a simmer.",
      "Cover and allow chili to cook for at least 15 minutes, simmering to desired thickness.",
      "Before serving, remove bay leaf and adjust seasoning with salt & pepper, to taste."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large stockpot or dutch oven, heat olive oil to medium-high. Add the bell pepper, onion, celery and garlic. Sauté until onions are translucent, about 5 minutes.\nAdd ground chicken. Breaking up the meat as chicken browns, cook until no longer pink, about 5 minutes.\nAdd water, tomatoes, beans, chili powder, cumin, bay leaf, buffalo sauce, and salt & pepper. Bring to a simmer.\nCover and allow chili to cook for at least 15 minutes, simmering to desired thickness.\nBefore serving, remove bay leaf and adjust seasoning with salt & pepper, to taste.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("simplywhisked.com")
    expect(recipe.canonical_url).to eq("https://www.simplywhisked.com/buffalo-chicken-chili/")
    expect(recipe.site_name).to eq("Simply Whisked")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Melissa Belanger")
    expect(recipe.description).to eq("This buffalo chicken chili is a hearty, go-to meal that can be ready pretty quickly. The buffalo flavor is the perfect amount of spicy. Make this for your next football game, everyone will love it!")
    expect(recipe.image).to eq("https://www.simplywhisked.com/wp-content/uploads/2016/02/Buffalo-Chicken-Chili-4-1.jpg")
    expect(recipe.category).to eq("Soups")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(["beans", "buffalo", "chili", "dairy free", "easy", "egg free", "healthy"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "240 kcal",
      "sugarContent" => "6 g",
      "sodiumContent" => "1318 mg",
      "fatContent" => "11 g",
      "transFatContent" => "0.1 g",
      "carbohydrateContent" => "17 g",
      "fiberContent" => "4 g",
      "proteinContent" => "19 g",
      "cholesterolContent" => "73 mg",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 240.0 },
      { name: "sugarContent", unit: "g", amount: 6.0 },
      { name: "sodiumContent", unit: "mg", amount: 1318.0 },
      { name: "fatContent", unit: "g", amount: 11.0 },
      { name: "transFatContent", unit: "g", amount: 0.1 },
      { name: "carbohydrateContent", unit: "g", amount: 17.0 },
      { name: "fiberContent", unit: "g", amount: 4.0 },
      { name: "proteinContent", unit: "g", amount: 19.0 },
      { name: "cholesterolContent", unit: "mg", amount: 73.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
