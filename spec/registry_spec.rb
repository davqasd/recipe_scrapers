# frozen_string_literal: true

RSpec.describe RecipeScrapers::Registry do
  around do |example|
    saved = described_class.snapshot
    described_class.clear!
    example.run
    described_class.restore(saved)
  end

  it "finds a declaration by host" do
    described_class.register("example.com")
    expect(described_class.for("https://example.com/r/1").host).to eq("example.com")
  end

  it "ignores a www prefix" do
    described_class.register("example.com")
    expect(described_class.for("https://www.example.com/r/1")).not_to be_nil
  end

  it "registers extra domains from also" do
    described_class.register("aldi-nord.de", also: %w[aldi.es aldi.fr])
    expect(described_class.for("https://aldi.fr/r/1").host).to eq("aldi-nord.de")
  end

  it "returns nil for an unknown host" do
    expect(described_class.for("https://nowhere.example/r/1")).to be_nil
  end

  it "registers a scraper class by its declared host" do
    klass = Class.new(RecipeScrapers::Scraper) { host "nih.example" }
    described_class.register_class(klass)
    expect(described_class.for("https://nih.example/r/1")).to eq(klass)
  end

  it "lists every registered host" do
    described_class.register("a.example")
    described_class.register("b.example", also: ["c.example"])
    expect(described_class.hosts).to match_array(%w[a.example b.example c.example])
  end
end
