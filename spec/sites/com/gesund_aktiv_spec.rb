# frozen_string_literal: true

RSpec.describe "gesund-aktiv.com" do
  subject(:recipe) { scrape_cassette("com/gesund_aktiv", url: "https://www.gesund-aktiv.com/rezepte/vegetarisch/himbeer-joghurt-eis") }

  it "reads the title" do
    expect(recipe.title).to eq("Himbeer-Joghurt-Eis")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "200 g Himbeere",
      "120 g Joghurt (Kuh)",
      "1/2 Stück Zitrone",
      "1 Teelöffel Vanille",
      "1 Esslöffel Honig",
      "1 Esslöffel Leinöl",
      "1 Stängel Minze (grün)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 200.0, unit: "g", name: "Himbeere" },
      { amount: 120.0, unit: "g", name: "Joghurt" },
      { amount: 0.5, unit: "Stück", name: "Zitrone" },
      { amount: 1.0, unit: nil, name: "Teelöffel Vanille" },
      { amount: 1.0, unit: nil, name: "Esslöffel Honig" },
      { amount: 1.0, unit: nil, name: "Esslöffel Leinöl" },
      { amount: 1.0, unit: nil, name: "Stängel Minze" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Zu Beginn die Himbeeren gründlich abwaschen und anschließend in einem dafür geeignetem Gefäß pürieren.",
      "Die halbe Zitrone ausdrücken und den Saft zusammen mit einem Esslöffel Honig und einem Teelöffel Vanille in den Himbeermus einrühren.",
      "Dann in einer Schale Joghurt und Leinöl verrühren und im Anschluss den Himbeermus dazugeben und vermengen.",
      "Zum Schluss die Masse in Stieleisförmchen umfüllen und dann für mindestens vier Stunden in einem Tiefkühler gefrieren lassen. Zum Servieren mit ein paar Minzblättchen garnieren."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Zu Beginn die Himbeeren gründlich abwaschen und anschließend in einem dafür geeignetem Gefäß pürieren.\nDie halbe Zitrone ausdrücken und den Saft zusammen mit einem Esslöffel Honig und einem Teelöffel Vanille in den Himbeermus einrühren.\nDann in einer Schale Joghurt und Leinöl verrühren und im Anschluss den Himbeermus dazugeben und vermengen.\nZum Schluss die Masse in Stieleisförmchen umfüllen und dann für mindestens vier Stunden in einem Tiefkühler gefrieren lassen. Zum Servieren mit ein paar Minzblättchen garnieren.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("gesund-aktiv.com")
    expect(recipe.canonical_url).to eq("https://www.gesund-aktiv.com/rezepte/vegetarisch/himbeer-joghurt-eis")
    expect(recipe.site_name).to eq("gesund + aktiv")
    expect(recipe.language).to eq("de-DE")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Manchmal muss es eben Eis sein. Am besten selbstgemachtes mit nichts als guten Zutaten drin. Zum Beispiel Himbeeren und Joghurt. Einfach, erfrischend und lecker.")
    expect(recipe.image).to eq("https://www.gesund-aktiv.com/fileadmin/data/rezepte/info/rezept_himbeer_joghurt_wassereis_a.png")
    expect(recipe.category).to eq("Vegetarisch")
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
    expect(recipe.links).to include("#page-content")
  end
end
