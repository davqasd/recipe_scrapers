# frozen_string_literal: true

RSpec.describe "carlsbadcravings.com" do
  subject(:recipe) { scrape_cassette("com/carlsbadcravings", url: "https://carlsbadcravings.com/brown-sugar-glazed-ham/") }

  it "reads the title" do
    expect(recipe.title).to eq("Glaze for Ham")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 (8-11 pounds) bone-in, fully cooked spiral-sliced ham",
      "Aluminum foil",
      "Roasting pan",
      "Thermometer",
      "1 cup packed light brown sugar",
      "1/2 cup clover honey",
      "3 tablespoons cider vinegar",
      "2 tablespoons Dijon mustard",
      "2 tablespoons yellow mustard",
      "1 teaspoon ground cinnamon",
      "1/2 tsp EACH onion powder, garlic powder, ground sage, dried parsley, ground nutmeg ground ginger, ground cloves, paprika",
      "1/4 tsp EACH pepper, ancho chili powder"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "bone-in, fully cooked spiral-sliced ham" },
      { amount: nil, unit: nil, name: "Aluminum foil" },
      { amount: nil, unit: nil, name: "Roasting pan" },
      { amount: nil, unit: nil, name: "Thermometer" },
      { amount: 1.0, unit: "cup", name: "packed light brown sugar" },
      { amount: 0.5, unit: "cup", name: "clover honey" },
      { amount: 3.0, unit: "tablespoons", name: "cider vinegar" },
      { amount: 2.0, unit: "tablespoons", name: "Dijon mustard" },
      { amount: 2.0, unit: "tablespoons", name: "yellow mustard" },
      { amount: 1.0, unit: "teaspoon", name: "ground cinnamon" },
      { amount: 0.5, unit: "tsp", name: "EACH onion powder, garlic powder, ground sage, dried parsley, ground nutmeg ground ginger, ground cloves, paprika" },
      { amount: 0.25, unit: "tsp", name: "EACH pepper, ancho chili powder" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Remove ham from refrigerator and let sit at room temperature for 2 hours.",
      "Preheat oven to 325 degrees F. Adjust oven rack to lowest position. Pour 2 of cups water into bottom of roasting pan with a roasting rack. (Skip step if you don’t have a roasting rack.)",
      "Whisk together all of the Brown Sugar Glaze ingredients in a medium saucepan. Bring to a simmer, stirring often, until brown sugar dissolves, about 1-2 minutes. Set aside.",
      "Roll out 2 large pieces of foil to wrap your ham in, making sure they overlap in the center. Place ham on foil, flat side up, and brush ham all over with approximately 1/3 of the Glaze, including in between slices. Tightly wrap ham with foil and place ham FLAT/FACE SIDE DOWN on the roasting rack (or bottom of pan).",
      "Bake ham at 325 degrees F until the center registers 100-110 degrees F, (approx. 10-14 minutes per pound). Remove ham from oven and increase oven temperature to 400 degrees F.",
      "Carefully unwrap ham from foil and discard foil. Spoon juices from the bottom of the pan all over ham. Brush ham all over with 1/3 Glaze (Glaze will have thickened so return to heat to loosen, about 30 seconds).",
      "Leave ham uncovered to caramelize surface and bake until the ham reaches an internal temperature of around 140 degrees F, approximately 20-30 minutes, spooning juices over ham every 10 minutes.*** Turn oven to broil for more caramelized edges if desired watching closely so they don’t burn.",
      "Remove ham from oven and spoon juices from bottom of pan/foil again all over ham and brush again with Glaze. Loosely cover with foil. Let rest for 15 minutes then spoon more juices over ham and serve with any remaining Glaze (and my husband loves it with a side of Dijon as well).",
      "Optional: Serve with Easter or Christmas sides linked below recipe."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        [nil, 4],
        ["Brown Sugar Glaze", 8]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Remove ham from refrigerator and let sit at room temperature for 2 hours.\nPreheat oven to 325 degrees F. Adjust oven rack to lowest position. Pour 2 of cups water into bottom of roasting pan with a roasting rack. (Skip step if you don’t have a roasting rack.)\nWhisk together all of the Brown Sugar Glaze ingredients in a medium saucepan. Bring to a simmer, stirring often, until brown sugar dissolves, about 1-2 minutes. Set aside.\nRoll out 2 large pieces of foil to wrap your ham in, making sure they overlap in the center. Place ham on foil, flat side up, and brush ham all over with approximately 1/3 of the Glaze, including in between slices. Tightly wrap ham with foil and place ham FLAT/FACE SIDE DOWN on the roasting rack (or bottom of pan).\nBake ham at 325 degrees F until the center registers 100-110 degrees F, (approx. 10-14 minutes per pound). Remove ham from oven and increase oven temperature to 400 degrees F.\nCarefully unwrap ham from foil and discard foil. Spoon juices from the bottom of the pan all over ham. Brush ham all over with 1/3 Glaze (Glaze will have thickened so return to heat to loosen, about 30 seconds).\nLeave ham uncovered to caramelize surface and bake until the ham reaches an internal temperature of around 140 degrees F, approximately 20-30 minutes, spooning juices over ham every 10 minutes.*** Turn oven to broil for more caramelized edges if desired watching closely so they don’t burn.\nRemove ham from oven and spoon juices from bottom of pan/foil again all over ham and brush again with Glaze. Loosely cover with foil. Let rest for 15 minutes then spoon more juices over ham and serve with any remaining Glaze (and my husband loves it with a side of Dijon as well).\nOptional: Serve with Easter or Christmas sides linked below recipe.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("carlsbadcravings.com")
    expect(recipe.canonical_url).to eq("https://carlsbadcravings.com/brown-sugar-glazed-ham/")
    expect(recipe.site_name).to eq("Carlsbad Cravings")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Jen")
    expect(recipe.description).to eq("Brown Sugar Glazed Ham is beautifully juicy, seeping with flavor, with crispy caramelized edges and the BEST Brown Sugar Glaze you will ever sink your teeth into - the perfect centerpiece for Easter and Christmas! This Baked Ham Recipe made with brown, sugar, honey, mustard and spices is sweet, smoky and dripping with flavor AND it only takes minutes of hands on prep time!")
    expect(recipe.image).to eq("https://carlsbadcravings.com/wp-content/uploads/2018/03/Brown-Sugar-Glazed-Ham-10.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to eq(130)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(120)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(10)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
