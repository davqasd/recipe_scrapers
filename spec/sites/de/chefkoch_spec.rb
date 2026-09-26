# frozen_string_literal: true

RSpec.describe "chefkoch.de" do
  subject(:recipe) { scrape_cassette("de/chefkoch", url: "https://www.chefkoch.de/rezepte/1170311223132029/Hackbraten-supersaftig.html") }

  it "reads the title" do
    expect(recipe.title).to eq("Saftiger Hackbraten im Ofen")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1.5 Semmel(n) (altbacken)",
      "2 Gewürzgurke(n)",
      "2 kleine Zwiebel(n)",
      "1 kl. Bund Petersilie",
      "50 g Butter",
      "600 g Hackfleisch, gemischtes",
      "2 kleine Ei(er) (Kl. S)",
      "2 EL Zitronensaft",
      "Salz und Pfeffer, schwarzer",
      "Cayennepfeffer",
      "Fett für die Form",
      "125 ml Fleischbrühe",
      "125 ml Sahne",
      "1 EL Crème fraîche",
      "1 TL Paprikapulver, edelsüßes"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.5, unit: nil, name: "Semmel" },
      { amount: 2.0, unit: nil, name: "Gewürzgurke" },
      { amount: 2.0, unit: nil, name: "kleine Zwiebel" },
      { amount: 1.0, unit: "Bund", name: "Petersilie" },
      { amount: 50.0, unit: "g", name: "Butter" },
      { amount: 600.0, unit: "g", name: "Hackfleisch, gemischtes" },
      { amount: 2.0, unit: nil, name: "kleine Ei" },
      { amount: 2.0, unit: "EL", name: "Zitronensaft" },
      { amount: nil, unit: nil, name: "Salz und Pfeffer, schwarzer" },
      { amount: nil, unit: nil, name: "Cayennepfeffer" },
      { amount: nil, unit: nil, name: "Fett für die Form" },
      { amount: 125.0, unit: "ml", name: "Fleischbrühe" },
      { amount: 125.0, unit: "ml", name: "Sahne" },
      { amount: 1.0, unit: "EL", name: "Crème fraîche" },
      { amount: 1.0, unit: "TL", name: "Paprikapulver, edelsüßes" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Für den Hackbraten die Semmeln in Scheiben schneiden, mit Wasser übergießen und 10 Minuten quellen lassen. Gut ausdrücken. Die Gewürzgurken in sehr feine Würfel schneiden. Zwiebeln ebenfalls in feine Würfel schneiden.",
      "1 EL Butter erhitzen und die Zwiebeln glasig anschwitzen. Petersilie dazugeben.",
      "Zwiebel-Petersilien-Mischung in eine Schüssel geben. Semmeln, Gewürzgurken, Hackfleisch, Eier und Zitronensaft zufügen. Alles mit Salz, schwarzem Pfeffer und Cayennepfeffer würzen und kräftig durchkneten.",
      "Die restliche Butter schmelzen und damit eine Form fetten. Den Fleischteig zu einem Laib formen und in die Form legen. Auf der unteren Schiene bei 180 °C Umluft 30 Minuten backen, dabei mehrfach mit der flüssigen Butter bestreichen.",
      "Für die Sauce die Fleischbrühe erhitzen und mit der Sahne, der Crème fraîche und dem Paprikapulver verrühren. (Wer sehr viel Sauce mag, kann die Zutatenmenge einfach verdoppeln). Die Sauce über den Hackbraten gießen und alles weitere 10–15 Minuten garen. Hinweis: Dazu passen hervorragend Salzkartoffeln."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Für den Hackbraten die Semmeln in Scheiben schneiden, mit Wasser übergießen und 10 Minuten quellen lassen. Gut ausdrücken. Die Gewürzgurken in sehr feine Würfel schneiden. Zwiebeln ebenfalls in feine Würfel schneiden.\n1 EL Butter erhitzen und die Zwiebeln glasig anschwitzen. Petersilie dazugeben.\nZwiebel-Petersilien-Mischung in eine Schüssel geben. Semmeln, Gewürzgurken, Hackfleisch, Eier und Zitronensaft zufügen. Alles mit Salz, schwarzem Pfeffer und Cayennepfeffer würzen und kräftig durchkneten.\nDie restliche Butter schmelzen und damit eine Form fetten. Den Fleischteig zu einem Laib formen und in die Form legen. Auf der unteren Schiene bei 180 °C Umluft 30 Minuten backen, dabei mehrfach mit der flüssigen Butter bestreichen.\nFür die Sauce die Fleischbrühe erhitzen und mit der Sahne, der Crème fraîche und dem Paprikapulver verrühren. (Wer sehr viel Sauce mag, kann die Zutatenmenge einfach verdoppeln). Die Sauce über den Hackbraten gießen und alles weitere 10–15 Minuten garen. Hinweis: Dazu passen hervorragend Salzkartoffeln.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("chefkoch.de")
    expect(recipe.canonical_url).to eq("https://www.chefkoch.de/rezepte/1170311223132029/Hackbraten-supersaftig.html")
    expect(recipe.site_name).to eq("Chefkoch")
    expect(recipe.language).to eq("de-DE")
    expect(recipe.author).to eq("Delphinella")
    expect(recipe.description).to eq("Hackbraten supersaftig - Klassischer saftiger Hackbraten mit viel Sauce. Über 1454 Bewertungen und für lecker befunden. Mit ► Portionsrechner ► Kochbuch ► Video-Tipps!")
    expect(recipe.image).to eq("https://img.chefkoch-cdn.de/rezepte/1170311223132029/bilder/1617140/crop-960x540/hackbraten-supersaftig.jpg")
    expect(recipe.category).to eq("Braten")
    expect(recipe.cuisine).to eq("Deutsch")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(85)
    expect(recipe.prep_time).to eq(40)
    expect(recipe.cook_time).to eq(45)
    expect(recipe.keywords).to eq([
      "Fleisch",
      "Hauptspeise",
      "Rind",
      "Saucen",
      "Schwein",
      "Resteverwertung",
      "ketogen",
      "Low Carb"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.58)
    expect(recipe.ratings_count).to eq(1454)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 Portion",
      "calories" => "613 kcal",
      "proteinContent" => "29.9 g",
      "fatContent" => "46.6 g",
      "carbohydrateContent" => "19.2 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "Portion", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 613.0 },
      { name: "proteinContent", unit: "g", amount: 29.9 },
      { name: "fatContent", unit: "g", amount: 46.6 },
      { name: "carbohydrateContent", unit: "g", amount: 19.2 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.funkemedien.de/de/")
  end
end
