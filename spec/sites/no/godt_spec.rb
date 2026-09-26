# frozen_string_literal: true

RSpec.describe "godt.no" do
  subject(:recipe) { scrape_cassette("no/godt", url: "https://www.godt.no/oppskrifter/pannekaker-og-vafler/8749/grove-middagspannekaker") }

  it "reads the title" do
    expect(recipe.title).to eq("Grove pannekaker - Perfekt middag")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 stk egg",
      "2 ss sukker",
      "2 ss smør",
      "1 l lettmelk",
      "2.5 dl fint sammalt hvetemel",
      "3.5 dl hvetemel",
      "1 dl havregryn"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: "stk", name: "egg" },
      { amount: 2.0, unit: "ss", name: "sukker" },
      { amount: 2.0, unit: "ss", name: "smør" },
      { amount: 1.0, unit: "l", name: "lettmelk" },
      { amount: 2.5, unit: "dl", name: "fint sammalt hvetemel" },
      { amount: 3.5, unit: "dl", name: "hvetemel" },
      { amount: 1.0, unit: "dl", name: "havregryn" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Pisk sammen egg, sukker, smeltet smør og halvparten av melken. Rør inn fin sammalt hvete. Bland inn hvetemelet og spe med resten av melken. Vend inn havregryn til slutt. La deigen stå og svelle i en halvtime.",
      "Stek tynne pannekaker i stekepanne på middels varme. Bruk litt smør eller formfett til stekingen dersom du ikke har en god teflonpanne. Serveres nystekte!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Pisk sammen egg, sukker, smeltet smør og halvparten av melken. Rør inn fin sammalt hvete. Bland inn hvetemelet og spe med resten av melken. Vend inn havregryn til slutt. La deigen stå og svelle i en halvtime.\nStek tynne pannekaker i stekepanne på middels varme. Bruk litt smør eller formfett til stekingen dersom du ikke har en god teflonpanne. Serveres nystekte!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("godt.no")
    expect(recipe.canonical_url).to eq("https://www.godt.no/oppskrifter/pannekaker-og-vafler/8749/grove-middagspannekaker")
    expect(recipe.site_name).to eq("godt.no")
    expect(recipe.language).to eq("nb-NO")
    expect(recipe.author).to eq("Kristine Ilstad - Det søte liv")
    expect(recipe.description).to eq("Grove pannekaker er en hit hos både store og små! Middagspannekaker kan serveres med salte eller søte toppinger og gjør seg godt i matpakken. Se oppskrift her!")
    expect(recipe.image).to eq("https://img.godt.no/w2000/plain/recipes/42%2F425b83de-49b1-4807-973d-a0fe0cb3a818")
    expect(recipe.category).to eq("middag")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(60)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Pannekaker og vafler", "Hverdag", "Vegetar", "Enkel"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.32)
    expect(recipe.ratings_count).to eq(25)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#maincontent")
  end
end
