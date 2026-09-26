# frozen_string_literal: true

RSpec.describe "gastronom.ru" do
  subject(:recipe) do
    scrape_cassette("ru/gastronom/recipe", url: "https://www.gastronom.ru/recipe/8107/borshch-ukrainskij")
  end

  it "reads the recipe out of json-ld", :aggregate_failures do
    expect(recipe.title).to eq("Домашнее сливочное масло")
    expect(recipe.total_time).to eq(30)
    expect(recipe.ingredients).to eq(["Сливки 35% (жирные)"])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "Сливки 35%" }
    ])
  end

  it "reads every instruction step", :aggregate_failures do
    expect(recipe.instructions_list.size).to eq(7)
    expect(recipe.instructions_list.first).to start_with("Удобнее всего готовить домашнее сливочное масло")
  end

  it "reads every instructions list" do
    expect(recipe.instructions_list).to eq([
      "Удобнее всего готовить домашнее сливочное масло при помощи стационарного миксера с глубокой миской большого объема, но можно сделать это и обычным ручным.",
      "Влейте сливки комнатной температуры в миску (ее емкость должна превышать объем сливок в 3 раза). Затяните миску двойным слоем пленки так, чтобы она была надежно закреплена. Идеально, если вы просто завернете миску со сливками в пленку полностью.",
      "Сделайте в пленке надрезы так, чтобы в них пролезали венчики миксера. Установите их, аккуратно вставьте в разрезы и начинайте взбивать сливки на небольшой скорости, постепенно увеличивая ее до максимальной.",
      "Сначала сливки взобьются в пышную пену, потом она станет плотной и, наконец, изменит цвет с белого на бледно-желтый или белый с желтыми вкраплениями. Эти вкрапления и есть масло. Процесс занимает как минимум 8–10 минут.",
      "Продолжайте взбивать еще 2–3 минуты, чтобы масло сепарировалось. Отделившаяся жидкость (пахта) начнет разбрызгиваться во все стороны: именно поэтому следовало закрыть емкость пленкой. Выключите миксер.",
      "Установите дуршлаг в миску и выстелите его тонкой полотняной салфеткой или марлей в несколько слоев. Снимите с миски пленку, вылейте ее содержимое в дуршлаг, оставьте на 15 минут.",
      "Затем деревянной ложкой или силиконовой лопаткой разомните содержимое дуршлага, чтобы убрать оставшуюся пахту и сделать масло однородным. Вымешивайте примерно 5 минут. Сливочное масло готово."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Удобнее всего готовить домашнее сливочное масло при помощи стационарного миксера с глубокой миской большого объема, но можно сделать это и обычным ручным.\nВлейте сливки комнатной температуры в миску (ее емкость должна превышать объем сливок в 3 раза). Затяните миску двойным слоем пленки так, чтобы она была надежно закреплена. Идеально, если вы просто завернете миску со сливками в пленку полностью.\nСделайте в пленке надрезы так, чтобы в них пролезали венчики миксера. Установите их, аккуратно вставьте в разрезы и начинайте взбивать сливки на небольшой скорости, постепенно увеличивая ее до максимальной.\nСначала сливки взобьются в пышную пену, потом она станет плотной и, наконец, изменит цвет с белого на бледно-желтый или белый с желтыми вкраплениями. Эти вкрапления и есть масло. Процесс занимает как минимум 8–10 минут.\nПродолжайте взбивать еще 2–3 минуты, чтобы масло сепарировалось. Отделившаяся жидкость (пахта) начнет разбрызгиваться во все стороны: именно поэтому следовало закрыть емкость пленкой. Выключите миксер.\nУстановите дуршлаг в миску и выстелите его тонкой полотняной салфеткой или марлей в несколько слоев. Снимите с миски пленку, вылейте ее содержимое в дуршлаг, оставьте на 15 минут.\nЗатем деревянной ложкой или силиконовой лопаткой разомните содержимое дуршлага, чтобы убрать оставшуюся пахту и сделать масло однородным. Вымешивайте примерно 5 минут. Сливочное масло готово.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("gastronom.ru")
    expect(recipe.canonical_url).to eq("https://www.gastronom.ru/recipe/8107/domashnee-slivochnoe-maslo")
    expect(recipe.site_name).to eq("www.gastronom.ru")
    expect(recipe.language).to eq("ru")
    expect(recipe.author).to eq("gastronom")
    expect(recipe.description).to eq("Домашнее сливочное масло — настоящий подарок ценителям натурального вкуса. Попробовав этот продукт однажды, вы больше не захотите иметь дело с магазинным! А самое интересное, что готовить сливочное масло в домашних условиях не так уж и сложно: главное — найти правильный ингредиент. Да-да, мы не ошиблись, употребив это слово в единственном числе, ведь для приготовления домашнего сливочного масла вам потребуется всего один исходный продукт. Речь идет о натуральных, нестерилизованных сливках, приобрести которые можно или непосредственно в фермерском хозяйстве, или на рынке. Попробуйте найти такой продукт и приготовьте сливочное масло по нашему подробному рецепту. Вот увидите: результат окажется достойным всех ваших стараний!")
    expect(recipe.image).to eq("https://images.gastronom.ru/epkTterciNZXbqt8YgnRWQoAKM39M9cM95OOfWCeU8k/pr:recipe-cover-image/g:ce/rs:auto:0:0:0/L2Ntcy9hbGwtaW1hZ2VzLzBkMzFlMTRlLTVkYjktNDVhMy1hZDNlLWExOWI2MjAxNWZjNS5qcGc.webp")
    expect(recipe.category).to eq("рецепт")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("350 servings")
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(10)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "202.20 ккал",
      "fatContent" => "21.00 г.",
      "carbohydrateContent" => "1.80 г.",
      "proteinContent" => "1.50 г."
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 202.2 },
      { name: "fatContent", unit: "g", amount: 21.0 },
      { name: "carbohydrateContent", unit: "g", amount: 1.8 },
      { name: "proteinContent", unit: "g", amount: 1.5 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("http://top.mail.ru/jump?from=1341924")
  end
end
