# frozen_string_literal: true

RSpec.describe RecipeScrapers::Sources::OpenGraph do
  subject(:graph) { described_class.new(Nokogiri::HTML5(html)) }

  let(:html) do
    <<~HTML
      <html><head>
      <meta property="og:title" content=" Borscht ">
      <meta property="og:image" content="https://example.com/b.jpg">
      <meta property="og:site_name" content="Eda">
      <title>Fallback title</title>
      </head><body></body></html>
    HTML
  end

  it "reads the og title" do
    expect(graph.title).to eq("Borscht")
  end

  it "reads the og image" do
    expect(graph.image).to eq("https://example.com/b.jpg")
  end

  it "reads the og site name" do
    expect(graph.site_name).to eq("Eda")
  end

  it "falls back to the title tag" do
    graph = described_class.new(Nokogiri::HTML5("<html><head><title>Only this</title></head></html>"))
    expect(graph.title).to eq("Only this")
  end

  it "returns nil when the page carries neither" do
    graph = described_class.new(Nokogiri::HTML5("<html><body></body></html>"))
    expect(graph.title).to be_nil
  end
end
