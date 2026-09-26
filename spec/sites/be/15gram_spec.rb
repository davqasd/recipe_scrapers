# frozen_string_literal: true

RSpec.describe "15gram.be" do
  subject(:recipe) { scrape_cassette("be/15gram", url: "https://15gram.be/recepten/mac-n-cheese-met-gehakt-en-pompoen") }

  it "reads the title" do
    expect(recipe.title).to eq("Mac 'n cheese met gehakt en pompoen")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "400 gr pompoenblokjes",
      "1 teentje knoflook",
      "300 gr rund-varkensgehakt",
      "200 gr tortiglioni pasta",
      "150 gr zure room",
      "75 gr geraspte cheddar",
      "olijfolie",
      "zout",
      "zwarte peper"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 400.0, unit: "gr", name: "pompoenblokjes" },
      { amount: 1.0, unit: "teentje", name: "knoflook" },
      { amount: 300.0, unit: "gr", name: "rund-varkensgehakt" },
      { amount: 200.0, unit: "gr", name: "tortiglioni pasta" },
      { amount: 150.0, unit: "gr", name: "zure room" },
      { amount: 75.0, unit: "gr", name: "geraspte cheddar" },
      { amount: nil, unit: nil, name: "olijfolie" },
      { amount: nil, unit: nil, name: "zout" },
      { amount: nil, unit: nil, name: "zwarte peper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Breng een ruime pot gezouten water aan de kook voor de pasta.",
      "Verwarm de oven voor op 220°C en bedek een bakplaat met bakpapier.",
      "Schik de pompoenblokjes op de bakplaat en pers de knoflook erbij. Hussel door elkaar met olijfolie, zout en zwarte peper. Rooster in 20 min. gaar in de oven.",
      "Verhit een scheutje olijfolie in een pan op hoog vuur. Bak het gehakt in 6-8 min. Prak met een spatel in \"chunks\", het hoeft niet helemaal fijn te zijn.",
      "Kook de pasta volgens de instructies op de verpakking.",
      "Schik de geroosterde pompoen in een blender of maatbeker en mix, samen met de zure room en de helft van de geraspte cheddar, tot een gladde saus. Proef en breng op smaak met extra zout of zwarte peper (zie tip).",
      "Giet de pasta af en schik opnieuw in de pot. Meng met de roomsaus en het gehakt. Stort in een ovenschaal en strooi de rest van de kaas erover. Gratineer nog 5-10 min. in de oven voor een mooi kaaskorstje.",
      "TIP: Geef de saus wat extra punch met paprikapoeder, chilivlokken of bouillon."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Breng een ruime pot gezouten water aan de kook voor de pasta.\nVerwarm de oven voor op 220°C en bedek een bakplaat met bakpapier.\nSchik de pompoenblokjes op de bakplaat en pers de knoflook erbij. Hussel door elkaar met olijfolie, zout en zwarte peper. Rooster in 20 min. gaar in de oven.\nVerhit een scheutje olijfolie in een pan op hoog vuur. Bak het gehakt in 6-8 min. Prak met een spatel in \"chunks\", het hoeft niet helemaal fijn te zijn.\nKook de pasta volgens de instructies op de verpakking.\nSchik de geroosterde pompoen in een blender of maatbeker en mix, samen met de zure room en de helft van de geraspte cheddar, tot een gladde saus. Proef en breng op smaak met extra zout of zwarte peper (zie tip).\nGiet de pasta af en schik opnieuw in de pot. Meng met de roomsaus en het gehakt. Stort in een ovenschaal en strooi de rest van de kaas erover. Gratineer nog 5-10 min. in de oven voor een mooi kaaskorstje.\nTIP: Geef de saus wat extra punch met paprikapoeder, chilivlokken of bouillon.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("15gram.be")
    expect(recipe.canonical_url).to eq("https://15gram.be/recepten/mac-n-cheese-met-gehakt-en-pompoen")
    expect(recipe.site_name).to eq("15gram")
    expect(recipe.language).to eq("nl")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("We nemen je mee op skivakantie! Of toch naar de après-ski maaltijd. De pompoenblokjes zijn al voorgesneden en mixen we door de saus. Daardoor kleurt die ook mooi oranje!")
    expect(recipe.image).to eq("https://image.15gram.be/uploads/recipes/5193_1706264487-1920x1280.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(%w[Foodbag gehakt pasta pompoen skikost])
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
    expect(recipe.links).to include("https://15gram.be")
  end
end
