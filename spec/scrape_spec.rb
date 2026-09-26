# frozen_string_literal: true

RSpec.describe "RecipeScrapers.scrape" do
  around do |example|
    saved = RecipeScrapers::Registry.snapshot
    RecipeScrapers::Registry.clear!
    example.run
    RecipeScrapers::Registry.restore(saved)
    RecipeScrapers.reset_config!
  end

  let(:page) do
    <<~HTML
      <html><head><script type="application/ld+json">
      {"@context":"https://schema.org","@type":"Recipe","name":"Borscht","recipeIngredient":["1 beet"]}
      </script></head><body></body></html>
    HTML
  end

  def stubbed_connection(body)
    Faraday.new do |faraday|
      faraday.adapter :test do |stub|
        stub.get("https://example.com/r/1") { [200, { "Content-Type" => "text/html" }, body] }
      end
    end
  end

  it "fetches and parses through a supplied connection" do
    RecipeScrapers.register("example.com")
    recipe = RecipeScrapers.scrape("https://example.com/r/1", connection: stubbed_connection(page))
    expect(recipe.title).to eq("Borscht")
  end

  it "uses the configured connection when none is passed" do
    RecipeScrapers.register("example.com")
    RecipeScrapers.configure { |config| config.connection = stubbed_connection(page) }
    expect(RecipeScrapers.scrape("https://example.com/r/1").title).to eq("Borscht")
  end

  it "carries supported_only through to parse" do
    expect do
      RecipeScrapers.scrape("https://example.com/r/1", connection: stubbed_connection(page))
    end.to raise_error(RecipeScrapers::UnsupportedSite)
  end

  it "keeps the url it was given as the parse url" do
    RecipeScrapers.register("example.com")
    recipe = RecipeScrapers.scrape("https://example.com/r/1", connection: stubbed_connection(page))
    expect(recipe.url).to eq("https://example.com/r/1")
  end
end
