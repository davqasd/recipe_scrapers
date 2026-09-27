# frozen_string_literal: true

RSpec.describe "mykitchen101.com" do
  subject(:recipe) { scrape_cassette("com/mykitchen101", url: "https://mykitchen101.com/nyonya-acar-%E5%A8%98%E6%83%B9%E5%BC%8F%E8%85%8C%E5%88%B6%E6%9D%82%E8%8F%9C/") }

  it "reads the title" do
    expect(recipe.title).to eq("Nyonya Acar – 娘惹式腌制杂菜")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "100 克 花生",
      "80 克 白芝麻",
      "200 克 红萝卜",
      "200 克 长豆",
      "200 克 黄瓜",
      "200 克 包菜",
      "2 汤匙 盐",
      "300 克 黄梨 (凤梨)",
      "2 支 香茅 (切段)",
      "200 克 红辣椒 (去籽切小段)",
      "80 克 红葱头 (shallot)",
      "30 克 蒜 (garlic)",
      "12 克 南姜 (2片, Galangal)",
      "5 克 辣椒干 (去籽剪段)",
      "½ 茶匙 黄姜粉",
      "160 克 油",
      "4 汤匙 油",
      "100 克 糖",
      "1 茶匙 盐",
      "150 毫升 白米醋"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 100.0, unit: nil, name: "克 花生" },
      { amount: 80.0, unit: nil, name: "克 白芝麻" },
      { amount: 200.0, unit: nil, name: "克 红萝卜" },
      { amount: 200.0, unit: nil, name: "克 长豆" },
      { amount: 200.0, unit: nil, name: "克 黄瓜" },
      { amount: 200.0, unit: nil, name: "克 包菜" },
      { amount: 2.0, unit: nil, name: "汤匙 盐" },
      { amount: 300.0, unit: nil, name: "克 黄梨" },
      { amount: 2.0, unit: nil, name: "支 香茅" },
      { amount: 200.0, unit: nil, name: "克 红辣椒" },
      { amount: 80.0, unit: nil, name: "克 红葱头" },
      { amount: 30.0, unit: nil, name: "克 蒜" },
      { amount: 12.0, unit: nil, name: "克 南姜" },
      { amount: 5.0, unit: nil, name: "克 辣椒干" },
      { amount: 0.5, unit: nil, name: "茶匙 黄姜粉" },
      { amount: 160.0, unit: nil, name: "克 油" },
      { amount: 4.0, unit: nil, name: "汤匙 油" },
      { amount: 100.0, unit: nil, name: "克 糖" },
      { amount: 1.0, unit: nil, name: "茶匙 盐" },
      { amount: 150.0, unit: nil, name: "毫升 白米醋" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "花生铺平在烤盘上，以170°C/340°F预热烤箱烘烤15分钟，或直到呈金黄色。 冷却后把花生米的表皮去掉。(注: 烘烤时间只供参考，需要根据个别的烤箱做出适当的调整。)用食物调理机把花生打成粗颗粒状，搁置一旁备用。",
      "白芝麻放入干锅，以中火炒香，时间大约3-4分钟，搁置一旁备用。",
      "红萝卜，长豆，黄瓜，包菜清洗干净，切成条状，大约3厘米左右的长度。",
      "把切成条状的蔬菜加入2汤匙盐搅拌均匀，腌制30分钟。",
      "腌制蔬菜后多余的水分去掉，用清水冲洗干净，滤干水分。",
      "把一大锅水滚开后，汆烫蔬菜60秒。",
      "把汆烫好的蔬菜摊开铺平在干净的布上，放在通风的地方或用风扇吹，稍微风干，至少一小时。",
      "黄梨(凤梨)切成条状，大约3厘米。",
      "用少许油，开大火把黄梨的水份稍微收干，大约2至3分钟。",
      "把2支香茅(切段)，200克红辣椒(去籽切小段)，80克红葱头，30克蒜，12克南姜，5克辣椒干(去籽剪段)，½茶匙黄姜粉，160克油放入搅拌器打成糊。",
      "锅加入4汤匙油加热，把辣椒糊倒入锅中，加热至滚开，转至中火或中小火，继续拌炒8-10分钟至香。",
      "拌入100克糖，1茶匙盐和150毫升白米醋，加热至滚开。",
      "把多余的油去掉。拌入蔬菜和黄梨，搅拌均匀即可熄火。",
      "倒入芝麻和花生，搅拌均匀就可以了。",
      "完全冷却后放入干净的玻璃罐，冷藏保存至1个月。"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("花生铺平在烤盘上，以170°C/340°F预热烤箱烘烤15分钟，或直到呈金黄色。 冷却后把花生米的表皮去掉。(注: 烘烤时间只供参考，需要根据个别的烤箱做出适当的调整。)用食物调理机把花生打成粗颗粒状，搁置一旁备用。\n白芝麻放入干锅，以中火炒香，时间大约3-4分钟，搁置一旁备用。\n红萝卜，长豆，黄瓜，包菜清洗干净，切成条状，大约3厘米左右的长度。\n把切成条状的蔬菜加入2汤匙盐搅拌均匀，腌制30分钟。\n腌制蔬菜后多余的水分去掉，用清水冲洗干净，滤干水分。\n把一大锅水滚开后，汆烫蔬菜60秒。\n把汆烫好的蔬菜摊开铺平在干净的布上，放在通风的地方或用风扇吹，稍微风干，至少一小时。\n黄梨(凤梨)切成条状，大约3厘米。\n用少许油，开大火把黄梨的水份稍微收干，大约2至3分钟。\n把2支香茅(切段)，200克红辣椒(去籽切小段)，80克红葱头，30克蒜，12克南姜，5克辣椒干(去籽剪段)，½茶匙黄姜粉，160克油放入搅拌器打成糊。\n锅加入4汤匙油加热，把辣椒糊倒入锅中，加热至滚开，转至中火或中小火，继续拌炒8-10分钟至香。\n拌入100克糖，1茶匙盐和150毫升白米醋，加热至滚开。\n把多余的油去掉。拌入蔬菜和黄梨，搅拌均匀即可熄火。\n倒入芝麻和花生，搅拌均匀就可以了。\n完全冷却后放入干净的玻璃罐，冷藏保存至1个月。")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("mykitchen101.com")
    expect(recipe.canonical_url).to eq("https://mykitchen101.com/nyonya-acar-%e5%a8%98%e6%83%b9%e5%bc%8f%e8%85%8c%e5%88%b6%e6%9d%82%e8%8f%9c/")
    expect(recipe.site_name).to eq("清闲廚房")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Nyonya Acar 是一道充滿南洋風味的娘惹式腌制酸辣杂菜。在新马一带，这是很地道的开胃菜肴。制作这娘惹阿杂(Nyonya Acar)虽然步骤简单，但是准备所需要的材料会比较费时。")
    expect(recipe.image).to eq("https://mykitchen101.com/wp-content/uploads/2020/08/acarnyonya17.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
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
    expect(recipe.links).to include("#")
  end
end
