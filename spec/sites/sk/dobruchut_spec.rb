# frozen_string_literal: true

RSpec.describe "dobruchut.aktuality.sk" do
  subject(:recipe) { scrape_cassette("sk/dobruchut", url: "https://dobruchut.aktuality.sk/recept/83918/vierkin-jablkovy-kolac-krehke-cesto-stavnata-jablkova-napln-a-jemny-orechovy-biskvit-kombinacia-ktora-nikdy-nesklame-videorecept/") }

  it "reads the title" do
    expect(recipe.title).to eq("Vierkin jablkový koláč: Krehké cesto, šťavnatá jablková náplň a jemný orechový biskvit. Kombinácia, ktorá nikdy nesklame, VIDEORECEPT")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "450 g polohrubá múka",
      "8 g kypriaci prášok do pečiva (2 lyžičky)",
      "4 g soľ",
      "90 g práškový cukor",
      "1 ks stredne veľké vajce",
      "250 g maslo",
      "1 kg očistené jablká (bez šupky, jadrovníka)",
      "50 ml citrónová šťava (1 citrón)",
      "50 ml voda",
      "60 g škoricový cukor (3 vrecká)",
      "4 ks bielky",
      "1 štipka soľ",
      "110 g kryštálový cukor",
      "4 ks zltky",
      "80 g slnečnicový olej (4 lyžice)",
      "30 g zomleté vlašské orechy",
      "70 g hladká múka",
      "práškový cukor na ozdobenie koláča"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 450.0, unit: "g", name: "polohrubá múka" },
      { amount: 8.0, unit: "g", name: "kypriaci prášok do pečiva" },
      { amount: 4.0, unit: "g", name: "soľ" },
      { amount: 90.0, unit: "g", name: "práškový cukor" },
      { amount: 1.0, unit: "ks", name: "stredne veľké vajce" },
      { amount: 250.0, unit: "g", name: "maslo" },
      { amount: 1.0, unit: "kg", name: "očistené jablká" },
      { amount: 50.0, unit: "ml", name: "citrónová šťava" },
      { amount: 50.0, unit: "ml", name: "voda" },
      { amount: 60.0, unit: "g", name: "škoricový cukor" },
      { amount: 4.0, unit: "ks", name: "bielky" },
      { amount: 1.0, unit: "štipka", name: "soľ" },
      { amount: 110.0, unit: "g", name: "kryštálový cukor" },
      { amount: 4.0, unit: "ks", name: "zltky" },
      { amount: 80.0, unit: "g", name: "slnečnicový olej" },
      { amount: 30.0, unit: "g", name: "zomleté vlašské orechy" },
      { amount: 70.0, unit: "g", name: "hladká múka" },
      { amount: nil, unit: nil, name: "práškový cukor na ozdobenie koláča" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "1:",
      "Podrobný postup je vo videu. K dispozícii sú aj titulky. Ďakujem za sledovanie !"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("1:\nPodrobný postup je vo videu. K dispozícii sú aj titulky. Ďakujem za sledovanie !")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("dobruchut.aktuality.sk")
    expect(recipe.canonical_url).to eq("https://dobruchut.aktuality.sk/recept/83918/vierkin-jablkovy-kolac-krehke-cesto-stavnata-jablkova-napln-a-jemny-orechovy-biskvit-kombinacia-ktora-nikdy-nesklame-videorecept/")
    expect(recipe.site_name).to eq("DobrúChuť.sk")
    expect(recipe.language).to eq("sk")
    expect(recipe.author).to eq("LiViera Desserts")
    expect(recipe.description).to eq("Základ z krehkého cesta, jablková plnka ochutená škoricou a jemný orechový biskvit je kombinácia, ktorá vás určite nesklame. Priznám sa, že odkedy mi napadol recept na tento skvelý koláč, tak ho robím už niekoľký krát po sebe a chutí nám stále viac a viac.")
    expect(recipe.image).to eq("https://img.aktuality.sk/foto/Zml0LWluLzg4MHg0MDAvZmlsdGVyczpmb3JtYXQoanBlZykvaW1n/BqzrlOOnRb-C4etyPMKCIA.png?st=oa3lFrczW0RAEtAgl_9sj3AmwQXRi83sHHs5UJdrr_4&ts=1788164599&e=0")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("0 items")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.6)
    expect(recipe.ratings_count).to eq(27)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.aktuality.sk")
  end
end
