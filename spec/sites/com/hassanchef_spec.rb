# frozen_string_literal: true

RSpec.describe "hassanchef.com" do
  subject(:recipe) { scrape_cassette("com/hassanchef", url: "https://www.hassanchef.com/2019/06/chicken-lollipop-recipe-lollipop-chicken.html") }

  it "reads the title" do
    expect(recipe.title).to eq("Crispy Restaurant-Style Chicken Lollipop")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "6–8 chicken wings (drumette and wingette parts)",
      "1/2 cup corn flour (cornstarch)",
      "1/4 cup maida (all-purpose flour)",
      "2 tbsp rice flour – the secret to lasting crunch",
      "1 egg, lightly beaten",
      "1 tsp ginger-garlic paste",
      "1/2 tsp celery, finely chopped",
      "1/2 tsp red chilli sauce",
      "1/2 tsp schezwan sauce",
      "1 tbsp Kashmiri chilli powder",
      "1/2 tsp red chilli paste",
      "1/2 tsp green chilli paste",
      "1/2 tsp white pepper powder",
      "1/2 tsp lemon juice",
      "Salt to taste",
      "Oil for deep frying"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 6.0, unit: nil, name: "chicken wings" },
      { amount: 0.5, unit: "cup", name: "corn flour" },
      { amount: 0.25, unit: "cup", name: "maida" },
      { amount: 2.0, unit: "tbsp", name: "rice flour – the secret to lasting crunch" },
      { amount: 1.0, unit: nil, name: "egg, lightly beaten" },
      { amount: 1.0, unit: "tsp", name: "ginger-garlic paste" },
      { amount: 0.5, unit: "tsp", name: "celery, finely chopped" },
      { amount: 0.5, unit: "tsp", name: "red chilli sauce" },
      { amount: 0.5, unit: "tsp", name: "schezwan sauce" },
      { amount: 1.0, unit: "tbsp", name: "Kashmiri chilli powder" },
      { amount: 0.5, unit: "tsp", name: "red chilli paste" },
      { amount: 0.5, unit: "tsp", name: "green chilli paste" },
      { amount: 0.5, unit: "tsp", name: "white pepper powder" },
      { amount: 0.5, unit: "tsp", name: "lemon juice" },
      { amount: nil, unit: nil, name: "Salt to taste" },
      { amount: nil, unit: nil, name: "Oil for deep frying" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "French the Lollipops",
      "Separate the chicken wing into drumette, wingette and tip. Use a sharp paring knife to cut around the bone end in a circular motion, severing connective tissue. Scrape the meat firmly downward toward the thicker end to expose 1–2 inches of clean bone. Invert the meat ball by folding it inside out over itself to form the signature tight lollipop shape.",
      "Brine (Optional but Recommended)",
      "Soak the shaped lollipops in a buttermilk brine (3–4 tbsp yogurt + 1¼ cup water + salt) for at least 1 hour or overnight. This prevents the chicken from becoming dry or rubbery during high-heat frying.",
      "Marinate",
      "Toss the lollipops with lemon juice, salt, ginger-garlic paste and Kashmiri chilli powder. Rest for at least 30 minutes – or overnight in the fridge for maximum flavour penetration and the deepest red colour.",
      "Prepare the Batter",
      "In a mixing bowl whisk together corn flour, maida, rice flour, beaten egg, chopped celery, red chilli sauce, schezwan sauce, red chilli paste, green chilli paste, white pepper powder and remaining Kashmiri chilli powder. Add a little water to bring the batter to a smooth, medium-thick, paste-like consistency that clings to the meat.",
      "First Fry – The Primer (160°C)",
      "Coat each lollipop fully in the batter. Heat oil to 160°C and fry for 7–8 minutes until pale golden and cooked through. Remove onto paper towels and rest. You can refrigerate these for up to a few hours if prepping ahead.",
      "Flash Fry – The Topcoat (200°C)",
      "Just before serving, heat oil to 200°C. Re-fry the lollipops for exactly 60 seconds. This high-heat flash fry evaporates all surface moisture and locks in a shatteringly crispy, glass-like crust. Verify internal temperature has reached 165°F / 74°C at the thickest part of the drumette.",
      "Drain and Serve",
      "Remove lollipops and blot on paper towels. Wrap the exposed bone in foil for restaurant-style presentation. Garnish with chopped spring onions and serve hot with schezwan sauce."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("French the Lollipops\nSeparate the chicken wing into drumette, wingette and tip. Use a sharp paring knife to cut around the bone end in a circular motion, severing connective tissue. Scrape the meat firmly downward toward the thicker end to expose 1–2 inches of clean bone. Invert the meat ball by folding it inside out over itself to form the signature tight lollipop shape.\nBrine (Optional but Recommended)\nSoak the shaped lollipops in a buttermilk brine (3–4 tbsp yogurt + 1¼ cup water + salt) for at least 1 hour or overnight. This prevents the chicken from becoming dry or rubbery during high-heat frying.\nMarinate\nToss the lollipops with lemon juice, salt, ginger-garlic paste and Kashmiri chilli powder. Rest for at least 30 minutes – or overnight in the fridge for maximum flavour penetration and the deepest red colour.\nPrepare the Batter\nIn a mixing bowl whisk together corn flour, maida, rice flour, beaten egg, chopped celery, red chilli sauce, schezwan sauce, red chilli paste, green chilli paste, white pepper powder and remaining Kashmiri chilli powder. Add a little water to bring the batter to a smooth, medium-thick, paste-like consistency that clings to the meat.\nFirst Fry – The Primer (160°C)\nCoat each lollipop fully in the batter. Heat oil to 160°C and fry for 7–8 minutes until pale golden and cooked through. Remove onto paper towels and rest. You can refrigerate these for up to a few hours if prepping ahead.\nFlash Fry – The Topcoat (200°C)\nJust before serving, heat oil to 200°C. Re-fry the lollipops for exactly 60 seconds. This high-heat flash fry evaporates all surface moisture and locks in a shatteringly crispy, glass-like crust. Verify internal temperature has reached 165°F / 74°C at the thickest part of the drumette.\nDrain and Serve\nRemove lollipops and blot on paper towels. Wrap the exposed bone in foil for restaurant-style presentation. Garnish with chopped spring onions and serve hot with schezwan sauce.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hassanchef.com")
    expect(recipe.canonical_url).to eq("https://www.hassanchef.com/2019/06/chicken-lollipop-recipe-lollipop-chicken.html")
    expect(recipe.site_name).to eq("hassanchef restaurant style recipes")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Mobasir Hassan")
    expect(recipe.description).to eq("Restaurant-style crispy chicken lollipop made using the professional double-fry technique. Juicy inside, shatteringly crispy outside, vibrant red colour – no artificial colour needed. Includes dry, masala, gravy, biryani and green versions.")
    expect(recipe.image).to eq("https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgyQNvLC9YzhmKRh9DuMpEPopzFzX8U0oKR6VhEEnyeYU_Gu1xljD2nA1ptX5wNj8mLsAdSVpJabru4YWUFZ1ljeOCNXcYh2lYZmO_jK64ahS9FliOe8QGsYU9qc6rYPQelQc-Qf4wE2Ms/s1600/IMG_20190629_212341.jpg")
    expect(recipe.category).to eq("Appetizer")
    expect(recipe.cuisine).to eq("Indo-Chinese")
    expect(recipe.cooking_method).to eq("Deep Frying")
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq([
      "chicken lollipop",
      "chicken lollipop recipe",
      "crispy chicken lollipop",
      "chicken lollipop dry",
      "chicken lollipop masala",
      "chicken lollipop gravy",
      "how to make chicken lollipop",
      "fried chicken lollipop",
      "chicken lollipop masala dry",
      "chicken lollipop biryani",
      "raw chicken lollipop",
      "chicken lollipop calories"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.9)
    expect(recipe.ratings_count).to eq(38)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "4 pieces (approx 140g)",
      "calories" => "322 kcal",
      "proteinContent" => "15g",
      "fatContent" => "22g",
      "carbohydrateContent" => "14g",
      "sodiumContent" => "520mg"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "pieces", amount: 4.0 },
      { name: "calories", unit: "kcal", amount: 322.0 },
      { name: "proteinContent", unit: "g", amount: 15.0 },
      { name: "fatContent", unit: "g", amount: 22.0 },
      { name: "carbohydrateContent", unit: "g", amount: 14.0 },
      { name: "sodiumContent", unit: "mg", amount: 520.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.hassanchef.com/")
  end
end
