# frozen_string_literal: true

RSpec.describe "iamcook.ru" do
  subject(:recipe) { scrape_cassette("ru/iamcook", url: "https://www.iamcook.ru/showrecipe/18797") }

  it "reads the title" do
    expect(recipe.title).to eq("Нектарины в сиропе на зиму")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "Нектарин - 3 шт.",
      "Сахар - 200 г",
      "Вода - 200 мл"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "шт", name: "Нектарин" },
      { amount: 200.0, unit: "г", name: "Сахар" },
      { amount: 200.0, unit: "мл", name: "Вода" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Выбираю для заготовки спелые, но крепкие нектарины, они должны быть чуть мягкими. Такие фрукты в банке сохраняют свою форму. Фрукты нужно тщательно вымыть. Сахар можно отмерять с помощью кухонных весов.",
      "Нарежьте нектарины дольками, удалите косточки.",
      "Уложите дольки нектаринов в чистые стерильные банки. Попутно банки нужно встряхивать, чтобы кусочки укладывались более компактно.",
      "Залейте кусочки фруктов в банках крутым кипятком. Накройте банку крышкой и оставьте остывать, минут на 15.",
      "В сотейник пересыпьте нужное количество сахара. Также можно добавить пару щепоток молотой корицы или ванильного сахара.",
      "Используя специальную крышку, слейте горячую воду из банки в кастрюлю с сахаром. Поставьте на плиту и сварите сироп, помешивая.",
      "Залейте нектарины в банках очень горячим сиропом до самого верха, сразу же накройте стерильными крышками и укупорьте.",
      "Опрокиньте банки крышками вниз и укутайте на пару дней одеялом. Нектарины в сиропе на зиму готовы. Храните заготовки в сухом темном месте."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Выбираю для заготовки спелые, но крепкие нектарины, они должны быть чуть мягкими. Такие фрукты в банке сохраняют свою форму. Фрукты нужно тщательно вымыть. Сахар можно отмерять с помощью кухонных весов.\nНарежьте нектарины дольками, удалите косточки.\nУложите дольки нектаринов в чистые стерильные банки. Попутно банки нужно встряхивать, чтобы кусочки укладывались более компактно.\nЗалейте кусочки фруктов в банках крутым кипятком. Накройте банку крышкой и оставьте остывать, минут на 15.\nВ сотейник пересыпьте нужное количество сахара. Также можно добавить пару щепоток молотой корицы или ванильного сахара.\nИспользуя специальную крышку, слейте горячую воду из банки в кастрюлю с сахаром. Поставьте на плиту и сварите сироп, помешивая.\nЗалейте нектарины в банках очень горячим сиропом до самого верха, сразу же накройте стерильными крышками и укупорьте.\nОпрокиньте банки крышками вниз и укутайте на пару дней одеялом. Нектарины в сиропе на зиму готовы. Храните заготовки в сухом темном месте.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("iamcook.ru")
    expect(recipe.canonical_url).to eq("https://www.iamcook.ru/showrecipe/18797")
    expect(recipe.site_name).to eq("Аймкук")
    expect(recipe.language).to be_nil
    expect(recipe.author).to eq("Аймкук")
    expect(recipe.description).to eq("Проверенный рецепт заготовки нектаринов в сиропе на зиму, шаг за шагом с фотографиями.")
    expect(recipe.image).to eq("https://img.iamcook.ru/2019/upl/recipes/zen/u-5bb5c7d4c6309b3bdb0941fbac914178.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(45)
    expect(recipe.keywords).to eq(["нектарины в сиропе на зиму"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.88)
    expect(recipe.ratings_count).to eq(32)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "calories" => "138 кКал" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 138.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/files/users-politics.pdf")
  end
end
