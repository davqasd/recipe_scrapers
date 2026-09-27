# frozen_string_literal: true

RSpec.describe "mindmegette.hu" do
  subject(:recipe) { scrape_cassette("hu/mindmegette", url: "https://www.mindmegette.hu/recept/kokuszos-oreo-mini-sajttorta") }

  it "reads the title" do
    expect(recipe.title).to eq("Kókuszos-oreós mini sajttorta | Mindmegette.hu")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "15 dkg oreo",
      "5 dkg Margarin",
      "25 dkg Mascarpone",
      "15 dkg Kókuszreszelék",
      "10 dkg Porcukor",
      "1 csomag Vaníliás cukor",
      "1 tk kókuszaroma"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 15.0, unit: "dkg", name: "oreo" },
      { amount: 5.0, unit: "dkg", name: "Margarin" },
      { amount: 25.0, unit: "dkg", name: "Mascarpone" },
      { amount: 15.0, unit: "dkg", name: "Kókuszreszelék" },
      { amount: 10.0, unit: "dkg", name: "Porcukor" },
      { amount: 1.0, unit: "csomag", name: "Vaníliás cukor" },
      { amount: 1.0, unit: nil, name: "tk kókuszaroma" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "1. lépés",
      "A sütőt előmelegítjük 175 fokra, és egy muffinsütő tepsi mélyedéseit kibéleljünk muffinpapírral.",
      "2. lépés",
      "A ledarált kekszet összekeverjük az olvasztott margarinnal, majd elosztjuk a mélyedésekben, és kicsit elegyengetjük. 5 percig sütjük, majd kivesszük a sütőből.",
      "3. lépés",
      "A mascarponét összekeverjük a kétféle cukorral, a kókuszaromával és a kókuszreszelékkel. Ezt a masszát is elosztjuk a 12 db papírkapszliban, majd 15 percig sütjük. Miután megsült, kihűtjük, majd a hűtőbe tesszük őket legalább 2 órára."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("1. lépés\nA sütőt előmelegítjük 175 fokra, és egy muffinsütő tepsi mélyedéseit kibéleljünk muffinpapírral.\n2. lépés\nA ledarált kekszet összekeverjük az olvasztott margarinnal, majd elosztjuk a mélyedésekben, és kicsit elegyengetjük. 5 percig sütjük, majd kivesszük a sütőből.\n3. lépés\nA mascarponét összekeverjük a kétféle cukorral, a kókuszaromával és a kókuszreszelékkel. Ezt a masszát is elosztjuk a 12 db papírkapszliban, majd 15 percig sütjük. Miután megsült, kihűtjük, majd a hűtőbe tesszük őket legalább 2 órára.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("mindmegette.hu")
    expect(recipe.canonical_url).to eq("https://www.mindmegette.hu/recept/kokuszos-oreo-mini-sajttorta")
    expect(recipe.site_name).to eq("Mindmegette.hu")
    expect(recipe.language).to eq("hu")
    expect(recipe.author).to eq("Tóth Éva")
    expect(recipe.description).to eq("Készítsd el a Kókuszos-oreós mini sajttorta kipróbált, bevált receptjét. A Mindmegette.hu receptgyűjteményében mindent megtalálsz.")
    expect(recipe.image).to eq("https://cdn.mindmegette.hu/2024/02/cbIAitzOFnZ1G-OEyl-25zoAgGiDB0UDAxcmWViL76U/fill/0/0/no/1/aHR0cHM6Ly9jbXNjZG4uYXBwLmNvbnRlbnQucHJpdmF0ZS9jb250ZW50LzUyNDYzNGMxODVmNDQwOTViZmQ4N2NiZDMwNjZhOTc4.webp")
    expect(recipe.category).to eq("30 perc")
    expect(recipe.cuisine).to eq("amerikai")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["sajttorta"])
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
    expect(recipe.links).to include("#main-content")
  end
end
