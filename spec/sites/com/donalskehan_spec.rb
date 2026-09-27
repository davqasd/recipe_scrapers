# frozen_string_literal: true

RSpec.describe "donalskehan.com" do
  subject(:recipe) { scrape_cassette("com/donalskehan", url: "https://donalskehan.com/recipes/air-fryer-indian-butter-chicken/") }

  it "reads the title" do
    expect(recipe.title).to eq("Air Fryer Indian Butter Chicken")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "8 boneless, skinless chicken thighs, cut into bite-sized pieces",
      "3 garlic cloves, finely grated",
      "1-inch piece of fresh ginger, peeled and finely grated",
      "3 tbsp tandoori paste",
      "1 tbsp honey",
      "1 tsp ground cumin",
      "2 tbsp Greek yogurt",
      "3.5 oz (about 1/3 cup) butter",
      "2 small green chilies, sliced lengthways down the middle, leaving the stem intact",
      "1 ½ tsp ground cumin",
      "1 tsp ground coriander",
      "5 oz (about 2/3 cup) tomato paste",
      "1 can finely chopped tomatoes",
      "½ cup water",
      "1 tsp fenugreek leaves",
      "1 tsp dried dill",
      "1/3 cup heavy cream",
      "Juice of ½ a lemon",
      "Handful of cilantro leaves",
      "Steamed rice",
      "Naan breads"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 8.0, unit: nil, name: "boneless, skinless chicken thighs, cut into bite-sized pieces" },
      { amount: 3.0, unit: nil, name: "garlic cloves, finely grated" },
      { amount: 1.0, unit: nil, name: "-inch piece of fresh ginger, peeled and finely grated" },
      { amount: 3.0, unit: "tbsp", name: "tandoori paste" },
      { amount: 1.0, unit: "tbsp", name: "honey" },
      { amount: 1.0, unit: "tsp", name: "ground cumin" },
      { amount: 2.0, unit: "tbsp", name: "Greek yogurt" },
      { amount: 3.5, unit: "oz", name: "butter" },
      { amount: 2.0, unit: nil, name: "small green chilies, sliced lengthways down the middle, leaving the stem intact" },
      { amount: 1.5, unit: "tsp", name: "ground cumin" },
      { amount: 1.0, unit: "tsp", name: "ground coriander" },
      { amount: 5.0, unit: "oz", name: "tomato paste" },
      { amount: 1.0, unit: "can", name: "finely chopped tomatoes" },
      { amount: 0.5, unit: "cup", name: "water" },
      { amount: 1.0, unit: "tsp", name: "fenugreek leaves" },
      { amount: 1.0, unit: "tsp", name: "dried dill" },
      { amount: 0.33, unit: "cup", name: "heavy cream" },
      { amount: nil, unit: nil, name: "Juice of ½ a lemon" },
      { amount: 1.0, unit: "Handful", name: "cilantro leaves" },
      { amount: nil, unit: nil, name: "Steamed rice" },
      { amount: nil, unit: nil, name: "Naan breads" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Start by placing the chicken thigh pieces into a bowl. Add the garlic, ginger, tandoori paste, honey, cumin, and Greek yogurt, then mix everything together until well combined, ensuring the chicken is evenly coated with the marinade.",
      "Place chicken into the air fryer basket and cook at 180°C for 16 minutes.",
      "For the sauce, place the butter into a deep sided saucepan and, once the butter has melted, add the green chilli, cumin and coriander and fry for a few seconds.",
      "Add the tomato purée and cook for a further few minutes then add in the tinned tomatoes and water.",
      "Cook, stirring, for 5 - 7 minutes until the sauce is slightly thickened and smells fragrant.",
      "Stir in the fenugreek leaves, dried dill, cream and lemon juice then add the cooked chicken, along with any juices from the airfryer.",
      "Cover with a lid and allow everything to cook together for 5 minutes then serve sprinkled with some coriander alongside some steamed rice and naan."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        [nil, 7],
        ["For the sauce", 11],
        ["To serve", 3]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Start by placing the chicken thigh pieces into a bowl. Add the garlic, ginger, tandoori paste, honey, cumin, and Greek yogurt, then mix everything together until well combined, ensuring the chicken is evenly coated with the marinade.\nPlace chicken into the air fryer basket and cook at 180°C for 16 minutes.\nFor the sauce, place the butter into a deep sided saucepan and, once the butter has melted, add the green chilli, cumin and coriander and fry for a few seconds.\nAdd the tomato purée and cook for a further few minutes then add in the tinned tomatoes and water.\nCook, stirring, for 5 - 7 minutes until the sauce is slightly thickened and smells fragrant.\nStir in the fenugreek leaves, dried dill, cream and lemon juice then add the cooked chicken, along with any juices from the airfryer.\nCover with a lid and allow everything to cook together for 5 minutes then serve sprinkled with some coriander alongside some steamed rice and naan.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("donalskehan.com")
    expect(recipe.canonical_url).to eq("https://donalskehan.com/recipes/air-fryer-indian-butter-chicken/")
    expect(recipe.site_name).to eq("Donal Skehan | EAT LIVE GO")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("This easy Air Fryer Butter Chicken delivers deep flavour from a spiced yogurt marinade, juicy tandoori-style chicken, and a rich, buttery tomato sauce—perfect for a family-favourite meal with rice and naan.")
    expect(recipe.image).to be_nil
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
    expect(recipe.links).to include("#us")
  end
end
