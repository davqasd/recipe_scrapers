# frozen_string_literal: true

RSpec.describe "povar.ru" do
  subject(:recipe) { scrape_cassette("ru/povar", url: "https://povar.ru/recipes/shashlyk_iz_kartofelya-12708.html") }

  it "reads the title" do
    expect(recipe.title).to eq("Шашлык из картофеля")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "Картофель 1 кг (молодой картофель)",
      "Сало 400 грамм",
      "Соль По вкусу",
      "Перец По вкусу"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "кг", name: "Картофель" },
      { amount: 400.0, unit: "грамм", name: "Сало" },
      { amount: nil, unit: nil, name: "Соль По вкусу" },
      { amount: nil, unit: nil, name: "Перец По вкусу" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Подготовьте все ингредиенты по списку. Картофель выбирайте небольшого размера. Сало можно заменить беконом или варено-копчёной грудинкой.",
      "Картофель тщательно промойте, если картофель молодой, то шкурку оставьте.",
      "Нарежьте сало (или бекон) на дольки шириной 0,5 см. Если сало с мясной прослойкой — это еще лучше!",
      "Картофель нарежьте кружочками по 4-5 мм. толщиной. У меня небольшой картофель, я просто разрезала его на 2 части. Переложите картофель в глубокую миску. Посолите и поперчите, можно добавить ароматные специи и травы. Если у вас сало не свежее, а солёное, то соль можно и вовсе не добавлять.",
      "Насадите на шампуры картофель и кусочки сала. Можно поочерёдно или в хаотичном порядке, я чередовала с клубнями картофеля.",
      "Тщательно заверните в несколько слоёв фольги.",
      "Готовьте 30-40 минут, не меньше. Жар должен быть достаточно большой. Сало растает, картофель пропарится и размягчится.",
      "Когда аромат начнёт пробиваться сквозь щели в фольге, снимите фольгу и поставьте шампуры на угли ещё раз. Жар уже не должен быть такой большой.",
      "Горячая и практически готовая уже картошка зарумянится за считанные минуты, а сало превратится в любимые выжарки. Шашлык из картофеля готов. Подавайте немедленно к столу!",
      "Приятного аппетита!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Подготовьте все ингредиенты по списку. Картофель выбирайте небольшого размера. Сало можно заменить беконом или варено-копчёной грудинкой.\nКартофель тщательно промойте, если картофель молодой, то шкурку оставьте.\nНарежьте сало (или бекон) на дольки шириной 0,5 см. Если сало с мясной прослойкой — это еще лучше!\nКартофель нарежьте кружочками по 4-5 мм. толщиной. У меня небольшой картофель, я просто разрезала его на 2 части. Переложите картофель в глубокую миску. Посолите и поперчите, можно добавить ароматные специи и травы. Если у вас сало не свежее, а солёное, то соль можно и вовсе не добавлять.\nНасадите на шампуры картофель и кусочки сала. Можно поочерёдно или в хаотичном порядке, я чередовала с клубнями картофеля.\nТщательно заверните в несколько слоёв фольги.\nГотовьте 30-40 минут, не меньше. Жар должен быть достаточно большой. Сало растает, картофель пропарится и размягчится.\nКогда аромат начнёт пробиваться сквозь щели в фольге, снимите фольгу и поставьте шампуры на угли ещё раз. Жар уже не должен быть такой большой.\nГорячая и практически готовая уже картошка зарумянится за считанные минуты, а сало превратится в любимые выжарки. Шашлык из картофеля готов. Подавайте немедленно к столу!\nПриятного аппетита!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("povar.ru")
    expect(recipe.canonical_url).to eq("https://povar.ru/recipes/shashlyk_iz_kartofelya-12708.html")
    expect(recipe.site_name).to eq("Повар.ру")
    expect(recipe.language).to eq("ru")
    expect(recipe.author).to eq("Марина Щербакова")
    expect(recipe.description).to eq("Приготовить шашлык из картофеля очень просто, при этом блюдо получается сытное, вкусное и прекрасно подойдёт для отдыха на природе! Подавайте как гарнир к мясу или самостоятельно с соусами и овощами.")
    expect(recipe.image).to eq("https://img.povar.ru/main/4f/f0/d8/69/shashlik_iz_kartofelya-914808.jpeg")
    expect(recipe.category).to eq("Овощи / Картофель")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("5 servings")
    expect(recipe.total_time).to eq(60)
    expect(recipe.prep_time).to eq(60)
    expect(recipe.cook_time).to eq(60)
    expect(recipe.keywords).to eq(["Горячие блюда / Шашлык"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(25)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "270 ккал",
      "proteinContent" => "2 г",
      "fatContent" => "21 г",
      "carbohydrateContent" => "9 г"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 270.0 },
      { name: "proteinContent", unit: "g", amount: 2.0 },
      { name: "fatContent", unit: "g", amount: 21.0 },
      { name: "carbohydrateContent", unit: "g", amount: 9.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://povar.ru/")
  end
end
