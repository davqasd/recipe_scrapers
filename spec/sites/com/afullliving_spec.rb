# frozen_string_literal: true

RSpec.describe "afullliving.com" do
  subject(:recipe) { scrape_cassette("com/afullliving", url: "https://afullliving.com/chicken-butternut-squash-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Chicken and Butternut Squash Recipe with Parmesan Sauce")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 tablespoons unsalted butter",
      "2 pounds chicken thighs, bone-in and skin-on (can also use skinless and boneless if desired)",
      "1 tablespoon fresh thyme",
      "2 tablespoons Italian seasoning",
      "1.5 teaspoons kosher salt",
      "black pepper, to taste (start with about 1/2 a teaspoon of coarse ground black pepper)",
      "2 tablespoons olive oil",
      "300 grams butternut squash, peeled and cubed ((about half of a medium butternut squash) )",
      "8 ounces fresh spinach",
      "4 cloves garlic, minced",
      "1 cup chicken broth",
      "1 cup heavy whipping cream",
      "4 ounces parmesan cheese, shredded or grated",
      "To garnish: thyme sprigs, grated parmesan cheese"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "tablespoons", name: "unsalted butter" },
      { amount: 2.0, unit: "pounds", name: "chicken thighs, bone-in and skin-on" },
      { amount: 1.0, unit: "tablespoon", name: "fresh thyme" },
      { amount: 2.0, unit: "tablespoons", name: "Italian seasoning" },
      { amount: 1.5, unit: "teaspoons", name: "kosher salt" },
      { amount: nil, unit: nil, name: "black pepper, to taste" },
      { amount: 2.0, unit: "tablespoons", name: "olive oil" },
      { amount: 300.0, unit: "grams", name: "butternut squash, peeled and cubed" },
      { amount: 8.0, unit: "ounces", name: "fresh spinach" },
      { amount: 4.0, unit: "cloves", name: "garlic, minced" },
      { amount: 1.0, unit: "cup", name: "chicken broth" },
      { amount: 1.0, unit: "cup", name: "heavy whipping cream" },
      { amount: 4.0, unit: "ounces", name: "parmesan cheese, shredded or grated" },
      { amount: nil, unit: nil, name: "To garnish: thyme sprigs, grated parmesan cheese" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat your oven to 375°F. In a small bowl, combine all of your dry seasonings, salt and pepper. Sprinkle seasoning all over the chicken on both sides. Save and set aside the remaining for the squash.",
      "In a hot skillet, add the butter, and then the chicken thighs skin side down. Allow to cook until golden brown, about 4 minutes. Flip, and then sear for another 4 minutes. Remove from the skillet and set aside.",
      "Add your olive oil, butternut squash, and remaining seasonings to the skillet and mix. Cook until squash is lightly browned, about 5 minutes.",
      "Add in your fresh spinach and wilt. Once wilted, add in garlic cloves until fragrant, about 30 seconds. Reduce the heat to low. Stir in, your chicken broth, heavy whipping cream, and parmesan cheese. Stir until the cheese is melted.",
      "Add the chicken thighs back into the skillet, skin side up. Bake for 20-25 minutes at 375°F, until the cheese is bubbling. Garnish with fresh parmesan and thyme sprigs.",
      "Eat within 5 days and store in an airtight container in the fridge."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat your oven to 375°F. In a small bowl, combine all of your dry seasonings, salt and pepper. Sprinkle seasoning all over the chicken on both sides. Save and set aside the remaining for the squash.\nIn a hot skillet, add the butter, and then the chicken thighs skin side down. Allow to cook until golden brown, about 4 minutes. Flip, and then sear for another 4 minutes. Remove from the skillet and set aside.\nAdd your olive oil, butternut squash, and remaining seasonings to the skillet and mix. Cook until squash is lightly browned, about 5 minutes.\nAdd in your fresh spinach and wilt. Once wilted, add in garlic cloves until fragrant, about 30 seconds. Reduce the heat to low. Stir in, your chicken broth, heavy whipping cream, and parmesan cheese. Stir until the cheese is melted.\nAdd the chicken thighs back into the skillet, skin side up. Bake for 20-25 minutes at 375°F, until the cheese is bubbling. Garnish with fresh parmesan and thyme sprigs.\nEat within 5 days and store in an airtight container in the fridge.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("afullliving.com")
    expect(recipe.canonical_url).to eq("https://afullliving.com/chicken-butternut-squash-recipe/")
    expect(recipe.site_name).to eq("A Full Living")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Briana")
    expect(recipe.description).to eq("This Creamy Parmesan Chicken and Butternut Squash Skillet Recipe is an easy, luscious and hearty one skillet dinner time favorite. This yummy butternut squash chicken dinner combines a flavorful parmesan cream sauce packed with garlic, spinach, fresh thyme and roasted butternut squash and chicken thighs. This one skillet meal will become a go-to dinner recipe for the fall and winter.")
    expect(recipe.image).to eq("https://afullliving.com/wp-content/uploads/2020/10/Chicken-and-Butternut-Squash-Recipe-1200-x-1200.png")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(60)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(40)
    expect(recipe.keywords).to eq([
      "chicken dinner",
      "fall recipes",
      "gluten free",
      "keto",
      "one skillet meal"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(14)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "615 kcal",
      "carbohydrateContent" => "11 g",
      "proteinContent" => "31 g",
      "fatContent" => "50 g",
      "saturatedFatContent" => "21 g",
      "transFatContent" => "1 g",
      "cholesterolContent" => "207 mg",
      "sodiumContent" => "1161 mg",
      "fiberContent" => "3 g",
      "sugarContent" => "2 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 615.0 },
      { name: "carbohydrateContent", unit: "g", amount: 11.0 },
      { name: "proteinContent", unit: "g", amount: 31.0 },
      { name: "fatContent", unit: "g", amount: 50.0 },
      { name: "saturatedFatContent", unit: "g", amount: 21.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 207.0 },
      { name: "sodiumContent", unit: "mg", amount: 1161.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "sugarContent", unit: "g", amount: 2.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://afullliving.com/")
  end
end
