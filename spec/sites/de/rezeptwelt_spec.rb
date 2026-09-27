# frozen_string_literal: true

RSpec.describe "rezeptwelt.de" do
  subject(:recipe) { scrape_cassette("de/rezeptwelt", url: "https://www.rezeptwelt.de/Saucen-Dips-Brotaufstriche-rezepte/Konfiture-mit-Gelierfix-und-wenig-Zucker/iug92m9p-5f111-764580-4a364-iixan86v") }

  it "reads the title" do
    expect(recipe.title).to eq("Konfitüre mit Gelierfix und wenig Zucker")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "900 Gramm Früchte /Erdbeeren , Himbeeren etc.",
      "200 Gramm Zucker /Erythrit",
      "25 Gramm Gelierfix*",
      "3 Esslöffel Zitronensaft",
      "1 Esslöffel Vanillepaste",
      "1 Teelöffel Speiseöl"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 900.0, unit: "Gramm", name: "Früchte /Erdbeeren, Himbeeren etc." },
      { amount: 200.0, unit: "Gramm", name: "Zucker /Erythrit" },
      { amount: 25.0, unit: "Gramm", name: "Gelierfix*" },
      { amount: 3.0, unit: nil, name: "Esslöffel Zitronensaft" },
      { amount: 1.0, unit: nil, name: "Esslöffel Vanillepaste" },
      { amount: 1.0, unit: nil, name: "Teelöffel Speiseöl" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Gläser",
      "Zuerst die Gläser im Varoma 25 min sterilisieren (Dampfgaren)\"Modus „Pürieren“\"",
      "Konfitüre",
      "750 gr. Früchte in den Mixtopf geben.",
      "25 gr. Gelierfix in den Mixtopf geben.",
      "3 Essl&oum...",
      "3 Esslöffel Zitronensaft in den Mixtopf geben.",
      "1 Essl&oum...",
      "1 Esslöffel Vanillepaste und 1 Teelöffel Pflanzenfett in den Mixtopf geben.",
      "Mit dem Mixtopfdeckel verschliessen und 9 Min./100°C/ auf Stufe 2 im \"Linkslauf\" ohne Deckelkappe kochen lassen.",
      "Die 150 gr. restlichen Früchte (falls die Früchte zu gross sind, etwas klein schneiden) in den Mixtopf geben.",
      "Weitere 4 Min./100°C/ auf Stufe 2 im \"Linkslauf\" ohne Deckelkappe kochen lassen.",
      "Dann eine Gelierprobe nehmen und wenn die Konsistenz gut ist, in die vorbereiteten Gläser füllen, verschliessen und danach kurz umdrehen bzw. auf den Deckel stellen.",
      "Dann die Konfitüre in den Kühlschrank stellen."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Gläser\nZuerst die Gläser im Varoma 25 min sterilisieren (Dampfgaren)\"Modus „Pürieren“\"\nKonfitüre\n750 gr. Früchte in den Mixtopf geben.\n25 gr. Gelierfix in den Mixtopf geben.\n3 Essl&oum...\n3 Esslöffel Zitronensaft in den Mixtopf geben.\n1 Essl&oum...\n1 Esslöffel Vanillepaste und 1 Teelöffel Pflanzenfett in den Mixtopf geben.\nMit dem Mixtopfdeckel verschliessen und 9 Min./100°C/ auf Stufe 2 im \"Linkslauf\" ohne Deckelkappe kochen lassen.\nDie 150 gr. restlichen Früchte (falls die Früchte zu gross sind, etwas klein schneiden) in den Mixtopf geben.\nWeitere 4 Min./100°C/ auf Stufe 2 im \"Linkslauf\" ohne Deckelkappe kochen lassen.\nDann eine Gelierprobe nehmen und wenn die Konsistenz gut ist, in die vorbereiteten Gläser füllen, verschliessen und danach kurz umdrehen bzw. auf den Deckel stellen.\nDann die Konfitüre in den Kühlschrank stellen.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("rezeptwelt.de")
    expect(recipe.canonical_url).to eq("https://www.rezeptwelt.de/Saucen-Dips-Brotaufstriche-rezepte/Konfiture-mit-Gelierfix-und-wenig-Zucker/iug92m9p-5f111-764580-4a364-iixan86v")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to be_nil
    expect(recipe.author).to eq("Manu_1974")
    expect(recipe.description).to eq("Konfitüre mit Gelierfix und wenig Zucker, ein Rezept der Kategorie Saucen/Dips/Brotaufstriche. Mehr Thermomix® Rezepte auf www.rezeptwelt.de")
    expect(recipe.image).to eq("https://d1a52lafkyga3q.cloudfront.net/recipeimage/iug92m9p-5f111-764580-4a364-iixan86v/450a4ac9-36da-480b-9c06-c43b39e1bf7f/original/konfituere-mit-gelierfix-und-wenig-zucker.JPG")
    expect(recipe.category).to eq("Saucen/Dips/Brotaufstriche")
    expect(recipe.cuisine).to eq("Europäisch")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("5 servings")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to eq(40)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(%w[Europäisch europaisch])
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
    expect(recipe.links).to include("#socialShares")
  end
end
