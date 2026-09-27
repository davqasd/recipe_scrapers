# frozen_string_literal: true

RSpec.describe "marieclaire.fr" do
  subject(:recipe) { scrape_cassette("fr/marieclaire", url: "https://www.marieclaire.fr/cuisine/recette-de-dumpling-bake-cremeux-au-miso-et-aux-herbes,1519177.asp") }

  it "reads the title" do
    expect(recipe.title).to eq("Ajoutez une cuillère de miso à la sauce de vos raviolis : ce petit ingrédient change tout")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "20 dumplings ou gyozas surgelés",
      "20 cl de crème liquide",
      "20 cl de bouillon de légumes",
      "1 belle c. à soupe de miso blanc",
      "1 c. à soupe de sauce soja",
      "1 c. à café d’huile de sésame",
      "1 petite gousse d’ail",
      "1 petit morceau de gingembre frais",
      "2 cébettes",
      "Quelques brins de coriandre ou d’aneth",
      "Poivre"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 20.0, unit: nil, name: "dumplings ou gyozas surgelés" },
      { amount: 20.0, unit: "cl", name: "crème liquide" },
      { amount: 20.0, unit: "cl", name: "bouillon de légumes" },
      { amount: 1.0, unit: nil, name: "belle c. à soupe de miso blanc" },
      { amount: 1.0, unit: "c. à soupe", name: "sauce soja" },
      { amount: 1.0, unit: "c. à café", name: "d’huile de sésame" },
      { amount: 1.0, unit: nil, name: "petite gousse d’ail" },
      { amount: 1.0, unit: nil, name: "petit morceau de gingembre frais" },
      { amount: 2.0, unit: nil, name: "cébettes" },
      { amount: nil, unit: nil, name: "Quelques brins de coriandre ou d’aneth" },
      { amount: nil, unit: nil, name: "Poivre" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Préchauffez le four à 200 °C.",
      "Dans un plat à gratin, délayez le miso avec le bouillon. Ajoutez la crème liquide, la sauce soja, l’huile de sésame, l’ail et le gingembre finement râpés. Mélangez.",
      "Disposez les dumplings encore surgelés dans la sauce, sans les superposer.",
      "Couvrez hermétiquement le plat de papier aluminium et enfournez pendant 15 minutes.",
      "Retirez le papier aluminium et poursuivez la cuisson pendant 8 à 10 minutes, jusqu’à ce que les raviolis soient cuits et la sauce crémeuse.",
      "Parsemez généreusement de cébettes et d’herbes fraîches avant de servir."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Préchauffez le four à 200 °C.\nDans un plat à gratin, délayez le miso avec le bouillon. Ajoutez la crème liquide, la sauce soja, l’huile de sésame, l’ail et le gingembre finement râpés. Mélangez.\nDisposez les dumplings encore surgelés dans la sauce, sans les superposer.\nCouvrez hermétiquement le plat de papier aluminium et enfournez pendant 15 minutes.\nRetirez le papier aluminium et poursuivez la cuisson pendant 8 à 10 minutes, jusqu’à ce que les raviolis soient cuits et la sauce crémeuse.\nParsemez généreusement de cébettes et d’herbes fraîches avant de servir.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("marieclaire.fr")
    expect(recipe.canonical_url).to eq("https://www.marieclaire.fr/cuisine/recette-de-dumpling-bake-cremeux-au-miso-et-aux-herbes,1519177.asp")
    expect(recipe.site_name).to eq("Marie Claire")
    expect(recipe.language).to eq("fr")
    expect(recipe.author).to eq("Cuisine et Vins de France")
    expect(recipe.description).to eq("Ici, pas de curry ni de lait de coco : les dumplings cuisent directement au four dans une sauce crémeuse relevée de miso, puis sont servis avec une belle poignée d’herbes fraîches. Une variante douce et très parfumée du fameux « dumpling bake », prête sans passer des heures aux fourneaux.")
    expect(recipe.image).to eq("https://cache.marieclaire.fr/data/photo/w1200_h630_c17/7g/recette-dumpling-bake-cremeux-miso-aux-herbes.jpg")
    expect(recipe.category).to eq("Plat")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(25)
    expect(recipe.keywords).to be_nil
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
    expect(recipe.links).to include("https://x.com/Cuisine_VinsdeF")
  end
end
