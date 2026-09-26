# frozen_string_literal: true

RSpec.describe "emmikochteinfach.de" do
  subject(:recipe) { scrape_cassette("de/emmikochteinfach", url: "https://emmikochteinfach.de/klassisches-rindergulasch/") }

  it "reads the title" do
    expect(recipe.title).to eq("Klassisches Rindergulasch ganz einfach")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "600 g Rindergulasch (ca. 3x3 cm große Stücke, gegebenenfalls selbst kleiner schneiden)",
      "400 ml Rinderfond (selbstgemacht oder aus dem Glas)",
      "300 g Schalotten (geschält und halbiert)",
      "200 ml trockener Rotwein, einen den Du gerne trinkst (alternativ roter 100% Traubendirektsaft )",
      "40 g Tomatenmark",
      "2-3 EL Butterschmalz (z.B. Buttaris; Alternativ Pflanzenöl )",
      "1 Knoblauchzehe (geschält, klein geschnitten)",
      "1-2 TL Zitronenabrieb (unbehandelt bzw. Bio) (kannst Du auch weggelassen )",
      "2 TL Paprikapulver, edelsüß",
      "1/2 TL Majoran, getrocknet",
      "1 Msp. Cayennepfeffer",
      "1 Prise Salz"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 600.0, unit: "g", name: "Rindergulasch" },
      { amount: 400.0, unit: "ml", name: "Rinderfond" },
      { amount: 300.0, unit: "g", name: "Schalotten" },
      { amount: 200.0, unit: "ml", name: "trockener Rotwein, einen den Du gerne trinkst" },
      { amount: 40.0, unit: "g", name: "Tomatenmark" },
      { amount: 2.0, unit: "EL", name: "Butterschmalz" },
      { amount: 1.0, unit: nil, name: "Knoblauchzehe" },
      { amount: 1.0, unit: "TL", name: "Zitronenabrieb" },
      { amount: 2.0, unit: "TL", name: "Paprikapulver, edelsüß" },
      { amount: 0.5, unit: "TL", name: "Majoran, getrocknet" },
      { amount: 1.0, unit: "Msp", name: "Cayennepfeffer" },
      { amount: 1.0, unit: "Prise", name: "Salz" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Das Gulasch-Fleisch bitte ca. eine halbe Stunde vor der Zubereitung aus dem Kühlschrank nehmen, damit es Zimmertemperatur annehmen kann und nicht eiskalt gebraten wird. Wenn Du das Fleisch selbst schneidest, erst Scheiben quer zur Fleischfaser und daraus wiederum Würfel schneiden. Eine ideale Größe ist ca. 3x3 cm (Walnussgröße). Die 600 g Fleisch nur mäßig salzen, wenn überhaupt nur mit 1 Prise Salz kurz vor dem Anbraten.",
      "Jetzt schälst Du die 300 g Schalotten und halbierst sie, besonders große Exemplare kannst Du auch vierteln. 1 EL Butterschmalz in einem Bräter / Schmortopf erhitzen und darin die Schalotten goldgelb anbraten. Herausnehmen und zur Seite stellen.",
      "Im Anschluss wieder 1 EL Butterschmalz im Bräter erhitzen und bei sehr hoher Temperatur das Fleisch portionsweise anbraten. Erst nach ca. 1 Minute das erste Mal wenden, damit nicht zu viel Hitze vom Boden entweicht, das Fleisch eine schöne Bräune annimmt und sich Röstaromen bilden. Die Fleischportionen entsprechend zur Seite stellen. HINWEIS: Meine Empfehlung ist das Fleisch auf jeden Fall portionsweise anzubraten, auch wenn es etwas Geduld erfordert. Wenn das gesamte Gulaschfleisch auf einmal in den Topf kommt, kann der Boden in der Regel die Hitze nicht halten und das Fleisch köchelt mehr als zu braten.",
      "Nun kommt das gesamte Fleisch zurück in den Bräter zur letzten Fleischportion zurück, ebenfalls die Schalotten sowie 40 g Tomatenmark. Das Tomatenmark gut unterrühren damit es kurz mit rösten kann.",
      "Mit 200 ml trockenem Rotwein ablöschen und den Rotwein zu 2/3 verkochen lassen, sprich auf ungefähr 1/3 reduzieren.",
      "In der Zwischenzeit 1 Knoblauchzehe schälen und in feine Würfel schneiden. Die Zitrone heiß abwaschen, abtrocknen und die Schale mit einer feinen Reibe abreiben für ca. 1 bis 2 TL Zitronenabrieb. Wenn der Rotwein reduziert ist, den Knoblauch, 1-2 TL Zitronenabrieb, 2 TL Paprikapulver, 1/2 TL Majoran und 1 Messerspitze Cayennepfeffer hinzufügen und kurz unterrühren.TIPP: Das Gulasch erhält durch den Zitronenabrieb ein feines Zitronenaroma. Wenn Du das nicht möchtest, kannst Du den Abrieb auch einfach weglassen.",
      "Das Fleisch und die Schalotten nun mit 400 ml Rinderfond ablöschen und mit Deckel für ca. 1,5 Stunden bei geringer Hitze auf der Herdplatte garen. Nach einer Stunde mal nachsehen, ob Dir die Soße zu flüssig erscheint. Falls ja, kannst Du das Gulasch die letzten 30 Minuten ohne Deckel weiter garen. Am Ende der Garzeit das Gulasch nach Belieben abschmecken und gegebenenfalls eindicken.",
      "Ich wünsche Dir einen guten Appetit! Lass Dir mein klassisches Rindergulasch Rezept gut schmecken."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["FÜR DIE DOPPELTE ZUTATENMENGE SOLLTE DER BRÄTER 6-7 LITER FASSUNGSVERMÖGEN HABEN.", 12]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Das Gulasch-Fleisch bitte ca. eine halbe Stunde vor der Zubereitung aus dem Kühlschrank nehmen, damit es Zimmertemperatur annehmen kann und nicht eiskalt gebraten wird. Wenn Du das Fleisch selbst schneidest, erst Scheiben quer zur Fleischfaser und daraus wiederum Würfel schneiden. Eine ideale Größe ist ca. 3x3 cm (Walnussgröße). Die 600 g Fleisch nur mäßig salzen, wenn überhaupt nur mit 1 Prise Salz kurz vor dem Anbraten.\nJetzt schälst Du die 300 g Schalotten und halbierst sie, besonders große Exemplare kannst Du auch vierteln. 1 EL Butterschmalz in einem Bräter / Schmortopf erhitzen und darin die Schalotten goldgelb anbraten. Herausnehmen und zur Seite stellen.\nIm Anschluss wieder 1 EL Butterschmalz im Bräter erhitzen und bei sehr hoher Temperatur das Fleisch portionsweise anbraten. Erst nach ca. 1 Minute das erste Mal wenden, damit nicht zu viel Hitze vom Boden entweicht, das Fleisch eine schöne Bräune annimmt und sich Röstaromen bilden. Die Fleischportionen entsprechend zur Seite stellen. HINWEIS: Meine Empfehlung ist das Fleisch auf jeden Fall portionsweise anzubraten, auch wenn es etwas Geduld erfordert. Wenn das gesamte Gulaschfleisch auf einmal in den Topf kommt, kann der Boden in der Regel die Hitze nicht halten und das Fleisch köchelt mehr als zu braten.\nNun kommt das gesamte Fleisch zurück in den Bräter zur letzten Fleischportion zurück, ebenfalls die Schalotten sowie 40 g Tomatenmark. Das Tomatenmark gut unterrühren damit es kurz mit rösten kann.\nMit 200 ml trockenem Rotwein ablöschen und den Rotwein zu 2/3 verkochen lassen, sprich auf ungefähr 1/3 reduzieren.\nIn der Zwischenzeit 1 Knoblauchzehe schälen und in feine Würfel schneiden. Die Zitrone heiß abwaschen, abtrocknen und die Schale mit einer feinen Reibe abreiben für ca. 1 bis 2 TL Zitronenabrieb. Wenn der Rotwein reduziert ist, den Knoblauch, 1-2 TL Zitronenabrieb, 2 TL Paprikapulver, 1/2 TL Majoran und 1 Messerspitze Cayennepfeffer hinzufügen und kurz unterrühren.TIPP: Das Gulasch erhält durch den Zitronenabrieb ein feines Zitronenaroma. Wenn Du das nicht möchtest, kannst Du den Abrieb auch einfach weglassen.\nDas Fleisch und die Schalotten nun mit 400 ml Rinderfond ablöschen und mit Deckel für ca. 1,5 Stunden bei geringer Hitze auf der Herdplatte garen. Nach einer Stunde mal nachsehen, ob Dir die Soße zu flüssig erscheint. Falls ja, kannst Du das Gulasch die letzten 30 Minuten ohne Deckel weiter garen. Am Ende der Garzeit das Gulasch nach Belieben abschmecken und gegebenenfalls eindicken.\nIch wünsche Dir einen guten Appetit! Lass Dir mein klassisches Rindergulasch Rezept gut schmecken.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("emmikochteinfach.de")
    expect(recipe.canonical_url).to eq("https://emmikochteinfach.de/klassisches-rindergulasch/")
    expect(recipe.site_name).to eq("emmikochteinfach")
    expect(recipe.language).to eq("de")
    expect(recipe.author).to eq("Emmi")
    expect(recipe.description).to eq("Mein Familienrezept ist ein echter Klassiker. Gulasch kochen geht einfacher als man denkt. Mit zartem Fleisch, leckeren Röstaromen und einer sämigen Soße wird es auch Dir gelingen.")
    expect(recipe.image).to eq("https://emmikochteinfach.de/wp-content/uploads/2022/02/seo_Gulasch-Nah-200.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(120)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(90)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1528)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "549 kcal",
      "carbohydrateContent" => "8 g",
      "proteinContent" => "32 g",
      "fatContent" => "38 g",
      "servingSize" => "1 Portion"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 549.0 },
      { name: "carbohydrateContent", unit: "g", amount: 8.0 },
      { name: "proteinContent", unit: "g", amount: 32.0 },
      { name: "fatContent", unit: "g", amount: 38.0 },
      { name: "servingSize", unit: "Portion", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://emmikochteinfach.de/")
  end
end
