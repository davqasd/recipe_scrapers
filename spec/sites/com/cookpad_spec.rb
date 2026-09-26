# frozen_string_literal: true

RSpec.describe "cookpad.com" do
  subject(:recipe) { scrape_cassette("com/cookpad", url: "https://cookpad.com/recipe/4610651") }

  it "reads the title" do
    expect(recipe.title).to eq("30分で簡単♡本格バターチキンカレー♡")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "♥鶏モモ肉 500g前後",
      "♥玉ねぎ 2個",
      "♥にんにくチューブ 5cm",
      "♥生姜チューブ 5cm(なくても♡)",
      "♥カレー粉 大さじ1と1/2",
      "♥バター 大さじ2+大さじ3(60g)",
      "＊トマト缶 1缶",
      "＊コンソメ 小さじ1",
      "＊塩 小さじ(1〜)2弱",
      "＊砂糖 小さじ2",
      "＊水 100ml",
      "＊ケチャップ 大さじ1",
      "♥生クリーム 100ml"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "鶏モモ肉 500g前後" },
      { amount: 2.0, unit: "個", name: "玉ねぎ" },
      { amount: 5.0, unit: "cm", name: "にんにくチューブ" },
      { amount: 5.0, unit: "cm", name: "生姜チューブ" },
      { amount: 1.5, unit: "大さじ", name: "カレー粉" },
      { amount: nil, unit: nil, name: "バター 大さじ2+大さじ3" },
      { amount: 1.0, unit: "缶", name: "トマト缶" },
      { amount: 1.0, unit: "小さじ", name: "コンソメ" },
      { amount: nil, unit: nil, name: "塩 小さじ 2弱" },
      { amount: 2.0, unit: "小さじ", name: "砂糖" },
      { amount: 100.0, unit: "ml", name: "水" },
      { amount: 1.0, unit: "大さじ", name: "ケチャップ" },
      { amount: 100.0, unit: "ml", name: "生クリーム" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "鶏モモ肉 は一口大に、 玉ねぎ は薄切り(orみじん切り)にします♪",
      "フライパンに バター(大さじ2) を熱し、鶏肉 に 塩胡椒 をふり表面をこんがり焼きます♪",
      "お鍋に バター(大さじ3) にんにくチューブ 生姜チューブ 玉ねぎ を入れてあめ色になるまでじっくり炒めます♪",
      "カレー粉 を加えて弱火で3分くらい炒めます♪",
      "＊ と 鶏肉(油分も) を加えて沸騰したら火が通るまで(10分程)煮ます♪",
      "仕上げに 生クリーム を加えて混ぜ、温まったらすぐ火を止めます♪ 完成♡♡ 更に仕上げに生クリームをトッピングしました♡",
      "子供ごはんはこんな感じの盛り付けに♡♥"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("鶏モモ肉 は一口大に、 玉ねぎ は薄切り(orみじん切り)にします♪\nフライパンに バター(大さじ2) を熱し、鶏肉 に 塩胡椒 をふり表面をこんがり焼きます♪\nお鍋に バター(大さじ3) にんにくチューブ 生姜チューブ 玉ねぎ を入れてあめ色になるまでじっくり炒めます♪\nカレー粉 を加えて弱火で3分くらい炒めます♪\n＊ と 鶏肉(油分も) を加えて沸騰したら火が通るまで(10分程)煮ます♪\n仕上げに 生クリーム を加えて混ぜ、温まったらすぐ火を止めます♪ 完成♡♡ 更に仕上げに生クリームをトッピングしました♡\n子供ごはんはこんな感じの盛り付けに♡♥")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cookpad.com")
    expect(recipe.canonical_url).to eq("https://cookpad.com/jp/recipes/19600325")
    expect(recipe.site_name).to eq("Cookpad")
    expect(recipe.language).to eq("ja")
    expect(recipe.author).to eq("reoririna")
    expect(recipe.description).to eq("おうちにある材料で作れるバターチキンカレーです(*´`*)♡ とっても簡単♬すぐ出来るのでぜひお試しください♡ʾʾ")
    expect(recipe.image).to eq("https://og-image.cookpad.com/global/jp/recipe/19600325?t=1519042774")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to eq("日本語")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 items")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq([
      "♥鶏モモ肉",
      "♥玉ねぎ",
      "♥にんにくチューブ",
      "♥生姜チューブ",
      "♥カレー粉",
      "♥バター",
      "＊トマト缶",
      "＊コンソメ",
      "＊塩",
      "＊砂糖",
      "＊水",
      "＊ケチャップ",
      "♥生クリーム"
    ])
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
    expect(recipe.links).to include("https://cookpad.com/jp")
  end
end
