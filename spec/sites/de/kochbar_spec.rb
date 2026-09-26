# frozen_string_literal: true

RSpec.describe "kochbar.de" do
  subject(:recipe) { scrape_cassette("de/kochbar", url: "https://www.kochbar.de/rezept/549118/Ligurisches-Huehnerragout-mit-Zucchini-Spezzatino-con-zucchine.html") }

  it "reads the title" do
    expect(recipe.title).to eq("Ligurisches Hühnerragout mit Zucchini – Spezzatino con zucchine - von Antareja")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "250 g Hühnerbrust, ohne Knochen",
      "3 mittelgross Knoblauchzehen, frisch",
      "2 TL Zitronensaft",
      "2 EL Olivenöl, extra vergine",
      "1 TL Oregano, frisch oder TK",
      "4 kleine Zwiebelchen, rot",
      "2 mittelgross Knoblauchzehen, frisch",
      "200 g Zucchini, grün",
      "1 mittelgross Kartoffel, festkochend",
      "40 g Karotte",
      "4 mit Tomaten, rot, vollreif",
      "2 EL Schnittsellerie-Stängel, frisch oder TK",
      "1 kleine Peperoni, rot, mittelscharf",
      "3 EL Olivenöl",
      "2 TL Rosmarin, frisch oder TK",
      "6 Oliven, grün, kernlos",
      "2 Prise Pfeffer, schwarz, frisch aus der Mühle",
      "2 EL Schnittsellerie-Blätter, frisch oder TK",
      "50 g Tomatensaft",
      "50 g Weißwein, trocken",
      "1 TL Zucker",
      "2 TL (gestrichen) Hühnerbrühe, Kraftbouillon",
      "Blüten und Blätter"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 250.0, unit: "g", name: "Hühnerbrust, ohne Knochen" },
      { amount: 3.0, unit: nil, name: "mittelgross Knoblauchzehen, frisch" },
      { amount: 2.0, unit: "TL", name: "Zitronensaft" },
      { amount: 2.0, unit: "EL", name: "Olivenöl, extra vergine" },
      { amount: 1.0, unit: "TL", name: "Oregano, frisch oder TK" },
      { amount: 4.0, unit: nil, name: "kleine Zwiebelchen, rot" },
      { amount: 2.0, unit: nil, name: "mittelgross Knoblauchzehen, frisch" },
      { amount: 200.0, unit: "g", name: "Zucchini, grün" },
      { amount: 1.0, unit: nil, name: "mittelgross Kartoffel, festkochend" },
      { amount: 40.0, unit: "g", name: "Karotte" },
      { amount: 4.0, unit: nil, name: "mit Tomaten, rot, vollreif" },
      { amount: 2.0, unit: "EL", name: "Schnittsellerie-Stängel, frisch oder TK" },
      { amount: 1.0, unit: nil, name: "kleine Peperoni, rot, mittelscharf" },
      { amount: 3.0, unit: "EL", name: "Olivenöl" },
      { amount: 2.0, unit: "TL", name: "Rosmarin, frisch oder TK" },
      { amount: 6.0, unit: nil, name: "Oliven, grün, kernlos" },
      { amount: 2.0, unit: "Prise", name: "Pfeffer, schwarz, frisch aus der Mühle" },
      { amount: 2.0, unit: "EL", name: "Schnittsellerie-Blätter, frisch oder TK" },
      { amount: 50.0, unit: "g", name: "Tomatensaft" },
      { amount: 50.0, unit: "g", name: "Weißwein, trocken" },
      { amount: 1.0, unit: "TL", name: "Zucker" },
      { amount: 2.0, unit: "TL", name: "Hühnerbrühe, Kraftbouillon" },
      { amount: nil, unit: nil, name: "Blüten und Blätter" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Die Hühnerbrust in ca. 2 x 3 cm große Stücke schneiden. Die Knoblauchzehen in eine Schale auspressen und die restlichen Zutaten zur Marinade zufügen. Die Hühnerstücke in der Marinade für ca. 1 Stunde marinieren.",
      "In der Zwischenzeit für das Gemüse die Zwiebelchen und die Knoblauchzehen an beide Enden kappen, schälen und in kleine Stücke schneiden. Den Zucchino waschen, an beiden Enden kappen und längs halbieren. Die Hälften quer in ca. 8 mm dicke Scheiben schneiden. Die Kartoffel waschen, schälen, längs halbieren, die Hälften längs halbieren und quer vierteln. In Salzwasser in 15 Minuten gar kochen, das Wasser abgießen und die Kartoffeln bereit halten.",
      "Die Karotte waschen, an beiden Enden kappen und schälen. Mit einer groben Raspel die entsprechende Menge von unten her abraspeln. Bei den Tomaten die Stiele entfernen, häuten, vierteln und entkernen. Die Viertel längs und quer halbieren.",
      "Die frische Schnittsellerie waschen, trocken schütteln und die makellosen Blätter abzupfen, zerkleinern, 2 EL bereit halten und den Rest tieffrieren. Die makellosen Stiele quer in ca. 3 mm breite Röllchen schneiden und 2 EL davon bereithalten. Die restlichen Röllchen tieffrieren. TK-Ware abwiegen und auftauen lassen. Die frischen, roten Peperoni waschen, die Stiele entfernen, diagonal in ca. 6 mm breite Stücke schneiden und die Körner belassen.",
      "Für die Würze die Oliven längs vierteln und mit den restlichen Zutaten bereit halten. Die Zutaten für die Sauce mischen und rühren, bis der Zucker gelöst ist. Die Hühnerstücke abseihen und die Marinadenreste in die Sauce mischen.",
      "In einer tiefen Pfanne oder Wok das Olivenöl erhitzen bis es duftet. Die Zwiebelchen und die Knoblauchzehen zugeben und 30 Sekunden braten, dann die Hühnerstücke zufügen und 3 Minuten scharf braten. Zucchini, Karotte, Schnittsellerie-Stängel und Peperoni dazugeben und 1 Minute pfannenrühren. Die Kartoffel- und Tomatenstücke zusammen mit der Würze untermischen. Noch 1 Minute pfannenrühren und dann mit der Sauce ablöschen. Mit Deckel 3 Minuten köcheln lassen.",
      "Mit Salz und Pfeffer abschmecken, auf die angewärmten Servierteller verteilen, garnieren, sofort gut warm servieren und genießen."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Die Hühnerbrust in ca. 2 x 3 cm große Stücke schneiden. Die Knoblauchzehen in eine Schale auspressen und die restlichen Zutaten zur Marinade zufügen. Die Hühnerstücke in der Marinade für ca. 1 Stunde marinieren.\nIn der Zwischenzeit für das Gemüse die Zwiebelchen und die Knoblauchzehen an beide Enden kappen, schälen und in kleine Stücke schneiden. Den Zucchino waschen, an beiden Enden kappen und längs halbieren. Die Hälften quer in ca. 8 mm dicke Scheiben schneiden. Die Kartoffel waschen, schälen, längs halbieren, die Hälften längs halbieren und quer vierteln. In Salzwasser in 15 Minuten gar kochen, das Wasser abgießen und die Kartoffeln bereit halten.\nDie Karotte waschen, an beiden Enden kappen und schälen. Mit einer groben Raspel die entsprechende Menge von unten her abraspeln. Bei den Tomaten die Stiele entfernen, häuten, vierteln und entkernen. Die Viertel längs und quer halbieren.\nDie frische Schnittsellerie waschen, trocken schütteln und die makellosen Blätter abzupfen, zerkleinern, 2 EL bereit halten und den Rest tieffrieren. Die makellosen Stiele quer in ca. 3 mm breite Röllchen schneiden und 2 EL davon bereithalten. Die restlichen Röllchen tieffrieren. TK-Ware abwiegen und auftauen lassen. Die frischen, roten Peperoni waschen, die Stiele entfernen, diagonal in ca. 6 mm breite Stücke schneiden und die Körner belassen.\nFür die Würze die Oliven längs vierteln und mit den restlichen Zutaten bereit halten. Die Zutaten für die Sauce mischen und rühren, bis der Zucker gelöst ist. Die Hühnerstücke abseihen und die Marinadenreste in die Sauce mischen.\nIn einer tiefen Pfanne oder Wok das Olivenöl erhitzen bis es duftet. Die Zwiebelchen und die Knoblauchzehen zugeben und 30 Sekunden braten, dann die Hühnerstücke zufügen und 3 Minuten scharf braten. Zucchini, Karotte, Schnittsellerie-Stängel und Peperoni dazugeben und 1 Minute pfannenrühren. Die Kartoffel- und Tomatenstücke zusammen mit der Würze untermischen. Noch 1 Minute pfannenrühren und dann mit der Sauce ablöschen. Mit Deckel 3 Minuten köcheln lassen.\nMit Salz und Pfeffer abschmecken, auf die angewärmten Servierteller verteilen, garnieren, sofort gut warm servieren und genießen.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("kochbar.de")
    expect(recipe.canonical_url).to eq("https://www.kochbar.de/rezept/549118/Ligurisches-Huehnerragout-mit-Zucchini-Spezzatino-con-zucchine.html")
    expect(recipe.site_name).to eq("kochbar.de")
    expect(recipe.language).to eq("de")
    expect(recipe.author).to eq("Antareja")
    expect(recipe.description).to eq("Hervorragendes Rezept für Ligurisches Hühnerragout mit Zucchini – Spezzatino con zucchine - toll & oft gelobt. Mit ausführlichen Nährwertangaben. Jetzt als Favorit merken!")
    expect(recipe.image).to eq("https://ais.kochbar.de/kbrezept/549118_1087108/1200x1200/ligurisches-huehnerragout-mit-zucchini-spezzatino-con-zucchine-rezept-bild-nr-2.jpg")
    expect(recipe.category).to eq("Mittagstisch")
    expect(recipe.cuisine).to eq("Internationale Küche")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(40)
    expect(recipe.keywords).to eq(["Hühnerbrust", "ohne Knochen", "Knoblauchzehen", "frisch", "Zitronensaft"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(4)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "127 kcal",
      "fatContent" => "11.2 g",
      "proteinContent" => "2.5 g",
      "carbohydrateContent" => "2.9 g",
      "servingSize" => "100 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 127.0 },
      { name: "fatContent", unit: "g", amount: 11.2 },
      { name: "proteinContent", unit: "g", amount: 2.5 },
      { name: "carbohydrateContent", unit: "g", amount: 2.9 },
      { name: "servingSize", unit: "g", amount: 100.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
