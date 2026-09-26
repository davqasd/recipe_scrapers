# frozen_string_literal: true

RSpec.describe "sundpaabudget.dk" do
  subject(:recipe) { scrape_cassette("dk/sundpaabudget", url: "https://sundpaabudget.dk/one-pot-pasta-med-kyllingekebab/") }

  it "reads the title" do
    expect(recipe.title).to eq("One pot pasta med kyllingekebab")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "300 g kyllingekebab",
      "1 spsk olie",
      "2 alm. løg",
      "2 tomater",
      "2 peberfrugter",
      "300 g fuldkornsspaghetti (el. pasta)",
      "125 g flødeost m. hvidløg",
      "7 dl vand",
      "1 bouillonterning",
      "0,5 tsk spidskommen",
      "0,5 tsk paprika (evt. røget)",
      "chili eller cayennepeber efter smag",
      "salt og peber"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 300.0, unit: "g", name: "kyllingekebab" },
      { amount: 1.0, unit: "spsk", name: "olie" },
      { amount: 2.0, unit: nil, name: "alm. løg" },
      { amount: 2.0, unit: nil, name: "tomater" },
      { amount: 2.0, unit: nil, name: "peberfrugter" },
      { amount: 300.0, unit: "g", name: "fuldkornsspaghetti" },
      { amount: 125.0, unit: "g", name: "flødeost m. hvidløg" },
      { amount: 7.0, unit: "dl", name: "vand" },
      { amount: 1.0, unit: nil, name: "bouillonterning" },
      { amount: 0.5, unit: "tsk", name: "spidskommen" },
      { amount: 0.5, unit: "tsk", name: "paprika" },
      { amount: nil, unit: nil, name: "chili eller cayennepeber efter smag" },
      { amount: nil, unit: nil, name: "salt og peber" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Rengør og hak løg, peberfrugt og tomater i tern.",
      "Opvarm olie i en stor gryde og svits kyllingekebaben et par minutter. Tilsæt grøntsagerne og lad det svitse med yderligere 2 minutter.",
      "Tilsæt spaghetti, flødeost, vand, bouillonterning og krydderier.",
      "Lad retten simre ved middelvarme til spaghettien er aldente og vandet er kogt næsten ind til en cremet sauce.",
      "Smag til med salt og peber."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Rengør og hak løg, peberfrugt og tomater i tern.\nOpvarm olie i en stor gryde og svits kyllingekebaben et par minutter. Tilsæt grøntsagerne og lad det svitse med yderligere 2 minutter.\nTilsæt spaghetti, flødeost, vand, bouillonterning og krydderier.\nLad retten simre ved middelvarme til spaghettien er aldente og vandet er kogt næsten ind til en cremet sauce.\nSmag til med salt og peber.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("sundpaabudget.dk")
    expect(recipe.canonical_url).to eq("https://sundpaabudget.dk/one-pot-pasta-med-kyllingekebab/")
    expect(recipe.site_name).to eq("Sund på budget")
    expect(recipe.language).to eq("da-DK")
    expect(recipe.author).to eq("Britt // Sund på budget")
    expect(recipe.description).to eq("Nem og lækker one pot med kyllingekebab (du kan også bruge okse/lam, hvis du hellere vil det).")
    expect(recipe.image).to eq("https://sundpaabudget.dk/wp-content/uploads/2021/08/20210803123311_IMG_0714.jpg")
    expect(recipe.category).to eq("Kylling")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.05)
    expect(recipe.ratings_count).to eq(46)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "calories" => "300 kcal", "servingSize" => "1 person" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 300.0 },
      { name: "servingSize", unit: "person", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.facebook.com/sundpaabudget")
  end
end
