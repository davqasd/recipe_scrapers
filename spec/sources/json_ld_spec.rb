# frozen_string_literal: true

RSpec.describe RecipeScrapers::Sources::JsonLd do
  def build(json)
    document = Nokogiri::HTML5(<<~HTML)
      <html><head>
      <script type="application/ld+json">#{json}</script>
      </head><body></body></html>
    HTML
    described_class.new(document)
  end

  it "finds a recipe at the top level" do
    reader = build('{"@context":"https://schema.org","@type":"Recipe","name":"Borscht"}')
    expect(reader.recipe["name"]).to eq("Borscht")
  end

  it "finds a recipe inside an @graph" do
    reader = build(<<~JSON)
      {"@context":"https://schema.org","@graph":[
        {"@type":"WebSite","name":"Eda"},
        {"@type":"Recipe","name":"Borscht"}]}
    JSON
    expect(reader.recipe["name"]).to eq("Borscht")
  end

  it "finds a recipe hanging off a WebPage mainEntity" do
    reader = build(<<~JSON)
      {"@context":"https://schema.org","@type":"WebPage",
       "mainEntity":{"@type":"Recipe","name":"Borscht"}}
    JSON
    expect(reader.recipe["name"]).to eq("Borscht")
  end

  it "accepts a type given as an array" do
    reader = build('{"@context":"https://schema.org","@type":["Recipe","Thing"],"name":"Borscht"}')
    expect(reader.recipe["name"]).to eq("Borscht")
  end

  it "indexes a person by id so an author reference resolves" do
    reader = build(<<~JSON)
      {"@context":"https://schema.org","@graph":[
        {"@type":"Person","@id":"#nagi","name":"Nagi"},
        {"@type":"Recipe","name":"Kale Salad","author":{"@id":"#nagi"}}]}
    JSON
    expect(reader.person("#nagi")["name"]).to eq("Nagi")
  end

  it "indexes an aggregate rating by id" do
    reader = build(<<~JSON)
      {"@context":"https://schema.org","@graph":[
        {"@type":"AggregateRating","@id":"#r","ratingValue":4.5,"ratingCount":12},
        {"@type":"Recipe","name":"Kale Salad","aggregateRating":{"@id":"#r"}}]}
    JSON
    expect(reader.rating("#r")["ratingCount"]).to eq(12)
  end

  it "reads the website name" do
    reader = build(<<~JSON)
      {"@context":"https://schema.org","@graph":[
        {"@type":"WebSite","name":"Eda"},
        {"@type":"Recipe","name":"Borscht"}]}
    JSON
    expect(reader.website_name).to eq("Eda")
  end

  it "keeps the last value of a key the recipe repeats" do
    reader = build('{"@type":"Recipe","name":"Old","name":"Borscht"}')
    expect(reader.recipe["name"]).to eq("Borscht")
  end

  it "reads a recipe wrapped in a commented CDATA section" do
    reader = build("// <![CDATA[\n{\"@type\":\"Recipe\",\"name\":\"Borscht\"}\n// ]]>")
    expect(reader.recipe["name"]).to eq("Borscht")
  end

  it "reads a recipe followed by a stray semicolon" do
    reader = build('{"@type":"Recipe","name":"Borscht"};')
    expect(reader.recipe["name"]).to eq("Borscht")
  end

  it "survives a script tag holding invalid json" do
    reader = build("{ not json")
    expect(reader.recipe).to be_nil
  end

  it "returns nil when no script carries a recipe" do
    reader = build('{"@context":"https://schema.org","@type":"WebSite","name":"Eda"}')
    expect(reader.recipe).to be_nil
  end
end
