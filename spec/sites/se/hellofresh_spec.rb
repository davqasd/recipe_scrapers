# frozen_string_literal: true

RSpec.describe "hellofresh.se" do
  subject(:recipe) { scrape_cassette("se/hellofresh", url: "https://www.hellofresh.se/recipes/coq-au-vin-inspirerad-pulled-chicken-65806f4616590f43e9699f73") }

  it "reads the title" do
    expect(recipe.title).to eq("Coq au vin-inspirerad pulled chicken med vitlöksmos och färsk persilja")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "300 g Kycklingbröstfilé",
      "1 st Lök",
      "1 st Morot",
      "100 g Champinjoner",
      "1 st Vitlöksklyfta",
      "4 g Kycklingbuljong",
      "½ burk Tomatpuré",
      "4 g Vitlöksflörter",
      "1 st Worcestershiresås",
      "60 g Rödvinssås",
      "500 g Potatis",
      "1 portionspåse Bladpersilja",
      "¼ tsk Salt (steg 1)",
      "3 msk Mjölk (steg 2)",
      "½ tsk Salt (steg 2)",
      "1 msk Olivolja (steg 4)",
      "½ tsk Socker (steg 5)",
      "1 dl Vatten (steg 5)",
      "1 msk Smör (steg 5)",
      "¼ tsk Salt (steg 5)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 300.0, unit: "g", name: "Kycklingbröstfilé" },
      { amount: 1.0, unit: "st", name: "Lök" },
      { amount: 1.0, unit: "st", name: "Morot" },
      { amount: 100.0, unit: "g", name: "Champinjoner" },
      { amount: 1.0, unit: "st", name: "Vitlöksklyfta" },
      { amount: 4.0, unit: "g", name: "Kycklingbuljong" },
      { amount: 0.5, unit: "burk", name: "Tomatpuré" },
      { amount: 4.0, unit: "g", name: "Vitlöksflörter" },
      { amount: 1.0, unit: "st", name: "Worcestershiresås" },
      { amount: 60.0, unit: "g", name: "Rödvinssås" },
      { amount: 500.0, unit: "g", name: "Potatis" },
      { amount: 1.0, unit: nil, name: "portionspåse Bladpersilja" },
      { amount: 0.25, unit: "tsk", name: "Salt" },
      { amount: 3.0, unit: "msk", name: "Mjölk" },
      { amount: 0.5, unit: "tsk", name: "Salt" },
      { amount: 1.0, unit: "msk", name: "Olivolja" },
      { amount: 0.5, unit: "tsk", name: "Socker" },
      { amount: 1.0, unit: "dl", name: "Vatten" },
      { amount: 1.0, unit: "msk", name: "Smör" },
      { amount: 0.25, unit: "tsk", name: "Salt" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Värm ugnen till 220 °C/200 °C (varmluft). Lägg över kyckling på en plåt med bakplåtspapper. Krydda med salt [1/4 tsk | 1/2 tsk] och stek i ugnen i 17–19 min, eller tills genomstekt. VIKTIGT: 1) Tvätta händer och köksredskap noggrant efter hantering av rå kyckling. 2) Den är färdiglagad när köttet inte längre är rosa i mitten.",
      "Koka upp en medelstor kastrull med saltat vatten. Skala och tärna potatis i 2 cm stora bitar. Skala vitlök. Koka potatis och vitlök i 11–13 min, eller tills de enkelt kan delas med en kniv. Häll av vattnet, och mosa potatis och vitlök tillsammans med mjölk [3 msk | 6 msk], salt [½ tsk | 1 tsk] och en nypa peppar i kastrullen tills lent. Ställ åt sidan under lock. TIPS: Tillsätt en klick smör för att göra moset extra krämigt.",
      "Under tiden, finhacka morot (oskalad) och lök. Grovhacka svamp [1/2 paket, 2P].",
      "Hetta upp olivolja [1 msk | 2 msk] i en stor stekpanna på medelvärme. Stek lök, morot, svamp och en nypa salt i 6–8 min, eller tills mjuka. Under tiden, använd 2 gafflar för att riva tills kyckling är helt strimlad.",
      "Tillsätt tomatpuré [1/2 burk, 2P], socker [1/2 tsk | 1 tsk] och Vitlöksflörter till stekpannan. Stek i 1 min, eller tills väldoftande. Tillsätt vatten [1 dl | 2 dl], worcestershiresås, kycklingbuljong, rödvinssås och smör [1 msk | 2 msk] och sjud i 3–4 min. Tillsätt kyckling, salt [1/4 tsk | 1/2 tsk] och en nypa peppar och sjud i ytterligare 1 min. Grovhacka persilja.",
      "Lägg upp potatismos och pulled chicken på tallrikar. Toppa med persilja och nymalen peppar."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Värm ugnen till 220 °C/200 °C (varmluft). Lägg över kyckling på en plåt med bakplåtspapper. Krydda med salt [1/4 tsk | 1/2 tsk] och stek i ugnen i 17–19 min, eller tills genomstekt. VIKTIGT: 1) Tvätta händer och köksredskap noggrant efter hantering av rå kyckling. 2) Den är färdiglagad när köttet inte längre är rosa i mitten.\nKoka upp en medelstor kastrull med saltat vatten. Skala och tärna potatis i 2 cm stora bitar. Skala vitlök. Koka potatis och vitlök i 11–13 min, eller tills de enkelt kan delas med en kniv. Häll av vattnet, och mosa potatis och vitlök tillsammans med mjölk [3 msk | 6 msk], salt [½ tsk | 1 tsk] och en nypa peppar i kastrullen tills lent. Ställ åt sidan under lock. TIPS: Tillsätt en klick smör för att göra moset extra krämigt.\nUnder tiden, finhacka morot (oskalad) och lök. Grovhacka svamp [1/2 paket, 2P].\nHetta upp olivolja [1 msk | 2 msk] i en stor stekpanna på medelvärme. Stek lök, morot, svamp och en nypa salt i 6–8 min, eller tills mjuka. Under tiden, använd 2 gafflar för att riva tills kyckling är helt strimlad.\nTillsätt tomatpuré [1/2 burk, 2P], socker [1/2 tsk | 1 tsk] och Vitlöksflörter till stekpannan. Stek i 1 min, eller tills väldoftande. Tillsätt vatten [1 dl | 2 dl], worcestershiresås, kycklingbuljong, rödvinssås och smör [1 msk | 2 msk] och sjud i 3–4 min. Tillsätt kyckling, salt [1/4 tsk | 1/2 tsk] och en nypa peppar och sjud i ytterligare 1 min. Grovhacka persilja.\nLägg upp potatismos och pulled chicken på tallrikar. Toppa med persilja och nymalen peppar.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hellofresh.se")
    expect(recipe.canonical_url).to eq("https://www.hellofresh.se/recipes/coq-au-vin-inspirerad-pulled-chicken-65806f4616590f43e9699f73")
    expect(recipe.site_name).to eq("HelloFresh")
    expect(recipe.language).to eq("sv-SE")
    expect(recipe.author).to eq("HelloFresh")
    expect(recipe.description).to eq("Coq au vin OCH pulled chicken i en och samma rätt – kan det bli bättre? Kanske om vi säger att du kan svänga ihop denna kulinariska upplevelse på drygt en halvtimme. Vi lagar ett krämigt potatis- och vitlöksmos och kycklingen får sällskap av en härlig rödvinssås med champinjoner, morot, lök och örtkryddor. Färsk persilja och nymalen peppar på toppen, och så är middagen redo att avnjutas.")
    expect(recipe.image).to eq("https://img.hellofresh.com/f_auto,fl_lossy,h_640,q_auto,w_1200/hellofresh_s3/image/HF_Y24_R27_W07_SE_C20480-2_Main__1low-79f230b0.jpg")
    expect(recipe.category).to eq("Huvudrätt")
    expect(recipe.cuisine).to eq("Fransk")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.180210315018721)
    expect(recipe.ratings_count).to eq(523)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "626 kcal",
      "fatContent" => "21.5 g",
      "saturatedFatContent" => "7.5 g",
      "carbohydrateContent" => "64.1 g",
      "sugarContent" => "18.3 g",
      "proteinContent" => "44.5 g",
      "fiberContent" => "7.3 g",
      "sodiumContent" => "4.9 g",
      "servingSize" => "643"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 626.0 },
      { name: "fatContent", unit: "g", amount: 21.5 },
      { name: "saturatedFatContent", unit: "g", amount: 7.5 },
      { name: "carbohydrateContent", unit: "g", amount: 64.1 },
      { name: "sugarContent", unit: "g", amount: 18.3 },
      { name: "proteinContent", unit: "g", amount: 44.5 },
      { name: "fiberContent", unit: "g", amount: 7.3 },
      { name: "sodiumContent", unit: "g", amount: 4.9 },
      { name: "servingSize", unit: nil, amount: 643.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#page")
  end
end
