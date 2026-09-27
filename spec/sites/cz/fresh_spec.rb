# frozen_string_literal: true

RSpec.describe "fresh.iprima.cz" do
  subject(:recipe) { scrape_cassette("cz/fresh", url: "https://fresh.iprima.cz/affogato-s-dalgona-penou-kava-se-zmrzlinou-a-sladkou-kavovou-cepici-518992") }

  it "reads the title" do
    expect(recipe.title).to eq("Affogato s dalgona pěnou – káva se zmrzlinou a sladkou kávovou čepicí")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 lžíce instatní káva, prášková",
      "2 lžíce cukr krupice",
      "2 lžíce horká voda",
      "4 kopečky vanilková zmrzlina",
      "4 shoty espresso",
      "kávová zrna, na ozdobu",
      "4 ks cukrářské piškoty, dlouhé"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: nil, name: "lžíce instatní káva, prášková" },
      { amount: 2.0, unit: nil, name: "lžíce cukr krupice" },
      { amount: 2.0, unit: nil, name: "lžíce horká voda" },
      { amount: 4.0, unit: nil, name: "kopečky vanilková zmrzlina" },
      { amount: 4.0, unit: nil, name: "shoty espresso" },
      { amount: nil, unit: nil, name: "kávová zrna, na ozdobu" },
      { amount: 4.0, unit: "ks", name: "cukrářské piškoty, dlouhé" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Na dalgona pěnu nasypte do užší misky nebo sklenice kávu, cukr a horkou vodu. Šlehejte, dokud nevznikne hustá, světlejší pěna.",
      "Do každé sklenice dejte kopeček vanilkové zmrzliny, zalijte espressem a navrch naneste lžíci dalgona pěny .",
      "Posypte rozdrcenými kávovými zrny, do sklenice přidejte dlouhý piškot a ihned podávejte."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Na dalgona pěnu nasypte do užší misky nebo sklenice kávu, cukr a horkou vodu. Šlehejte, dokud nevznikne hustá, světlejší pěna.\nDo každé sklenice dejte kopeček vanilkové zmrzliny, zalijte espressem a navrch naneste lžíci dalgona pěny .\nPosypte rozdrcenými kávovými zrny, do sklenice přidejte dlouhý piškot a ihned podávejte.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("fresh.iprima.cz")
    expect(recipe.canonical_url).to eq("https://fresh.iprima.cz/affogato-s-dalgona-penou-kava-se-zmrzlinou-a-sladkou-kavovou-cepici-518992")
    expect(recipe.site_name).to eq("Prima Fresh")
    expect(recipe.language).to eq("cs")
    expect(recipe.author).to eq("redakce Prima FRESH")
    expect(recipe.description).to eq("Italská klasika pro letní dny dostává tentokrát korejský twist. Affogato, kopeček vanilkové zmrzliny zalitý espressem, doplní nadýchaná dalgona pěna z vyšlehané instantní kávy a cukru. Ideální dezert i osvěžení v jednom, navíc hotové za 15 minut.")
    expect(recipe.image).to eq("https://cdn.administrace.tv/2026/08/11/small_169/eda518662142571c5b2fcbed32867f31.jpg")
    expect(recipe.category).to eq("Nápoje")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["instatní káva", "cukr krupice", "horká voda", "vanilková zmrzlina", "espresso", "kávová zrna", "cukrářské piškoty"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.25)
    expect(recipe.ratings_count).to eq(4)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
