# frozen_string_literal: true

RSpec.describe "chefkoch.de, the schema reader" do
  def parse(instructions)
    html = <<~HTML
      <html><head><script type="application/ld+json">
      {"@context":"https://schema.org","@type":"Recipe","name":"Hackbraten",
       "recipeIngredient":["500 g Hackfleisch"],
       "recipeInstructions":#{instructions}}
      </script></head><body></body></html>
    HTML
    RecipeScrapers.parse(html, url: "https://www.chefkoch.de/rezepte/1/Hackbraten.html")
  end

  let(:numbered_section) do
    <<~JSON
      [{"@type":"HowToSection","name":"Zubereitung","itemListElement":[
        {"@type":"HowToStep","name":1,"text":"Die Semmeln einweichen."},
        {"@type":"HowToStep","name":2,"text":"Die Zwiebeln anschwitzen."}]}]
    JSON
  end

  it "reads the title and the ingredients out of json-ld", :aggregate_failures do
    recipe = parse(numbered_section)
    expect(recipe.title).to eq("Hackbraten")
    expect(recipe.ingredients).to eq(["500 g Hackfleisch"])
  end

  it "leaves out the section heading and the numbering the steps carry as names" do
    expect(parse(numbered_section).instructions_list).
      to eq(["Die Semmeln einweichen.", "Die Zwiebeln anschwitzen."])
  end

  it "keeps a step name the step text does not open with" do
    instructions = <<~JSON
      [{"@type":"HowToStep","name":"Vorbereitung","text":"Die Semmeln einweichen."}]
    JSON
    expect(parse(instructions).instructions_list).to eq(["Vorbereitung", "Die Semmeln einweichen."])
  end
end
