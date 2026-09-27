# frozen_string_literal: true

RSpec.describe "recipes.timesofindia.com" do
  subject(:recipe) { scrape_cassette("com/recipes", url: "https://recipes.timesofindia.com/recipes/chicken-65/rs53683545.cms") }

  it "reads the title" do
    expect(recipe.title).to eq("Chicken 65 Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "500 grams chicken",
      "1 pinch red chilli powder",
      "2 tablespoon coriander powder",
      "1/2 teaspoon turmeric",
      "4 tablespoon yoghurt (curd)",
      "1 tablespoon curry leaves",
      "4 Numbers green chilli",
      "4 tablespoon tomato ketchup",
      "4 tablespoon mustard oil",
      "0 As required salt",
      "1 stalk spring onions chopped"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 500.0, unit: "grams", name: "chicken" },
      { amount: 1.0, unit: "pinch", name: "red chilli powder" },
      { amount: 2.0, unit: "tablespoon", name: "coriander powder" },
      { amount: 0.5, unit: "teaspoon", name: "turmeric" },
      { amount: 4.0, unit: "tablespoon", name: "yoghurt" },
      { amount: 1.0, unit: "tablespoon", name: "curry leaves" },
      { amount: 4.0, unit: nil, name: "Numbers green chilli" },
      { amount: 4.0, unit: "tablespoon", name: "tomato ketchup" },
      { amount: 4.0, unit: "tablespoon", name: "mustard oil" },
      { amount: nil, unit: nil, name: "As required salt" },
      { amount: 1.0, unit: "stalk", name: "spring onions chopped" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "For the marination, take a bowl and mix chilli powder, coriander powder, turmeric powder, curd and salt together. This marination step is very important and will give this chicken recipe real flavour.",
      "Now, wash the chicken in cold running water and chop it. Once it is done, add the chicken pieces to the marinade. Once the chicken pieces are well-coated, keep them aside for 4-5 hours so that flavours are well absorbed. You can keep them in the refrigerator.",
      "Now, take a deep-bottomed pan and heat oil in it over medium flame. Once the oil is sufficiently hot, carefully put the marinated chicken pieces in the oil and shallow fry them till cooked or golden from both sides.",
      "Now, remove and cook the chicken pieces in a separate pan without oil over low flame. This step will make the chicken crispier. Once done, add the green chillies, curry leaves and ketchup. Mix well till the chicken pieces are well coated and continue to cook over medium heat for 5-6 minutes. Transfer the dish in a serving bowl and garnish it with chopped spring onions.",
      "Chicken 65 is ready. Serve as a snack or you can pair this easy snack recipe with drinks of your choice. Prepare this delectable snack on weekends or when guests are coming over!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("For the marination, take a bowl and mix chilli powder, coriander powder, turmeric powder, curd and salt together. This marination step is very important and will give this chicken recipe real flavour.\nNow, wash the chicken in cold running water and chop it. Once it is done, add the chicken pieces to the marinade. Once the chicken pieces are well-coated, keep them aside for 4-5 hours so that flavours are well absorbed. You can keep them in the refrigerator.\nNow, take a deep-bottomed pan and heat oil in it over medium flame. Once the oil is sufficiently hot, carefully put the marinated chicken pieces in the oil and shallow fry them till cooked or golden from both sides.\nNow, remove and cook the chicken pieces in a separate pan without oil over low flame. This step will make the chicken crispier. Once done, add the green chillies, curry leaves and ketchup. Mix well till the chicken pieces are well coated and continue to cook over medium heat for 5-6 minutes. Transfer the dish in a serving bowl and garnish it with chopped spring onions.\nChicken 65 is ready. Serve as a snack or you can pair this easy snack recipe with drinks of your choice. Prepare this delectable snack on weekends or when guests are coming over!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("recipes.timesofindia.com")
    expect(recipe.canonical_url).to eq("https://recipes.timesofindia.com/recipes/chicken-65/rs53683545.cms")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("TNN")
    expect(recipe.description).to eq("One of the spiciest chicken delicacies of South Indian cuisine, Chicken 65 is a delight for meat lovers. It can be enjoyed on any occasion and is super-easy to make. If you are wondering how to make this delicacy, then here is the detailed recipe of Chicken 65 explained with step-by-step images. So, what are you wondering? Go for this amazing chicken 65 recipe and let us know your feedback in the comment box below. If you are wondering how to make Chicken 65 recipe at home, we have just the recipe for you! This chicken 65 recipe will help you make delicious, spicy and authentic South Indian chicken dish in under an hour. The Recipe of Chicken 65 is a tasty chicken starter recipe that you can try at your next house party. With this super easy chicken 65 recipe, your friends and family are sure to shower you with compliments. Children will absolutely love the crispy and spicy chicken 65 in their snacks. Chicken 65 is prepared using chicken marinated in spices and flavoured with tomato ketchup and yoghurt. It is also perfect for occasions like kitty parties, birthdays and anniversaries. In this chicken 65 recipe, bite-sized chicken pieces are marinated and deep-fried. This interesting chicken recipe is a perfect amalgamation of spices, tangy yoghurt and juicy chicken. To make this appetizer dish more delectable you can dry roast the spices separately and grind them, this accentuates the taste of the chicken recipe and makes it more aromatic. You can add your own twist of flavours to this crispy and delicious chicken recipe. This chicken 65 dish is for all the spice lovers out there as it is high on spice quotient. Here’s how to make chicken 65 at home with some very simple steps. The taste of this recipe depends a lot on the marinade. If you want to make it less spicy and creamy, add some fresh cream. To make it more aromatic, crush dry curry leaves and use them for marinating. This melange of southern spices and tender chicken makes for a perfectly seasoned dish to relish. You can pair this easy chicken 65 recipe snack with drinks of your choice.")
    expect(recipe.image).to eq("https://static.toiimg.com/thumb/53683545.cms?width=1200&height=900")
    expect(recipe.category).to eq("Appetizers")
    expect(recipe.cuisine).to eq("South Indian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["chicken 65 recipe", "recipe for chicken 65", "how to make chicken 65 at home", "easy chicken 65 recipe", "chicken 65 ingredients", "homemade chicken 65 recipe", "how to prepare chicken 65"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(3.8)
    expect(recipe.ratings_count).to eq(30)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 bowl",
      "calories" => "372 cal"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "bowl", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 372.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("javascript://")
  end
end
