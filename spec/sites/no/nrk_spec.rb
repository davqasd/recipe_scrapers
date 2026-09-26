# frozen_string_literal: true

RSpec.describe "nrk.no" do
  subject(:recipe) { scrape_cassette("no/nrk", url: "https://www.nrk.no/mat/honningmarinert-grillet-kylling-med-rosmarinpoteter-1.15110596") }

  it "reads the title" do
    expect(recipe.title).to eq("Honningmarinert grillet kylling med rosmarinpoteter")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1,3 kg hel kylling",
      "3 ss flytende honning",
      "1 ss ferske rosmarinblader",
      "2 hvitløkfedd",
      "3 ss tomatpure",
      "50 ml olivenolje, extra virgin",
      "1/2 sitron, juicen",
      "1 ss fersk persille, hakket (til pynt)",
      "salt og nykvernet pepper",
      "500 g nypoteter",
      "75 ml olivenolje, extra virgin",
      "4 hvitløkfedd",
      "3 kvister rosmarin"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.3, unit: "kg", name: "hel kylling" },
      { amount: 3.0, unit: "ss", name: "flytende honning" },
      { amount: 1.0, unit: "ss", name: "ferske rosmarinblader" },
      { amount: 2.0, unit: nil, name: "hvitløkfedd" },
      { amount: 3.0, unit: "ss", name: "tomatpure" },
      { amount: 50.0, unit: "ml", name: "olivenolje, extra virgin" },
      { amount: 0.5, unit: nil, name: "sitron, juicen" },
      { amount: 1.0, unit: "ss", name: "fersk persille, hakket" },
      { amount: nil, unit: nil, name: "salt og nykvernet pepper" },
      { amount: 500.0, unit: "g", name: "nypoteter" },
      { amount: 75.0, unit: "ml", name: "olivenolje, extra virgin" },
      { amount: 4.0, unit: nil, name: "hvitløkfedd" },
      { amount: 3.0, unit: "kvister", name: "rosmarin" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Når kyllingen skal varmebehandles hardt må eventuell hyssing som holder skroget sammen fjernes. Legg fuglen med brystet ned på en skjærefjøl. Bruk en skarp kniv og kutt langs begge sidene av ryggraden, og kast den. Vend kyllingen og bruk håndflaten til å trykke godt langs brystbenet for å flate ut fuglen, slik at den blir liggende flat.",
      "Drypp honning over kyllingen, deretter spres rosmarinblader og knust hvitløk over den. Fordel tomatpuré og drypp olje over den. Salt og pepre. Gni blandingen godt over hele kyllingen for å få marinaden jevnt fordelt.",
      "Forvarm en stor jernpanne med riller over høy varme i 5-10 minutter. Når den er varm, reduseres varmen til middels og kyllingbrystsiden legges på grillpannen. Klem over sitronsaften når du snur kyllingen. Stek i 15 minutter på hver side, eller til den er gyllen og gjennomstekt. Sett til side for å hvile, og hold den varm.",
      "I mellomtiden deles nypotetene opp i grove biter. Kok potetene i saltet vann i 4-5 minutter, eller til de er møre. Tøm av vannet.",
      "Varm olivenoljen i en stor stekepanne på middels varme. Tilsett hvitløk skåret i tynne skiver. Når den begynner å surre tilsettes rosmarin og poteter. Krydre med salt og pepper. Stek potetene i 4-5 minutter, eller til de er gyllenbrune. Vend potetene ofte.",
      "Skjær kyllingen i biter og legg på et serveringsfat sammen med potetene. Dryss over persille og ha et siste skvis med sitron over retten før den serveres."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Når kyllingen skal varmebehandles hardt må eventuell hyssing som holder skroget sammen fjernes. Legg fuglen med brystet ned på en skjærefjøl. Bruk en skarp kniv og kutt langs begge sidene av ryggraden, og kast den. Vend kyllingen og bruk håndflaten til å trykke godt langs brystbenet for å flate ut fuglen, slik at den blir liggende flat.\nDrypp honning over kyllingen, deretter spres rosmarinblader og knust hvitløk over den. Fordel tomatpuré og drypp olje over den. Salt og pepre. Gni blandingen godt over hele kyllingen for å få marinaden jevnt fordelt.\nForvarm en stor jernpanne med riller over høy varme i 5-10 minutter. Når den er varm, reduseres varmen til middels og kyllingbrystsiden legges på grillpannen. Klem over sitronsaften når du snur kyllingen. Stek i 15 minutter på hver side, eller til den er gyllen og gjennomstekt. Sett til side for å hvile, og hold den varm.\nI mellomtiden deles nypotetene opp i grove biter. Kok potetene i saltet vann i 4-5 minutter, eller til de er møre. Tøm av vannet.\nVarm olivenoljen i en stor stekepanne på middels varme. Tilsett hvitløk skåret i tynne skiver. Når den begynner å surre tilsettes rosmarin og poteter. Krydre med salt og pepper. Stek potetene i 4-5 minutter, eller til de er gyllenbrune. Vend potetene ofte.\nSkjær kyllingen i biter og legg på et serveringsfat sammen med potetene. Dryss over persille og ha et siste skvis med sitron over retten før den serveres.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("nrk.no")
    expect(recipe.canonical_url).to eq("https://www.nrk.no/mat/honningmarinert-grillet-kylling-med-rosmarinpoteter-1.15110596")
    expect(recipe.site_name).to eq("NRK")
    expect(recipe.language).to eq("nb-NO")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Kyllingen skal stekes på så høy varme at honning­marinaden svir seg. Den bitre smaken av brent og den søte honningen smaker fortreffelig sammen med rosmarin­potetene.")
    expect(recipe.image).to eq("https://gfx.nrk.no/XuK_5Mw6V4wOrt3NLJh-VQLHcFhoLAp4dsSMmlCiEmaw.jpg")
    expect(recipe.category).to eq("Middag")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 items")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Grill", "Kylling/Fugl"])
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
    expect(recipe.links).to include("#innhold")
  end
end
