# frozen_string_literal: true

RSpec.describe "sallys-blog.de" do
  subject(:recipe) { scrape_cassette("de/sallys_blog", url: "https://sallys-blog.de/rezepte/germknoedel-mit-pflaumenfuellung-vanillesosse-und-mohn") }

  it "reads the title" do
    expect(recipe.title).to eq("Germknödel / mit Pflaumenfüllung, Vanillesoße und Mohn")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "0",
      "Hefe",
      "1",
      "Wasser",
      "2",
      "Zucker",
      "3",
      "Mehl",
      "4",
      "Milch",
      "5",
      "Butter (weich)",
      "6",
      "Salz",
      "7",
      "Pflaumenmus",
      "8",
      "Zimt",
      "9",
      "Vanilleextrakt",
      "12",
      "Speisestärke",
      "13",
      "Eigelbe",
      "15",
      "Butter (flüssig)",
      "16",
      "Mohn",
      "17",
      "Puderzucker"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: nil },
      { amount: nil, unit: nil, name: "Hefe" },
      { amount: 1.0, unit: nil, name: nil },
      { amount: nil, unit: nil, name: "Wasser" },
      { amount: 2.0, unit: nil, name: nil },
      { amount: nil, unit: nil, name: "Zucker" },
      { amount: 3.0, unit: nil, name: nil },
      { amount: nil, unit: nil, name: "Mehl" },
      { amount: 4.0, unit: nil, name: nil },
      { amount: nil, unit: nil, name: "Milch" },
      { amount: 5.0, unit: nil, name: nil },
      { amount: nil, unit: nil, name: "Butter" },
      { amount: 6.0, unit: nil, name: nil },
      { amount: nil, unit: nil, name: "Salz" },
      { amount: 7.0, unit: nil, name: nil },
      { amount: nil, unit: nil, name: "Pflaumenmus" },
      { amount: 8.0, unit: nil, name: nil },
      { amount: nil, unit: nil, name: "Zimt" },
      { amount: 9.0, unit: nil, name: nil },
      { amount: nil, unit: nil, name: "Vanilleextrakt" },
      { amount: 12.0, unit: nil, name: nil },
      { amount: nil, unit: nil, name: "Speisestärke" },
      { amount: 13.0, unit: nil, name: nil },
      { amount: nil, unit: nil, name: "Eigelbe" },
      { amount: 15.0, unit: nil, name: nil },
      { amount: nil, unit: nil, name: "Butter" },
      { amount: 16.0, unit: nil, name: nil },
      { amount: nil, unit: nil, name: "Mohn" },
      { amount: 17.0, unit: nil, name: nil },
      { amount: nil, unit: nil, name: "Puderzucker" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Hefeteig",
      "Verrühre die Hefe mit dem Wasser und Zucker.",
      "Füge übrigen Zutaten hinzu und verknete alles in etwa 10 Minuten zu einem geschmeidigen Teig.",
      "Forme den Teig zu einer Kugel, fette ihn mit etwas Backtrennspray und lasse ihn abgedeckt etwa 1 Stunde bei Raumtemperatur aufgehen.",
      "_",
      "Germknödel füllen und formen",
      "Fette ein Dampfblech mit etwas Backtrennspray. Verrühre das Pflaumenmus mit dem Zimt.",
      "Gib den Teig auf eine leicht bemehlte Arbeitsfläche, teile ihn in gleichmäßige Portionen und forme sie zu Kugeln.",
      "Öffne jede Kugel, indem du sie leicht flach drückst, gib das Pflaumenmus mit einem mittleren Portionierer hinein und verschließe den Teig mit den Fingerspitzen, sodass das Mus vollständig umschlossen ist. Achte darauf, die Naht gut zu verschließen.",
      "Forme glatte Kugeln und lege sie mit der Naht nach unten und etwas Abstand in das gefettete Blech.",
      "Germknödel garen",
      "Gib das Blech in den kalten Ofen und stelle ihn dann mit der Dampfgarfunktion auf 100 °C. Gare die Germknödel für 20 Minuten. Bereite in der Zwischenzeit die Vanillesoße zu.",
      "_",
      "Vanillesoße",
      "Verrühre alle Zutaten für die Soße miteinander in einem Topf und lasse die Mischung dann unter ständigem Rühren bei mittlerer Hitze aufkochen.",
      "Lasse die Soße köcheln und eindicken, bis die gewünschte Konsistenz erreicht ist. Streiche sie bei Bedarf durch ein Sieb, um Klümpchen zu entfernen.",
      "_",
      "Germknödel servieren",
      "Schmilz die Butter und bestreiche die warmen Knödel damit. Gib die Knödel auf Teller, gieße die Vanillesoße dazu und bestreue die Germknödel großzügig mit Mohn und Puderzucker."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Hefeteig\nVerrühre die Hefe mit dem Wasser und Zucker.\nFüge übrigen Zutaten hinzu und verknete alles in etwa 10 Minuten zu einem geschmeidigen Teig.\nForme den Teig zu einer Kugel, fette ihn mit etwas Backtrennspray und lasse ihn abgedeckt etwa 1 Stunde bei Raumtemperatur aufgehen.\n_\nGermknödel füllen und formen\nFette ein Dampfblech mit etwas Backtrennspray. Verrühre das Pflaumenmus mit dem Zimt.\nGib den Teig auf eine leicht bemehlte Arbeitsfläche, teile ihn in gleichmäßige Portionen und forme sie zu Kugeln.\nÖffne jede Kugel, indem du sie leicht flach drückst, gib das Pflaumenmus mit einem mittleren Portionierer hinein und verschließe den Teig mit den Fingerspitzen, sodass das Mus vollständig umschlossen ist. Achte darauf, die Naht gut zu verschließen.\nForme glatte Kugeln und lege sie mit der Naht nach unten und etwas Abstand in das gefettete Blech.\nGermknödel garen\nGib das Blech in den kalten Ofen und stelle ihn dann mit der Dampfgarfunktion auf 100 °C. Gare die Germknödel für 20 Minuten. Bereite in der Zwischenzeit die Vanillesoße zu.\n_\nVanillesoße\nVerrühre alle Zutaten für die Soße miteinander in einem Topf und lasse die Mischung dann unter ständigem Rühren bei mittlerer Hitze aufkochen.\nLasse die Soße köcheln und eindicken, bis die gewünschte Konsistenz erreicht ist. Streiche sie bei Bedarf durch ein Sieb, um Klümpchen zu entfernen.\n_\nGermknödel servieren\nSchmilz die Butter und bestreiche die warmen Knödel damit. Gib die Knödel auf Teller, gieße die Vanillesoße dazu und bestreue die Germknödel großzügig mit Mohn und Puderzucker.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("sallys-blog.de")
    expect(recipe.canonical_url).to eq("https://sallys-blog.de/rezepte/germknoedel-mit-pflaumenfuellung-vanillesosse-und-mohn")
    expect(recipe.site_name).to eq("Sallys Blog")
    expect(recipe.language).to eq("de-DE")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Diese Germknödel sind wunderbar fluffig und mit würzigem Pflaumenmus und Zimt gefüllt. Der weiche Hefeteig wird schonend im Dampf gegart und bleibt dadurch besonders locker und saftig. Ihr könnt sie aber auch im Topf zubereiten. Dazu gibt es eine selbstgemachte, cremige Vanillesoße. Zum Servieren werden die warmen Germknödel mit geschmolzener Butter bestrichen und großzügig mit Mohn und Puderzucker bestreut. Zusammen mit der Vanillesoße sind sie ein echter Klassiker für kalte Tage und schmecken als süße Hauptspeise oder warmes Dessert.")
    expect(recipe.image).to eq("https://sallyshop.b-cdn.net/media/a0/62/8c/1790172004/sally-germknoedel-pflaumenfuellung-rezept.jpg?width=3000")
    expect(recipe.category).to eq("Desserts")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(45)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq(["Germknödel", "Germknödel Rezept", "Germknödel selber machen", "Germknödel mit Pflaumenmus", "Germknödel mit Vanillesoße", "Germknödel mit Mohn", "Germknödel dämpfen", "gedämpfte Germknödel", "Hefeknödel", "Hefeknödel Rezept", "Pflaumenmus", "Vanillesoße selber machen", "süße Hauptspeise", "österreichische Germknödel", "österreichische Küche", "Mehlspeise"])
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
    expect(recipe.links).to include("#cookieActivateModalURL")
  end
end
