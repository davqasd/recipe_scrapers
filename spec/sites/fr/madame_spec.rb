# frozen_string_literal: true

RSpec.describe "madame.lefigaro.fr" do
  subject(:recipe) { scrape_cassette("fr/madame", url: "https://madame.lefigaro.fr/recettes/sauce-tomate-maison-040204-198443") }

  it "reads the title" do
    expect(recipe.title).to eq("Sauce tomate maison facile")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "800 g de tomates",
      "2 oignons",
      "2 gousses ail",
      "8 brins de persil",
      "sel",
      "poivre du moulin",
      "basilic"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 800.0, unit: "g", name: "tomates" },
      { amount: 2.0, unit: nil, name: "oignons" },
      { amount: 2.0, unit: "gousses", name: "ail" },
      { amount: 8.0, unit: "brins", name: "persil" },
      { amount: nil, unit: nil, name: "sel" },
      { amount: nil, unit: nil, name: "poivre du moulin" },
      { amount: nil, unit: nil, name: "basilic" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Préparation des ingrédients: Lavez et coupez les tomates en petits morceaux. Pelez et émincez les oignons. Pelez et hachez l'ail. Lavez et hachez le persil et le basilic en petits morceaux.",
      "Préparation de la sauce: Versez les tomates et leur jus, les oignons, l'ail et le persil dans une casserole profonde. Portez à ébullition à feu vif, puis baissez le feu et couvrez partiellement. Laissez mijoter une vingtaine de minutes en mélangeant. Si la sauce réduit trop pendant la cuisson, n'hésitez pas à ajouter de l'eau.",
      "Assaisonnement: Passez la sauce au moulin à légumes. Ajoutez du sel, du poivre et du basilic. Remettez la sauce à mijoter pendant 5 minutes.",
      "Finitions: Ajoutez l'huile et sortez la casserole du feu."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Préparation des ingrédients: Lavez et coupez les tomates en petits morceaux. Pelez et émincez les oignons. Pelez et hachez l'ail. Lavez et hachez le persil et le basilic en petits morceaux.\nPréparation de la sauce: Versez les tomates et leur jus, les oignons, l'ail et le persil dans une casserole profonde. Portez à ébullition à feu vif, puis baissez le feu et couvrez partiellement. Laissez mijoter une vingtaine de minutes en mélangeant. Si la sauce réduit trop pendant la cuisson, n'hésitez pas à ajouter de l'eau.\nAssaisonnement: Passez la sauce au moulin à légumes. Ajoutez du sel, du poivre et du basilic. Remettez la sauce à mijoter pendant 5 minutes.\nFinitions: Ajoutez l'huile et sortez la casserole du feu.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("madame.lefigaro.fr")
    expect(recipe.canonical_url).to eq("https://madame.lefigaro.fr/recettes/sauce-tomate-maison-040204-198443")
    expect(recipe.site_name).to eq("Madame Figaro")
    expect(recipe.language).to eq("fr")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Quoi de mieux qu'une sauce tomate faite maison ? Des tomates, des oignons, de l'ail, du persil et le tour est joué !")
    expect(recipe.image).to eq("https://i.f1g.fr/media/cms/1200x_cropupscale/2024/04/11/1b71c2833a07c4e51e143ad1912a850a7f97624cc55d9bd53381514e470c0ed2.jpg")
    expect(recipe.category).to eq("Accompagnement")
    expect(recipe.cuisine).to eq("Grandes occasions")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 items")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(25)
    expect(recipe.keywords).to eq([
      "Italie",
      "recettes italiennes",
      "tomate",
      "sauce",
      "Accompagnement",
      "rapide",
      "Facile",
      "Grandes occasions",
      "Cuisine française",
      "idées repas",
      "idées recettes",
      "idées menus",
      "recette",
      "recette rapide",
      "recette simple",
      "recette entrée",
      "recette plat",
      "recette dessert",
      "recette entrée rapide",
      "recette entrée facile",
      "recette plat facile",
      "recette plat rapide",
      "recette dessert rapide",
      "actualité cuisine",
      "idées de menus",
      "recettes pour tous les jours",
      "idée repas",
      "que manger ce soir ?",
      "repas du soir",
      "recette du jour"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.0)
    expect(recipe.ratings_count).to eq(9636)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#fig-page")
  end
end
