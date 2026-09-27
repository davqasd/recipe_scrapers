# frozen_string_literal: true

RSpec.describe "hellofresh.no" do
  subject(:recipe) { scrape_cassette("no/hellofresh", url: "https://www.hellofresh.no/recipes/hvitlok-og-chilistekte-reker-i-spaghetti-med-laks-6a3e6f85f396cfc62f2b2a5b") }

  it "reads the title" do
    expect(recipe.title).to eq("Hvitløk- og chilistekte reker i spaghetti med squash og ruccola")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 stk Løk",
      "1 stk Squash",
      "½ stk Sitrusfrukt",
      "1 pose Basilikum",
      "150 g Reker",
      "1 pakke Spaghetti",
      "150 ml Matfløte",
      "1 stk Hvitløk",
      "4 g Buljong",
      "1 stk Tomat",
      "1 g Chiliflak",
      "20 g Ruccola",
      "1 ss Smør (steg 1)",
      "½ ss Olivenolje (steg 1)",
      "½ ss Olivenolje (steg 3)",
      "½ ts Salt (steg 3)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "stk", name: "Løk" },
      { amount: 1.0, unit: "stk", name: "Squash" },
      { amount: 0.5, unit: "stk", name: "Sitrusfrukt" },
      { amount: 1.0, unit: nil, name: "pose Basilikum" },
      { amount: 150.0, unit: "g", name: "Reker" },
      { amount: 1.0, unit: "pakke", name: "Spaghetti" },
      { amount: 150.0, unit: "ml", name: "Matfløte" },
      { amount: 1.0, unit: "stk", name: "Hvitløk" },
      { amount: 4.0, unit: "g", name: "Buljong" },
      { amount: 1.0, unit: "stk", name: "Tomat" },
      { amount: 1.0, unit: "g", name: "Chiliflak" },
      { amount: 20.0, unit: "g", name: "Ruccola" },
      { amount: 1.0, unit: "ss", name: "Smør" },
      { amount: 0.5, unit: "ss", name: "Olivenolje" },
      { amount: 0.5, unit: "ss", name: "Olivenolje" },
      { amount: 0.5, unit: "ts", name: "Salt" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Kok opp saltet vann i en stor kjele. Finhakk eller press hvitløk. Krydre reker med en klype salt. Varm opp olivenolje [1/2 ss | 1 ss] i en stor stekepanne på middels høy varme. Stek reker, hvitløk og chiliflak i 1-2 min på hver side, eller til gjennomstekt. Tilsett smør [1 ss | 2 ss] og la det smelte. Sett til side i en skål. TIPS: Rekene er ferdige når de er rosa på utsiden og matte inni.TIPS: Tilsett chiliflak etter smak - det er sterkt.",
      "Kok spaghetti i 8-9 min, eller til 'al dente'. Spar litt pastavann [1 dl | 2 dl] i en kopp og hell av resten. TIPS: Kokevannet bør være like salt som sjøvann. TIPS: 'Al dente' betyr at spaghettien er myk med litt tyggemotstand.",
      "I mellomtiden, skjær løk i tynne halve skiver. Riv squash grovt. Grovhakk tomat. Varm opp olivenolje [1/2 ss | 1 ss] i stekepannen brukt til reker på middels høy varme. Stek løk, squash, tomat, grønnsaksbuljong, salt [1/2 ts | 1 ts] og en klype pepper i 5-6 min, eller til mykt og vannet fra squash er absorbert.",
      "I mellomtiden, grovhakk basilikum. Skjær sitron [1/2 stk, 2P] i to.",
      "Tilsett matfløte [1/2 pakke, 2P], sitronsaft [1 ss | 2 ss], basilikum, spaghetti og halvparten av pastavann. Krydre med en klype salt og pepper. La putre i 1-2 min, eller til tyknet. Skyll ruccola [1/2 pose, 2P]. TIPS: Tilsett litt mer pastavann om retten ser tørr ut.",
      "Anrett spaghetti i skåler. Legg på reker og smørsaus samt ruccola. TIPS: Tilsett en skvett olivenolje om ønskelig."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Kok opp saltet vann i en stor kjele. Finhakk eller press hvitløk. Krydre reker med en klype salt. Varm opp olivenolje [1/2 ss | 1 ss] i en stor stekepanne på middels høy varme. Stek reker, hvitløk og chiliflak i 1-2 min på hver side, eller til gjennomstekt. Tilsett smør [1 ss | 2 ss] og la det smelte. Sett til side i en skål. TIPS: Rekene er ferdige når de er rosa på utsiden og matte inni.TIPS: Tilsett chiliflak etter smak - det er sterkt.\nKok spaghetti i 8-9 min, eller til 'al dente'. Spar litt pastavann [1 dl | 2 dl] i en kopp og hell av resten. TIPS: Kokevannet bør være like salt som sjøvann. TIPS: 'Al dente' betyr at spaghettien er myk med litt tyggemotstand.\nI mellomtiden, skjær løk i tynne halve skiver. Riv squash grovt. Grovhakk tomat. Varm opp olivenolje [1/2 ss | 1 ss] i stekepannen brukt til reker på middels høy varme. Stek løk, squash, tomat, grønnsaksbuljong, salt [1/2 ts | 1 ts] og en klype pepper i 5-6 min, eller til mykt og vannet fra squash er absorbert.\nI mellomtiden, grovhakk basilikum. Skjær sitron [1/2 stk, 2P] i to.\nTilsett matfløte [1/2 pakke, 2P], sitronsaft [1 ss | 2 ss], basilikum, spaghetti og halvparten av pastavann. Krydre med en klype salt og pepper. La putre i 1-2 min, eller til tyknet. Skyll ruccola [1/2 pose, 2P]. TIPS: Tilsett litt mer pastavann om retten ser tørr ut.\nAnrett spaghetti i skåler. Legg på reker og smørsaus samt ruccola. TIPS: Tilsett en skvett olivenolje om ønskelig.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hellofresh.no")
    expect(recipe.canonical_url).to eq("https://www.hellofresh.no/recipes/chilli-garlic-shrimp-spaghetti-659ebde670cc438cf4f78c7f")
    expect(recipe.site_name).to eq("HelloFresh")
    expect(recipe.language).to eq("nb-NO")
    expect(recipe.author).to eq("HelloFresh")
    expect(recipe.description).to eq("Det er vanskelig å ikke like spaghetti, og dagens middag har et minst like uimotståelig tilbehør. Vi steker reker sammen med hvitløk og chili, og lar dem smelte sammen med smør i pannen. Deretter blander vi spaghetti sammen med et smakfullt utvalg grønnsaker, blant annet revet squash, og en kremet saus av fløte, sitron og basilikum. Retten toppes med frisk ruccola.")
    expect(recipe.image).to eq("https://img.hellofresh.com/f_auto,fl_lossy,h_640,q_auto,w_1200/hellofresh_s3/image/HF_Y23_R16_W49_SE_K17354-3_Main_low-e32f6c51.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to eq("Italienske")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(25)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.382635681877309)
    expect(recipe.ratings_count).to eq(1105)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "692 kcal",
      "fatContent" => "30 g",
      "saturatedFatContent" => "14.1 g",
      "carbohydrateContent" => "74.9 g",
      "sugarContent" => "12.2 g",
      "proteinContent" => "26 g",
      "fiberContent" => "5.9 g",
      "sodiumContent" => "408 mg",
      "servingSize" => "498"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 692.0 },
      { name: "fatContent", unit: "g", amount: 30.0 },
      { name: "saturatedFatContent", unit: "g", amount: 14.1 },
      { name: "carbohydrateContent", unit: "g", amount: 74.9 },
      { name: "sugarContent", unit: "g", amount: 12.2 },
      { name: "proteinContent", unit: "g", amount: 26.0 },
      { name: "fiberContent", unit: "g", amount: 5.9 },
      { name: "sodiumContent", unit: "mg", amount: 408.0 },
      { name: "servingSize", unit: nil, amount: 498.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#page")
  end
end
