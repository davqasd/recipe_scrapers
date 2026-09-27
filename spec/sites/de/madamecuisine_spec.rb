# frozen_string_literal: true

RSpec.describe "madamecuisine.de" do
  subject(:recipe) { scrape_cassette("de/madamecuisine", url: "https://www.madamecuisine.de/klassisches-rotkohl-rezept/") }

  it "reads the title" do
    expect(recipe.title).to eq("Klassisches Rotkohl Rezept")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 Kopf Rotkohl",
      "1 Zwiebel",
      "1 kleiner Apfel",
      "2 EL Butterschmalz (oder Butter)",
      "300 ml kräftiger Rotwein",
      "300 ml Gemüsebrühe",
      "2 EL Rotweinessig",
      "2 Lorbeerblätter",
      "Nelken (ca. 8 Stück reichen)",
      "Kardamomkapseln (ca. 8 Stück reichen)",
      "1 Zimtstange",
      "1 TL Zimt",
      "1 EL Puderzucker",
      "1 EL Mehl (optional)",
      "Salz & Pfeffer"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "Kopf Rotkohl" },
      { amount: 1.0, unit: nil, name: "Zwiebel" },
      { amount: 1.0, unit: nil, name: "kleiner Apfel" },
      { amount: 2.0, unit: "EL", name: "Butterschmalz" },
      { amount: 300.0, unit: "ml", name: "kräftiger Rotwein" },
      { amount: 300.0, unit: "ml", name: "Gemüsebrühe" },
      { amount: 2.0, unit: "EL", name: "Rotweinessig" },
      { amount: 2.0, unit: nil, name: "Lorbeerblätter" },
      { amount: nil, unit: nil, name: "Nelken" },
      { amount: nil, unit: nil, name: "Kardamomkapseln" },
      { amount: 1.0, unit: nil, name: "Zimtstange" },
      { amount: 1.0, unit: "TL", name: "Zimt" },
      { amount: 1.0, unit: "EL", name: "Puderzucker" },
      { amount: 1.0, unit: "EL", name: "Mehl" },
      { amount: nil, unit: nil, name: "Salz & Pfeffer" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Den Rotkohl halbieren, den Strunk entfernen und dann fein raspeln. Den Apfel entkernen und ebenfalls fein raspeln oder würfeln. Die Zwiebel klein schneiden.",
      "Butterschmalz in einem großen Topf zerlassen. Zwiebel darin kurz andünsten, dann Rotkohl und Apfel zugeben und ein paar Minuten andünsten; dabei ab und zu umrühren.",
      "Rotwein, Gemüsebrühe, Rotweinessig und Lorbeerblätter in den Topf zugeben. Nelken, Kardamomkapseln und Zimtstange in ein Säckchen verpacken und auch in den Topf geben. So entfaltet sich der Geschmack, und man kann es nach dem Kochen einfach entfernen. Wer kein Säckchen hat, kann sich übrigens auch mit einem Teebeutel helfen.",
      "Alles für mindestens 1 Stunde köcheln, bis der Rotkohl die gewünschte Konsistenz und Bissfeste hat. Ich persönlich koche den Rotkohl lieber etwas länger und weicher.",
      "Zimt und Puderzucker unterrühren und kräftig mit Salz und etwas Pfeffer abschmecken. In manchen Rezepten wird auch etwas Mehl zugegeben, um dem Rotkohl eine sämige Konsistenz zu geben.",
      "Am besten am nächsten Tag aufwärmen. Vorgekocht und aufgewärmt schmeckt der Rotkohl gleich nochmal besser!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Den Rotkohl halbieren, den Strunk entfernen und dann fein raspeln. Den Apfel entkernen und ebenfalls fein raspeln oder würfeln. Die Zwiebel klein schneiden.\nButterschmalz in einem großen Topf zerlassen. Zwiebel darin kurz andünsten, dann Rotkohl und Apfel zugeben und ein paar Minuten andünsten; dabei ab und zu umrühren.\nRotwein, Gemüsebrühe, Rotweinessig und Lorbeerblätter in den Topf zugeben. Nelken, Kardamomkapseln und Zimtstange in ein Säckchen verpacken und auch in den Topf geben. So entfaltet sich der Geschmack, und man kann es nach dem Kochen einfach entfernen. Wer kein Säckchen hat, kann sich übrigens auch mit einem Teebeutel helfen.\nAlles für mindestens 1 Stunde köcheln, bis der Rotkohl die gewünschte Konsistenz und Bissfeste hat. Ich persönlich koche den Rotkohl lieber etwas länger und weicher.\nZimt und Puderzucker unterrühren und kräftig mit Salz und etwas Pfeffer abschmecken. In manchen Rezepten wird auch etwas Mehl zugegeben, um dem Rotkohl eine sämige Konsistenz zu geben.\nAm besten am nächsten Tag aufwärmen. Vorgekocht und aufgewärmt schmeckt der Rotkohl gleich nochmal besser!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("madamecuisine.de")
    expect(recipe.canonical_url).to eq("https://www.madamecuisine.de/klassisches-rotkohl-rezept/")
    expect(recipe.site_name).to eq("Madame Cuisine")
    expect(recipe.language).to eq("de")
    expect(recipe.author).to eq("Martin")
    expect(recipe.description).to eq("Das klassische Rotkohl-Rezept mit Apfel und Zwiebel, mit winterlichen Gewürzen (Nelken, Zimt und Kardamom) langsam eingekocht. Am besten vorgekocht, schmeckt aufgewärmt nochmal besser.")
    expect(recipe.image).to eq("https://www.madamecuisine.de/wp-content/uploads/2021/12/rotkohl-blaukraut-featured.jpg")
    expect(recipe.category).to eq("Beilage")
    expect(recipe.cuisine).to eq("Deutsch")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(80)
    expect(recipe.keywords).to eq(%w[Apfel-Rotkohl Beilage Blaukraut Rotkohl])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.84)
    expect(recipe.ratings_count).to eq(18)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "330 kcal",
      "servingSize" => "1 Portion"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 330.0 },
      { name: "servingSize", unit: "Portion", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#title#")
  end
end
