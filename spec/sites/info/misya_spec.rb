# frozen_string_literal: true

RSpec.describe "misya.info" do
  subject(:recipe) { scrape_cassette("info/misya", url: "https://www.misya.info/ricetta/tortino-cuore-caldo.htm") }

  it "reads the title" do
    expect(recipe.title).to eq("Tortino cuore caldo")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 di uova",
      "2 di tuorli",
      "100 gr di zucchero",
      "110 gr di cioccolato bianco",
      "110 gr di burro",
      "50 gr di farina",
      "6 gr di cacao",
      "1 cucchiaino di essenza di vaniglia",
      "1 cucchiaino di colorante rosso",
      "zucchero a velo"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: nil, name: "uova" },
      { amount: 2.0, unit: nil, name: "tuorli" },
      { amount: 100.0, unit: "gr", name: "zucchero" },
      { amount: 110.0, unit: "gr", name: "cioccolato bianco" },
      { amount: 110.0, unit: "gr", name: "burro" },
      { amount: 50.0, unit: "gr", name: "farina" },
      { amount: 6.0, unit: "gr", name: "cacao" },
      { amount: 1.0, unit: "cucchiaino", name: "essenza di vaniglia" },
      { amount: 1.0, unit: "cucchiaino", name: "colorante rosso" },
      { amount: nil, unit: nil, name: "zucchero a velo" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Montate i tuorli e le uova fino a renderle spumose.",
      "Poi aggiungete lo zucchero",
      "Poi unite il cioccolato ed il burro fuso.",
      "Aggiungete adesso il cacao e la farina.",
      "Quindi aggiungete il colorante e la vaniglia e mescolate fino ad ottenere un impasto di un bel colore rosso.",
      "Versate l'impasto in 6 stampini imburrati ed infarinati meticolosamente.",
      "Poi infornate i tortini in forno già caldo a 190° e cuocete per 13-15 minuti circa.Vi accorgerete quando è il momento giusto quando vedrete una leggera crosticina sui bordi e la superficie ma muovendo lo stampino risulterà ancora morbido.Fate la prova con uno prima di tirarli via dal forno tutti e ricordatevi che ogni forno è diverso dall'altro.",
      "Lasciate riposare un minuto, poi capovolgete su un piatto da dessert.",
      "Servite il Tortino cuore caldo immediatamente spolverizzandolo con zucchero a velo."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Montate i tuorli e le uova fino a renderle spumose.\nPoi aggiungete lo zucchero\nPoi unite il cioccolato ed il burro fuso.\nAggiungete adesso il cacao e la farina.\nQuindi aggiungete il colorante e la vaniglia e mescolate fino ad ottenere un impasto di un bel colore rosso.\nVersate l'impasto in 6 stampini imburrati ed infarinati meticolosamente.\nPoi infornate i tortini in forno già caldo a 190° e cuocete per 13-15 minuti circa.Vi accorgerete quando è il momento giusto quando vedrete una leggera crosticina sui bordi e la superficie ma muovendo lo stampino risulterà ancora morbido.Fate la prova con uno prima di tirarli via dal forno tutti e ricordatevi che ogni forno è diverso dall'altro.\nLasciate riposare un minuto, poi capovolgete su un piatto da dessert.\nServite il Tortino cuore caldo immediatamente spolverizzandolo con zucchero a velo.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("misya.info")
    expect(recipe.canonical_url).to eq("https://www.misya.info/ricetta/tortino-cuore-caldo.htm")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("it")
    expect(recipe.author).to eq("Flavia Imperatore")
    expect(recipe.description).to eq("Il tortino dal cuore caldo (o lava cake) è una delle ricette dolci che preferisco: dolce e scioglievole al punto giusto e sempre di effetto. Ne avevo già fatta una versione con il cioccolato fondente anni fa, e quest'anno ho pensato di proporne una nuova, fatta con il cioccolato bianco e romanticamente colorata di rosso, un dolce di un buono ma di un buono che mi ha conquistato al primo assaggio. A che stanno i vostri preparativi per domenica? Già scelto il menu di San Valentino? Se vi manca ancora il dolce potreste optare per questo romanticissimo e delizioso tortino rosso dal cuore morbido, una vera chicca per gli amanti del cioccolato bianco! Mi raccomando solo di stare attenti alla cottura, l'unica vera difficoltà di questo dolce. Quindi vi consiglio di fare la prova tirando via dal forno un solo tortino per poi passare agli altri. Ragazze io scappo, oggi ho un venerdì infuocato ;)")
    expect(recipe.image).to eq("https://www.misya.info/wp-content/uploads/2016/02/Tortino-cuore-caldo1.jpg")
    expect(recipe.category).to eq("Dolci")
    expect(recipe.cuisine).to eq("Italiana")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 items")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(["tortino cuore caldo", "ricetta tortino cuore caldo"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.8)
    expect(recipe.ratings_count).to eq(43)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#")
  end
end
