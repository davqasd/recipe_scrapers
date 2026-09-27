# frozen_string_literal: true

RSpec.describe "culy.nl" do
  subject(:recipe) { scrape_cassette("nl/culy", url: "https://www.culy.nl/recepten/yakisoba-udon-noodles-vegetarisch/") }

  it "reads the title" do
    expect(recipe.title).to eq("Yakisoba: Japanse udon-noodles met véél groenten - Culy")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 eetlepel olie (bijv. sjalottenolie, of neutrale olie)",
      "2 uien, in halve ringen",
      "1 winterpeen, in halve plakjes",
      "2 bosuien, in langwerpige stukjes",
      "1/2e witte kool, in grove stukken",
      "125 gram taugé",
      "100 gram shiitake of champignons, in plakjes",
      "300 gram udon noodles (liefst kant-en-klare)",
      "1 eetlepel sesamolie",
      "1,5 eetlepel sojasaus",
      "1 eetlepel mirin",
      "1/2 eetlepel rijstazijn",
      "Geroosterde sesamzaadjes",
      "Gebakken uitjes",
      "Sushi-gember (liefst de roze, anders de gewone), in dunne reepjes gesneden"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "eetlepel", name: "olie" },
      { amount: 2.0, unit: nil, name: "uien, in halve ringen" },
      { amount: 1.0, unit: nil, name: "winterpeen, in halve plakjes" },
      { amount: 2.0, unit: nil, name: "bosuien, in langwerpige stukjes" },
      { amount: 0.5, unit: nil, name: "e witte kool, in grove stukken" },
      { amount: 125.0, unit: "gram", name: "taugé" },
      { amount: 100.0, unit: "gram", name: "shiitake of champignons, in plakjes" },
      { amount: 300.0, unit: "gram", name: "udon noodles" },
      { amount: 1.0, unit: "eetlepel", name: "sesamolie" },
      { amount: 1.5, unit: "eetlepel", name: "sojasaus" },
      { amount: 1.0, unit: "eetlepel", name: "mirin" },
      { amount: 0.5, unit: "eetlepel", name: "rijstazijn" },
      { amount: nil, unit: nil, name: "Geroosterde sesamzaadjes" },
      { amount: nil, unit: nil, name: "Gebakken uitjes" },
      { amount: nil, unit: nil, name: "Sushi-gember, in dunne reepjes gesneden" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Het is weer tijd voor een makkelijk en gezond recept met héél veel groenten. Dan zit je doorgaans wel goed in de Japanse keuken, zoals met deze yakisoba. Traditioneel is yakisoba een Japans wokgerecht met boekweitnoedels, maar wij gebruiken van die lekkere dikke udon noodles.",
      "Wil je helemaal snel klaar zijn met dit makkelijke recept, koop dan kant-en-klare udon noodles. Die vind je in de meeste supermarkten en zeker bij de toko.",
      "Het mooiste is het als je ingelegde gember kunt vinden die zo mooi felroze is (gari). Kun je die niet vinden? Gebruik dan gewone ingelegde gember. Die zou je eventueel zelfs een beetje kunnen kleuren met een druppeltje bietensap. Snijd de gember in dunne reepjes en leg die in een klein hoopje bovenop de yakisoba. Lekker!",
      "https://www.culy.nl/inspiratie/myoga-gember/",
      "Yakisoba recept",
      "Begin met het roosteren van de sesamzaadjes, als je dat nog niet had gedaan.",
      "Verhit een wok op hoog vuur tot 'ie rookt. Voeg de olie toe en wok de ui, winterpeen en bosui tot ze beginnen te kleuren. Doe de witte kool en de taugé erbij in de wok en bak ze tot ze ongeveer een derde zijn geslonken.",
      "Wok nu ook de shiitake of champignons kort mee. Daarna mogen de sauzen erbij: de sesamolie, sojasaus, mirin en rijstazijn.",
      "Voeg tot slot de udon noodles toe en laat ze kort mee verwarmen.",
      "Schep alles goed door en dien het daarna meteen op met de sesamzaadjes, de gebakken uitjes en de ingelegde gember.",
      "Meer recepten met udon noodles:",
      "Ga je geheid lekker vinden: boterzachte udon noodles met miso-zalm",
      "Snelle udon noodles met oesterzwammen (een vega umamibom)",
      "Golden Curry udonnoedels met dashi en gehakt"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Het is weer tijd voor een makkelijk en gezond recept met héél veel groenten. Dan zit je doorgaans wel goed in de Japanse keuken, zoals met deze yakisoba. Traditioneel is yakisoba een Japans wokgerecht met boekweitnoedels, maar wij gebruiken van die lekkere dikke udon noodles.\nWil je helemaal snel klaar zijn met dit makkelijke recept, koop dan kant-en-klare udon noodles. Die vind je in de meeste supermarkten en zeker bij de toko.\nHet mooiste is het als je ingelegde gember kunt vinden die zo mooi felroze is (gari). Kun je die niet vinden? Gebruik dan gewone ingelegde gember. Die zou je eventueel zelfs een beetje kunnen kleuren met een druppeltje bietensap. Snijd de gember in dunne reepjes en leg die in een klein hoopje bovenop de yakisoba. Lekker!\nhttps://www.culy.nl/inspiratie/myoga-gember/\nYakisoba recept\nBegin met het roosteren van de sesamzaadjes, als je dat nog niet had gedaan.\nVerhit een wok op hoog vuur tot 'ie rookt. Voeg de olie toe en wok de ui, winterpeen en bosui tot ze beginnen te kleuren. Doe de witte kool en de taugé erbij in de wok en bak ze tot ze ongeveer een derde zijn geslonken.\nWok nu ook de shiitake of champignons kort mee. Daarna mogen de sauzen erbij: de sesamolie, sojasaus, mirin en rijstazijn.\nVoeg tot slot de udon noodles toe en laat ze kort mee verwarmen.\nSchep alles goed door en dien het daarna meteen op met de sesamzaadjes, de gebakken uitjes en de ingelegde gember.\nMeer recepten met udon noodles:\nGa je geheid lekker vinden: boterzachte udon noodles met miso-zalm\nSnelle udon noodles met oesterzwammen (een vega umamibom)\nGolden Curry udonnoedels met dashi en gehakt")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("culy.nl")
    expect(recipe.canonical_url).to eq("https://www.culy.nl/recepten/yakisoba-udon-noodles-vegetarisch/")
    expect(recipe.site_name).to eq("Culy")
    expect(recipe.language).to eq("nl-NL")
    expect(recipe.author).to eq("Nancy van Batenburg")
    expect(recipe.description).to eq("Het is weer tijd voor een makkelijk en gezond recept met héél veel groenten. Dan zit je doorgaans wel goed in de Japanse keuken, zoals met ...")
    expect(recipe.image).to eq("https://www.culy.nl/wp-content/uploads/2019/02/9_yakisoba-noodles.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("3 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.516129032258065)
    expect(recipe.ratings_count).to eq(31)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "665"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: nil, amount: 665.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.culy.nl")
  end
end
