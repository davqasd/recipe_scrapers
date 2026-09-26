# frozen_string_literal: true

RSpec.describe "bakingmischief.com" do
  subject(:recipe) { scrape_cassette("com/bakingmischief", url: "https://bakingmischief.com/barbacoa-burrito-bowls/") }

  it "reads the title" do
    expect(recipe.title).to eq("Barbacoa Burrito Bowls")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 boneless 2-3 pound chuck roast ( trimmed and cut into fist-size chunks)",
      "Salt and pepper",
      "1 medium white or yellow onion diced",
      "3 tablespoons vegetable oil",
      "1-6 cups beef or chicken broth",
      "1/4 cup lime juice",
      "1/4 cup apple cider vinegar",
      "2 chipotle peppers in adobo sauce minced (optional)",
      "1 tablespoon ground cumin",
      "1 tablespoon dried oregano",
      "1/4 teaspoon ground cloves optional",
      "3/4 teaspoon salt",
      "3 bay leaves",
      "Juice from 1 lime (about 2 tablespoons)",
      "Scant 2 cups chicken broth",
      "1 cup long-grain rice",
      "Zest from 1 lime (divided)",
      "1 tablespoon (14g) butter (salted or unsalted is fine)",
      "1/4 teaspoon salt",
      "1/4 cup chopped loosely packed cilantro (divided)",
      "1 15-ounce can black beans (rinsed, drained, and warmed)",
      "1 15- 15-ounce can corn (drained and warmed)",
      "1/2 cup (2oz) shredded Mexican-blend cheese",
      "1 cup pico de gallo",
      "1/2 cup guacamole",
      "1/4 cup sour cream"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "boneless 2-3 pound chuck roast" },
      { amount: nil, unit: nil, name: "Salt and pepper" },
      { amount: 1.0, unit: nil, name: "medium white or yellow onion diced" },
      { amount: 3.0, unit: "tablespoons", name: "vegetable oil" },
      { amount: 1.0, unit: "cups", name: "beef or chicken broth" },
      { amount: 0.25, unit: "cup", name: "lime juice" },
      { amount: 0.25, unit: "cup", name: "apple cider vinegar" },
      { amount: 2.0, unit: nil, name: "chipotle peppers in adobo sauce minced" },
      { amount: 1.0, unit: "tablespoon", name: "ground cumin" },
      { amount: 1.0, unit: "tablespoon", name: "dried oregano" },
      { amount: 0.25, unit: "teaspoon", name: "ground cloves optional" },
      { amount: 0.75, unit: "teaspoon", name: "salt" },
      { amount: 3.0, unit: nil, name: "bay leaves" },
      { amount: nil, unit: nil, name: "Juice from 1 lime" },
      { amount: 2.0, unit: "cups", name: "chicken broth" },
      { amount: 1.0, unit: "cup", name: "long-grain rice" },
      { amount: nil, unit: nil, name: "Zest from 1 lime" },
      { amount: 1.0, unit: "tablespoon", name: "butter" },
      { amount: 0.25, unit: "teaspoon", name: "salt" },
      { amount: 0.25, unit: "cup", name: "chopped loosely packed cilantro" },
      { amount: 1.0, unit: "can", name: "black beans" },
      { amount: 1.0, unit: "can", name: "corn" },
      { amount: 0.5, unit: "cup", name: "shredded Mexican-blend cheese" },
      { amount: 1.0, unit: "cup", name: "pico de gallo" },
      { amount: 0.5, unit: "cup", name: "guacamole" },
      { amount: 0.25, unit: "cup", name: "sour cream" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Barbacoa",
      "Generously salt and pepper meat on all sides.",
      "In a large dutch oven (or skillet if you’ll be using a slow cooker), heat oil over medium-high heat. Brown meat on all sides, in batches if necessary. This may take up to 15 minutes.",
      "Stovetop Barbacoa",
      "Add onion and just enough chicken or beef broth to mostly submerge the meat. Stir, scraping the bottom of the pan to remove any stuck-on bits. Stir in remaining ingredients and bring mixture to a low simmer. Cook, stirring occasionally for 2 1/2 to 3 hours, until meat is very tender and can be pulled apart with a fork.",
      "Slow Cooker Barbacoa",
      "If using a slow cooker, transfer meat and any drippings remaining in the pan to the slow cooker and add onions, 1 cup of broth and remaining ingredients. Cook on high for 3 to 4 hours, low for 7 to 8 hours, until the beef is tender and can be easily shredded with a fork.",
      "Shred",
      "Once meat is done, use a slotted spoon to transfer the pieces to a cutting board. Use two forks to shred the meat, discarding any large pieces of fat as you go.",
      "Return shredded meat to the cooking liquid. Add more salt and pepper to taste.",
      "Cilantro Lime Rice",
      "Add lime juice to a 2-cup measuring cup. Fill the measuring cup the rest of the way with chicken broth.",
      "In a saucepan or rice cooker, cook rice according to package instructions, replacing the water with the lime juice/chicken broth mixture and adding butter and salt when you add the rice (if the package instructions already call for salt, do not add additional salt).",
      "After rice has finished cooking, stir in half of the lime zest and cilantro. Taste and add more lime and cilantro to taste.",
      "Burrito Bowls",
      "Divide cilantro rice between bowls or food prep containers. Top rice with shredded barbacoa and the rest of your burrito bowl toppings. Serve and enjoy."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["Barbacoa", 13],
        ["Cilantro Lime Rice", 7],
        ["Burrito Bowls", 6]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Barbacoa\nGenerously salt and pepper meat on all sides.\nIn a large dutch oven (or skillet if you’ll be using a slow cooker), heat oil over medium-high heat. Brown meat on all sides, in batches if necessary. This may take up to 15 minutes.\nStovetop Barbacoa\nAdd onion and just enough chicken or beef broth to mostly submerge the meat. Stir, scraping the bottom of the pan to remove any stuck-on bits. Stir in remaining ingredients and bring mixture to a low simmer. Cook, stirring occasionally for 2 1/2 to 3 hours, until meat is very tender and can be pulled apart with a fork.\nSlow Cooker Barbacoa\nIf using a slow cooker, transfer meat and any drippings remaining in the pan to the slow cooker and add onions, 1 cup of broth and remaining ingredients. Cook on high for 3 to 4 hours, low for 7 to 8 hours, until the beef is tender and can be easily shredded with a fork.\nShred\nOnce meat is done, use a slotted spoon to transfer the pieces to a cutting board. Use two forks to shred the meat, discarding any large pieces of fat as you go.\nReturn shredded meat to the cooking liquid. Add more salt and pepper to taste.\nCilantro Lime Rice\nAdd lime juice to a 2-cup measuring cup. Fill the measuring cup the rest of the way with chicken broth.\nIn a saucepan or rice cooker, cook rice according to package instructions, replacing the water with the lime juice/chicken broth mixture and adding butter and salt when you add the rice (if the package instructions already call for salt, do not add additional salt).\nAfter rice has finished cooking, stir in half of the lime zest and cilantro. Taste and add more lime and cilantro to taste.\nBurrito Bowls\nDivide cilantro rice between bowls or food prep containers. Top rice with shredded barbacoa and the rest of your burrito bowl toppings. Serve and enjoy.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("bakingmischief.com")
    expect(recipe.canonical_url).to eq("https://bakingmischief.com/barbacoa-burrito-bowls/")
    expect(recipe.site_name).to eq("Baking Mischief")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Tracy")
    expect(recipe.description).to eq("These barbacoa burrito bowls are loaded with tender and tangy homemade barbacoa and all your favorite burrito toppings layered over a bed of cilantro lime rice.")
    expect(recipe.image).to eq("https://bakingmischief.com/wp-content/uploads/2020/12/barbacoa-burrito-bowls-image-square-2.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(190)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(160)
    expect(recipe.keywords).to eq(["Barbacoa Burrito Bowl"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "calories" => "824 kcal", "servingSize" => "1 serving" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 824.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://bakingmischief.com")
  end
end
