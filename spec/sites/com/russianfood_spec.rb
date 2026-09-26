# frozen_string_literal: true

RSpec.describe "russianfood.com" do
  subject(:recipe) do
    scrape_cassette(
      "com/russianfood/omelette",
      url: "https://www.russianfood.com/recipes/recipe.php?rid=134944"
    )
  end

  it "reads the title out of a windows-1251 page carrying no structured data" do
    expect(recipe.title).to eq("Омлет в мультиварке")
  end

  it "reads every ingredient line off the declared rows" do
    expect(recipe.ingredients).to eq([
      "Яйца (лучше выбрать крупные) – 5 шт.",
      "Молоко – 300 мл",
      "Сыр твёрдый – 100 г",
      "Укроп свежий – 3-4 веточки",
      "Крупа манная – посыпать чашу мультиварки (1 ст.л.)",
      "Масло растительное или сливочное - смазать чашу мультиварки",
      "Соль – щепотка"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 5.0, unit: "шт", name: "Яйца" },
      { amount: 300.0, unit: "мл", name: "Молоко" },
      { amount: 100.0, unit: "г", name: "Сыр твёрдый" },
      { amount: 3.0, unit: "веточки", name: "Укроп свежий" },
      { amount: nil, unit: nil, name: "Крупа манная – посыпать чашу мультиварки" },
      { amount: nil, unit: nil, name: "Масло растительное или сливочное - смазать чашу мультиварки" },
      { amount: 1.0, unit: "щепотка", name: "Соль" }
    ])
  end

  it "reads every instruction step off the declared rows", :aggregate_failures do
    expect(recipe.instructions_list.size).to eq(9)
    expect(recipe.instructions_list.first).to eq("Подготовим ингредиенты для приготовления омлета в мультиварке.")
    expect(recipe.instructions_list.last).to eq("Горячий, пышный омлет разложим по тарелкам. Приятного аппетита!")
  end

  it "reports the host without the www" do
    expect(recipe.host).to eq("russianfood.com")
  end

  it "leaves a field the page does not publish empty" do
    expect(recipe.total_time).to be_nil
  end

  it "reads every instructions list" do
    expect(recipe.instructions_list).to eq([
      "Подготовим ингредиенты для приготовления омлета в мультиварке.",
      "Как приготовить омлет в мультиварке: Разобьём яйца по одному в отдельную миску.",
      "Добавим к ним молоко. Не забудем посолить. Затем всё аккуратно перемешаем венчиком или обычной вилкой.",
      "Мелко порубим укроп.",
      "Натрём сыр.",
      "Укроп и сыр выложим к яичной смеси. Перемешаем.",
      "Смажем чашу мультиварки растительным маслом (можно обильно смазать кусочком сливочного масла) и присыплем манкой дно и стенки. Зальём омлетную смесь в подготовленную мультиварку.",
      "Установим на панели управления режим «Выпечка» и запрограммируем на 30 минут. Запустим программу. Дождёмся финального сигнала. Откроем крышку. Омлет в мультиварке готов.",
      "Горячий, пышный омлет разложим по тарелкам. Приятного аппетита!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Подготовим ингредиенты для приготовления омлета в мультиварке.\nКак приготовить омлет в мультиварке: Разобьём яйца по одному в отдельную миску.\nДобавим к ним молоко. Не забудем посолить. Затем всё аккуратно перемешаем венчиком или обычной вилкой.\nМелко порубим укроп.\nНатрём сыр.\nУкроп и сыр выложим к яичной смеси. Перемешаем.\nСмажем чашу мультиварки растительным маслом (можно обильно смазать кусочком сливочного масла) и присыплем манкой дно и стенки. Зальём омлетную смесь в подготовленную мультиварку.\nУстановим на панели управления режим «Выпечка» и запрограммируем на 30 минут. Запустим программу. Дождёмся финального сигнала. Откроем крышку. Омлет в мультиварке готов.\nГорячий, пышный омлет разложим по тарелкам. Приятного аппетита!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.canonical_url).to eq("https://www.russianfood.com/recipes/recipe.php?rid=134944")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to be_nil
    expect(recipe.author).to be_nil
    expect(recipe.description).to be_nil
    expect(recipe.image).to eq("https://www.russianfood.com/dycontent/images_upl/322/big_321870.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
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
    expect(recipe.links).to include("/")
  end
end
