# frozen_string_literal: true

RSpec.describe RecipeScrapers::Declaration do
  subject(:declaration) do
    described_class.build("russianfood.com") do
      encoding "windows-1251"
      title "h1"
      ingredients rows: "#ingridients tr.ingr_tr_0"
    end
  end

  it "keeps the host" do
    expect(declaration.host).to eq("russianfood.com")
  end

  it "keeps the declared encoding" do
    expect(declaration.encoding_name).to eq("windows-1251")
  end

  it "stores a bare selector as a selector rule" do
    expect(declaration.rule(:title)).to eq({ selector: "h1" })
  end

  it "stores keyword options as given" do
    expect(declaration.rule(:ingredients)).to eq({ rows: "#ingridients tr.ingr_tr_0" })
  end

  it "has no rule for a field it never mentioned" do
    expect(declaration.rule(:cuisine)).to be_nil
  end

  it "refuses a field that is not in the contract" do
    expect { described_class.build("example.com") { calories "span" } }.
      to raise_error(NoMethodError)
  end

  describe "reading a declared field off a page carrying advertising scripts" do
    subject(:recipe) { RecipeScrapers.parse(page, url: "https://example.com/r/1", supported_only: false) }

    let(:page) do
      <<~HTML
        <html><body>
          <h1>Омлет<script>renderAd("title")</script></h1>
          <div class="ingr">Свёкла<script>renderAd("ingr")</script></div>
          <div class="step_n"><p>Свёклу и морковь обжарить.</p><script>if (w < 820) { renderAd("s_rec"); }</script></div>
          <div class="step_n"><p>Посолить.</p></div>
        </body></html>
      HTML
    end

    before do
      RecipeScrapers::Registry.register("example.com") do
        title "h1"
        ingredients rows: "div.ingr"
        instructions rows: "div.step_n"
      end
    end

    around do |example|
      saved = RecipeScrapers::Registry.snapshot
      example.run
      RecipeScrapers::Registry.restore(saved)
    end

    it "leaves the script out of a declared text field" do
      expect(recipe.title).to eq("Омлет")
    end

    it "leaves the script out of a declared row", :aggregate_failures do
      expect(recipe.ingredients).to eq(["Свёкла"])
      expect(recipe.instructions_list).to eq(["Свёклу и морковь обжарить.", "Посолить."])
    end
  end

  describe "reading a row the way the page renders it" do
    subject(:recipe) { RecipeScrapers.parse(page, url: "https://example.com/r/1", supported_only: false) }

    let(:page) do
      <<~HTML
        <html><body>
          <h1>Carrots</h1>
          <li class="ingredient">- 6 <b>c</b>arrots</li>
          <li class="ingredient">2 tbsp honey</li>
          <li class="ingredient"><span>1</span><span>cup</span> flour</li>
          <div class="step">1. Pe<span>el the carrots.</span></div>
        </body></html>
      HTML
    end

    before do
      RecipeScrapers::Registry.register("example.com") do
        title "h1"
        ingredients rows: "li.ingredient"
        instructions rows: "div.step"
      end
    end

    around do |example|
      saved = RecipeScrapers::Registry.snapshot
      example.run
      RecipeScrapers::Registry.restore(saved)
    end

    it "reads a row as the page shows it, without its list marker", :aggregate_failures do
      expect(recipe.ingredients).to eq(["6 carrots", "2 tbsp honey", "1 cup flour"])
      expect(recipe.instructions_list).to eq(["Peel the carrots."])
    end
  end
end
