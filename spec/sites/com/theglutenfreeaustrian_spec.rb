# frozen_string_literal: true

RSpec.describe "theglutenfreeaustrian.com" do
  subject(:recipe) { scrape_cassette("com/theglutenfreeaustrian", url: "https://theglutenfreeaustrian.com/gluten-free-sourdough-starter/") }

  it "reads the title" do
    expect(recipe.title).to eq("Gluten Free Sourdough Starter")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "350 grams gluten-free flour of choice",
      "Water, as needed, filtered or bottled spring water"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 350.0, unit: "grams", name: "gluten-free flour of choice" },
      { amount: nil, unit: nil, name: "Water, as needed, filtered or bottled spring water" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "How to make a Gluten Free Sourdough StarterStart: to a clean, sanitized mason jar add 25 grams of gluten free flour and 25 grams warm water (around 77F/25C – 84F/29C). Using a plastic spoon or spatula mix it together. Cover it with cheesecloth and a rubber pan or loosly cover it with the mason jar lid. Allow for it to sit at room temperature at the counter.",
      "Feeding #1: Around 8-12hrs after starting the sourdough starter, add 25 grams of gluten free flour and 25 grams of warm water. Mix it together, loosely cover it and allow for it to see at room temperature . If your mixture seems very stiff, add 5-10 extra grams of water to loosen up the mixture. It’s okay for the starter to be too runny vs being too dry.",
      "Feeding #2: 8-12 hours after the first feeding, it’s time for the second meal. Depending on which flour you used, your may already see some bubbles and growth in your starter. Add 25 grams of flour and 25 grams of warm water, mix, cover and place in a warm place.",
      "Feeding #3: You should definitely see some small bubbles and growth in your gluten free sourdough starter now. Repeat the feeding, mix, cover and store at ambient temperature.",
      "Feeding #4: On day three it's time to switch to a 1:1:1 feeding process and start discarding some of the starter.Remove all but 50 grams of the sourdough starter from the jar. Compost the discard or throw it away. Add 50 grams of fresh flour and 50 grams of warm water (around 77F/25C - 84F/29C) to the jar and mix. Cover and store at ambient temperature. (At this point, it is too early to save the discard for recipes since it is not yet from an established starter. )",
      "Feeding #5 up to 7 days: The sourdough starter should become more active now. You may also see bubbles. Keep up with the feedings every 8-12hrs. Remove all but 50 grams of the sourdough starter from the jar. Compost the discard or throw it away. Add 50 grams of fresh flour and 50 grams of warm water (around 77F/25C - 84F/29C) to the jar and mix. Cover and store at ambient temperature.",
      "After Seven days: After seven days and at least three days of consistent growth and doubling the size after every feeding within 4-12 hours, the gluten-free sourdough starter is ready to be used in recipes. I recommend feeding the sourdough starter ONCE a day for an additional week. This will strengthen the starter and build a strong starter to have on hand. I call those feedings maintenance feedings, which can be done with less flour and less often."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["Gluten Free Sourdough Starter", 2]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("How to make a Gluten Free Sourdough StarterStart: to a clean, sanitized mason jar add 25 grams of gluten free flour and 25 grams warm water (around 77F/25C – 84F/29C). Using a plastic spoon or spatula mix it together. Cover it with cheesecloth and a rubber pan or loosly cover it with the mason jar lid. Allow for it to sit at room temperature at the counter.\nFeeding #1: Around 8-12hrs after starting the sourdough starter, add 25 grams of gluten free flour and 25 grams of warm water. Mix it together, loosely cover it and allow for it to see at room temperature . If your mixture seems very stiff, add 5-10 extra grams of water to loosen up the mixture. It’s okay for the starter to be too runny vs being too dry.\nFeeding #2: 8-12 hours after the first feeding, it’s time for the second meal. Depending on which flour you used, your may already see some bubbles and growth in your starter. Add 25 grams of flour and 25 grams of warm water, mix, cover and place in a warm place.\nFeeding #3: You should definitely see some small bubbles and growth in your gluten free sourdough starter now. Repeat the feeding, mix, cover and store at ambient temperature.\nFeeding #4: On day three it's time to switch to a 1:1:1 feeding process and start discarding some of the starter.Remove all but 50 grams of the sourdough starter from the jar. Compost the discard or throw it away. Add 50 grams of fresh flour and 50 grams of warm water (around 77F/25C - 84F/29C) to the jar and mix. Cover and store at ambient temperature. (At this point, it is too early to save the discard for recipes since it is not yet from an established starter. )\nFeeding #5 up to 7 days: The sourdough starter should become more active now. You may also see bubbles. Keep up with the feedings every 8-12hrs. Remove all but 50 grams of the sourdough starter from the jar. Compost the discard or throw it away. Add 50 grams of fresh flour and 50 grams of warm water (around 77F/25C - 84F/29C) to the jar and mix. Cover and store at ambient temperature.\nAfter Seven days: After seven days and at least three days of consistent growth and doubling the size after every feeding within 4-12 hours, the gluten-free sourdough starter is ready to be used in recipes. I recommend feeding the sourdough starter ONCE a day for an additional week. This will strengthen the starter and build a strong starter to have on hand. I call those feedings maintenance feedings, which can be done with less flour and less often.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("theglutenfreeaustrian.com")
    expect(recipe.canonical_url).to eq("https://theglutenfreeaustrian.com/gluten-free-sourdough-starter/")
    expect(recipe.site_name).to eq("The Gluten Free Austrian")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Daniela Weiner")
    expect(recipe.description).to eq("This simple gluten free sourdough starter is made from two ingredients: a gluten free flour, such as sorghum flour, and filtered water. Small batch gluten free sour dough starter recipe")
    expect(recipe.image).to eq("https://theglutenfreeaustrian.com/wp-content/uploads/2024/03/sourdough-13-720x720.jpg")
    expect(recipe.category).to eq("Gluten Free Bread")
    expect(recipe.cuisine).to eq("Austrian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("250 servings")
    expect(recipe.total_time).to eq(10_090)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(5)
    expect(recipe.keywords).to eq([
      "gluten free sourdough starter",
      "gluten free sourdough",
      "gluten free sourdough bread"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["GlutenFreeDiet"])
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(9)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "calories" => "1 calories", "servingSize" => "1" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 1.0 },
      { name: "servingSize", unit: nil, amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://theglutenfreeaustrian.com/")
  end
end
