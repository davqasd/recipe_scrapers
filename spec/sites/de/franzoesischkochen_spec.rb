# frozen_string_literal: true

RSpec.describe "franzoesischkochen.de" do
  subject(:recipe) { scrape_cassette("de/franzoesischkochen", url: "https://www.franzoesischkochen.de/donut-mit-meinem-brioche-rezept/") }

  it "reads the title" do
    expect(recipe.title).to eq("Donuts mit meinem Brioche Rezept")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "500 g Mehl ( T45 oder Typ 405)",
      "60 g Zucker",
      "1 Ei",
      "1/4 TL gemahlene Tonkabohnen",
      "60 g kalte Butter",
      "1 Würfel Hefe-40g (oder 1/2 - 20 g-wenn Sie sie länger gehen lassen)",
      "250 ml Milch",
      "1 Packung Puderzucker (200-250 g)",
      "etwas Milch und Lebensmittelfarben Ihrer Wahl",
      "Cassis",
      "Turkis",
      "Rosa",
      "Silber und Goldglitzer"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 500.0, unit: "g", name: "Mehl" },
      { amount: 60.0, unit: "g", name: "Zucker" },
      { amount: 1.0, unit: nil, name: "Ei" },
      { amount: 0.25, unit: "TL", name: "gemahlene Tonkabohnen" },
      { amount: 60.0, unit: "g", name: "kalte Butter" },
      { amount: 1.0, unit: nil, name: "Würfel Hefe-40g" },
      { amount: 250.0, unit: "ml", name: "Milch" },
      { amount: 1.0, unit: nil, name: "Packung Puderzucker" },
      { amount: nil, unit: nil, name: "etwas Milch und Lebensmittelfarben Ihrer Wahl" },
      { amount: nil, unit: nil, name: "Cassis" },
      { amount: nil, unit: nil, name: "Turkis" },
      { amount: nil, unit: nil, name: "Rosa" },
      { amount: nil, unit: nil, name: "Silber und Goldglitzer" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Den Briocheteig wie im Originalrezept beschrieben zubereiten und 30 Minuten gehen lassen.",
      "Die Brioche zusammen falten. Die kleinen Babas, oder Savarin oder Donuts Formen einfetten, und mit Mehl bestauben.... Aus den Teig, kleine 40-50 g Kugeln formen.... und dann ein Loch in der Mitte eindrücken. Um schöne Donuts zu machen, sollte man nie einen Band machen und es dann zusammen binden. Es würde beim Backen auseinandergehen. So sieht es dann aus: Den Teig in die kleinen Formen verteilen und 20 Minuten gehen lassen und dann mit Milch bepinseln. Dann werden die Donuts bei 180-190 °C Umluft (mit einem Backblech mit 500 ml Wasser ) ganz unten im Backofen) 25 Minuten gebacken.",
      "Deko",
      "Die Donuts kurz abkühlen lassen und dann aus den Formen nehmen. (sie kommen einfacher aus den Formen, wenn sie abgekühlt sind). In 3 verschiedene Schälchen den Puderzucker verteilen und Tröpfchen nach Tröpfchen die Milch eingeben bis eine dickflüssige Zuckerglasur entsteht. Nur dann kommt die Farbe hinein. Tipp: Achtung, falls Ihr meine Farben verwendet, nur 1 Messerspitze verwenden!!!!! Es färbt wirklich sehr stark! Die abgekühlten Donuts in die Zuckerglasur tauchen.... und dann auf ein Gitter abtrocknen lassen. Ich habe auch mal die Donuts auf das Gitter platziert und die Zuckerglasur darüber gegossen. Geht auch. Eigentlich ab diesem Punkt wünsche ich euch einfach Spaß beim Dekorieren mit euren Kindern. Es ist einfach total lustig.... besondern wenn sie noch den Löffel lecken und dann eine blaue Zunge bekommen! Da kann man direkt sehen, wer heimlich genascht hat!;-) Mit den Farben hat es richtig Spaß gemacht... etwas Glitzer durfte auch noch drauf... Et voilà! Donuts ohne Zuckerglasur geht es doch gar nicht oder?"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Den Briocheteig wie im Originalrezept beschrieben zubereiten und 30 Minuten gehen lassen.\nDie Brioche zusammen falten. Die kleinen Babas, oder Savarin oder Donuts Formen einfetten, und mit Mehl bestauben.... Aus den Teig, kleine 40-50 g Kugeln formen.... und dann ein Loch in der Mitte eindrücken. Um schöne Donuts zu machen, sollte man nie einen Band machen und es dann zusammen binden. Es würde beim Backen auseinandergehen. So sieht es dann aus: Den Teig in die kleinen Formen verteilen und 20 Minuten gehen lassen und dann mit Milch bepinseln. Dann werden die Donuts bei 180-190 °C Umluft (mit einem Backblech mit 500 ml Wasser ) ganz unten im Backofen) 25 Minuten gebacken.\nDeko\nDie Donuts kurz abkühlen lassen und dann aus den Formen nehmen. (sie kommen einfacher aus den Formen, wenn sie abgekühlt sind). In 3 verschiedene Schälchen den Puderzucker verteilen und Tröpfchen nach Tröpfchen die Milch eingeben bis eine dickflüssige Zuckerglasur entsteht. Nur dann kommt die Farbe hinein. Tipp: Achtung, falls Ihr meine Farben verwendet, nur 1 Messerspitze verwenden!!!!! Es färbt wirklich sehr stark! Die abgekühlten Donuts in die Zuckerglasur tauchen.... und dann auf ein Gitter abtrocknen lassen. Ich habe auch mal die Donuts auf das Gitter platziert und die Zuckerglasur darüber gegossen. Geht auch. Eigentlich ab diesem Punkt wünsche ich euch einfach Spaß beim Dekorieren mit euren Kindern. Es ist einfach total lustig.... besondern wenn sie noch den Löffel lecken und dann eine blaue Zunge bekommen! Da kann man direkt sehen, wer heimlich genascht hat!;-) Mit den Farben hat es richtig Spaß gemacht... etwas Glitzer durfte auch noch drauf... Et voilà! Donuts ohne Zuckerglasur geht es doch gar nicht oder?")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("franzoesischkochen.de")
    expect(recipe.canonical_url).to eq("https://www.franzoesischkochen.de/donut-mit-meinem-brioche-rezept/")
    expect(recipe.site_name).to eq("Französisch kochen – Aurélie Bastian")
    expect(recipe.language).to eq("de-DE")
    expect(recipe.author).to eq("Aurélie Bastian")
    expect(recipe.description).to eq("Ein einfaches Rezept mit Schritt-für-Schritt-Fotos und vielen Tipps über das Thema: Donuts mit meinem Brioche Rezept")
    expect(recipe.image).to eq("https://www.franzoesischkochen.de/wp-content/uploads/2018/04/donuts-mit-meinem-brioche-rezept.jpg")
    expect(recipe.category).to eq("Brioche")
    expect(recipe.cuisine).to eq("Französisch")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("22 servings")
    expect(recipe.total_time).to eq(160)
    expect(recipe.prep_time).to eq(135)
    expect(recipe.cook_time).to eq(25)
    expect(recipe.keywords).to eq(["Donuts mit meinem Brioche Rezept", "Beste Mama der Welt", "Brioche", "Frühstück", "Kinder", "französische Rezepte"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(17)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
