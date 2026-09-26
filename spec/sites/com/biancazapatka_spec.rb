# frozen_string_literal: true

RSpec.describe "biancazapatka.com" do
  subject(:recipe) { scrape_cassette("com/biancazapatka", url: "https://biancazapatka.com/en/tempeh-rice-noodle-bowl-in-peanut-sauce/") }

  it "reads the title" do
    expect(recipe.title).to eq("Rice Noodle Salad with Tempeh and Peanut Sauce")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "7 oz Tempeh (oder Tofu)",
      "2 garlic cloves (pressed)",
      "3 piece of ginger (grated)",
      "3 tbsp tamari (or soy sauce)",
      "1 tbsp sesame oil (or peanut oil + more for frying)",
      "1 tbsp rice vinegar (or other vinegar or lemon/lime juice)",
      "1 tbsp maple syrup (or other syrup)",
      "1 tsp sriracha (or chili paste optional to taste)",
      "7 oz rice noodles (or other noodles or rice or quinoa)",
      "6 radishes (finely sliced)",
      "4 mini cucumbers (finely sliced)",
      "1 red bell pepper (finely sliced)",
      "2 large carrots (finely sliced)",
      "2 cups fresh baby spinach",
      "3-4 spring onions (cut into fine rings)",
      "1 recipe peanut sauce (or tahini sauce, if nut-free)",
      "2 tbsp sesame seeds",
      "4 tbsp roasted peanuts"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 7.0, unit: "oz", name: "Tempeh" },
      { amount: 2.0, unit: nil, name: "garlic cloves" },
      { amount: 3.0, unit: "piece", name: "ginger" },
      { amount: 3.0, unit: "tbsp", name: "tamari" },
      { amount: 1.0, unit: "tbsp", name: "sesame oil" },
      { amount: 1.0, unit: "tbsp", name: "rice vinegar" },
      { amount: 1.0, unit: "tbsp", name: "maple syrup" },
      { amount: 1.0, unit: "tsp", name: "sriracha" },
      { amount: 7.0, unit: "oz", name: "rice noodles" },
      { amount: 6.0, unit: nil, name: "radishes" },
      { amount: 4.0, unit: nil, name: "mini cucumbers" },
      { amount: 1.0, unit: nil, name: "red bell pepper" },
      { amount: 2.0, unit: nil, name: "large carrots" },
      { amount: 2.0, unit: "cups", name: "fresh baby spinach" },
      { amount: 3.0, unit: nil, name: "spring onions" },
      { amount: 1.0, unit: nil, name: "recipe peanut sauce" },
      { amount: 2.0, unit: "tbsp", name: "sesame seeds" },
      { amount: 4.0, unit: "tbsp", name: "roasted peanuts" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Marinated Tempeh",
      "For the marinade, pour tamari, sesame oil, rice vinegar, maple syrup, and Sriracha into a sealable container. Press in the garlic, grate in the ginger, and stir everything together.",
      "Cut the tempeh into cubes and add them to the marinade. Seal the container and shake well until the tempeh is completely marinated. Then let it marinate for at least 20 minutes (or overnight in the refrigerator).",
      "Noodles & Veggies",
      "Meanwhile, prepare and chop the vegetables. Cover the rice noodles with boiling water and set aside, covered, for 10 minutes (or according to package directions). Then drain and rinse with fresh water.",
      "Cook and assemble",
      "Once the tempeh is marinated, heat about 1-2 tbsp of oil in a frying pan (or wok). Remove the tempeh from the marinade (you can use the remaining marinade to make the peanut sauce) and cook until golden brown from all sides.",
      "Assemble the rice noodles and vegetables in bowls, as shown in the recipe video. Add the tempeh on top and drizzle with peanut sauce. Lastly, garnish with scallions, sesame seeds, and peanuts, and serve with fresh limes on the side.",
      "Enjoy!"
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["Marinated Tempeh", 8],
        ["Noodles & Veggies", 7],
        ["To serve", 3]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Marinated Tempeh\nFor the marinade, pour tamari, sesame oil, rice vinegar, maple syrup, and Sriracha into a sealable container. Press in the garlic, grate in the ginger, and stir everything together.\nCut the tempeh into cubes and add them to the marinade. Seal the container and shake well until the tempeh is completely marinated. Then let it marinate for at least 20 minutes (or overnight in the refrigerator).\nNoodles & Veggies\nMeanwhile, prepare and chop the vegetables. Cover the rice noodles with boiling water and set aside, covered, for 10 minutes (or according to package directions). Then drain and rinse with fresh water.\nCook and assemble\nOnce the tempeh is marinated, heat about 1-2 tbsp of oil in a frying pan (or wok). Remove the tempeh from the marinade (you can use the remaining marinade to make the peanut sauce) and cook until golden brown from all sides.\nAssemble the rice noodles and vegetables in bowls, as shown in the recipe video. Add the tempeh on top and drizzle with peanut sauce. Lastly, garnish with scallions, sesame seeds, and peanuts, and serve with fresh limes on the side.\nEnjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("biancazapatka.com")
    expect(recipe.canonical_url).to eq("https://biancazapatka.com/en/tempeh-rice-noodle-bowl-in-peanut-sauce/")
    expect(recipe.site_name).to eq("Bianca Zapatka")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Bianca Zapatka")
    expect(recipe.description).to eq("This colorful Tempeh Rice Noodle Salad Bowl recipe is quick and easy to make, super healthy, and incredibly delicious! A vegan banquet of perfectly marinated tempeh with gluten-free rice noodles, crunchy fresh veggies, and the best peanut sauce ever! It’s the perfect bowl of happiness for anyone who’s looking to combine healthy eating with indulgence!")
    expect(recipe.image).to eq("https://biancazapatka.com/wp-content/uploads/2022/07/buddha-bowl-sauce.jpg")
    expect(recipe.category).to eq("Lunch & Dinner")
    expect(recipe.cuisine).to eq("Asian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(25)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq([
      "Asia Noodles",
      "Asian Food",
      "Bowl",
      "Noodle Salad",
      "Peanut Sauce",
      "Rice Noodles",
      "Tempeh",
      "Vegetables"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(3)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 Bowl",
      "calories" => "451 kcal",
      "carbohydrateContent" => "59.2 g",
      "proteinContent" => "17.6 g",
      "fatContent" => "17.6 g",
      "saturatedFatContent" => "3.4 g",
      "sodiumContent" => "779.3 mg",
      "sugarContent" => "5.8 g",
      "fiberContent" => "4.4 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "Bowl", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 451.0 },
      { name: "carbohydrateContent", unit: "g", amount: 59.2 },
      { name: "proteinContent", unit: "g", amount: 17.6 },
      { name: "fatContent", unit: "g", amount: 17.6 },
      { name: "saturatedFatContent", unit: "g", amount: 3.4 },
      { name: "sodiumContent", unit: "mg", amount: 779.3 },
      { name: "sugarContent", unit: "g", amount: 5.8 },
      { name: "fiberContent", unit: "g", amount: 4.4 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
