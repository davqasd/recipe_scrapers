# frozen_string_literal: true

RSpec.describe "eda.ru" do
  subject(:recipe) do
    scrape_cassette("ru/eda/recipe", url: "https://eda.ru/recepty/vypechka-deserty/shokoladnyj-tort-40190")
  end

  it "reads the recipe out of json-ld", :aggregate_failures do
    expect(recipe.title).to eq("Курица со спаржей в яблочном соусе")
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(30)
  end

  it "reads every ingredient line", :aggregate_failures do
    expect(recipe.ingredients.size).to eq(8)
    expect(recipe.ingredients.first).to eq("Куриная грудка, 500 г")
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 500.0, unit: "г", name: "Куриная грудка" },
      { amount: 1.0, unit: "стебель", name: "Свежая спаржа" },
      { amount: 1.0, unit: "штука", name: "Репчатый лук" },
      { amount: 1.0, unit: "штука", name: "Красные яблоки" },
      { amount: 3.0, unit: "столовые ложки", name: "Растительное масло" },
      { amount: 3.0, unit: "столовые ложки", name: "Темный соевый соус" },
      { amount: nil, unit: nil, name: "Молотый черный перец, по вкусу" },
      { amount: 1.0, unit: "стакан", name: "Вода" }
    ])
  end

  it "reads every instruction step", :aggregate_failures do
    expect(recipe.instructions_list.size).to eq(6)
    expect(recipe.instructions_list.last).to eq("Подавать блюдо горячим.")
    expect(recipe.instructions).to eq(recipe.instructions_list.join("\n"))
  end

  it "reads every ingredients" do
    expect(recipe.ingredients).to eq([
      "Куриная грудка, 500 г",
      "Свежая спаржа, 1 стебель",
      "Репчатый лук, 1 штука",
      "Красные яблоки, 1 штука",
      "Растительное масло, 3 столовые ложки",
      "Темный соевый соус, 3 столовые ложки",
      "Молотый черный перец, по вкусу",
      "Вода, 1 стакан"
    ])
  end

  it "reads every instructions list" do
    expect(recipe.instructions_list).to eq([
      "Нарежьте курицу на кубики размером 2–3 сантиметра. Поперчите. Налейте 2 столовые ложки растительного масла на сковороду и раскалите. Кусочки курицы обжарьте до легкой золотистой корочки, выложите в кастрюлю с толстым дном.",
      "Нарежьте луковицу кольцами толщиной 1 см (первое и последнее кольцо отложите). Обжарьте лук на сковороде, пока кольца не распадутся на отдельные части. Выложите поджарку в кастрюлю к курице, распределите равномерно по дну.",
      "В блендере взбейте оставшиеся кольца лука, яблоко, соевый соус и стакан теплой воды. Процедите соус через сито. Вам нужен будет соус без мякоти.",
      "Слегка разогрейте кастрюлю с курицей и луком и влейте 3/4 соуса, доведите блюдо до кипения и через 3 минуты убавьте огонь, тушите в течение 20 минут.",
      "Раскалите сковороду с одной ложкой растительного масла и выложите стебли спаржи. Обжаривайте в течение 3 минут и залейте оставшейся частью соуса. По желанию можно добавить дополнительную столовую ложку соевого соуса. Тушите в течение 7 минут на медленном огне.",
      "Подавать блюдо горячим."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("eda.ru")
    expect(recipe.canonical_url).to eq("https://eda.rambler.ru/recepty/osnovnye-blyuda/kurica-so-sparzhej-v-jablochnom-souse-40190")
    expect(recipe.site_name).to eq("Рамблер/еда")
    expect(recipe.language).to eq("ru")
    expect(recipe.author).to eq("Анна Перелыгина")
    expect(recipe.description).to eq("Курица со спаржей в яблочном соусе")
    expect(recipe.image).to eq("https://s1.eda.ru/StaticContent/Photos/120214142532/151015062830/p_O.jpg")
    expect(recipe.category).to eq("Основные блюда")
    expect(recipe.cuisine).to eq("Европейская кухня")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(["Курица со спаржей в яблочном соусе"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(4)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "310 калорий",
      "proteinContent" => "32",
      "fatContent" => "16",
      "carbohydrateContent" => "10"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 310.0 },
      { name: "proteinContent", unit: nil, amount: 32.0 },
      { name: "fatContent", unit: nil, amount: 16.0 },
      { name: "carbohydrateContent", unit: nil, amount: 10.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://news.rambler.ru/")
  end
end
