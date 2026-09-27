# frozen_string_literal: true

RSpec.describe "drizzleanddip.com" do
  subject(:recipe) { scrape_cassette("com/drizzleanddip", url: "https://drizzleanddip.com/2026/01/20/the-best-broccoli-salad-youll-ever-make-adapted-from-dishoom/") }

  it "reads the title" do
    expect(recipe.title).to eq("Broccoli Salad with Dates, Pistachios & Ginger-Lime Dressing Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "60 ml ¼ cup extra virgin olive oil",
      "2 Tbsp rice wine vinegar",
      "Juice of 2 limes (plus extra if needed)",
      "1-2 tsp pickled jalapeño (or half a fresh one)",
      "A good knob of ginger (about 3cm, peeled and sliced)",
      "1 Tbsp honey",
      "6 mint leaves",
      "¼ tsp salt",
      "2.5-3 cups chopped broccoli florets (small, even pieces)",
      "4-5 dates (stones removed, sliced and finely chopped)",
      "1 medium red pepper (or ¾ of a large pepper, diced)",
      "A small handful of fresh coriander with stalks (approximately 10g, chopped)",
      "4 mint leaves (roughly chopped)",
      "50 grams fresh pistachio nuts (roughly chopped)",
      "25 grams about ¼ cup toasted pumpkin seeds",
      "A small handful of pomegranate seeds (entirely optional)",
      "Additional lime juice if needed"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 60.0, unit: "ml", name: "extra virgin olive oil" },
      { amount: 2.0, unit: "Tbsp", name: "rice wine vinegar" },
      { amount: nil, unit: nil, name: "Juice of 2 limes" },
      { amount: 1.0, unit: "tsp", name: "pickled jalapeño" },
      { amount: nil, unit: nil, name: "A good knob of ginger" },
      { amount: 1.0, unit: "Tbsp", name: "honey" },
      { amount: 6.0, unit: nil, name: "mint leaves" },
      { amount: 0.25, unit: "tsp", name: "salt" },
      { amount: 2.5, unit: "cups", name: "chopped broccoli florets" },
      { amount: 4.0, unit: nil, name: "dates" },
      { amount: 1.0, unit: nil, name: "medium red pepper" },
      { amount: 1.0, unit: "handful", name: "fresh coriander with stalks" },
      { amount: 4.0, unit: nil, name: "mint leaves" },
      { amount: 50.0, unit: "grams", name: "fresh pistachio nuts" },
      { amount: 25.0, unit: "grams", name: "about ¼ cup toasted pumpkin seeds" },
      { amount: 1.0, unit: "handful", name: "pomegranate seeds" },
      { amount: nil, unit: nil, name: "Additional lime juice if needed" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "To make the dressing, place all the dressing ingredients into the jug of a powerful blender and blend until well combined and smooth. Taste and adjust the lime, honey or salt if needed.",
      "Prepare all your salad ingredients. The broccoli should be cut into small, even bite-sized florets. Make sure your dates are finely chopped so they distribute evenly throughout the salad.",
      "In a large bowl, combine the broccoli, chopped dates, diced red pepper, coriander and mint. Pour over the dressing and toss everything together until the broccoli is well coated.",
      "If serving immediately, let the salad sit for at least 20 minutes to allow the flavours to meld. If making ahead, you can leave it for up to 3 hours in the fridge.",
      "Just before serving, add the chopped pistachios and toasted pumpkin seeds, tossing to combine. Scatter over the pomegranate seeds if using. Taste and add an extra squeeze of lime if you think it needs more zing."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["For the Dressing:", 8],
        ["For the Salad:", 9]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("To make the dressing, place all the dressing ingredients into the jug of a powerful blender and blend until well combined and smooth. Taste and adjust the lime, honey or salt if needed.\nPrepare all your salad ingredients. The broccoli should be cut into small, even bite-sized florets. Make sure your dates are finely chopped so they distribute evenly throughout the salad.\nIn a large bowl, combine the broccoli, chopped dates, diced red pepper, coriander and mint. Pour over the dressing and toss everything together until the broccoli is well coated.\nIf serving immediately, let the salad sit for at least 20 minutes to allow the flavours to meld. If making ahead, you can leave it for up to 3 hours in the fridge.\nJust before serving, add the chopped pistachios and toasted pumpkin seeds, tossing to combine. Scatter over the pomegranate seeds if using. Taste and add an extra squeeze of lime if you think it needs more zing.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("drizzleanddip.com")
    expect(recipe.canonical_url).to eq("https://drizzleanddip.com/2026/01/20/the-best-broccoli-salad-youll-ever-make-adapted-from-dishoom/")
    expect(recipe.site_name).to eq("Drizzle and Dip")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Sam Linsell")
    expect(recipe.description).to eq("A punchy ginger-lime dressing transforms raw broccoli into something special in this Dishoom-inspired salad. The secret is letting it marinate for 20 minutes before serving.")
    expect(recipe.image).to eq("https://drizzleanddip.com/wp-content/uploads/2026/01/The-best-broccoli-salad-2.jpg")
    expect(recipe.category).to eq("Salad")
    expect(recipe.cuisine).to eq("Indian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(25)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Broccoli", "ginger", "lime", "pistachio", "pumpkin seeds", "red pepper", "salad"])
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
    expect(recipe.links).to include("#main")
  end
end
