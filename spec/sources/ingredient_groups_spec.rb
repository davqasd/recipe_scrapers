# frozen_string_literal: true

RSpec.describe RecipeScrapers::Sources::IngredientGroups do
  let(:document) do
    Nokogiri::HTML5(<<~HTML)
      <div class="ing">
        <h3 class="head">For the base</h3>
        <li class="item">400 g kale</li>
        <li class="item">1 clove garlic</li>
        <h3 class="head">For the dressing</h3>
        <li class="item">2 tbsp oil</li>
      </div>
    HTML
  end

  let(:ingredients) { ["400 g kale", "1 clove garlic", "2 tbsp oil"] }

  it "splits the ingredients under their headings", :aggregate_failures do
    groups = described_class.call(
      document: document, ingredients: ingredients, heading: "h3.head", item: "li.item"
    )
    expect(groups.map(&:purpose)).to eq(["For the base", "For the dressing"])
    expect(groups.map(&:ingredients)).to eq([["400 g kale", "1 clove garlic"], ["2 tbsp oil"]])
  end

  it "returns one unnamed group when the page has no headings", :aggregate_failures do
    plain = Nokogiri::HTML5('<li class="item">400 g kale</li>')
    groups = described_class.call(
      document: plain, ingredients: ["400 g kale"], heading: "h3.head", item: "li.item"
    )
    expect(groups.map(&:purpose)).to eq([nil])
    expect(groups.first.ingredients).to eq(["400 g kale"])
  end

  it "finds the groups a wp recipe maker page marks up, without a declaration" do
    page = Nokogiri::HTML5(<<~HTML)
      <div class="wprm-recipe-ingredient-group">
        <h4 class="wprm-recipe-ingredient-group-name">For the base</h4>
        <li class="wprm-recipe-ingredient">400 g kale</li>
      </div>
      <div class="wprm-recipe-ingredient-group">
        <h4 class="wprm-recipe-ingredient-group-name">For the dressing</h4>
        <li class="wprm-recipe-ingredient">2 tbsp oil</li>
      </div>
    HTML
    groups = described_class.detect(document: page, ingredients: ["400 g kale", "2 tbsp oil"])
    expect(groups.map(&:purpose)).to eq(["For the base", "For the dressing"])
  end

  it "returns one unnamed group when it recognises no layout" do
    page = Nokogiri::HTML5("<ul><li>400 g kale</li></ul>")
    groups = described_class.detect(document: page, ingredients: ["400 g kale"])
    expect(groups.map { |group| [group.purpose, group.ingredients] }).to eq([[nil, ["400 g kale"]]])
  end

  it "refuses a layout whose item count disagrees with the ingredient list" do
    groups = described_class.call(
      document: document, ingredients: ["400 g kale"], heading: "h3.head", item: "li.item"
    )
    expect(groups.map(&:purpose)).to eq([nil])
  end

  describe ".sections" do
    it "drops a line with no letter and no digit" do
      expect(described_class.sections(["2 eggs", "*", "—", "salt"])).to eq([[nil, ["2 eggs", "salt"]]])
    end

    it "starts a section at a line that ends in a colon and has no digit" do
      lines = ["For the dough:", "200 g flour", "Для крема:", "100 г сливок"]
      expect(described_class.sections(lines)).
        to eq([["For the dough", ["200 g flour"]], ["Для крема", ["100 г сливок"]]])
    end

    it "keeps a line with an amount after the colon as an ingredient" do
      expect(described_class.sections(["Salt: 1 tsp"])).to eq([[nil, ["Salt: 1 tsp"]]])
    end

    it "drops a heading that no ingredient follows" do
      expect(described_class.sections(["2 eggs", "To serve:"])).to eq([[nil, ["2 eggs"]]])
    end
  end
end
