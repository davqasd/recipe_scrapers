# frozen_string_literal: true

RSpec.describe "aldi-sued.de" do
  subject(:recipe) { scrape_cassette("de/aldi_sued", url: "https://www.aldi-sued.de/rezepte/ernaehrungsweise/ausgewogene-ernaehrung/rdp-paprika-reispfanne-mit-haehnchenfilet") }

  it "reads the title" do
    expect(recipe.title).to eq("Paprika-Reispfanne mit Hähnchenfilet")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "BON RI Basmatireis",
      "Zwiebeln",
      "Zehen NATUR LIEBLINGE Knoblauch",
      "rote Paprika",
      "gelbe Paprika",
      "grüne Paprika",
      "MEINE METZGEREI Hähnchenbrustfilet",
      "CANTINELLE Natives Olivenöl extra",
      "CUCINA NOBILE Tomatenmark",
      "LE GUSTO Paprika, scharf",
      "KING’S CROWN Tomaten fein gehackt",
      "LE GUSTO klare Brühe im Glas, Sorte: Gemüse",
      "Salz",
      "LE GUSTO Pfeffer",
      "Zucker",
      "Bio-Topfkräuter Schnittlauch"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "BON RI Basmatireis" },
      { amount: nil, unit: nil, name: "Zwiebeln" },
      { amount: nil, unit: nil, name: "Zehen NATUR LIEBLINGE Knoblauch" },
      { amount: nil, unit: nil, name: "rote Paprika" },
      { amount: nil, unit: nil, name: "gelbe Paprika" },
      { amount: nil, unit: nil, name: "grüne Paprika" },
      { amount: nil, unit: nil, name: "MEINE METZGEREI Hähnchenbrustfilet" },
      { amount: nil, unit: nil, name: "CANTINELLE Natives Olivenöl extra" },
      { amount: nil, unit: nil, name: "CUCINA NOBILE Tomatenmark" },
      { amount: nil, unit: nil, name: "LE GUSTO Paprika, scharf" },
      { amount: nil, unit: nil, name: "KING’S CROWN Tomaten fein gehackt" },
      { amount: nil, unit: nil, name: "LE GUSTO klare Brühe im Glas, Sorte: Gemüse" },
      { amount: nil, unit: nil, name: "Salz" },
      { amount: nil, unit: nil, name: "LE GUSTO Pfeffer" },
      { amount: nil, unit: nil, name: "Zucker" },
      { amount: nil, unit: nil, name: "Bio-Topfkräuter Schnittlauch" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Den Reis nach Packungsanweisung 10 Minuten vorgaren. Das Wasser abgießen.",
      "Die Zwiebeln und den Knoblauch abziehen und fein würfeln. Die Paprika waschen, putzen und in mundgerechte Stücke schneiden.",
      "Das Hähnchenfleisch abbrausen, trockentupfen und in Stücke schneiden. Mit Salz und Pfeffer würzen. Das Fleisch in einer Pfanne mit Olivenöl rundherum 3 Minuten anbraten, aus der Pfanne nehmen und beiseitestellen.",
      "Die Zwiebeln und den Knoblauch in dem restlichen Öl andünsten, die Paprika und den Reis zugeben. Mit Salz, Pfeffer, Zucker, Tomatenmark und Paprikapulver würzen.",
      "Die gehackten Tomaten und die Brühe dazugeben und 6 Minuten in der Pfanne köcheln lassen.",
      "Das Hähnchenfleisch in die Pfanne geben und weitere 2 Minuten bei mittlerer Hitze garen. Alles gut verrühren und vor dem Servieren nochmals mit Gewürzen abschmecken. Mit Schnittlauchröllchen garniert servieren."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Den Reis nach Packungsanweisung 10 Minuten vorgaren. Das Wasser abgießen.\nDie Zwiebeln und den Knoblauch abziehen und fein würfeln. Die Paprika waschen, putzen und in mundgerechte Stücke schneiden.\nDas Hähnchenfleisch abbrausen, trockentupfen und in Stücke schneiden. Mit Salz und Pfeffer würzen. Das Fleisch in einer Pfanne mit Olivenöl rundherum 3 Minuten anbraten, aus der Pfanne nehmen und beiseitestellen.\nDie Zwiebeln und den Knoblauch in dem restlichen Öl andünsten, die Paprika und den Reis zugeben. Mit Salz, Pfeffer, Zucker, Tomatenmark und Paprikapulver würzen.\nDie gehackten Tomaten und die Brühe dazugeben und 6 Minuten in der Pfanne köcheln lassen.\nDas Hähnchenfleisch in die Pfanne geben und weitere 2 Minuten bei mittlerer Hitze garen. Alles gut verrühren und vor dem Servieren nochmals mit Gewürzen abschmecken. Mit Schnittlauchröllchen garniert servieren.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("aldi-sued.de")
    expect(recipe.canonical_url).to eq("https://www.aldi-sued.de/rezepte/ernaehrungsweise/ausgewogene-ernaehrung/rdp-paprika-reispfanne-mit-haehnchenfilet")
    expect(recipe.site_name).to eq("ALDI SÜD")
    expect(recipe.language).to eq("de-DE")
    expect(recipe.author).to eq("ALDI SÜD")
    expect(recipe.description).to eq("Rice, Rice, Baby! Schnell gemacht und super lecker – an dieser bunten Paprika-Reispfanne mit zartem Hähnchenfilet kommt keiner vorbei.")
    expect(recipe.image).to eq("https://www.aldi-sued.de/content/dam/aldi/emea/de-aldisued/editorial/rezepte/rezeptdetailseiten/Rezept_Article_RZ49540530000000.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(25)
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
    expect(recipe.links).to include("#main")
  end
end
