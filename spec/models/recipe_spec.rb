# frozen_string_literal: true

RSpec.describe RecipeScrapers::Models::Recipe do
  let(:url) { "https://example.com/r/1" }
  let(:html) do
    <<~HTML
      <script type="application/ld+json">
        {"@type": "Recipe", "name": "Toast", "inLanguage": "en", "recipeIngredient": ["2 slices bread"],
         "nutrition": {"@type": "NutritionInformation", "calories": "120 kcal"}}
      </script>
    HTML
  end

  subject(:recipe) { RecipeScrapers.parse(html, url: url, supported_only: false) }

  it "is what parse returns, without the page it was read from", :aggregate_failures do
    expect(recipe).to be_a(described_class)
    expect(recipe).not_to respond_to(:document)
    expect(recipe.url).to eq(url)
  end

  it "answers every field a scraper reads" do
    expect(described_class.members - [:url]).to match_array(RecipeScrapers::Scraper::CONTRACT)
  end

  it "turns the nested value objects into hashes too", :aggregate_failures do
    expect(recipe.to_h[:parsed_ingredients]).to eq([{ amount: 2.0, unit: "slices", name: "bread" }])
    expect(recipe.to_h[:parsed_nutrients]).to eq([{ name: "calories", unit: "kcal", amount: 120.0 }])
    expect(recipe.to_h[:ingredient_groups]).to eq([{
      purpose: nil,
      ingredients: ["2 slices bread"],
      parsed_ingredients: [{ amount: 2.0, unit: "slices", name: "bread" }]
    }])
  end

  it "keeps the value objects on the recipe itself" do
    expect(recipe.parsed_ingredients.first).to be_a(RecipeScrapers::Models::Ingredient)
  end

  it "equals a recipe read from the same page" do
    expect(recipe).to eq(RecipeScrapers.parse(html, url: url, supported_only: false))
  end

  context "with a list that carries its headings and separators as lines" do
    let(:html) do
      <<~HTML
        <h1>Бефстроганов</h1>
        <table>
          <tr class="ingr"><td>Для мяса:</td></tr>
          <tr class="ingr"><td>Говядина – 450 г</td></tr>
          <tr class="ingr"><td>*</td></tr>
          <tr class="ingr"><td>Для пюре:</td></tr>
          <tr class="ingr"><td>Картофель – 1,2 кг</td></tr>
        </table>
      HTML
    end
    let(:declaration) { RecipeScrapers::Declaration.build("example.com") { ingredients rows: "tr.ingr" } }

    subject(:recipe) { RecipeScrapers::Scraper.new(html, url: url, declaration: declaration).to_recipe }

    it "keeps only the ingredient lines" do
      expect(recipe.ingredients).to eq(["Говядина – 450 г", "Картофель – 1,2 кг"])
    end

    it "parses no line into an empty ingredient" do
      expect(recipe.parsed_ingredients).to all(satisfy { |ingredient| ingredient.to_h.values.any? })
    end

    it "groups the ingredients under the headings" do
      expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients] }).to eq([
        ["Для мяса", ["Говядина – 450 г"]],
        ["Для пюре", ["Картофель – 1,2 кг"]]
      ])
    end

    it "parses the lines of every group the way it parses the whole list" do
      expect(recipe.ingredient_groups.flat_map(&:parsed_ingredients)).to eq(recipe.parsed_ingredients)
    end
  end
end
