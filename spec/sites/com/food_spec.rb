# frozen_string_literal: true

RSpec.describe "food.com" do
  subject(:recipe) { scrape_cassette("com/food", url: "https://www.food.com/recipe/chicken-noodle-soup-with-carrots-parsnips-and-dill-454415") }

  it "reads the title" do
    expect(recipe.title).to eq("Chicken Noodle Soup With Carrots, Parsnips and Dill")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "8 cups low sodium chicken broth",
      "1 onion, chopped",
      "4 carrots, halved lengthwise and cut crosswise into 1-inch pieces",
      "4 parsnips, halved lengthwise and cut crosswise into 1-inch pieces",
      "1 1/2 teaspoons salt",
      "1/4 teaspoon fresh ground black pepper",
      "1 split chicken breast",
      "1 cup noodles (about 2 ounces)",
      "1/4 cup chopped fresh dill",
      "1/4 cup chopped fresh parsley"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 8.0, unit: "cups", name: "low sodium chicken broth" },
      { amount: 1.0, unit: nil, name: "onion, chopped" },
      { amount: 4.0, unit: nil, name: "carrots, halved lengthwise and cut crosswise into 1-inch pieces" },
      { amount: 4.0, unit: nil, name: "parsnips, halved lengthwise and cut crosswise into 1-inch pieces" },
      { amount: 1.5, unit: "teaspoons", name: "salt" },
      { amount: 0.25, unit: "teaspoon", name: "fresh ground black pepper" },
      { amount: 1.0, unit: nil, name: "split chicken breast" },
      { amount: 1.0, unit: "cup", name: "noodles" },
      { amount: 0.25, unit: "cup", name: "chopped fresh dill" },
      { amount: 0.25, unit: "cup", name: "chopped fresh parsley" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large pot, combine the broth, onion, carrots, parsnips, salt, and pepper and bring to a simmer. Add the chicken breasts to the pot and simmer until jfor about 20 minutes, until cooked. Remove the chicken and let rest. When cool enough to handle, remove skin and bones and chop or shred intobite-size pieces.",
      "While chicken is cooling, bring the soup back to a simmer and stir the noodles into the soup. Simmer until the vegetables are tender and the noodles are done, about 5 minutes. Return the chicken pieces to the pot and then stir in the dill and the parsley."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large pot, combine the broth, onion, carrots, parsnips, salt, and pepper and bring to a simmer. Add the chicken breasts to the pot and simmer until jfor about 20 minutes, until cooked. Remove the chicken and let rest. When cool enough to handle, remove skin and bones and chop or shred intobite-size pieces.\nWhile chicken is cooling, bring the soup back to a simmer and stir the noodles into the soup. Simmer until the vegetables are tender and the noodles are done, about 5 minutes. Return the chicken pieces to the pot and then stir in the dill and the parsley.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("food.com")
    expect(recipe.canonical_url).to eq("https://www.food.com/recipe/chicken-noodle-soup-with-carrots-parsnips-and-dill-454415")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("JackieOhNo!")
    expect(recipe.description).to eq("This is a variation on my family's favorite chicken soup that I have already posted here. Lots of carrots and parsnips give it more of a sweet savor. The parsley actually balances the sweetness, though. To balance this effect, use the optional parsley, which is just slightly bitter. Sometimes I also add a diced turnip if I have one. For the noodles, I like to use tagliolini nests, which you can usually find in the imported pasta section. I prefer a thin noodle for this soup, but you can certainly use whatever is your preference.")
    expect(recipe.image).to eq("https://img.sndimg.com/food/image/upload/q_92,fl_progressive,w_1200,c_scale/v1/img/recipes/45/44/15/IoYo06IEQoD16Ti6nVPV_parsnip-chicken-noodle-soup-5210.jpg")
    expect(recipe.category).to eq("Chicken Breast")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(45)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq([
      "Chicken",
      "Poultry",
      "Vegetable",
      "Meat",
      "Spring",
      "Winter",
      "Weeknight",
      "< 60 Mins",
      "Beginner Cook",
      "Easy"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "213.6",
      "fatContent" => "6.9",
      "saturatedFatContent" => "2",
      "cholesterolContent" => "31.2",
      "sodiumContent" => "1086.5",
      "carbohydrateContent" => "21.3",
      "fiberContent" => "2.7",
      "sugarContent" => "4.9",
      "proteinContent" => "19.5"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: nil, amount: 213.6 },
      { name: "fatContent", unit: nil, amount: 6.9 },
      { name: "saturatedFatContent", unit: nil, amount: 2.0 },
      { name: "cholesterolContent", unit: nil, amount: 31.2 },
      { name: "sodiumContent", unit: nil, amount: 1086.5 },
      { name: "carbohydrateContent", unit: nil, amount: 21.3 },
      { name: "fiberContent", unit: nil, amount: 2.7 },
      { name: "sugarContent", unit: nil, amount: 4.9 },
      { name: "proteinContent", unit: nil, amount: 19.5 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/?ref=nav")
  end
end
