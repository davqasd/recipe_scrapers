# frozen_string_literal: true

RSpec.describe RecipeScrapers::Scraper do
  subject(:scraper) { described_class.new("<html><body></body></html>", url: "https://example.com/r/1") }

  it "answers every method in the contract" do
    RecipeScrapers::Scraper::CONTRACT.each do |field|
      expect(scraper).to respond_to(field)
    end
  end

  it "counts twenty eight fields in the contract" do
    expect(RecipeScrapers::Scraper::CONTRACT.size).to eq(28)
  end

  it "reads the host off the url with the www stripped" do
    expect(scraper.host).to eq("example.com")
  end

  it "falls back to the url when the page names no canonical" do
    expect(scraper.canonical_url).to eq("https://example.com/r/1")
  end

  it "resolves an image path against the page url" do
    html = '<script type="application/ld+json">{"@type":"Recipe","name":"Toast","image":"/img/toast.jpg"}</script>'
    expect(described_class.new(html, url: "https://example.com/r/1").image).to eq("https://example.com/img/toast.jpg")
  end

  it "reads the address a site glued behind its own host" do
    html = '<meta property="og:title" content="Toast">' \
           '<meta property="og:image" content="http://example.comhttps://cdn.example.com/t.jpg">'
    expect(described_class.new(html, url: "https://example.com/r/1").image).to eq("https://cdn.example.com/t.jpg")
  end

  it "keeps an image address that carries another address in its query" do
    html = '<meta property="og:image" content="https://img.example.com/fit?src=https://cdn.example.com/t.jpg">'
    expect(described_class.new(html, url: "https://example.com/r/1").image).
      to eq("https://img.example.com/fit?src=https://cdn.example.com/t.jpg")
  end

  it "gives a protocol relative image the scheme of the page" do
    html = '<script type="application/ld+json">{"@type":"Recipe","image":"//cdn.example.com/t.jpg"}</script>'
    expect(described_class.new(html, url: "https://example.com/r/1").image).to eq("https://cdn.example.com/t.jpg")
  end

  it "parses every ingredient line in the order the page lists them" do
    html = <<~HTML
      <script type="application/ld+json">
        {"@type": "Recipe", "name": "Toast", "recipeIngredient": ["2 slices bread", "Butter (salted)"]}
      </script>
    HTML
    recipe = described_class.new(html, url: "https://example.com/r/1")

    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "slices", name: "bread" },
      { amount: nil, unit: nil, name: "Butter" }
    ])
  end

  it "leaves the parsed ingredients empty when the page lists no ingredients" do
    expect(scraper.parsed_ingredients).to be_nil
  end

  it "leaves the parsed nutrients empty when the page publishes no nutrients" do
    expect(scraper.parsed_nutrients).to be_nil
  end

  it "keys to_h by the contract" do
    expect(scraper.to_h.keys).to match_array(RecipeScrapers::Scraper::CONTRACT)
  end
end
