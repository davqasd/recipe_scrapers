# frozen_string_literal: true

RSpec.describe "choosehomemade.org" do
  subject(:recipe) { scrape_cassette("org/choosehomemade", url: "https://choosehomemade.org/recipes/easy-pork-paella/") }

  it "reads the title" do
    expect(recipe.title).to eq("Easy Pork Paella")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 Tbsp olive oil",
      "1 lb boneless pork loin, cubed",
      "1 Tbsp paprika",
      "1 Tbsp dried oregano",
      "1 small white onion, diced",
      "1 large red bell pepper, sliced",
      "4 cloves garlic, minced",
      "1 (15 oz) can crushed tomatoes",
      "1 cup white rice, uncooked",
      "3 cups unsalted chicken broth, divided",
      "1 cup frozen peas, thawed",
      "1/4 cup minced fresh parsley"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "Tbsp", name: "olive oil" },
      { amount: 1.0, unit: "lb", name: "boneless pork loin, cubed" },
      { amount: 1.0, unit: "Tbsp", name: "paprika" },
      { amount: 1.0, unit: "Tbsp", name: "dried oregano" },
      { amount: 1.0, unit: nil, name: "small white onion, diced" },
      { amount: 1.0, unit: nil, name: "large red bell pepper, sliced" },
      { amount: 4.0, unit: "cloves", name: "garlic, minced" },
      { amount: 1.0, unit: "can", name: "crushed tomatoes" },
      { amount: 1.0, unit: "cup", name: "white rice, uncooked" },
      { amount: 3.0, unit: "cups", name: "unsalted chicken broth, divided" },
      { amount: 1.0, unit: "cup", name: "frozen peas, thawed" },
      { amount: 0.25, unit: "cup", name: "minced fresh parsley" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large skillet, heat oil over medium-high. Add pork, paprika and oregano. Cook 3-5 minutes, or until browned. Transfer pork to a plate and set aside.",
      "Return skillet to medium heat. Add onion and bell pepper. Sauté 2-3 minutes, or until soft. Add garlic and tomatoes. Simmer 4-5 minutes, or until slightly thickened.",
      "Stir in rice and mix well. Add 1/2 of the broth, cover and cook 12-15 minutes, stirring occasionally.",
      "Add pork back into skillet and stir in remaining broth. Cover and simmer until rice is tender, about 15 minutes. Stir in peas and cook 2 minutes.",
      "Serve topped with fresh parsley."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large skillet, heat oil over medium-high. Add pork, paprika and oregano. Cook 3-5 minutes, or until browned. Transfer pork to a plate and set aside.\nReturn skillet to medium heat. Add onion and bell pepper. Sauté 2-3 minutes, or until soft. Add garlic and tomatoes. Simmer 4-5 minutes, or until slightly thickened.\nStir in rice and mix well. Add 1/2 of the broth, cover and cook 12-15 minutes, stirring occasionally.\nAdd pork back into skillet and stir in remaining broth. Cover and simmer until rice is tender, about 15 minutes. Stir in peas and cook 2 minutes.\nServe topped with fresh parsley.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("choosehomemade.org")
    expect(recipe.canonical_url).to eq("https://choosehomemade.org/recipes/easy-pork-paella/")
    expect(recipe.site_name).to eq("Choose Homemade")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("This dish is perfect for trying new flavors that are low in sodium.")
    expect(recipe.image).to eq("https://choosehomemade.org/wp-content/uploads/2021/10/IMG_4471-RGB.webp")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
