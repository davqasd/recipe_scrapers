# frozen_string_literal: true

RSpec.describe "kiddokitchen.se" do
  subject(:recipe) { scrape_cassette("se/kiddokitchen", url: "https://kiddokitchen.se/recept/pasta-med-broccolipesto") }

  it "reads the title" do
    expect(recipe.title).to eq("Pasta med broccolipesto")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "75 g Broccoli",
      "0.5 st Vitlöksklyfta",
      "1 dl Parmesan",
      "1 näve Färsk Basilika",
      "2.5 msk Olivolja",
      "Citron"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 75.0, unit: "g", name: "Broccoli" },
      { amount: 0.5, unit: "st", name: "Vitlöksklyfta" },
      { amount: 1.0, unit: "dl", name: "Parmesan" },
      { amount: 1.0, unit: "näve", name: "Färsk Basilika" },
      { amount: 2.5, unit: "msk", name: "Olivolja" },
      { amount: nil, unit: nil, name: "Citron" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Koka valfri pasta",
      "Ånga broccolin tills den är mjuk",
      "Mixa den ångade broccolin med resterande ingredienser till peston i en matberedare el mixer. Citronen skall endast vara en skvätt",
      "Smaka av peston och se om man behöver addera något",
      "Blanda med den färdiga pastan"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Koka valfri pasta\nÅnga broccolin tills den är mjuk\nMixa den ångade broccolin med resterande ingredienser till peston i en matberedare el mixer. Citronen skall endast vara en skvätt\nSmaka av peston och se om man behöver addera något\nBlanda med den färdiga pastan")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("kiddokitchen.se")
    expect(recipe.canonical_url).to eq("https://kiddokitchen.se/recept/pasta-med-broccolipesto")
    expect(recipe.site_name).to eq("KiddoKitchen")
    expect(recipe.language).to eq("sv")
    expect(recipe.author).to eq("KiddoKitchen")
    expect(recipe.description).to eq("Lämpligt från 10 mån. Superlätt recept att slänga ihop men nyttiga ingredienser. För glutenfritt, välj glutenfri pasta. Likaså med äggfritt/vetefritt.")
    expect(recipe.image).to eq("https://kiddo-cdn.b-cdn.net/legacy/clp07b8j4004el741g5jvc624.jpg")
    expect(recipe.category).to eq("Plockmat")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["LowCalorieDiet"])
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
