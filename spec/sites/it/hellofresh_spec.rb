# frozen_string_literal: true

RSpec.describe "hellofresh.it" do
  subject(:recipe) { scrape_cassette("it/hellofresh", url: "https://www.hellofresh.it/recipes/bowl-di-riso-con-carne-al-hoisin-coleslaw-e-cetriolo-argodolce-e-piccante-695d24095c0be345fe76a929") }

  it "reads the title" do
    expect(recipe.title).to eq("Bowl alla vietnamita di carne in salsa hoisin con riso Jasmine, cetrioli agrodolci e coleslaw")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 pacchetto Macinato misto di maiale e manzo",
      "150 g Riso Jasmine",
      "150 g Mix di Carote e Cavolo Cappuccio",
      "1 pezzo(i) Cetriolo",
      "1 pacchetto Salsa Hoisin",
      "1 pacchetto Arachidi",
      "1 pezzo(i) Peperoncino",
      "3 pacchetto Maionese",
      "230 ml Acqua per il riso",
      "q.b. Sale",
      "4 cucchiaio Aceto",
      "2 cucchiaino Zucchero",
      "q.b. Pepe",
      "q.b. Olio d'oliva"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: nil, name: "pacchetto Macinato misto di maiale e manzo" },
      { amount: 150.0, unit: "g", name: "Riso Jasmine" },
      { amount: 150.0, unit: "g", name: "Mix di Carote e Cavolo Cappuccio" },
      { amount: 1.0, unit: nil, name: "pezzo Cetriolo" },
      { amount: 1.0, unit: nil, name: "pacchetto Salsa Hoisin" },
      { amount: 1.0, unit: nil, name: "pacchetto Arachidi" },
      { amount: 1.0, unit: nil, name: "pezzo Peperoncino" },
      { amount: 3.0, unit: nil, name: "pacchetto Maionese" },
      { amount: 230.0, unit: "ml", name: "Acqua per il riso" },
      { amount: nil, unit: nil, name: "q.b. Sale" },
      { amount: 4.0, unit: "cucchiaio", name: "Aceto" },
      { amount: 2.0, unit: "cucchiaino", name: "Zucchero" },
      { amount: nil, unit: nil, name: "q.b. Pepe" },
      { amount: nil, unit: nil, name: "q.b. Olio d'oliva" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Seguite le quantità indicate a sinistra in base al numero di porzioni per preparare correttamente la ricetta! Raccogliete in un pentolino il riso con l'acqua per il riso. Unite un pizzico di sale, coprite con un coperchio e portate a bollore su fuoco medio-alto. Abbassate il fuoco al minimo e cuocete per 12 minuti, quindi spegnete e lasciate coperto fino al momento di servire.",
      "Tagliate il peperoncino a metà nel senso della lunghezza, rimuovete i semi e tritate finemente. I GUSTI SONO GUSTI: omettete il peperoncino se non gradite il piccante. Affettate il cetriolo a rondelle fini. Raccoglietelo in una ciotola con l'aceto, lo zucchero, un pizzico di sale e peperoncino tritato (dosate a piacere) e mescolate bene. In una seconda ciotola, condite il mix di carota e cavolo con olio, aceto, sale e pepe a piacere. Poi aggiungete la maionese e mescolate bene per amalgamare gli ingredienti.",
      "Scaldate una padella con filo d'olio a fuoco medio-alto. Unite il macinato di carne, condite con sale e pepe, mescolate per sgranare e cuocete per 7-8 minuti, finché la carne non è più rosa al centro. Aggiungete la salsa hoisin, mescolate e spegnete il fuoco. Assagiate e aggiustate di sale e pepe se necessario. Tritate le arachidi (oppure frantumatele direttamente nel loro sacchetto battendoci sopra con un cucchiaio di legno).",
      "Disponete il riso in piatti fondi o ciotole. Unite il mix di carote e cavolo, il cetriolo e la carne. Guarnite con le arachidi."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Seguite le quantità indicate a sinistra in base al numero di porzioni per preparare correttamente la ricetta! Raccogliete in un pentolino il riso con l'acqua per il riso. Unite un pizzico di sale, coprite con un coperchio e portate a bollore su fuoco medio-alto. Abbassate il fuoco al minimo e cuocete per 12 minuti, quindi spegnete e lasciate coperto fino al momento di servire.\nTagliate il peperoncino a metà nel senso della lunghezza, rimuovete i semi e tritate finemente. I GUSTI SONO GUSTI: omettete il peperoncino se non gradite il piccante. Affettate il cetriolo a rondelle fini. Raccoglietelo in una ciotola con l'aceto, lo zucchero, un pizzico di sale e peperoncino tritato (dosate a piacere) e mescolate bene. In una seconda ciotola, condite il mix di carota e cavolo con olio, aceto, sale e pepe a piacere. Poi aggiungete la maionese e mescolate bene per amalgamare gli ingredienti.\nScaldate una padella con filo d'olio a fuoco medio-alto. Unite il macinato di carne, condite con sale e pepe, mescolate per sgranare e cuocete per 7-8 minuti, finché la carne non è più rosa al centro. Aggiungete la salsa hoisin, mescolate e spegnete il fuoco. Assagiate e aggiustate di sale e pepe se necessario. Tritate le arachidi (oppure frantumatele direttamente nel loro sacchetto battendoci sopra con un cucchiaio di legno).\nDisponete il riso in piatti fondi o ciotole. Unite il mix di carote e cavolo, il cetriolo e la carne. Guarnite con le arachidi.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hellofresh.it")
    expect(recipe.canonical_url).to eq("https://www.hellofresh.it/recipes/bowl-di-riso-con-carne-al-hoisin-coleslaw-e-cetriolo-argodolce-e-piccante-695d24095c0be345fe76a929")
    expect(recipe.site_name).to eq("HelloFresh")
    expect(recipe.language).to eq("it-IT")
    expect(recipe.author).to eq("HelloFresh")
    expect(recipe.description).to eq("A base di zucchero, pasta di fagioli di soia fermentata, aglio, spezie e acqua, la salsa hoisin è un condimento tradizionale della cucina cinese. Dal gusto dolce-salato e aroma intenso, questa salsa scura e densa è ideale per glassare la carne o insaporire le verdure. Una curiosità: anche se letteralmente la parola hoisin significa 'frutti di mare', nella sua preparazione non c'è traccia di pesce, tanto che può essere mangiata anche da chi segue una dieta vegetariana. Vuoi sapere da dove arrivano i tuoi ingredienti? Scoprilo qui: https://www.hellofresh.it/about/ingredienti-produttori")
    expect(recipe.image).to eq("https://img.hellofresh.com/f_auto,fl_lossy,h_640,q_auto,w_1200/hellofresh_s3/image/HF_Y26_R13_W10_IT_IT51097-2_Main__9high-3a41ad8d.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to eq("Orientale")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(25)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.744318181818182)
    expect(recipe.ratings_count).to eq(11)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "1162 Kcal",
      "fatContent" => "63.5 g",
      "saturatedFatContent" => "19.5 g",
      "carbohydrateContent" => "79.9 g",
      "sugarContent" => "13.3 g",
      "proteinContent" => "62.3 g",
      "fiberContent" => "2.3 g",
      "sodiumContent" => "889.5 mg",
      "servingSize" => "618"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 1162.0 },
      { name: "fatContent", unit: "g", amount: 63.5 },
      { name: "saturatedFatContent", unit: "g", amount: 19.5 },
      { name: "carbohydrateContent", unit: "g", amount: 79.9 },
      { name: "sugarContent", unit: "g", amount: 13.3 },
      { name: "proteinContent", unit: "g", amount: 62.3 },
      { name: "fiberContent", unit: "g", amount: 2.3 },
      { name: "sodiumContent", unit: "mg", amount: 889.5 },
      { name: "servingSize", unit: nil, amount: 618.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#page")
  end
end
