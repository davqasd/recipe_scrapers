# frozen_string_literal: true

RSpec.describe "yemek.com" do
  subject(:recipe) { scrape_cassette("com/yemek", url: "https://yemek.com/tarif/kori-soslu-tavuklu-patates-toplari/") }

  it "reads the title" do
    expect(recipe.title).to eq("Köri Soslu Tavuklu Patates Topları")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 yemek kaşığı sıvı yağ",
      "1 kilogram tavuk (doğranmış)",
      "1 adet soğan (piyazlık doğranmış)",
      "1 adet kapya biber (doğranmış)",
      "300 gram mantar (iri doğranmış)",
      "1,5 çay kaşığı tuz",
      "1 çay kaşığı karabiber",
      "1 çay kaşığı toz kırmızı biber",
      "1 çay bardağı su",
      "5 adet patates",
      "2 yemek kaşığı tereyağı",
      "2 çay kaşığı tuz",
      "2 yemek kaşığı tereyağı",
      "1 tatlı kaşığı sıvı yağ",
      "2 yemek kaşığı un",
      "2,5 su bardağı süt",
      "1 tatlı kaşığı köri",
      "1/2 çay kaşığı tuz",
      "100 gram rendelenmiş mozarella peyniri (arzuya göre kaşar peyniri)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "yemek kaşığı", name: "sıvı yağ" },
      { amount: 1.0, unit: "kilogram", name: "tavuk" },
      { amount: 1.0, unit: "adet", name: "soğan" },
      { amount: 1.0, unit: "adet", name: "kapya biber" },
      { amount: 300.0, unit: "gram", name: "mantar" },
      { amount: 1.5, unit: "çay kaşığı", name: "tuz" },
      { amount: 1.0, unit: "çay kaşığı", name: "karabiber" },
      { amount: 1.0, unit: "çay kaşığı", name: "toz kırmızı biber" },
      { amount: 1.0, unit: "çay bardağı", name: "su" },
      { amount: 5.0, unit: "adet", name: "patates" },
      { amount: 2.0, unit: "yemek kaşığı", name: "tereyağı" },
      { amount: 2.0, unit: "çay kaşığı", name: "tuz" },
      { amount: 2.0, unit: "yemek kaşığı", name: "tereyağı" },
      { amount: 1.0, unit: "tatlı kaşığı", name: "sıvı yağ" },
      { amount: 2.0, unit: "yemek kaşığı", name: "un" },
      { amount: 2.5, unit: "su bardağı", name: "süt" },
      { amount: 1.0, unit: "tatlı kaşığı", name: "köri" },
      { amount: 0.5, unit: "çay kaşığı", name: "tuz" },
      { amount: 100.0, unit: "gram", name: "rendelenmiş mozarella peyniri" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Patatesleri bir tencerede haşlayın. Haşlandıktan sonra suyunu süzüp tereyağı ve tuzla tatlandırıp püre haline getirin. Kişi sayısına göre eşit parçalara bölüp top haline getirin.",
      "Tavukları pişireceğiniz tavayı ısıtın ve sıvı yağ ekleyip tavukları suyunu salıp çekene dek pişirin.",
      "Soğanları da tavukların üzerine ekleyip 2-3 dakika soteleyin. Ardından kapya biberi de ilave edip kavurun ve mantarları ekleyip suyunu salıp çekmesini bekleyin. Ara ara karıştırın.",
      "Tuz, karabiber ve kırmızı biberi de ilave edip karıştırın ve son olarak suyunu ilave edip kısık ateşte 10 dakika kadar pişirin.",
      "Sos için, tereyağını bir sos tenceresinde eritin ve sıvı yağ ekleyin. Üzerine un ve köriyi ilave edip 2-3 dakika kavurun. Sütü de yavaş yavaş ilave edip sürekli olarak karıştırın. Kaynamaya ve kıvamı koyulaşmaya başladıktan sonra altını kısıp 5 dakika daha pişirip ocaktan alın. Beklerken çok koyulaşırsa su veya sütle açın.",
      "Fırını 200 dereceye ayarlayın.",
      "Borcama pişirdiğiniz sebzeli tavuğu yayın. Üzerine hazırladığınız patates toplarını, aralarında boşluk olacak şekilde dizin. Her bir patates topunun üzerine köri sosundan eşit miktarda dökün. Son olarak üzerlerine rendelenmiş mozarella ilave edip 200 derece fırında üzerleri kızarana dek 15 dakika pişirin."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Patatesleri bir tencerede haşlayın. Haşlandıktan sonra suyunu süzüp tereyağı ve tuzla tatlandırıp püre haline getirin. Kişi sayısına göre eşit parçalara bölüp top haline getirin.\nTavukları pişireceğiniz tavayı ısıtın ve sıvı yağ ekleyip tavukları suyunu salıp çekene dek pişirin.\nSoğanları da tavukların üzerine ekleyip 2-3 dakika soteleyin. Ardından kapya biberi de ilave edip kavurun ve mantarları ekleyip suyunu salıp çekmesini bekleyin. Ara ara karıştırın.\nTuz, karabiber ve kırmızı biberi de ilave edip karıştırın ve son olarak suyunu ilave edip kısık ateşte 10 dakika kadar pişirin.\nSos için, tereyağını bir sos tenceresinde eritin ve sıvı yağ ekleyin. Üzerine un ve köriyi ilave edip 2-3 dakika kavurun. Sütü de yavaş yavaş ilave edip sürekli olarak karıştırın. Kaynamaya ve kıvamı koyulaşmaya başladıktan sonra altını kısıp 5 dakika daha pişirip ocaktan alın. Beklerken çok koyulaşırsa su veya sütle açın.\nFırını 200 dereceye ayarlayın.\nBorcama pişirdiğiniz sebzeli tavuğu yayın. Üzerine hazırladığınız patates toplarını, aralarında boşluk olacak şekilde dizin. Her bir patates topunun üzerine köri sosundan eşit miktarda dökün. Son olarak üzerlerine rendelenmiş mozarella ilave edip 200 derece fırında üzerleri kızarana dek 15 dakika pişirin.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("yemek.com")
    expect(recipe.canonical_url).to eq("https://yemek.com/tarif/kori-soslu-tavuklu-patates-toplari/")
    expect(recipe.site_name).to eq("Yemek.com")
    expect(recipe.language).to eq("tr")
    expect(recipe.author).to eq("Yasemin Gürsürer")
    expect(recipe.description).to eq("Patates ve tavuk ikilisi yeniden bir araya geliyor, güçlerini birleştiriyorlar ve ortaya inanılmaz bir lezzet çıkıyor. Köri soslu patates topları burada!")
    expect(recipe.image).to eq("https://imgrosetta.yemek.com/file/141006/141006-300x200.jpg")
    expect(recipe.category).to eq("Tavuk")
    expect(recipe.cuisine).to eq("Türk")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 items")
    expect(recipe.total_time).to eq(85)
    expect(recipe.prep_time).to eq(45)
    expect(recipe.cook_time).to eq(40)
    expect(recipe.keywords).to eq(%w[kori soslu tavuklu patates toplari])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.7)
    expect(recipe.ratings_count).to eq(3)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "calories" => "0 kalori" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kalori", amount: 0.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
