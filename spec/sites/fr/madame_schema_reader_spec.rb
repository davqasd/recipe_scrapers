# frozen_string_literal: true

RSpec.describe "madame.lefigaro.fr, the schema reader" do
  def parse(instructions)
    html = <<~HTML
      <html><head><script type="application/ld+json">
      {"@context":"https://schema.org","@type":"Recipe","name":"Sauce tomate",
       "recipeIngredient":["1 kg de tomates"],
       "recipeInstructions":#{instructions}}
      </script></head><body></body></html>
    HTML
    RecipeScrapers.parse(html, url: "https://madame.lefigaro.fr/recettes/sauce-tomate")
  end

  let(:named_steps) do
    <<~JSON
      [{"@type":"HowToStep","name":"Finitions","text":"Ajoutez l'huile."}]
    JSON
  end

  it "reads the title and the ingredients out of json-ld", :aggregate_failures do
    recipe = parse(named_steps)
    expect(recipe.title).to eq("Sauce tomate")
    expect(recipe.ingredients).to eq(["1 kg de tomates"])
  end

  it "merges the name of a step into the line carrying its text" do
    expect(parse(named_steps).instructions_list).to eq(["Finitions: Ajoutez l'huile."])
  end

  it "keeps a lone line for a step whose text already opens with its name" do
    instructions = <<~JSON
      [{"@type":"HowToStep","name":"Ajoutez l'huile.","text":"Ajoutez l'huile et servez."}]
    JSON
    expect(parse(instructions).instructions_list).to eq(["Ajoutez l'huile et servez."])
  end

  it "keeps a step with no name as one line" do
    instructions = <<~JSON
      [{"@type":"HowToStep","text":"Ajoutez l'huile."}]
    JSON
    expect(parse(instructions).instructions_list).to eq(["Ajoutez l'huile."])
  end
end
