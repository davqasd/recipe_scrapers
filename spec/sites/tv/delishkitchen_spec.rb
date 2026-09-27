# frozen_string_literal: true

RSpec.describe "delishkitchen.tv" do
  subject(:recipe) { scrape_cassette("tv/delishkitchen", url: "https://www.delishkitchen.tv/recipes/175844554405052820") }

  it "reads the title" do
    expect(recipe.title).to eq("鶏団子スープの作り方が動画でわかる！食べ応え抜群の絶品レシピ")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "春雨 20g",
      "鶏ひき肉 150g",
      "白菜 1/8個",
      "しょうが 1かけ",
      "ねぎ 1/3本",
      "塩 小さじ1/4",
      "こしょう 少々",
      "片栗粉 小さじ2",
      "酒 大さじ1",
      "しょうゆ 大さじ1と1/2",
      "鶏がらスープの素 大さじ1/2",
      "水 600cc"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 20.0, unit: "g", name: "春雨" },
      { amount: 150.0, unit: "g", name: "鶏ひき肉" },
      { amount: 0.13, unit: "個", name: "白菜" },
      { amount: nil, unit: nil, name: "しょうが 1かけ" },
      { amount: 0.33, unit: "本", name: "ねぎ" },
      { amount: 0.25, unit: "小さじ", name: "塩" },
      { amount: nil, unit: nil, name: "こしょう 少々" },
      { amount: 2.0, unit: "小さじ", name: "片栗粉" },
      { amount: 1.0, unit: "大さじ", name: "酒" },
      { amount: 1.5, unit: "大さじ", name: "しょうゆ" },
      { amount: 0.5, unit: "大さじ", name: "鶏がらスープの素" },
      { amount: nil, unit: nil, name: "水 600cc" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "白菜は千切りにする。しょうが、ねぎはみじん切りにする。",
      "ボウルに鶏ひき肉、ねぎ、しょうが、☆を入れて粘り気が出るまで混ぜ6等分にわける。",
      "鍋に★を入れて煮立ったら、2をスプーンですくい入れる。アクを取り除き、ふたをして中火で6分煮る。",
      "白菜を加えてしんなりしたら、春雨を加えて袋の表示時間通りゆでる。"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("白菜は千切りにする。しょうが、ねぎはみじん切りにする。\nボウルに鶏ひき肉、ねぎ、しょうが、☆を入れて粘り気が出るまで混ぜ6等分にわける。\n鍋に★を入れて煮立ったら、2をスプーンですくい入れる。アクを取り除き、ふたをして中火で6分煮る。\n白菜を加えてしんなりしたら、春雨を加えて袋の表示時間通りゆでる。")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("delishkitchen.tv")
    expect(recipe.canonical_url).to eq("https://delishkitchen.tv/recipes/175844554405052820")
    expect(recipe.site_name).to eq("デリッシュキッチン")
    expect(recipe.language).to eq("ja")
    expect(recipe.author).to eq("デリッシュキッチン")
    expect(recipe.description).to eq("鶏団子の旨味と白菜の甘味がスープにしっかりと染みた春雨スープをご紹介します！柔らかく煮た白菜の甘みと肉団子の旨みが相性抜群です♪鶏団子を作る際に生姜を入れるので、クセがなく程よいアクセントに♪")
    expect(recipe.image).to eq("https://image.delishkitchen.tv/recipe/175844554405052820/1.jpg?version=1788141321&w=920")
    expect(recipe.category).to eq("soup")
    expect(recipe.cuisine).to eq("Chinese")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 items")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(["副菜", "スープ", "汁物・シチュー", "白菜", "ねぎ", "春雨", "野菜のおかず", "お肉のおかず", "ひき肉", "旬野菜", "鶏ひき肉", "中華風スープ", "春雨スープ", "その他の材料のおかず", "鶏がら", "しょうゆ"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.5)
    expect(recipe.ratings_count).to eq(801)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "235kcal",
      "carbohydrateContent" => "20.2g",
      "fatContent" => "9.2g",
      "proteinContent" => "15.8g",
      "sugarContent" => "17.5g",
      "sodiumContent" => "3.8g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 235.0 },
      { name: "carbohydrateContent", unit: "g", amount: 20.2 },
      { name: "fatContent", unit: "g", amount: 9.2 },
      { name: "proteinContent", unit: "g", amount: 15.8 },
      { name: "sugarContent", unit: "g", amount: 17.5 },
      { name: "sodiumContent", unit: "g", amount: 3.8 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
