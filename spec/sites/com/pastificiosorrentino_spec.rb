# frozen_string_literal: true

RSpec.describe "pastificiosorrentino.com" do
  subject(:recipe) { scrape_cassette("com/pastificiosorrentino", url: "https://www.pastificiosorrentino.com/ricetta-degli-ziti-lunghi-lardiati/") }

  it "reads the title" do
    expect(recipe.title).to eq("Pasta Ziti lunghi lardiati")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "500 gr di Ziti lunghi IGP Oro di Gragnano",
      "150 gr di lardo di colonnata",
      "40g di parmigiano",
      "1 Cipolla ramata",
      "200 gr di Pomodorino ciliegino",
      "Basilico q.b",
      "Sale q.b.",
      "Pepe nero q.b.",
      "Olio extravergine di oliva q.b."
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 500.0, unit: "gr", name: "Ziti lunghi IGP Oro di Gragnano" },
      { amount: 150.0, unit: "gr", name: "lardo di colonnata" },
      { amount: 40.0, unit: "g", name: "parmigiano" },
      { amount: 1.0, unit: nil, name: "Cipolla ramata" },
      { amount: 200.0, unit: "gr", name: "Pomodorino ciliegino" },
      { amount: nil, unit: nil, name: "Basilico q.b" },
      { amount: nil, unit: nil, name: "Sale q.b." },
      { amount: nil, unit: nil, name: "Pepe nero q.b." },
      { amount: nil, unit: nil, name: "Olio extravergine di oliva q.b." }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preparazione",
      "Preparare un soffritto con la cipolla ramata tritata e il lardo di colonnata (ricordate che il lardo deve diventare quasi trasparente). Tagliate i pomodorini e a spicchi e aggiungeteli al soffritto e proseguite la cottura a fiamma lenta.",
      "Nel frattempo portate ad ebollizione l’acqua e iniziate a spezzare gli ziti. La lunghezza giusta è quella di quattro dita.",
      "Versate la pasta nell’acqua attendete 9 min, scolatela e poi aggiungetela alla padella con il soffritto, mantecate e aggiungete parmigiano e pepe. Guarnite il piatto con una foglia di basilico."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preparazione\nPreparare un soffritto con la cipolla ramata tritata e il lardo di colonnata (ricordate che il lardo deve diventare quasi trasparente). Tagliate i pomodorini e a spicchi e aggiungeteli al soffritto e proseguite la cottura a fiamma lenta.\nNel frattempo portate ad ebollizione l’acqua e iniziate a spezzare gli ziti. La lunghezza giusta è quella di quattro dita.\nVersate la pasta nell’acqua attendete 9 min, scolatela e poi aggiungetela alla padella con il soffritto, mantecate e aggiungete parmigiano e pepe. Guarnite il piatto con una foglia di basilico.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("pastificiosorrentino.com")
    expect(recipe.canonical_url).to eq("https://www.pastificiosorrentino.com/ricetta-degli-ziti-lunghi-lardiati/")
    expect(recipe.site_name).to eq("Pastificio Sorrentino Gragnano")
    expect(recipe.language).to eq("it-IT")
    expect(recipe.author).to eq("PSAdmin")
    expect(recipe.description).to eq("Ricetta della pasta Ziti lunghi lardiati (con lardo di colonnata): un primo piatto con pochi ingredienti, ma ricco di tradizione e gusto.")
    expect(recipe.image).to eq("https://www.pastificiosorrentino.com/wp-content/uploads/2020/09/news_01jpg_170411034325_JFZI.jpg")
    expect(recipe.category).to eq("Primi")
    expect(recipe.cuisine).to eq("Italiana")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(24)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(9)
    expect(recipe.keywords).to eq(["ricette con ziti", "ziti lardiati", "lardiata napoletana"])
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
    expect(recipe.links).to include("#come_preparare_gli_ziti_lunghi_lardiati")
  end
end
