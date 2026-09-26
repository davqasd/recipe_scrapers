# frozen_string_literal: true

RSpec.describe "edimdoma.ru" do
  subject(:recipe) do
    scrape_cassette(
      "ru/edimdoma/tagliatelle",
      url: "https://www.edimdoma.ru/retsepty/155484-talyatelle-chetyre-pertsa"
    )
  end

  it "reads the recipe out of json-ld", :aggregate_failures do
    expect(recipe.title).to eq("Тальятелле «четыре перца»")
    expect(recipe.yields).to eq("6 servings")
  end

  it "reads every ingredient line", :aggregate_failures do
    expect(recipe.ingredients.size).to eq(13)
    expect(recipe.ingredients.first).to eq("тальятелле-гнезда - 8 шт.")
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 8.0, unit: "шт", name: "тальятелле-гнезда" },
      { amount: 2.0, unit: "шт", name: "перец сладкий красный" },
      { amount: 70.0, unit: "г", name: "пармезан" },
      { amount: 1.0, unit: "шт", name: "лук красный" },
      { amount: 1.0, unit: "головка", name: "чеснок" },
      { amount: 1.0, unit: "шт", name: "перец чили" },
      { amount: 1.0, unit: "веточка", name: "базилик свежий" },
      { amount: 2.0, unit: "ст. л", name: "оливковое масло" },
      { amount: 2.0, unit: "ст. л", name: "оливковое масло Extra Virgin" },
      { amount: 0.3, unit: "ч. л", name: "кумин" },
      { amount: 1.0, unit: "щепотка", name: "паприка копченая" },
      { amount: 1.0, unit: "щепотка", name: "перец черный свежемолотый" },
      { amount: 1.0, unit: "ч. л", name: "соль морская" }
    ])
  end

  it "reads every instruction step", :aggregate_failures do
    expect(recipe.instructions_list.size).to eq(8)
    expect(recipe.instructions_list.first).to eq("Духовку предварительно разогреть в режиме «верх» до 240℃.")
  end

  it "reads every ingredients" do
    expect(recipe.ingredients).to eq([
      "тальятелле-гнезда - 8 шт.",
      "перец сладкий красный - 2 шт.",
      "пармезан - 70 г",
      "лук красный - 1 шт.",
      "чеснок - 1 головка",
      "перец чили - 1 шт.",
      "базилик свежий - 1 веточка",
      "оливковое масло - 2 ст. л.",
      "оливковое масло Extra Virgin - 2 ст. л.",
      "кумин - 0.3 ч. л.",
      "паприка копченая - 1 щепотка",
      "перец черный свежемолотый - 1 щепотка",
      "соль морская - 1 ч. л."
    ])
  end

  it "reads every instructions list" do
    expect(recipe.instructions_list).to eq([
      "Духовку предварительно разогреть в режиме «верх» до 240℃.",
      "Луковицу и головку чеснока очистить от шелухи и выложить в противень, выстеленный фольгой, добавить сладкий перец, полить все оливковым маслом, слегка посыпать солью, перцем и кумином.",
      "Запекать овощи в разогретой духовке до мягкости, затем сладкий перец очистить от кожуры и семян, зубчики чеснока вынуть из кожуры.",
      "Перец чили освободить от семян.",
      "Все подготовленные овощи выложить в блендер, влить оливковое масло Extra Virgin, добавить копченую паприку, слегка посолить и взбить.",
      "Макароны отваривать в подсоленной воде на пару минут меньше, чем указано на упаковке, затем выложить в большую тарелку, добавить соус из взбитых овощей, влить немного воды, в которой варились макароны, и все перемешать.",
      "Базилик порвать руками и добавить к макаронам.",
      "Пармезан натереть на мелкой терке и посыпать макароны."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Духовку предварительно разогреть в режиме «верх» до 240℃.\nЛуковицу и головку чеснока очистить от шелухи и выложить в противень, выстеленный фольгой, добавить сладкий перец, полить все оливковым маслом, слегка посыпать солью, перцем и кумином.\nЗапекать овощи в разогретой духовке до мягкости, затем сладкий перец очистить от кожуры и семян, зубчики чеснока вынуть из кожуры.\nПерец чили освободить от семян.\nВсе подготовленные овощи выложить в блендер, влить оливковое масло Extra Virgin, добавить копченую паприку, слегка посолить и взбить.\nМакароны отваривать в подсоленной воде на пару минут меньше, чем указано на упаковке, затем выложить в большую тарелку, добавить соус из взбитых овощей, влить немного воды, в которой варились макароны, и все перемешать.\nБазилик порвать руками и добавить к макаронам.\nПармезан натереть на мелкой терке и посыпать макароны.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("edimdoma.ru")
    expect(recipe.canonical_url).to eq("https://www.edimdoma.ru/retsepty/155484-talyatelle-chetyre-pertsa")
    expect(recipe.site_name).to eq("Едим Дома")
    expect(recipe.language).to eq("ru-RU")
    expect(recipe.author).to eq("Юлия Высоцкая")
    expect(recipe.description).to eq("Можно добавить в такие макароны рубленые орехи, каперсы или фету.")
    expect(recipe.image).to eq("https://e3.edimdoma.ru/data/recipes/0015/5484/155484-ed4_wide.jpg?1789752690")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to eq("итальянская кухня")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.total_time).to eq(50)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(50)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "35 ккал",
      "fatContent" => "2 г",
      "proteinContent" => "1 г",
      "carbohydrateContent" => "2 г"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 35.0 },
      { name: "fatContent", unit: "g", amount: 2.0 },
      { name: "proteinContent", unit: "g", amount: 1.0 },
      { name: "carbohydrateContent", unit: "g", amount: 2.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.edimdoma.ru/2021/planetazdorovo?erid=LjN8KcHoa")
  end
end
