# frozen_string_literal: true

RSpec.describe "recipe.yamasa.com" do
  subject(:recipe) { scrape_cassette("com/recipe", url: "https://recipe.yamasa.com/recipes/6368") }

  it "reads the title" do
    expect(recipe.title).to eq("レンジで簡単！豚ともやしの薬味ぽん酢がけ")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "豚ばら薄切り肉 200g",
      "もやし 1袋(200g)",
      "しょうが ひとかけ",
      "刻みねぎ、千切り大葉、白ごま 各適量",
      "日本酒 大さじ1",
      "ヤマサ昆布ぽん酢 適量",
      "こしょう お好みで"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 200.0, unit: "g", name: "豚ばら薄切り肉" },
      { amount: nil, unit: nil, name: "もやし 1袋" },
      { amount: nil, unit: nil, name: "しょうが ひとかけ" },
      { amount: nil, unit: nil, name: "刻みねぎ、千切り大葉、白ごま 各適量" },
      { amount: 1.0, unit: "大さじ", name: "日本酒" },
      { amount: nil, unit: nil, name: "ヤマサ昆布ぽん酢 適量" },
      { amount: nil, unit: nil, name: "こしょう お好みで" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "もやしは洗って水気を切り、耐熱容器に入れる。",
      "豚ばら薄切り肉に日本酒をまぶして揉み込み、STEP1の上を覆うように広げる。さらに千切りにしたしょうがを散らす。 豚ばら薄切り肉は、長ければ切ってから日本酒をまぶします。",
      "STEP2をラップで覆い、電子レンジ600Wで6分ほど加熱して取り出す。ラップをしたまま1分ほど蒸らす。",
      "ラップをはずして刻みねぎ、千切り大葉、白ごまを散らし、「ヤマサ昆布ぽん酢」を全体に適量かける。お好みでこしょうをかける。"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("もやしは洗って水気を切り、耐熱容器に入れる。\n豚ばら薄切り肉に日本酒をまぶして揉み込み、STEP1の上を覆うように広げる。さらに千切りにしたしょうがを散らす。 豚ばら薄切り肉は、長ければ切ってから日本酒をまぶします。\nSTEP2をラップで覆い、電子レンジ600Wで6分ほど加熱して取り出す。ラップをしたまま1分ほど蒸らす。\nラップをはずして刻みねぎ、千切り大葉、白ごまを散らし、「ヤマサ昆布ぽん酢」を全体に適量かける。お好みでこしょうをかける。")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("recipe.yamasa.com")
    expect(recipe.canonical_url).to eq("https://recipe.yamasa.com/recipes/6368")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("ja")
    expect(recipe.author).to eq("神田智美")
    expect(recipe.description).to eq("[\"豚肉のうま味＝イノシン酸×昆布ぽん酢の昆布うま味＝グルタミン酸の「うま味の相乗効果」を利用した『豚ブースターレシピ』（※）。火を使わずに耐熱容器で作れる1品です。リーズナブルな素材で簡単にできて、かつヘルシー！うれしいことづくめのおかずです。※『豚ブースターレシピ』とは、「うま味の相乗効果」を活かして、豚肉料理を何倍も美味しくする料理をコンセプトにしたシリーズです。\", \"blank\"]")
    expect(recipe.image).to eq("https://recipe.yamasa.com/rails/active_storage/representations/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBBMGllQVE9PSIsImV4cCI6bnVsbCwicHVyIjoiYmxvYl9pZCJ9fQ==--55b3920c7e1ba892de4835dd92d8bc2f16b26f4a/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdCem9MWm05eWJXRjBTU0lJYW5CbkJqb0dSVlE2RkhKbGMybDZaVjkwYjE5c2FXMXBkRnNIYVFMZ0FXa0NhQUU9IiwiZXhwIjpudWxsLCJwdXIiOiJ2YXJpYXRpb24ifX0=--6feffee7c65eecfcf3c859a4c2158773ad0e829f/6368.jpg")
    expect(recipe.category).to eq("和風")
    expect(recipe.cuisine).to eq("もやしは洗って水気を切り、耐熱容器に入れる。 豚ばら薄切り肉に日本酒をまぶして揉み込み、STEP1の上を覆うように広げる。さらに千切りにしたしょうがを散らす。 豚ばら薄切り肉は、長ければ切ってから日本酒をまぶします。 STEP2をラップで覆い、電子レンジ600Wで6分ほど加熱して取り出す。ラップをしたまま1分ほど蒸らす。 ラップをはずして刻みねぎ、千切り大葉、白ごまを散らし、「ヤマサ昆布ぽん酢」を全体に適量かける。お好みでこしょうをかける。")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 items")
    expect(recipe.total_time).to eq(15)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(["レンジ 簡単 カンタン 豚 ブタ もやし モヤシ 薬味 ヤクミ ぽん酢 ポンズ 豚肉 ブタニク うま味 ウマミ イノシン 酸 サン 昆布 コンブ グルタミン酸 グルタミンサン 相乗 ソウジョウ 効果 コウカ 利用 リヨウ する シ ブースター レシピ 火 ヒ 使う ツカワ 耐熱 タイネツ 容器 ヨウキ 作れる ツクレル 1 品 ヒン リーズナブル 素材 ソザイ できる デキ ヘルシー こと コト づく ヅク め メ おかず オカズ 活かす イカシ 料理 リョウリ 何 ナン 倍 バイ スル コンセプト シリーズ ばら バラ 薄切り ウスギリ 肉 ニク しょうが ショウガ 刻み キザミ ねぎ ネギ 千切り センギリ 大葉 オオバ 白 シロ ごま ゴマ 日本 ニッポン 酒 シュ ヤマサ こしょう コショウ"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "415kcal",
      "sodiumContent" => "1.3 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 415.0 },
      { name: "sodiumContent", unit: "g", amount: 1.3 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
