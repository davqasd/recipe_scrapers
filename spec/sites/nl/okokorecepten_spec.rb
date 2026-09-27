# frozen_string_literal: true

RSpec.describe "okokorecepten.nl" do
  subject(:recipe) { scrape_cassette("nl/okokorecepten", url: "https://www.okokorecepten.nl/recept/toetjes/appel/appels-krenten-bruine-suiker-oven-tana-ramsay") }

  it "reads the title" do
    expect(recipe.title).to eq("Appels met krenten en bruine suiker uit de oven van Tana Ramsay")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 moesappels",
      "2 eetlepels donkere basterdsuiker",
      "handvol krenten",
      "sap van 1 citroen",
      "4 klontjes boter"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: nil, name: "moesappels" },
      { amount: 2.0, unit: "eetlepels", name: "donkere basterdsuiker" },
      { amount: nil, unit: nil, name: "handvol krenten" },
      { amount: nil, unit: nil, name: "sap van 1 citroen" },
      { amount: 4.0, unit: nil, name: "klontjes boter" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Verwarm de oven voor op 160 °C. Boor zorgvuldig het klokhuis uit de appels. Beboter een ovenschaal en zet de appels erin.",
      "Meng in een kommetje de suiker met de krenten en vul daarmee de uitgeboorde appels. Sprenkel het citroensap over de appels en leg een klontje boter op de vulling.",
      "Kerf met een scherp mes de schil van de appels halverwege rondom in. Zo voorkom je dat ze halverwege het braden uit elkaar barsten.",
      "Zet de appels ca. 25 minuten in de oven, tot je ziet dat ze zacht zijn en het sap eruit loopt. Laat ze voor het serveren enigszins afkoelen. Heerlijk met slagroom, crème fraîche of ijs."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Verwarm de oven voor op 160 °C. Boor zorgvuldig het klokhuis uit de appels. Beboter een ovenschaal en zet de appels erin.\nMeng in een kommetje de suiker met de krenten en vul daarmee de uitgeboorde appels. Sprenkel het citroensap over de appels en leg een klontje boter op de vulling.\nKerf met een scherp mes de schil van de appels halverwege rondom in. Zo voorkom je dat ze halverwege het braden uit elkaar barsten.\nZet de appels ca. 25 minuten in de oven, tot je ziet dat ze zacht zijn en het sap eruit loopt. Laat ze voor het serveren enigszins afkoelen. Heerlijk met slagroom, crème fraîche of ijs.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("okokorecepten.nl")
    expect(recipe.canonical_url).to eq("https://www.okokorecepten.nl/recept/toetjes/appel/appels-krenten-bruine-suiker-oven-tana-ramsay")
    expect(recipe.site_name).to eq("okoko recepten")
    expect(recipe.language).to eq("nl")
    expect(recipe.author).to eq("Tana Ramsay")
    expect(recipe.description).to eq("Tana Ramsay's appels met krenten en bruine suiker uit de oven, uit het kookboek 'Tana Ramsay's familiekeuken'. Kijk voor de bereidingswijze op okokorecepten.nl.")
    expect(recipe.image).to eq("https://www.okokorecepten.nl/i/recepten/kookboeken/2008/tana-ramsays-familiekeuken/appels-krenten-bruine-suiker-oven-tana-ramsay-500.jpg")
    expect(recipe.category).to eq("Nagerecht")
    expect(recipe.cuisine).to eq("Hollands")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(35)
    expect(recipe.keywords).to eq(["appels recept", "tana ramsay's appels met krenten en bruine suiker uit de oven", "tana", "ramsay's", "appels", "krenten", "bruine", "suiker", "oven", "frans", "nagerecht", "vegetarisch", "tana ramsay", "toetjes", "moesappels", "basterdsuiker", "citroen", "boter"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(8.0)
    expect(recipe.ratings_count).to eq(37)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
