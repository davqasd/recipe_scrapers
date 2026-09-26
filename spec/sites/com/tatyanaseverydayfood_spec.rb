# frozen_string_literal: true

RSpec.describe "tatyanaseverydayfood.com" do
  subject(:recipe) { scrape_cassette("com/tatyanaseverydayfood", url: "https://tatyanaseverydayfood.com/smoked-salmon-chowder/") }

  it "reads the title" do
    expect(recipe.title).to eq("Creamy Smoked Salmon Chowder with Bacon (video)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "8 slices smoked bacon (diced)",
      "1 large sweet onion (diced)",
      "3 medium carrots (diced)",
      "2 large celery sticks (diced)",
      "6 garlic cloves (finely minced)",
      "1 tbsp fresh thyme",
      "1 tbsp fresh rosemary (chopped)",
      "1 1/2 tsp sea salt",
      "1/2 tsp ground black pepper",
      "1 tsp smoked paprika",
      "2 tbsp ketchup (or tomato paste)",
      "1/4 cup all-purpose flour",
      "6 cups chicken broth",
      "1 pound mini potato gnocchi (or 3 medium potatoes)",
      "1 pound hot smoked salmon",
      "1 1/2 cups corn (canned, or fresh)",
      "1 cup whole milk",
      "1 cup heavy cream (or half-and-half)",
      "1 1/2 cups grated parmesan cheese",
      "1/4 cup fresh dill (chopped)",
      "1/4 cup fresh parsley (chopped)",
      "1 lemon (for serving)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 8.0, unit: "slices", name: "smoked bacon" },
      { amount: 1.0, unit: nil, name: "large sweet onion" },
      { amount: 3.0, unit: nil, name: "medium carrots" },
      { amount: 2.0, unit: nil, name: "large celery sticks" },
      { amount: 6.0, unit: nil, name: "garlic cloves" },
      { amount: 1.0, unit: "tbsp", name: "fresh thyme" },
      { amount: 1.0, unit: "tbsp", name: "fresh rosemary" },
      { amount: 1.5, unit: "tsp", name: "sea salt" },
      { amount: 0.5, unit: "tsp", name: "ground black pepper" },
      { amount: 1.0, unit: "tsp", name: "smoked paprika" },
      { amount: 2.0, unit: "tbsp", name: "ketchup" },
      { amount: 0.25, unit: "cup", name: "all-purpose flour" },
      { amount: 6.0, unit: "cups", name: "chicken broth" },
      { amount: 1.0, unit: "pound", name: "mini potato gnocchi" },
      { amount: 1.0, unit: "pound", name: "hot smoked salmon" },
      { amount: 1.5, unit: "cups", name: "corn" },
      { amount: 1.0, unit: "cup", name: "whole milk" },
      { amount: 1.0, unit: "cup", name: "heavy cream" },
      { amount: 1.5, unit: "cups", name: "grated parmesan cheese" },
      { amount: 0.25, unit: "cup", name: "fresh dill" },
      { amount: 0.25, unit: "cup", name: "fresh parsley" },
      { amount: 1.0, unit: nil, name: "lemon" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preparing the Soup Base:",
      "Preheat a large soup pot over medium heat. Once the pot is hot, add in the diced bacon and fry for 6 to 8 minutes, until the bacon bits are golden and crispy. Remove the bits with a slotted spoon and set aside.",
      "Into the bacon fat, add the onion, carrots and celery. If there is too little fat, add in a few tablespoons of butter. Fry the mirepoix mixture for 8 to 10 minutes, until the onion is tender and translucent.",
      "If you are using fresh corn, add it to the mirepoix at this point in the recipe.",
      "Next, add in the garlic and all the spices and herbs: thyme, rosemary, smoked paprika, salt and pepper. Also add in the ketchup/tomato paste. Stir and cook for about 1 minute, until the garlic is aromatic.",
      "Sprinkle the flour over the mirepoix mixture and stir it in until it’s completely incorporated. Cook for 1 minute.",
      "Making Salmon Chowder:",
      "Add in 1 cup of chicken broth and deglaze the pan, then add the remaining broth. Return the bacon bits back into the pot and cover with a lid. Allow the soup to come up to a simmer and cook for 15 to 20 minutes.",
      "While the soup is cooking, prepare the smoked salmon. Peel and discard the skin, then use a sharp knife and cube and pull apart the salmon into chunks. It will flake naturally, too.",
      "Next, add in the mini gnocchi and cook according to package instructions. Some varieties may require more or less time, but approximately 5 minutes is a good cooking time.",
      "Lastly, add in the canned corn, the smoked salmon, and pour in the milk and cream. Sprinkle in the grated parmesan, fresh dill and parsley.",
      "Bring the chowder to a simmer over medium heat, stirring occasionally. Do not boil the soup after adding the dairy! It can boil over easily! Once it starts to simmer, remove the soup from the heat, cover and let it stand for 30 minutes, allowing the smoked salmon flavors to really season the soup.",
      "Serving Suggestions:",
      "Serve this smoky salmon chowder with more grated parmesan cheese over the top and sprinkle with dill and parsley. Squeeze some fresh lemon juice over the top for a bit of freshness.",
      "Top with oyster crackers or serve with toasted bread or baguette. Reheat any leftovers on the stove top.",
      "Using Potatoes for the Recipe:",
      "If you want to use potatoes, replace the gnocchi with 3 large potatoes. Peel and cube the potatoes into small pieces (about 1/3 to ½-inch cubes).",
      "Add the potatoes to the soup, along with the chicken broth and bacon. Simmer for 15 to 20 minutes, until the potatoes are tender."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preparing the Soup Base:\nPreheat a large soup pot over medium heat. Once the pot is hot, add in the diced bacon and fry for 6 to 8 minutes, until the bacon bits are golden and crispy. Remove the bits with a slotted spoon and set aside.\nInto the bacon fat, add the onion, carrots and celery. If there is too little fat, add in a few tablespoons of butter. Fry the mirepoix mixture for 8 to 10 minutes, until the onion is tender and translucent.\nIf you are using fresh corn, add it to the mirepoix at this point in the recipe.\nNext, add in the garlic and all the spices and herbs: thyme, rosemary, smoked paprika, salt and pepper. Also add in the ketchup/tomato paste. Stir and cook for about 1 minute, until the garlic is aromatic.\nSprinkle the flour over the mirepoix mixture and stir it in until it’s completely incorporated. Cook for 1 minute.\nMaking Salmon Chowder:\nAdd in 1 cup of chicken broth and deglaze the pan, then add the remaining broth. Return the bacon bits back into the pot and cover with a lid. Allow the soup to come up to a simmer and cook for 15 to 20 minutes.\nWhile the soup is cooking, prepare the smoked salmon. Peel and discard the skin, then use a sharp knife and cube and pull apart the salmon into chunks. It will flake naturally, too.\nNext, add in the mini gnocchi and cook according to package instructions. Some varieties may require more or less time, but approximately 5 minutes is a good cooking time.\nLastly, add in the canned corn, the smoked salmon, and pour in the milk and cream. Sprinkle in the grated parmesan, fresh dill and parsley.\nBring the chowder to a simmer over medium heat, stirring occasionally. Do not boil the soup after adding the dairy! It can boil over easily! Once it starts to simmer, remove the soup from the heat, cover and let it stand for 30 minutes, allowing the smoked salmon flavors to really season the soup.\nServing Suggestions:\nServe this smoky salmon chowder with more grated parmesan cheese over the top and sprinkle with dill and parsley. Squeeze some fresh lemon juice over the top for a bit of freshness.\nTop with oyster crackers or serve with toasted bread or baguette. Reheat any leftovers on the stove top.\nUsing Potatoes for the Recipe:\nIf you want to use potatoes, replace the gnocchi with 3 large potatoes. Peel and cube the potatoes into small pieces (about 1/3 to ½-inch cubes).\nAdd the potatoes to the soup, along with the chicken broth and bacon. Simmer for 15 to 20 minutes, until the potatoes are tender.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("tatyanaseverydayfood.com")
    expect(recipe.canonical_url).to eq("https://tatyanaseverydayfood.com/smoked-salmon-chowder/")
    expect(recipe.site_name).to eq("Tatyanas Everyday Food")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("tatyanaseverydayfood")
    expect(recipe.description).to eq("The best smoked salmon chowder recipe! Creamy seafood chowder made with bacon, corn, smoked salmon, cream, dill and parmesan cheese!")
    expect(recipe.image).to eq("https://tatyanaseverydayfood.com/wp-content/uploads/2022/10/Smoked-Salmon-Chowder-Recipe-3.jpg")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("14 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(45)
    expect(recipe.keywords).to eq([
      "bacon",
      "comfort food",
      "cream",
      "creamy soup",
      "dill",
      "fall",
      "lemon",
      "parmesan cheese",
      "salmon soup",
      "seafood chowder",
      "seafood soup",
      "smoked salmon",
      "smoked salmon chowder",
      "winter"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(6)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 cup",
      "calories" => "313 kcal",
      "carbohydrateContent" => "26 g",
      "proteinContent" => "15 g",
      "fatContent" => "17 g",
      "saturatedFatContent" => "8 g",
      "transFatContent" => "0.02 g",
      "cholesterolContent" => "48 mg",
      "sodiumContent" => "1313 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "5 g",
      "unsaturatedFatContent" => "7 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "cup", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 313.0 },
      { name: "carbohydrateContent", unit: "g", amount: 26.0 },
      { name: "proteinContent", unit: "g", amount: 15.0 },
      { name: "fatContent", unit: "g", amount: 17.0 },
      { name: "saturatedFatContent", unit: "g", amount: 8.0 },
      { name: "transFatContent", unit: "g", amount: 0.02 },
      { name: "cholesterolContent", unit: "mg", amount: 48.0 },
      { name: "sodiumContent", unit: "mg", amount: 1313.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 5.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 7.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://tatyanaseverydayfood.com")
  end
end
