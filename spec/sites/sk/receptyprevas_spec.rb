# frozen_string_literal: true

RSpec.describe "receptyprevas.sk" do
  subject(:recipe) { scrape_cassette("sk/receptyprevas", url: "https://www.receptyprevas.sk/recepty/buchty-na-pare-babickin-recept-na-parene-buchty/") }

  it "reads the title" do
    expect(recipe.title).to eq("Buchty na pare, babičkin RECEPT na parené buchty")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "Čerstvé droždie: 0.5 ks",
      "Mlieko: 1 dl",
      "Kryštálový cukor: 1 PL",
      "Polohrubá múka: 500 g",
      "Minerálka: 1 dl",
      "Mlieko: 1 dl",
      "Kryštálový cukor: 2 PL",
      "Vajce: 1 ks",
      "Olej: 2 PL",
      "Soľ: 1 štipka",
      "Lekvár: 16 ML",
      "Maslo: 100 g",
      "Granko",
      "Kakao",
      "Práškový cukor"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.5, unit: "ks", name: "Čerstvé droždie" },
      { amount: 1.0, unit: "dl", name: "Mlieko" },
      { amount: 1.0, unit: "PL", name: "Kryštálový cukor" },
      { amount: 500.0, unit: "g", name: "Polohrubá múka" },
      { amount: 1.0, unit: "dl", name: "Minerálka" },
      { amount: 1.0, unit: "dl", name: "Mlieko" },
      { amount: 2.0, unit: "PL", name: "Kryštálový cukor" },
      { amount: 1.0, unit: "ks", name: "Vajce" },
      { amount: 2.0, unit: "PL", name: "Olej" },
      { amount: 1.0, unit: "štipka", name: "Soľ" },
      { amount: 16.0, unit: "ML", name: "Lekvár" },
      { amount: 100.0, unit: "g", name: "Maslo" },
      { amount: nil, unit: nil, name: "Granko" },
      { amount: nil, unit: nil, name: "Kakao" },
      { amount: nil, unit: nil, name: "Práškový cukor" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Kvások. Do vlažného mlieka pridáme cukor a nadrobené čerstvé droždie. Dôkladne premiešame, aby sa droždie s cukrom rozpustili. Kvások necháme vzísť, po 5 minútach sa urobí hustá pena. Do väčšej misky pridáme suroviny na cesto a kvások, vypracujeme pružné cesto. Cesto posypeme múkou a prikryjeme utierkou.",
      "Cesto necháme na teplejšom mieste kysnúť približne hodinu, aby zdvojnásobilo objem. Tak ho preložíme na múkou vysypanú pracovnú dosku, rozvaľkáme na hrúbku 1 cm. Ostrým nožom nakrájame štvorce veľkosti cca 5x5 cm. Do každého štvorca pridáme 1 lyžičku lekváru, konce dôkladne stlačíme, otočíme spojom dole.",
      "Keď všetky buchty pripravíme, prvé kusy môžeme pariť, lebo už nakysli. Do hrnca nalejeme vodu, vložíme paráčik. Vody pridáme toľko, aby nepresahovala paráčik, bola 1 cm pod paráčikom. Na paráčik položíme papier na pečenie alebo ho potrieme olejom. Hrniec prikryjeme pokrievkou, necháme vodu zovrieť, urobí sa para.",
      "Vložíme buchty, nie príliš blízko seba, lebo parením narastú. Dávame pozor, para vie popáliť. Buchty paríme 8-10 minút. Potom pokrievku pomaly odstránime, aby nám kvapky pary nekvapli na buchty, a tak nepľasli. Opatrne ich vyberieme na tanier, popicháme ostrou špajdlou alebo ihlou. Na kvalitnej panvici opražíme maslo.",
      "Hotové buchty podávame ešte teplé, posypané s obľúbenými posýpkami - kakaovou, makovou či orechovou, poliate voňavým opraženým maslom. Ak buchty budeme konzumovať neskôr, potrieme ich olejom a prikryjeme, aby nevyschli. Keď vychladnú, môžeme ich zamraziť, a túto sladkú pochúťku máme hotovú raz-dva."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Kvások. Do vlažného mlieka pridáme cukor a nadrobené čerstvé droždie. Dôkladne premiešame, aby sa droždie s cukrom rozpustili. Kvások necháme vzísť, po 5 minútach sa urobí hustá pena. Do väčšej misky pridáme suroviny na cesto a kvások, vypracujeme pružné cesto. Cesto posypeme múkou a prikryjeme utierkou.\nCesto necháme na teplejšom mieste kysnúť približne hodinu, aby zdvojnásobilo objem. Tak ho preložíme na múkou vysypanú pracovnú dosku, rozvaľkáme na hrúbku 1 cm. Ostrým nožom nakrájame štvorce veľkosti cca 5x5 cm. Do každého štvorca pridáme 1 lyžičku lekváru, konce dôkladne stlačíme, otočíme spojom dole.\nKeď všetky buchty pripravíme, prvé kusy môžeme pariť, lebo už nakysli. Do hrnca nalejeme vodu, vložíme paráčik. Vody pridáme toľko, aby nepresahovala paráčik, bola 1 cm pod paráčikom. Na paráčik položíme papier na pečenie alebo ho potrieme olejom. Hrniec prikryjeme pokrievkou, necháme vodu zovrieť, urobí sa para.\nVložíme buchty, nie príliš blízko seba, lebo parením narastú. Dávame pozor, para vie popáliť. Buchty paríme 8-10 minút. Potom pokrievku pomaly odstránime, aby nám kvapky pary nekvapli na buchty, a tak nepľasli. Opatrne ich vyberieme na tanier, popicháme ostrou špajdlou alebo ihlou. Na kvalitnej panvici opražíme maslo.\nHotové buchty podávame ešte teplé, posypané s obľúbenými posýpkami - kakaovou, makovou či orechovou, poliate voňavým opraženým maslom. Ak buchty budeme konzumovať neskôr, potrieme ich olejom a prikryjeme, aby nevyschli. Keď vychladnú, môžeme ich zamraziť, a túto sladkú pochúťku máme hotovú raz-dva.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("receptyprevas.sk")
    expect(recipe.canonical_url).to eq("https://www.receptyprevas.sk/recepty/buchty-na-pare-babickin-recept-na-parene-buchty/")
    expect(recipe.site_name).to eq("Recepty pre Vás")
    expect(recipe.language).to eq("sk-SK")
    expect(recipe.author).to eq("Martina")
    expect(recipe.description).to eq("Tip pre vás. Na prípravu parených buchiet môžeme zvoliť aj múku špaldovú, pridáme jej však menej, lebo je hutnejšia. Pri bezlepkovej verzii pridáme múku bez lepku, vhodnú na kysnuté cesto.")
    expect(recipe.image).to eq("https://www.receptyprevas.sk/wp-content/uploads/2022/05/buchty_na_pare.jpg")
    expect(recipe.category).to eq("Bezmäsitá strava,Detské recepty,Hlavné jedlá,Klasické jedlá,Múčne jedlá")
    expect(recipe.cuisine).to eq("Slovenská")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(120)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "servingSize" => "1", "calories" => "790" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: nil, amount: 1.0 },
      { name: "calories", unit: nil, amount: 790.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#")
  end
end
