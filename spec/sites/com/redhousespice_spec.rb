# frozen_string_literal: true

RSpec.describe "redhousespice.com" do
  subject(:recipe) { scrape_cassette("com/redhousespice", url: "https://redhousespice.com/char-siu-chinese-bbq-pork/") }

  it "reads the title" do
    expect(recipe.title).to eq("Easy Char Siu (Chinese BBQ pork, 叉烧)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 pork shoulder steaks (aka pork butt) (about 350g/12oz, see note 1)",
      "4 tablespoon Char Siu sauce (see note 2)",
      "1 tablespoon oyster sauce",
      "1/2 tablespoon light soy sauce",
      "1/4 teaspoon Chinese five-spice powder",
      "4 cloves garlic, finely sliced",
      "5 slices ginger",
      "1/2 teaspoon chilli powder (optional, see note 4)",
      "2 teaspoon honey"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: nil, name: "pork shoulder steaks" },
      { amount: 4.0, unit: "tablespoon", name: "Char Siu sauce" },
      { amount: 1.0, unit: "tablespoon", name: "oyster sauce" },
      { amount: 0.5, unit: "tablespoon", name: "light soy sauce" },
      { amount: 0.25, unit: "teaspoon", name: "Chinese five-spice powder" },
      { amount: 4.0, unit: "cloves", name: "garlic, finely sliced" },
      { amount: 5.0, unit: "slices", name: "ginger" },
      { amount: 0.5, unit: "teaspoon", name: "chilli powder" },
      { amount: 2.0, unit: "teaspoon", name: "honey" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Marinate the meat",
      "Put pork steaks in a resealable plastic bag. Add all the ingredients for the marinade.",
      "Squeeze out air then seal the bag. Rub around for an even coating. Store in the fridge for at least 6 hours (ideally overnight).",
      "Take the meat out of the bag right before roasting. Keep the marinade for later use.",
      "Prepare for roasting",
      "Preheat the oven at 425°F/220°C/Fan 200°C.",
      "If using a baking tray with a wire rack that fits inside, fill the tray with hot water (lower than the rack) and put the steak on the rack. Place the tray in the middle of the oven.",
      "Alternatively, place a large tray with hot water at the bottom of the oven. Then place the steak on the middle rack of the oven.",
      "Roast & brush (see note 5)",
      "Leave the meat to roast for 15 mins. Take out and flip it over. Brush some marinade then put back into the oven (Make sure there is always enough water in the tray).",
      "Cook for a further 10 mins. While waiting, mix 2 teaspoons of honey with 2 teaspoons of the marinade.",
      "Then increase the oven temperature to 460°F/240°C/Fan 220°C. Take out the meat. Brush with the honey mixture.",
      "Put back into the oven for 5 mins. Then brush the other side with the honey mixture. Roast for a final 3 mins.",
      "Serve",
      "Leave the meat to rest for 5 mins then slice and serve it in your preferred way.",
      "You may also heat up the remaining marinade (remove the garlic & ginger) then serve it as a sauce, a soup base, or a noodle seasoning, etc."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        [nil, 1],
        ["For the marinade", 7],
        ["You also need", 1]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Marinate the meat\nPut pork steaks in a resealable plastic bag. Add all the ingredients for the marinade.\nSqueeze out air then seal the bag. Rub around for an even coating. Store in the fridge for at least 6 hours (ideally overnight).\nTake the meat out of the bag right before roasting. Keep the marinade for later use.\nPrepare for roasting\nPreheat the oven at 425°F/220°C/Fan 200°C.\nIf using a baking tray with a wire rack that fits inside, fill the tray with hot water (lower than the rack) and put the steak on the rack. Place the tray in the middle of the oven.\nAlternatively, place a large tray with hot water at the bottom of the oven. Then place the steak on the middle rack of the oven.\nRoast & brush (see note 5)\nLeave the meat to roast for 15 mins. Take out and flip it over. Brush some marinade then put back into the oven (Make sure there is always enough water in the tray).\nCook for a further 10 mins. While waiting, mix 2 teaspoons of honey with 2 teaspoons of the marinade.\nThen increase the oven temperature to 460°F/240°C/Fan 220°C. Take out the meat. Brush with the honey mixture.\nPut back into the oven for 5 mins. Then brush the other side with the honey mixture. Roast for a final 3 mins.\nServe\nLeave the meat to rest for 5 mins then slice and serve it in your preferred way.\nYou may also heat up the remaining marinade (remove the garlic & ginger) then serve it as a sauce, a soup base, or a noodle seasoning, etc.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("redhousespice.com")
    expect(recipe.canonical_url).to eq("https://redhousespice.com/char-siu-chinese-bbq-pork/")
    expect(recipe.site_name).to eq("Red House Spice")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Wei Guo")
    expect(recipe.description).to eq("Aromatic, smoky, savoury & a little sweet, Cantonese classic dish Char Siu (Chinese BBQ pork) is one of the tastiest ways to roast pork.")
    expect(recipe.image).to eq("https://redhousespice.com/wp-content/uploads/2020/05/Char-siu-Chinese-BBQ-pork-14-scaled.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("Chinese")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("3 servings")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(35)
    expect(recipe.keywords).to eq(["Pork"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(154)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "servingSize" => "1 serving", "calories" => "419 kcal" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "serving", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 419.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
