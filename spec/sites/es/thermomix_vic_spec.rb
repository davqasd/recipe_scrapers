# frozen_string_literal: true

RSpec.describe "thermomix-vic.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_vic", url: "https://thermomix-vic.es/yolanda-garrote-rierola/postres-y-dulces/berenars-per-triomfar") }

  it "reads the title" do
    expect(recipe.title).to eq("Berenars per triomfar!")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "100grs. de sucre glas",
      "100grs. de sucre",
      "15grs. cacau pur en pols",
      "120grs. de farina de reposteria",
      "50grs. de llet",
      "2 culleradetes de llevat en pols",
      "250grs. de mantega",
      "130grs. de formatge cremós",
      "1 polzim de sal",
      "2 culleradetes de vainilla liquida",
      "14 galetes sàndwich de xocolata ( tipus Oreo)",
      "2 ous"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 100.0, unit: "grs", name: "sucre glas" },
      { amount: 100.0, unit: "grs", name: "sucre" },
      { amount: 15.0, unit: "grs", name: "cacau pur en pols" },
      { amount: 120.0, unit: "grs", name: "farina de reposteria" },
      { amount: 50.0, unit: "grs", name: "llet" },
      { amount: 2.0, unit: nil, name: "culleradetes de llevat en pols" },
      { amount: 250.0, unit: "grs", name: "mantega" },
      { amount: 130.0, unit: "grs", name: "formatge cremós" },
      { amount: 1.0, unit: nil, name: "polzim de sal" },
      { amount: 2.0, unit: nil, name: "culleradetes de vainilla liquida" },
      { amount: 14.0, unit: nil, name: "galetes sàndwich de xocolata" },
      { amount: 2.0, unit: nil, name: "ous" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "PREPARACIÓ MASSAPreescalfeu el forn a 180°C. Col · loqueu 12 càpsules de magdalenes en un motlle de 12 muffins i reserveu",
      "Separeu les galetes de manera que una de les galetes quedi amb la crema i col·loqueu les 12 galetes a les càpsules de magdalena, amb la crema cap amunt.",
      "Poseu al got les 12 galetes (sense crema) i tritureu 10 seg/vel 10. Traieu i reserveu per al frosting.",
      "Poseu al got la farina, el cacau, el llevat i la sal i barregeu 5 seg/vel 5. Traieu a un bol i reservi.",
      "Poseu al got la farina, el cacau, el llevat i la sal i barregeu 5 seg/vel 5. Traieu a un bol i reservi.",
      "Afegiu els ous i barregeu 20 seg/vel 3. Incorporeu la llet i barregeu 30 seg/vel 3.Afegiu la barreja de farina i cacau i barregeu 10 seg/vel 4. Acabeu de barrejar amb l'espàtula. Poseu la barreja en una màniga pastissera i distribuïu-la a les càpsules de magdalenes que hem preparat anteriorment.Afegiu la barreja de farina i cacau i barregeu 10 seg/vel 4. Acabeu de barrejar amb l'espàtula. Poseu la barreja en una màniga pastissera i distribuïu-la a les càpsules de magdalenes que hem preparat anteriorment.Afegiu la barreja de farina i cacau i barregeu 10 seg/vel 4. Acabeu de barrejar amb l'espàtula. Poseu la barreja en una màniga pastissera i distribuïu-la a les càpsules de magdalenes que hem preparat anteriorment."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("PREPARACIÓ MASSAPreescalfeu el forn a 180°C. Col · loqueu 12 càpsules de magdalenes en un motlle de 12 muffins i reserveu\nSepareu les galetes de manera que una de les galetes quedi amb la crema i col·loqueu les 12 galetes a les càpsules de magdalena, amb la crema cap amunt.\nPoseu al got les 12 galetes (sense crema) i tritureu 10 seg/vel 10. Traieu i reserveu per al frosting.\nPoseu al got la farina, el cacau, el llevat i la sal i barregeu 5 seg/vel 5. Traieu a un bol i reservi.\nPoseu al got la farina, el cacau, el llevat i la sal i barregeu 5 seg/vel 5. Traieu a un bol i reservi.\nAfegiu els ous i barregeu 20 seg/vel 3. Incorporeu la llet i barregeu 30 seg/vel 3.Afegiu la barreja de farina i cacau i barregeu 10 seg/vel 4. Acabeu de barrejar amb l'espàtula. Poseu la barreja en una màniga pastissera i distribuïu-la a les càpsules de magdalenes que hem preparat anteriorment.Afegiu la barreja de farina i cacau i barregeu 10 seg/vel 4. Acabeu de barrejar amb l'espàtula. Poseu la barreja en una màniga pastissera i distribuïu-la a les càpsules de magdalenes que hem preparat anteriorment.Afegiu la barreja de farina i cacau i barregeu 10 seg/vel 4. Acabeu de barrejar amb l'espàtula. Poseu la barreja en una màniga pastissera i distribuïu-la a les càpsules de magdalenes que hem preparat anteriorment.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-vic.es")
    expect(recipe.canonical_url).to eq("https://thermomix-vic.es/yolanda-garrote-rierola/postres-y-dulces/berenars-per-triomfar")
    expect(recipe.site_name).to eq("Thermomix Vic")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("YOLANDA GARROTE RIEROLA")
    expect(recipe.description).to eq("Berenars per triomfar!, una receta de Postres y dulces, elaborada por YOLANDA GARROTE RIEROLA. Descubre las mejores recetas de Blogosfera Thermomix Vic")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/545f47dfc60f081f295af05a6a6236d7_c7a9f21588/545f47dfc60f081f295af05a6a6236d7_c7a9f21588.jpg")
    expect(recipe.category).to eq("Postres y dulces")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(1)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Berenars per triomfar!", "Postres y dulces"])
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
    expect(recipe.links).to include("https://blogosferathermomix.es/delegaciones-thermomix")
  end
end
