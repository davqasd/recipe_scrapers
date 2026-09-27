# frozen_string_literal: true

RSpec.describe "varecha.pravda.sk" do
  subject(:recipe) { scrape_cassette("sk/varecha", url: "https://varecha.pravda.sk/recepty/kysnute-pecivo-s-hroznovym-zele/94831-recept.html") }

  it "reads the title" do
    expect(recipe.title).to eq("Kysnuté pečivo s hroznovým želé")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "droždie, 50 g čerstvé",
      "cukor kryštálový, 100 g",
      "mlieko, 150 ml",
      "múka hladká, 450 g",
      "žĺtky, 2 ks",
      "vajcia, 2 ks",
      "cukor vanilkový, 1 bal.",
      "kôra citrónová, 1 ČL nastrúhaná",
      "maslo, 100 g",
      "vajce, 1 ks",
      "hrozno zelené, 300 g (bez jadierok)",
      "cukor kryštálový, 50 g",
      "škrob kukuričný, 20 g",
      "voda, 200 ml",
      "cukor práškový"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "droždie, 50 g čerstvé" },
      { amount: 100.0, unit: "g", name: "cukor kryštálový" },
      { amount: 150.0, unit: "ml", name: "mlieko" },
      { amount: 450.0, unit: "g", name: "múka hladká" },
      { amount: 2.0, unit: "ks", name: "žĺtky" },
      { amount: 2.0, unit: "ks", name: "vajcia" },
      { amount: nil, unit: nil, name: "cukor vanilkový, 1 bal." },
      { amount: nil, unit: nil, name: "kôra citrónová, 1 ČL nastrúhaná" },
      { amount: 100.0, unit: "g", name: "maslo" },
      { amount: 1.0, unit: "ks", name: "vajce" },
      { amount: 300.0, unit: "g", name: "hrozno zelené" },
      { amount: 50.0, unit: "g", name: "cukor kryštálový" },
      { amount: 20.0, unit: "g", name: "škrob kukuričný" },
      { amount: 200.0, unit: "ml", name: "voda" },
      { amount: nil, unit: nil, name: "cukor práškový" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Droždie rozotrieme s lyžicou cukru, pridáme časť vlažného mlieka a rozšľaháme. Primiešame lyžicu múky, pripravíme kvások a necháme ho vykysnúť.",
      "Vo väčšej mise zmiešame zvyšnú múku s cukrom. Pridáme žĺtky, vajcia, vanilkový cukor, nastrúhanú citrónovú kôru, vykysnutý kvások a zvyšné vlažné mlieko. Nakoniec prilievame rozpustené vlažné maslo a vypracujeme hladké pružné cesto. Necháme ho kysnúť približne 40 minút.",
      "Vykysnuté cesto rozdelíme na menšie kúsky, z každého vyvaľkáme valček a stočíme ho. Poukladáme na plech vystlaný papierom na pečenie, necháme ešte nakysnúť, potrieme rozšľahaným vajcom a pečieme pri 180 °C približne 12 minút. Po upečení necháme vychladnúť a pozdĺžne rozkrojíme.",
      "Hrozno povaríme asi 5 minút vo vode s cukrom. Primiešame kukuričný škrob rozmiešaný v troche studenej vody a krátko povaríme, kým náplň nezhustne. Ešte teplou náplňou naplníme vychladnuté pečivo a pred podávaním posypeme práškovým cukrom."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Droždie rozotrieme s lyžicou cukru, pridáme časť vlažného mlieka a rozšľaháme. Primiešame lyžicu múky, pripravíme kvások a necháme ho vykysnúť.\nVo väčšej mise zmiešame zvyšnú múku s cukrom. Pridáme žĺtky, vajcia, vanilkový cukor, nastrúhanú citrónovú kôru, vykysnutý kvások a zvyšné vlažné mlieko. Nakoniec prilievame rozpustené vlažné maslo a vypracujeme hladké pružné cesto. Necháme ho kysnúť približne 40 minút.\nVykysnuté cesto rozdelíme na menšie kúsky, z každého vyvaľkáme valček a stočíme ho. Poukladáme na plech vystlaný papierom na pečenie, necháme ešte nakysnúť, potrieme rozšľahaným vajcom a pečieme pri 180 °C približne 12 minút. Po upečení necháme vychladnúť a pozdĺžne rozkrojíme.\nHrozno povaríme asi 5 minút vo vode s cukrom. Primiešame kukuričný škrob rozmiešaný v troche studenej vody a krátko povaríme, kým náplň nezhustne. Ešte teplou náplňou naplníme vychladnuté pečivo a pred podávaním posypeme práškovým cukrom.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("varecha.pravda.sk")
    expect(recipe.canonical_url).to eq("https://varecha.pravda.sk/recepty/kysnute-pecivo-s-hroznovym-zele/94831-recept.html")
    expect(recipe.site_name).to eq("Varecha.sk")
    expect(recipe.language).to eq("sk")
    expect(recipe.author).to eq("redakcia")
    expect(recipe.description).to eq("Sladké pečivo z kysnutého cesta naplnené sviežim hroznovým želé je skvelou oslavou sezóny hrozna.")
    expect(recipe.image).to eq("https://varecha.pravda.sk/uploady/velky-bananiky-s-hroznovym-kremom.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("30 items")
    expect(recipe.total_time).to eq(62)
    expect(recipe.prep_time).to eq(50)
    expect(recipe.cook_time).to eq(12)
    expect(recipe.keywords).to eq(["Chody", "Dezerty", "Jesenné", "Koláče", "Na sladko", "Ovocné", "Pečené", "Sezónne jedlá", "Spôsob prípravy", "Zákusky"])
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
    expect(recipe.links).to include("/")
  end
end
