# frozen_string_literal: true

RSpec.describe "recepti.index.hr" do
  subject(:recipe) { scrape_cassette("hr/recepti", url: "https://recepti.index.hr/recept/1244-preokrenuti-kolac-od-sljiva") }

  it "reads the title" do
    expect(recipe.title).to eq("Preokrenuti kolač od šljiva")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "500 g šljiva",
      "2 jaja",
      "100 g otopljenog maslaca",
      "1 tekući jogurt",
      "130 g šećera",
      "150 g glatkog brašna",
      "100 g mljevenih badema",
      "undefined vrećice praška za pecivo",
      "1 žličica cejlonskog cimeta"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 500.0, unit: "g", name: "šljiva" },
      { amount: 2.0, unit: nil, name: "jaja" },
      { amount: 100.0, unit: "g", name: "otopljenog maslaca" },
      { amount: 1.0, unit: nil, name: "tekući jogurt" },
      { amount: 130.0, unit: "g", name: "šećera" },
      { amount: 150.0, unit: "g", name: "glatkog brašna" },
      { amount: 100.0, unit: "g", name: "mljevenih badema" },
      { amount: nil, unit: nil, name: "undefined vrećice praška za pecivo" },
      { amount: 1.0, unit: nil, name: "žličica cejlonskog cimeta" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Pripremite šljive",
      "Šljive operite, prepolovite i izvadite koštice. Pećnicu zagrijte na 180 stupnjeva.",
      "Pecite šljive",
      "Okrugli kalup za torte obložite papirom za pečenje i pospite s 2 žlice šećera. Šljive poslažite u kalup prerezanim dijelom prema dolje i stavite u pećnicu na 15 minuta.",
      "Pomiješajte",
      "Pripremite dvije zdjele i u jednoj pomiješajte brašno, prašak za pecivo, cimet i mljevene bademe. U drugoj zdjeli miksajte jaja i šećer pa dodajte otopljeni maslac i jogurt, a zatim sastojke sjedinite pjenjačom. U zdjelu s mokrim sastojcima dodajte suhe i dobro promiješajte.",
      "Pecite",
      "Dobivenu smjesu prelijte preko pečenih šljiva i vratite u pećnicu na 35 do 40 minuta.",
      "Preokrenite",
      "Pečen kolač izvadite iz pećnice i ostavite da se kratko ohladi. Na kalup stavite tanjur za serviranje i preokrenite. Oprezno uklonite papir za pečenje, narežite i poslužite."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Pripremite šljive\nŠljive operite, prepolovite i izvadite koštice. Pećnicu zagrijte na 180 stupnjeva.\nPecite šljive\nOkrugli kalup za torte obložite papirom za pečenje i pospite s 2 žlice šećera. Šljive poslažite u kalup prerezanim dijelom prema dolje i stavite u pećnicu na 15 minuta.\nPomiješajte\nPripremite dvije zdjele i u jednoj pomiješajte brašno, prašak za pecivo, cimet i mljevene bademe. U drugoj zdjeli miksajte jaja i šećer pa dodajte otopljeni maslac i jogurt, a zatim sastojke sjedinite pjenjačom. U zdjelu s mokrim sastojcima dodajte suhe i dobro promiješajte.\nPecite\nDobivenu smjesu prelijte preko pečenih šljiva i vratite u pećnicu na 35 do 40 minuta.\nPreokrenite\nPečen kolač izvadite iz pećnice i ostavite da se kratko ohladi. Na kalup stavite tanjur za serviranje i preokrenite. Oprezno uklonite papir za pečenje, narežite i poslužite.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("recepti.index.hr")
    expect(recipe.canonical_url).to eq("https://recepti.index.hr/recept/1244-preokrenuti-kolac-od-sljiva")
    expect(recipe.site_name).to eq("Index Recepti")
    expect(recipe.language).to eq("hr")
    expect(recipe.author).to eq("Index Recepti")
    expect(recipe.description).to eq("Pripremite ovaj jednostavan i sočan kolač u kojem su glavne zvijezde – šljive. Po želji u biskvit dodajte limunovu koricu, a poslužiti ga možete uz čaj ili kavu. Za pripremu ovog ukusnog kolača trebat će vam samo 15 minuta.")
    expect(recipe.image).to eq("https://recepti-api.index.hr/img/preview/large/recipe/2fb66220-6c30-40a8-ab95-5226f48ba3fb/shutterstock_1497370493.jpg")
    expect(recipe.category).to eq("Deserti")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(55)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(40)
    expect(recipe.keywords).to eq(%w[glavne limunovu ovog])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.0)
    expect(recipe.ratings_count).to eq(7)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
