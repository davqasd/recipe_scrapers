# frozen_string_literal: true

RSpec.describe "steamykitchen.com" do
  subject(:recipe) { scrape_cassette("com/steamykitchen", url: "https://steamykitchen.com/56719-instant-pot-vietnamese-chicken-pho.html") }

  it "reads the title" do
    expect(recipe.title).to eq("Instant Pot Vietnamese Chicken Pho")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 pounds bone-in chicken (either a whole chicken or bone-in parts: breast or thigh)",
      "1 tablespoon cooking oil",
      "2 teaspoons of whole coriander seeds (not ground coriander)",
      "2 star anise pods",
      "2\" nub of ginger (peeled and sliced a few times)",
      "1/2 onion",
      "3 whole cloves garlic",
      "3 tablespoons fish sauce",
      "1 1/2 teaspoons sugar",
      "1 package dried rice noodles (about 10-12 ounces, prepared according to package instructions, and drained)",
      "1/2 onion (thinly sliced and soaked in cold water)",
      "1 handful fresh cilantro (chopped)",
      "few sprigs of Thai basil (or regular basil)",
      "1 lime (in wedges)",
      "1/2 pound fresh bean sprouts",
      "1 jalapeno chile (sliced)",
      "Sriracha and Hoisin Sauce"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "pounds", name: "bone-in chicken" },
      { amount: 1.0, unit: "tablespoon", name: "cooking oil" },
      { amount: 2.0, unit: "teaspoons", name: "whole coriander seeds" },
      { amount: 2.0, unit: nil, name: "star anise pods" },
      { amount: 2.0, unit: nil, name: "\" nub of ginger" },
      { amount: 0.5, unit: nil, name: "onion" },
      { amount: 3.0, unit: nil, name: "whole cloves garlic" },
      { amount: 3.0, unit: "tablespoons", name: "fish sauce" },
      { amount: 1.5, unit: "teaspoons", name: "sugar" },
      { amount: 1.0, unit: "package", name: "dried rice noodles" },
      { amount: 0.5, unit: nil, name: "onion" },
      { amount: 1.0, unit: "handful", name: "fresh cilantro" },
      { amount: nil, unit: nil, name: "few sprigs of Thai basil" },
      { amount: 1.0, unit: nil, name: "lime" },
      { amount: 0.5, unit: "pound", name: "fresh bean sprouts" },
      { amount: 1.0, unit: nil, name: "jalapeno chile" },
      { amount: nil, unit: nil, name: "Sriracha and Hoisin Sauce" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Make the Broth",
      "Turn the pressure cooker to \"sautÃ©\" and heat the oil until smoking. Add the onion, ginger slices and cook until nicely browned, about 4 minutes. Add the garlic cloves, coriander, and star anise and sautÃ© for another 2 minutes until fragrant.",
      "Add in the chicken and 2 quarts of water to cover the chicken and seal the pot. Set to pressure and cook 20 minutes on high.",
      "Make your rice noodles while your broth is cooking.",
      "When the cooking is complete, carefully release the pressure then remove the lid once all pressure is released. Remove the chicken from the pot and transfer to a large bowl and let chicken cool off a bit. Strain all the spices from the broth and discard. Turn the pressure cooker on \"boil\" or \"sautÃ©\" to keep the broth very hot.",
      "Season broth with the fish sauce and sugar. Taste. If the broth is too bland, adjust with more fish sauce and sugar.",
      "Remove the chicken meat from bones, shred with fingers. Set aside.",
      "Make the Pho Bowls",
      "Drain the onions, Set your table with the onions, all of the herbs and condiments so that each person can customize their own bowl.",
      "Divide the chicken and prepared noodles amongst the bowls.",
      "Return the pho broth to a boil. Ladle the hot pho broth into each bowl, and serve."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["For the Pho", 9],
        ["Noodles and Toppings", 8]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Make the Broth\nTurn the pressure cooker to \"sautÃ©\" and heat the oil until smoking. Add the onion, ginger slices and cook until nicely browned, about 4 minutes. Add the garlic cloves, coriander, and star anise and sautÃ© for another 2 minutes until fragrant.\nAdd in the chicken and 2 quarts of water to cover the chicken and seal the pot. Set to pressure and cook 20 minutes on high.\nMake your rice noodles while your broth is cooking.\nWhen the cooking is complete, carefully release the pressure then remove the lid once all pressure is released. Remove the chicken from the pot and transfer to a large bowl and let chicken cool off a bit. Strain all the spices from the broth and discard. Turn the pressure cooker on \"boil\" or \"sautÃ©\" to keep the broth very hot.\nSeason broth with the fish sauce and sugar. Taste. If the broth is too bland, adjust with more fish sauce and sugar.\nRemove the chicken meat from bones, shred with fingers. Set aside.\nMake the Pho Bowls\nDrain the onions, Set your table with the onions, all of the herbs and condiments so that each person can customize their own bowl.\nDivide the chicken and prepared noodles amongst the bowls.\nReturn the pho broth to a boil. Ladle the hot pho broth into each bowl, and serve.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("steamykitchen.com")
    expect(recipe.canonical_url).to eq("https://steamykitchen.com/56719-instant-pot-vietnamese-chicken-pho.html")
    expect(recipe.site_name).to eq("Steamy Kitchen Recipes")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Jaden")
    expect(recipe.description).to eq("This Vietnamese Chicken Pho is the definition of a cozy and comforting meal. In less than 1 hour you will have a nourishing bowl of warm noodle soup!")
    expect(recipe.image).to eq("https://steamykitchen.com/wp-content/uploads/2020/12/INSTANT-POT-CHICKEN-PHO-.png")
    expect(recipe.category).to eq("dinner")
    expect(recipe.cuisine).to eq("Vietnamese")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(["instant pot pho", "pho recipe", "vietnamese pho"])
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
    expect(recipe.links).to include("https://steamykitchen.com/")
  end
end
