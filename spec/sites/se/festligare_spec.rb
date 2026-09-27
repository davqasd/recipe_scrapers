# frozen_string_literal: true

RSpec.describe "festligare.se" do
  subject(:recipe) { scrape_cassette("se/festligare", url: "https://festligare.se/recept/matrecept/fisk/lax-i-ugn-med-ort-och-citrontacke-fetaostkram-och-zucchinisallad") }

  it "reads the title" do
    expect(recipe.title).to eq("Lax i ugn med ört och citrontäcke, fetaostkräm och zucchinisallad")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "500 g laxsida",
      "1 citron",
      "1 kruka basilika",
      "2 vitlöksklyftor",
      "60 g parmesan",
      "1,5 dl pinjenötter",
      "1-2 dl olivolja",
      "salt",
      "svartpeppar",
      "2 zucchini",
      "1 citron",
      "60 g ruccola",
      "salt",
      "svartpeppar",
      "olivolja",
      "pinjenötter",
      "2 dl matyoghurt",
      "150 g fetaost",
      "3 droppar honung",
      "1⁄2 citron",
      "salt",
      "svartpeppar",
      "olivolja"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 500.0, unit: "g", name: "laxsida" },
      { amount: 1.0, unit: nil, name: "citron" },
      { amount: 1.0, unit: "kruka", name: "basilika" },
      { amount: 2.0, unit: nil, name: "vitlöksklyftor" },
      { amount: 60.0, unit: "g", name: "parmesan" },
      { amount: 1.5, unit: "dl", name: "pinjenötter" },
      { amount: 1.0, unit: "dl", name: "olivolja" },
      { amount: nil, unit: nil, name: "salt" },
      { amount: nil, unit: nil, name: "svartpeppar" },
      { amount: 2.0, unit: nil, name: "zucchini" },
      { amount: 1.0, unit: nil, name: "citron" },
      { amount: 60.0, unit: "g", name: "ruccola" },
      { amount: nil, unit: nil, name: "salt" },
      { amount: nil, unit: nil, name: "svartpeppar" },
      { amount: nil, unit: nil, name: "olivolja" },
      { amount: nil, unit: nil, name: "pinjenötter" },
      { amount: 2.0, unit: "dl", name: "matyoghurt" },
      { amount: 150.0, unit: "g", name: "fetaost" },
      { amount: 3.0, unit: nil, name: "droppar honung" },
      { amount: 0.5, unit: nil, name: "citron" },
      { amount: nil, unit: nil, name: "salt" },
      { amount: nil, unit: nil, name: "svartpeppar" },
      { amount: nil, unit: nil, name: "olivolja" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Fetaostkräm: Smula ner fetaosten i matyoghurten. Tillsätt honung, några droppar citron, salt och svartpeppar. Smaka av.",
      "Zucchinisallad: Skiva zucchinin på längden med en mandolin. Rosta pinjenötterna. Pressa citronen och blanda i en skål med zucchinin. Häll över ruccola och toppa med olivolja, salt, svartpeppar och pinjenötter.",
      "Mixa alla ingredienserna till peston förutom citron. När du är nöjd med peston tillsätter du några droppar citronsaft och rör ner, samt 1 tsk citronzest. Lägg laxen med skinnsidan nedåt i en ugnsfast form. Lägg över peston och ställ in i ugnen på 175 grader i cirka 20 minuter. Laxen ska få innertemperaturen 54 grader.",
      "Servera laxen med zucchinisallad och fetaostkräm."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Fetaostkräm: Smula ner fetaosten i matyoghurten. Tillsätt honung, några droppar citron, salt och svartpeppar. Smaka av.\nZucchinisallad: Skiva zucchinin på längden med en mandolin. Rosta pinjenötterna. Pressa citronen och blanda i en skål med zucchinin. Häll över ruccola och toppa med olivolja, salt, svartpeppar och pinjenötter.\nMixa alla ingredienserna till peston förutom citron. När du är nöjd med peston tillsätter du några droppar citronsaft och rör ner, samt 1 tsk citronzest. Lägg laxen med skinnsidan nedåt i en ugnsfast form. Lägg över peston och ställ in i ugnen på 175 grader i cirka 20 minuter. Laxen ska få innertemperaturen 54 grader.\nServera laxen med zucchinisallad och fetaostkräm.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("festligare.se")
    expect(recipe.canonical_url).to eq("https://festligare.se/recept/matrecept/fisk/lax-i-ugn-med-ort-och-citrontacke-fetaostkram-och-zucchinisallad")
    expect(recipe.site_name).to eq("Festligare Shop")
    expect(recipe.language).to eq("sv-SE")
    expect(recipe.author).to eq("Festligare")
    expect(recipe.description).to eq("Lax i ugn är en riktig klassiker som alla tycker om. Här är Sofia Henrikssons underbara recept med en fetaostkräm och zucchinisallad. Smakrikt och fräscht. Hoppas det smakar. Detta vin passar bra till rätten!")
    expect(recipe.image).to eq("https://cdn.thedock.space/linode/se-sto-1/a7e164f8/2022/04/laxiiugn-1024x640.webp")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(45)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.5)
    expect(recipe.ratings_count).to eq(7)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#comments")
  end
end
