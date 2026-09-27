# frozen_string_literal: true

RSpec.describe "xiachufang.com" do
  subject(:recipe) { scrape_cassette("com/xiachufang", url: "https://www.xiachufang.com/recipe/107491076/") }

  it "reads the title" do
    expect(recipe.title).to eq("蒜蓉蚝油生菜")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq(%w[
      一个生菜
      5瓣蒜
      两勺生抽
      一勺蚝油
      适量盐
      适量糖
      适量香油
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "一个生菜" },
      { amount: 5.0, unit: nil, name: "瓣蒜" },
      { amount: nil, unit: nil, name: "两勺生抽" },
      { amount: nil, unit: nil, name: "一勺蚝油" },
      { amount: nil, unit: nil, name: "适量盐" },
      { amount: nil, unit: nil, name: "适量糖" },
      { amount: nil, unit: nil, name: "适量香油" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "1.准备两种料汁。",
      "一种是水淀粉：放入一勺土豆淀粉后再加入少半碗水备用（这个水一定不能少）；",
      "另一种是蚝油料汁：碗里加入两勺生抽，一勺蚝油，半勺糖，适量水拌匀备用。 2.大蒜切成蒜末备用。 3.将生菜切掉根部后焯水，焯水前在水里放适量的油和盐。生菜焯水20秒左右即可捞出，捞出后摆盘。 4.起锅烧油，小火放入蒜末炒香。不要大火，以防蒜末炒黄。 5.蒜末炒香后放入蚝油汁，将蚝油汁炒开。 6.将水淀粉倒入。等锅中有一点挂糊后看料汁多少，如果料汁太稀可多热一会，如果料汁太浓就关火再加水，也可尝尝咸淡，根据口味调整水和盐的量。",
      "注意：此时很有可能水淀粉刚倒进去汤汁就很粘稠了，这说明水淀粉的水太少需要立刻加水，哪怕多加一点好控制让水蒸发完。",
      "这一步也要尝咸淡，不要觉得2勺生抽就有点咸了，其实裹在菜上的料汁并没有多少的。 7.最后一步加入几滴香油。 8.一切准备就绪后将料汁倒入盘中，一道蚝油生菜就做好了。"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("1.准备两种料汁。\n一种是水淀粉：放入一勺土豆淀粉后再加入少半碗水备用（这个水一定不能少）；\n另一种是蚝油料汁：碗里加入两勺生抽，一勺蚝油，半勺糖，适量水拌匀备用。 2.大蒜切成蒜末备用。 3.将生菜切掉根部后焯水，焯水前在水里放适量的油和盐。生菜焯水20秒左右即可捞出，捞出后摆盘。 4.起锅烧油，小火放入蒜末炒香。不要大火，以防蒜末炒黄。 5.蒜末炒香后放入蚝油汁，将蚝油汁炒开。 6.将水淀粉倒入。等锅中有一点挂糊后看料汁多少，如果料汁太稀可多热一会，如果料汁太浓就关火再加水，也可尝尝咸淡，根据口味调整水和盐的量。\n注意：此时很有可能水淀粉刚倒进去汤汁就很粘稠了，这说明水淀粉的水太少需要立刻加水，哪怕多加一点好控制让水蒸发完。\n这一步也要尝咸淡，不要觉得2勺生抽就有点咸了，其实裹在菜上的料汁并没有多少的。 7.最后一步加入几滴香油。 8.一切准备就绪后将料汁倒入盘中，一道蚝油生菜就做好了。")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("xiachufang.com")
    expect(recipe.canonical_url).to eq("https://www.xiachufang.com/recipe/107491076/")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to be_nil
    expect(recipe.author).to eq("随便做做xx")
    expect(recipe.description).to eq("1.准备两种料汁。 一种是水淀粉：放入一勺土豆淀粉后再加入少半碗水备用（这个水一定不能少）； 另一种是蚝油料汁：碗里加入两勺生抽，一勺蚝油，半勺糖，适量水拌匀备用；2.大蒜切成蒜末备用；3.将生菜切掉根部后焯水，焯水前在水里放适量的油和盐。生菜焯水20秒左右即可捞出，捞出后摆盘；4.起锅烧油，小火放入蒜末炒香。不要大火，以防蒜末炒黄；5.蒜末炒香后放入蚝油汁，将蚝油汁炒开；6.将水淀粉倒入。等锅中...")
    expect(recipe.image).to eq("https://i2.chuimg.com/08a60c0a095448508b1071e0079f2467_1280w_1706h.jpg?imageView2/1/w/280/h/216/interlace/1/q/75")
    expect(recipe.category).to eq("快手菜")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(%w[蒜蓉蚝油生菜的做法 蒜蓉蚝油生菜的家常做法 蒜蓉蚝油生菜的详细做法 蒜蓉蚝油生菜怎么做 蒜蓉蚝油生菜的最正宗做法 快手菜])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(7.7)
    expect(recipe.ratings_count).to eq(174)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
