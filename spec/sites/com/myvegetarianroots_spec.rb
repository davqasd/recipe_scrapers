# frozen_string_literal: true

RSpec.describe "myvegetarianroots.com" do
  subject(:recipe) { scrape_cassette("com/myvegetarianroots", url: "https://myvegetarianroots.com/falafel-wraps/") }

  it "reads the title" do
    expect(recipe.title).to eq("Falafel Wraps")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "½ cup Split Green Peas Lentils",
      "½ cup Whole Masoor",
      "½ cup Whole Green Mung Beans",
      "2½ cup Fresh Parsley (tightly packed)",
      "1½ cup Fresh Cilantro (tightly packed)",
      "1½ tbsp Whole Dry Coriander Seeds",
      "1½ tsp Salt",
      "2 Serrano (less if you prefer less spicy!)",
      "5 clove Garlic (medium sized cloves)",
      "2 inch Ginger Root",
      "2 cup Water"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.5, unit: "cup", name: "Split Green Peas Lentils" },
      { amount: 0.5, unit: "cup", name: "Whole Masoor" },
      { amount: 0.5, unit: "cup", name: "Whole Green Mung Beans" },
      { amount: 2.5, unit: "cup", name: "Fresh Parsley" },
      { amount: 1.5, unit: "cup", name: "Fresh Cilantro" },
      { amount: 1.5, unit: "tbsp", name: "Whole Dry Coriander Seeds" },
      { amount: 1.5, unit: "tsp", name: "Salt" },
      { amount: 2.0, unit: nil, name: "Serrano" },
      { amount: 5.0, unit: "clove", name: "Garlic" },
      { amount: 2.0, unit: "inch", name: "Ginger Root" },
      { amount: 2.0, unit: "cup", name: "Water" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Mix all lentils mentioned above, wash them few times and soak them for 6-8 hours.",
      "Once soaked, drain all the water out. Wrap it in a muslin/cotton cloth. Place it in a strainer with a plate underneath it. Place the whole set up in a dark place. I like to place it in an oven (THAT IS NOT ON) for 12 hours to let them sprout.",
      "Check the beans after 12 hours, move it around with you fingers. If you wish to sprout more, place the same setting in dark place for another 12 hours.",
      "Once sprouted, rinse them with water. Drain all the water out.",
      "Place drained sprouted beans in a blender/food processor with rest of the ingredients listed above. Keep blending till you get pancake like consistency. 2 cups of water as mentioned above should be enough to get the right consistency, but you can add more or less if you like. you can leave it grainy or smooth based on your preference.",
      "Once the batter is ready, it's ready to make the chilla/wrap. You can either use it right away or refrigerate it up to 3 days and use it as you like!",
      "Heat up cast irons skillet/choice of tawa. Spray avocado oil or use any type of oil to grease the skillet/tawa.",
      "Spread a thin (or thick, as you like) layer of batter on greasy hot skillet/tawa. Spray/drizzle some more oil on top, cover and let it cook on medium heat (closer to high but not too high) for about a min or so, until you see charred brown marks on the side facing down.",
      "Flip it and cook on the other side for few more second, until it starts showing some brown spots.",
      "Repeat the same process for as mnay wraps/chilla you like to make.",
      "Simply enjoy it with choice of subzi/dal/pickle/yogurt. Or top it with crunchy veggie salad. Drizzle creamy tahini sauce & spicy garlicky red pepper sauce as mentioned in my Falafel recipe. Wrap it and enjoy like a wrap!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Mix all lentils mentioned above, wash them few times and soak them for 6-8 hours.\nOnce soaked, drain all the water out. Wrap it in a muslin/cotton cloth. Place it in a strainer with a plate underneath it. Place the whole set up in a dark place. I like to place it in an oven (THAT IS NOT ON) for 12 hours to let them sprout.\nCheck the beans after 12 hours, move it around with you fingers. If you wish to sprout more, place the same setting in dark place for another 12 hours.\nOnce sprouted, rinse them with water. Drain all the water out.\nPlace drained sprouted beans in a blender/food processor with rest of the ingredients listed above. Keep blending till you get pancake like consistency. 2 cups of water as mentioned above should be enough to get the right consistency, but you can add more or less if you like. you can leave it grainy or smooth based on your preference.\nOnce the batter is ready, it's ready to make the chilla/wrap. You can either use it right away or refrigerate it up to 3 days and use it as you like!\nHeat up cast irons skillet/choice of tawa. Spray avocado oil or use any type of oil to grease the skillet/tawa.\nSpread a thin (or thick, as you like) layer of batter on greasy hot skillet/tawa. Spray/drizzle some more oil on top, cover and let it cook on medium heat (closer to high but not too high) for about a min or so, until you see charred brown marks on the side facing down.\nFlip it and cook on the other side for few more second, until it starts showing some brown spots.\nRepeat the same process for as mnay wraps/chilla you like to make.\nSimply enjoy it with choice of subzi/dal/pickle/yogurt. Or top it with crunchy veggie salad. Drizzle creamy tahini sauce & spicy garlicky red pepper sauce as mentioned in my Falafel recipe. Wrap it and enjoy like a wrap!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("myvegetarianroots.com")
    expect(recipe.canonical_url).to eq("https://myvegetarianroots.com/falafel-wraps/")
    expect(recipe.site_name).to eq("My Vegetarian Roots")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Hetal Desai")
    expect(recipe.description).to eq("Falafel Wraps - super green, protein and fiber rich sprouted beans chilla (flatbread), wrapped with crunchy veggie salad, creamy tahini sauce & spicy garlicky red sauce")
    expect(recipe.image).to eq("https://myvegetarianroots.com/wp-content/uploads/2022/06/DSC_0075.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("Mediterranean")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(15)
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
