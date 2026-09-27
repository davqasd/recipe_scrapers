# frozen_string_literal: true

RSpec.describe "hofer.at" do
  subject(:recipe) { scrape_cassette("at/hofer", url: "https://www.hofer.at/rezeptwelt/alle-rezepte/terrine-vom-rucherlachs-mit-rucolapesto-und-kartoffelwafferl") }

  it "reads the title" do
    expect(recipe.title).to eq("Terrine vom Räucherlachs mit Rucola-Pesto und Kartoffelwafferl")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "ZURÜCK ZUM URSPRUNG Bio-Freiland-Ei Eigelb",
      "Kartoffeln, mehlig",
      "Zitrone",
      "Dill, frisch",
      "ALMARE SEAFOOD ASC Räucherlachs",
      "Knoblauchzehe",
      "Gelatine",
      "Rucola",
      "CASTELLO Olivenöl extra nativ",
      "MILFINA Schlagobers",
      "Salz und Pfeffer",
      "Parmesan, fein gerieben",
      "ZURÜCK ZUM URSPRUNG Bio-Freiland-Ei",
      "Pinienkerne",
      "Salz und Pfeffer",
      "Fischfond",
      "Salz und Pfeffer",
      "MILFINA Crème fraîche, Sorte: Natur"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "ZURÜCK ZUM URSPRUNG Bio-Freiland-Ei Eigelb" },
      { amount: nil, unit: nil, name: "Kartoffeln, mehlig" },
      { amount: nil, unit: nil, name: "Zitrone" },
      { amount: nil, unit: nil, name: "Dill, frisch" },
      { amount: nil, unit: nil, name: "ALMARE SEAFOOD ASC Räucherlachs" },
      { amount: nil, unit: nil, name: "Knoblauchzehe" },
      { amount: nil, unit: nil, name: "Gelatine" },
      { amount: nil, unit: nil, name: "Rucola" },
      { amount: nil, unit: nil, name: "CASTELLO Olivenöl extra nativ" },
      { amount: nil, unit: nil, name: "MILFINA Schlagobers" },
      { amount: nil, unit: nil, name: "Salz und Pfeffer" },
      { amount: nil, unit: nil, name: "Parmesan, fein gerieben" },
      { amount: nil, unit: nil, name: "ZURÜCK ZUM URSPRUNG Bio-Freiland-Ei" },
      { amount: nil, unit: nil, name: "Pinienkerne" },
      { amount: nil, unit: nil, name: "Salz und Pfeffer" },
      { amount: nil, unit: nil, name: "Fischfond" },
      { amount: nil, unit: nil, name: "Salz und Pfeffer" },
      { amount: nil, unit: nil, name: "MILFINA Crème fraîche, Sorte: Natur" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Terrine:",
      "Terrinenform mit Frischhaltefolie auslegen und die Räucherlachsscheiben darauflegen, so dass die Scheiben leicht über den Rand hinausreichen. Danach in den Kühlschrank stellen. Gelatine in kaltem Wasser für etwa 5 Minuten einweichen.",
      "In der Zwischenzeit Crème fraîche mit dem Fischfond verrühren, Dill fein hacken und untermengen. Etwas Zitronenschale abreiben und beimengen. Die Masse mit Salz, Pfeffer und Zitronensaft abschmecken. Gelatine aus dem Wasser nehmen und bei niedriger Hitze in einem Topf auflösen. Etwas von der Masse zur Gelatine geben und gut verrühren.",
      "Danach die Gelatine vorsichtig unter die restliche Masse rühren und auf Eiswürfel kühl stellen. Schlagobers steif schlagen und vorsichtig unter die Masse heben. Anschließend die Form zu 3/4 mit der Masse füllen und die überstehenden Lachsscheiben einklappen, um die Form zu schließen. Die Terrine danach für mind. 5 Stunden in den Kühlschrank stellen. Gut gekühlt in Scheiben schneiden und servieren.",
      "Pesto:",
      "Rucola und Pinienkerne in der Küchenmaschine oder mit dem Mixstab pürieren. Geriebenen Parmesan, Öl und Knoblauch dazugeben und zu einer weichen Masse verarbeiten. Mit Salz und Pfeffer abschmecken.",
      "Kartoffelwaffel:",
      "Kartoffeln reiben und in ein Geschirrtuch geben, um die Flüssigkeit auszupressen. Danach die geriebenen Kartoffeln in einem Topf mit Eiern und Eigelb verrühren und würzen. Teig in einem Waffeleisen knusprig braten."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        [nil, 1],
        ["Pesto", 12],
        ["Terrine", 1],
        ["Kartoffelwafferl", 4]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Terrine:\nTerrinenform mit Frischhaltefolie auslegen und die Räucherlachsscheiben darauflegen, so dass die Scheiben leicht über den Rand hinausreichen. Danach in den Kühlschrank stellen. Gelatine in kaltem Wasser für etwa 5 Minuten einweichen.\nIn der Zwischenzeit Crème fraîche mit dem Fischfond verrühren, Dill fein hacken und untermengen. Etwas Zitronenschale abreiben und beimengen. Die Masse mit Salz, Pfeffer und Zitronensaft abschmecken. Gelatine aus dem Wasser nehmen und bei niedriger Hitze in einem Topf auflösen. Etwas von der Masse zur Gelatine geben und gut verrühren.\nDanach die Gelatine vorsichtig unter die restliche Masse rühren und auf Eiswürfel kühl stellen. Schlagobers steif schlagen und vorsichtig unter die Masse heben. Anschließend die Form zu 3/4 mit der Masse füllen und die überstehenden Lachsscheiben einklappen, um die Form zu schließen. Die Terrine danach für mind. 5 Stunden in den Kühlschrank stellen. Gut gekühlt in Scheiben schneiden und servieren.\nPesto:\nRucola und Pinienkerne in der Küchenmaschine oder mit dem Mixstab pürieren. Geriebenen Parmesan, Öl und Knoblauch dazugeben und zu einer weichen Masse verarbeiten. Mit Salz und Pfeffer abschmecken.\nKartoffelwaffel:\nKartoffeln reiben und in ein Geschirrtuch geben, um die Flüssigkeit auszupressen. Danach die geriebenen Kartoffeln in einem Topf mit Eiern und Eigelb verrühren und würzen. Teig in einem Waffeleisen knusprig braten.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hofer.at")
    expect(recipe.canonical_url).to eq("https://www.hofer.at/rezeptwelt/alle-rezepte/terrine-vom-rucherlachs-mit-rucolapesto-und-kartoffelwafferl")
    expect(recipe.site_name).to eq("HOFER")
    expect(recipe.language).to eq("de-AT")
    expect(recipe.author).to eq("HOFER")
    expect(recipe.description).to eq("Eine köstliche Vorspeise für einen besonderen Abend. Serviere die erfrischende Räucherlachs-Terrine mit Rucola-Pesto und Kartoffelwafferl.")
    expect(recipe.image).to eq("https://www.hofer.at/content/dam/aldi/emea/at/editorial/recipes/migrated-assets/Article_RZ01641300000000.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to eq(360)
    expect(recipe.prep_time).to eq(60)
    expect(recipe.cook_time).to eq(300)
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
