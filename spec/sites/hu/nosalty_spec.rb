# frozen_string_literal: true

RSpec.describe "nosalty.hu" do
  subject(:recipe) { scrape_cassette("hu/nosalty", url: "https://www.nosalty.hu/recept/burgundi-marharagu-boeuf-bourguignon-julia-child-receptje") }

  it "reads the title" do
    expect(recipe.title).to eq("Burgundi marharagu (Boeuf Bourguignon, ahogy Julia Child készítette)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 kg Marhalábszár 5 cm-es kockákra vágva",
      "150 g Füstölt szalonna pancetta vagy bacon, csíkokra vágva",
      "2 nagy db Sárgarépa felkarikázva vagy hosszú csíkokra vágva",
      "1 nagy fej Vöröshagyma durvára vágva",
      "2 gerezd Fokhagyma zúzva",
      "2 ek Finomliszt",
      "7 dl Száraz vörösbor lehetőleg burgundi, de bármely testes, száraz vörös jó",
      "6 dl Marha alaplé",
      "1 ek Paradicsomszósz vagy paradicsompüré",
      "1 db Babérlevél",
      "1 szál Kakukkfű",
      "0 ízlés szerint Só",
      "0 ízlés szerint Fekete bors",
      "20 db Gyöngyhagyma vagy salotta",
      "25 dkg Csiperkegomba egészben vagy félben",
      "3 ek Vaj",
      "1 ek Olívaolaj"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "kg", name: "Marhalábszár 5 cm-es kockákra vágva" },
      { amount: 150.0, unit: "g", name: "Füstölt szalonna pancetta vagy bacon, csíkokra vágva" },
      { amount: 2.0, unit: "db", name: "Sárgarépa felkarikázva vagy hosszú csíkokra vágva" },
      { amount: 1.0, unit: "fej", name: "Vöröshagyma durvára vágva" },
      { amount: 2.0, unit: "gerezd", name: "Fokhagyma zúzva" },
      { amount: 2.0, unit: "ek", name: "Finomliszt" },
      { amount: 7.0, unit: "dl", name: "Száraz vörösbor lehetőleg burgundi, de bármely testes, száraz vörös jó" },
      { amount: 6.0, unit: "dl", name: "Marha alaplé" },
      { amount: 1.0, unit: "ek", name: "Paradicsomszósz vagy paradicsompüré" },
      { amount: 1.0, unit: "db", name: "Babérlevél" },
      { amount: 1.0, unit: "szál", name: "Kakukkfű" },
      { amount: nil, unit: nil, name: "ízlés szerint Só" },
      { amount: nil, unit: nil, name: "ízlés szerint Fekete bors" },
      { amount: 20.0, unit: "db", name: "Gyöngyhagyma vagy salotta" },
      { amount: 25.0, unit: "dkg", name: "Csiperkegomba egészben vagy félben" },
      { amount: 3.0, unit: "ek", name: "Vaj" },
      { amount: 1.0, unit: "ek", name: "Olívaolaj" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Előkészítjük az alapot: a szalonnát egy korty vízben 5 percig előfőzzük (így kevésbé lesz füstös), leszűrjük, majd egy nagy lábasban (lehetőleg egy öntött vasedényben) 1 evőkanál vaj és 1 evőkanál olívaolaj keverékén aranybarnára pirítjuk. Kiszedjük, a zsírját a lábasban hagyjuk.",
      "Megpirítjuk a húst (kulcslépés!): a marhahúst papírtörlővel szárazra töröljük (így szépen pirul majd). Sózzuk, borsozzuk, és több részletben, nagy lángon körbepirítjuk. A húst is kiszedjük, félretesszük.",
      "Zöldségek pirítása: a zsírban megpirítjuk a felkarikázott répát és az apróra vágott hagymát. Hozzáadjuk a zúzott fokhagymát is.",
      "A hús lisztes sütése - a titkos lépés: visszatesszük a húst és a szalonnát a lábasba, rászórjuk a lisztet, jól átforgatjuk. Az öntött vasedényt fedő nélkül 220°C-ra előmelegített sütőbe tesszük 10 percre, félidőben átkeverjük. Ez adja a ragu telt, sűrű mártását.",
      "Felöntés és hosszú főzés: kivesszük az edényt a sütőből, felöntjük a borral és az alaplével, hozzáadjuk a paradicsompürét, a babérlevelet és a kakukkfüvet. A folyadék épphogy lepje el a húst. Lefedve 160°C-on 2,5–3 óra alatt puhára sütjük/főzzük. Akkor jó, ha a hús könnyen szétnyomható villával.",
      "A gyöngyhagyma elkészítése (Oignons Glacés à Brun: Julia Child klasszikus technikája): a vaj felén a megtisztított gyöngyhagymát aranybarnára pirítjuk, majd kevés alaplével felöntve, lefedve 20–25 percig puhára pároljuk, míg karamellizált és üveges nem lesz.",
      "A gomba pirítása (Champignons Sautés au Beurre: Julia Child klasszikus technikája): a gombát félbevágjuk, szárazra töröljük, majd a maradék vajon szép aranyszínűre pirítjuk. Julia szerint a gomba akkor pirul jól, ha nem mozgatjuk túl sokat és szélesen terítjük el a serpenyőben.",
      "A megpuhult raguba belekeverjük a pirított gyöngyhagymát és a gombát, pár percig még összeforraljuk.",
      "Tálalhatjuk vajjal dúsított krumplipürével, vajas tésztával vagy egyszerűen főtt burgonyával. Másnap még finomabb, érdemes előre elkészíteni!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Előkészítjük az alapot: a szalonnát egy korty vízben 5 percig előfőzzük (így kevésbé lesz füstös), leszűrjük, majd egy nagy lábasban (lehetőleg egy öntött vasedényben) 1 evőkanál vaj és 1 evőkanál olívaolaj keverékén aranybarnára pirítjuk. Kiszedjük, a zsírját a lábasban hagyjuk.\nMegpirítjuk a húst (kulcslépés!): a marhahúst papírtörlővel szárazra töröljük (így szépen pirul majd). Sózzuk, borsozzuk, és több részletben, nagy lángon körbepirítjuk. A húst is kiszedjük, félretesszük.\nZöldségek pirítása: a zsírban megpirítjuk a felkarikázott répát és az apróra vágott hagymát. Hozzáadjuk a zúzott fokhagymát is.\nA hús lisztes sütése - a titkos lépés: visszatesszük a húst és a szalonnát a lábasba, rászórjuk a lisztet, jól átforgatjuk. Az öntött vasedényt fedő nélkül 220°C-ra előmelegített sütőbe tesszük 10 percre, félidőben átkeverjük. Ez adja a ragu telt, sűrű mártását.\nFelöntés és hosszú főzés: kivesszük az edényt a sütőből, felöntjük a borral és az alaplével, hozzáadjuk a paradicsompürét, a babérlevelet és a kakukkfüvet. A folyadék épphogy lepje el a húst. Lefedve 160°C-on 2,5–3 óra alatt puhára sütjük/főzzük. Akkor jó, ha a hús könnyen szétnyomható villával.\nA gyöngyhagyma elkészítése (Oignons Glacés à Brun: Julia Child klasszikus technikája): a vaj felén a megtisztított gyöngyhagymát aranybarnára pirítjuk, majd kevés alaplével felöntve, lefedve 20–25 percig puhára pároljuk, míg karamellizált és üveges nem lesz.\nA gomba pirítása (Champignons Sautés au Beurre: Julia Child klasszikus technikája): a gombát félbevágjuk, szárazra töröljük, majd a maradék vajon szép aranyszínűre pirítjuk. Julia szerint a gomba akkor pirul jól, ha nem mozgatjuk túl sokat és szélesen terítjük el a serpenyőben.\nA megpuhult raguba belekeverjük a pirított gyöngyhagymát és a gombát, pár percig még összeforraljuk.\nTálalhatjuk vajjal dúsított krumplipürével, vajas tésztával vagy egyszerűen főtt burgonyával. Másnap még finomabb, érdemes előre elkészíteni!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("nosalty.hu")
    expect(recipe.canonical_url).to eq("https://www.nosalty.hu/recept/burgundi-marharagu-boeuf-bourguignon-julia-child-receptje")
    expect(recipe.site_name).to eq("Nosalty")
    expect(recipe.language).to eq("hu")
    expect(recipe.author).to eq("Hering András")
    expect(recipe.description).to eq("A burgundi marha Julia Child egyik leghíresebb fogása, amely bebizonyítja, hogy a francia konyha nem bonyolult, csak jó alapanyagokat és egy kis türelmet kíván. Ebben a receptben lépésről lépésre megmutatjuk, hogyan készítheted el otthon a legendás marharagut: selymes, sűrű mártással, omlós hússal és a klasszikus, külön pirított gombával és gyöngyhagymával. Másnap még finomabb, igazi hétvégi vagy ünnepi komfortétel.")
    expect(recipe.image).to eq("https://image-api.nosalty.hu/nosalty/images/recipes/ao/nv/burgundi-marharagu-boeuf-bourguignon-julia-child-receptje.jpg?w=1200&h=1200&s=189ea68d9b266cfea593700f42c1ab40")
    expect(recipe.category).to eq("ragu")
    expect(recipe.cuisine).to eq("francia")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(210)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(180)
    expect(recipe.keywords).to eq([
      "vasárnapi ebéd",
      "ebéd",
      "vacsora",
      "cukormentes",
      "tojásmentes",
      "Marhalábszár",
      "Füstölt szalonna",
      "Sárgarépa",
      "Vöröshagyma",
      "Fokhagyma",
      "Finomliszt",
      "Száraz vörösbor",
      "Marha alaplé",
      "Paradicsomszósz",
      "Babérlevél",
      "Kakukkfű",
      "Só",
      "Fekete bors",
      "Gyöngyhagyma",
      "Csiperkegomba",
      "Vaj",
      "Olívaolaj",
      "könnyű",
      "hétvégi"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "3659 g",
      "calories" => "3720.532 g",
      "fatContent" => "187.36104 g",
      "fiberContent" => "19.6621 g",
      "sugarContent" => "37.79542 g",
      "sodiumContent" => "959.495 g",
      "proteinContent" => "246.69337 g",
      "cholesterolContent" => "615.3 mg",
      "carbohydrateContent" => "120.1347 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "g", amount: 3659.0 },
      { name: "calories", unit: "g", amount: 3720.532 },
      { name: "fatContent", unit: "g", amount: 187.36104 },
      { name: "fiberContent", unit: "g", amount: 19.6621 },
      { name: "sugarContent", unit: "g", amount: 37.79542 },
      { name: "sodiumContent", unit: "g", amount: 959.495 },
      { name: "proteinContent", unit: "g", amount: 246.69337 },
      { name: "cholesterolContent", unit: "mg", amount: 615.3 },
      { name: "carbohydrateContent", unit: "g", amount: 120.1347 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.nosalty.hu")
  end
end
