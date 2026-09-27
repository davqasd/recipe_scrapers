# frozen_string_literal: true

RSpec.describe "amazingoriental.com" do
  subject(:recipe) { scrape_cassette("com/amazingoriental", url: "https://amazingoriental.com/recept/noedels-met-pittige-pindasaus-en-tofu/") }

  it "reads the title" do
    expect(recipe.title).to eq("Noedels met pittige pindasaus en tofu")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "250 g stevige tofu",
      "1–2 el maïzena",
      "2 el Golden Ox blended sesamolie",
      "200 g gedroogde noedels",
      "1 el olie",
      "2 teentjes knoflook",
      "4 el pindakaas",
      "2 el water",
      "1 tl chilisaus",
      "½ tl lichte sojasaus",
      "½ tl pure sesamolie",
      "½ tl rijstazijn",
      "1 tl suiker",
      "1 el blended sesamolie",
      "½ komkommer",
      "½ wortel",
      "½ tl Double pagoda zwarte sesamzaadjes"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 250.0, unit: "g", name: "stevige tofu" },
      { amount: 1.0, unit: "el", name: "maïzena" },
      { amount: 2.0, unit: "el", name: "Golden Ox blended sesamolie" },
      { amount: 200.0, unit: "g", name: "gedroogde noedels" },
      { amount: 1.0, unit: "el", name: "olie" },
      { amount: 2.0, unit: "teentjes", name: "knoflook" },
      { amount: 4.0, unit: "el", name: "pindakaas" },
      { amount: 2.0, unit: "el", name: "water" },
      { amount: 1.0, unit: "tl", name: "chilisaus" },
      { amount: 0.5, unit: "tl", name: "lichte sojasaus" },
      { amount: 0.5, unit: "tl", name: "pure sesamolie" },
      { amount: 0.5, unit: "tl", name: "rijstazijn" },
      { amount: 1.0, unit: "tl", name: "suiker" },
      { amount: 1.0, unit: "el", name: "blended sesamolie" },
      { amount: 0.5, unit: nil, name: "komkommer" },
      { amount: 0.5, unit: nil, name: "wortel" },
      { amount: 0.5, unit: "tl", name: "Double pagoda zwarte sesamzaadjes" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Haal de tofu uit de verpakking en wikkel deze in keukenpapier. Leg er een snijplank of bord op en plaats hier een zwaar voorwerp op. Laat de tofu ongeveer 20 minuten uitlekken, zodat overtollig vocht wordt verwijderd.",
      "Dep de tofu daarna goed droog en snijd in plakken van ongeveer 1 cm dik. Bestuif de plakken rondom licht met maïzena en schud het overtollige zetmeel eraf.",
      "Verhit de blended sesamolie in een koekenpan op middelhoog vuur. Bak de tofu in één laag 4–5 minuten per kant, totdat beide kanten goudbruin en krokant zijn. Zet apart.",
      "Breng een pan met ruim water aan de kook. Voeg de noedels toe en kook ze volgens de aanwijzingen op de verpakking tot ze beetgaar zijn. Voeg eventueel een scheutje olie toe aan het kookwater.",
      "Bewaar 2–3 eetlepels van het kookwater en giet de noedels daarna af. Spoel ze kort af met koud water en laat goed uitlekken.",
      "Hak de knoflook fijn. Verhit de blended sesamolie in een kleine pan op middelhoog vuur en fruit de knoflook ongeveer 30 seconden.",
      "Voeg de pindakaas, het water, de chilisaus, lichte sojasaus, pure sesamolie, rijstazijn en suiker toe. Roer goed door tot een gladde saus.",
      "Is de saus te dik? Voeg dan beetje bij beetje wat van het bewaarde kookwater van de noedels toe.",
      "Doe de gekookte noedels in een grote kom. Voeg de pindasaus toe en meng goed, zodat alle noedels met de saus zijn bedekt.",
      "Snijd de komkommer en wortel in dunne reepjes.",
      "Verdeel de noedels over twee kommen of diepe borden. Leg de krokante tofu erop en garneer met de komkommer, wortel en zwarte sesamzaadjes."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["Tofu", 3],
        ["Noedels", 2],
        ["Pittige pindasaus", 9],
        ["Garnering", 3]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Haal de tofu uit de verpakking en wikkel deze in keukenpapier. Leg er een snijplank of bord op en plaats hier een zwaar voorwerp op. Laat de tofu ongeveer 20 minuten uitlekken, zodat overtollig vocht wordt verwijderd.\nDep de tofu daarna goed droog en snijd in plakken van ongeveer 1 cm dik. Bestuif de plakken rondom licht met maïzena en schud het overtollige zetmeel eraf.\nVerhit de blended sesamolie in een koekenpan op middelhoog vuur. Bak de tofu in één laag 4–5 minuten per kant, totdat beide kanten goudbruin en krokant zijn. Zet apart.\nBreng een pan met ruim water aan de kook. Voeg de noedels toe en kook ze volgens de aanwijzingen op de verpakking tot ze beetgaar zijn. Voeg eventueel een scheutje olie toe aan het kookwater.\nBewaar 2–3 eetlepels van het kookwater en giet de noedels daarna af. Spoel ze kort af met koud water en laat goed uitlekken.\nHak de knoflook fijn. Verhit de blended sesamolie in een kleine pan op middelhoog vuur en fruit de knoflook ongeveer 30 seconden.\nVoeg de pindakaas, het water, de chilisaus, lichte sojasaus, pure sesamolie, rijstazijn en suiker toe. Roer goed door tot een gladde saus.\nIs de saus te dik? Voeg dan beetje bij beetje wat van het bewaarde kookwater van de noedels toe.\nDoe de gekookte noedels in een grote kom. Voeg de pindasaus toe en meng goed, zodat alle noedels met de saus zijn bedekt.\nSnijd de komkommer en wortel in dunne reepjes.\nVerdeel de noedels over twee kommen of diepe borden. Leg de krokante tofu erop en garneer met de komkommer, wortel en zwarte sesamzaadjes.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("amazingoriental.com")
    expect(recipe.canonical_url).to eq("https://amazingoriental.com/recept/noedels-met-pittige-pindasaus-en-tofu/")
    expect(recipe.site_name).to eq("Amazing Oriental")
    expect(recipe.language).to eq("nl-NL")
    expect(recipe.author).to be_nil
    expect(recipe.description).to be_nil
    expect(recipe.image).to eq("https://amazingoriental.com/wp-content/uploads/2026/09/NoedelsPittigePindasausTofu_680-x-320.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
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
    expect(recipe.links).to include("#Sitemap")
  end
end
