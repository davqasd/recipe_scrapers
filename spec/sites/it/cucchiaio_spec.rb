# frozen_string_literal: true

RSpec.describe "cucchiaio.it" do
  subject(:recipe) { scrape_cassette("it/cucchiaio", url: "https://www.cucchiaio.it/ricetta/pesce-spada-al-miele-millefiori-pomodorini-e-patatine-novelle/") }

  it "reads the title" do
    expect(recipe.title).to eq("Pesce spada al miele millefiori, pomodorini e patatine novelle")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 fette di pesce spada di circa 200 g l'una",
      "20 patatine novelle",
      "1 spicchio d'aglio",
      "1 grappolo di pomodorini",
      "2 cucchiai di pinoli tostati",
      "4-5 cucchiaini di miele millefiori",
      "1 bicchiere di aceto di vino",
      "foglioline di mirto",
      "prezzemolo",
      "erba cipollina",
      "olio extravergine di oliva",
      "sale",
      "pepe"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: "fette", name: "pesce spada di circa 200 g l'una" },
      { amount: 20.0, unit: nil, name: "patatine novelle" },
      { amount: 1.0, unit: "spicchio", name: "d'aglio" },
      { amount: 1.0, unit: "grappolo", name: "pomodorini" },
      { amount: 2.0, unit: "cucchiai", name: "pinoli tostati" },
      { amount: 4.0, unit: "cucchiaini", name: "miele millefiori" },
      { amount: 1.0, unit: "bicchiere", name: "aceto di vino" },
      { amount: nil, unit: nil, name: "foglioline di mirto" },
      { amount: nil, unit: nil, name: "prezzemolo" },
      { amount: nil, unit: nil, name: "erba cipollina" },
      { amount: nil, unit: nil, name: "olio extravergine di oliva" },
      { amount: nil, unit: nil, name: "sale" },
      { amount: nil, unit: nil, name: "pepe" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Iniziate la preparazione del pesce spada al miele millefiori, pomodorini e patatine novelle mettendo a marinare le fette di pesce. Poggiatele su un piatto, aggiungete alcune foglie di mirto, l'aglio a fettine, un giro d'olio e lasciatele marinare per dieci minuti. In un tegame scaldate tre cucchiai d'olio, adagiatevi le fette di pesce spada e cuocetele per circa 2 minuti per lato o comunque fino a quando si forma una crosticina. Trasferitele su una teglia e passatele per circa 5 minuti in forno a 200°. Sfornatele e fatele riposare al caldo per una decina di minuti.",
      "Intanto tagliate a cubetti i pomodorini, cospargeteli con un po' di sale, un pizzico di pepe, prezzemolo ed erba cipollina tritati finemente. Preparate la salsina al miele: in una casseruola scaldate l'aceto facendolo ridurre di un quarto, aggiungete il miele millefiori e assaggiate per controllarne il sapore, se troppo agro aggiungete altro miele. Lasciate raffreddare.",
      "Infine, incorporate il tutto ai pomodori, mescolate bene, aggiungete olio, pinoli, regolate di sale e fate riposare. Sbollentate le patatine in acqua salata, asciugatele e insaporitele in una padella con un filo d’olio.",
      "Disponete le fette di pesce spada sul piatto da portata: completate con le patatine e cospargete su tutto la salsina al miele."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Iniziate la preparazione del pesce spada al miele millefiori, pomodorini e patatine novelle mettendo a marinare le fette di pesce. Poggiatele su un piatto, aggiungete alcune foglie di mirto, l'aglio a fettine, un giro d'olio e lasciatele marinare per dieci minuti. In un tegame scaldate tre cucchiai d'olio, adagiatevi le fette di pesce spada e cuocetele per circa 2 minuti per lato o comunque fino a quando si forma una crosticina. Trasferitele su una teglia e passatele per circa 5 minuti in forno a 200°. Sfornatele e fatele riposare al caldo per una decina di minuti.\nIntanto tagliate a cubetti i pomodorini, cospargeteli con un po' di sale, un pizzico di pepe, prezzemolo ed erba cipollina tritati finemente. Preparate la salsina al miele: in una casseruola scaldate l'aceto facendolo ridurre di un quarto, aggiungete il miele millefiori e assaggiate per controllarne il sapore, se troppo agro aggiungete altro miele. Lasciate raffreddare.\nInfine, incorporate il tutto ai pomodori, mescolate bene, aggiungete olio, pinoli, regolate di sale e fate riposare. Sbollentate le patatine in acqua salata, asciugatele e insaporitele in una padella con un filo d’olio.\nDisponete le fette di pesce spada sul piatto da portata: completate con le patatine e cospargete su tutto la salsina al miele.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cucchiaio.it")
    expect(recipe.canonical_url).to eq("https://www.cucchiaio.it/ricetta/pesce-spada-al-miele-millefiori-pomodorini-e-patatine-novelle/")
    expect(recipe.site_name).to eq("Il Cucchiaio d'Argento")
    expect(recipe.language).to eq("it")
    expect(recipe.author).to eq("Il Cucchiaio d'Argento")
    expect(recipe.description).to eq("Quella del pesce spada al miele millefiori, pomodorini e patatine novelle è la ricetta originale di un secondo piatto sano e leggero. Un abbinamento inusuale che conquista grazie alla freschezza dei sapori ben equilibrati e alla facilità di esecuzione.")
    expect(recipe.image).to eq("https://www.cucchiaio.it/content/cucchiaio/it/ricette/2017/10/pesce-spada-al-miele-millefiori-pomodorini-e-patatine-novelle/jcr:content/header-par/image-single.img10.jpg/1610381008015.jpg")
    expect(recipe.category).to eq("Secondi")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 items")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(["Pesce spada al miele millefiori", "pomodorini e patatine novelle"])
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
    expect(recipe.links).to include("https://www.shoped.it/shop/i-nostri-brand/?testata=cucchiaiodargento#logo-testata")
  end
end
