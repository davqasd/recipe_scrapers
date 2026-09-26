# frozen_string_literal: true

RSpec.describe RecipeScrapers::Parsers::Vocabulary do
  it "picks the common words and the words of the language a tag names" do
    expect(described_class.names_for("en-US")).to eq(%i[common en])
  end

  it "picks one vocabulary for every language it declares" do
    expect(described_class.names_for("da")).to eq(%i[common scandinavian])
  end

  it "picks every vocabulary when the tag names no language" do
    expect(described_class.names_for(nil)).to match_array(described_class.catalog.keys)
  end

  it "picks every vocabulary when none declares the language" do
    expect(described_class.names_for("xx")).to match_array(described_class.catalog.keys)
  end

  it "adds the words of two vocabularies without repeating one" do
    both = described_class.new(units: %w[cup], number_words: { "one" => 1 }) +
           described_class.new(units: %w[cup tsp], number_words: { "two" => 2 })
    expect([both.units, both.number_words]).to eq([%w[cup tsp], { "one" => 1, "two" => 2 }])
  end

  it "loads every bundled vocabulary file into the catalog" do
    files = Dir[File.expand_path("../../lib/recipe_scrapers/parsers/vocabulary/*.yml", __dir__)]
    bundled = files.map { |path| File.basename(path, ".yml").to_sym }
    expect(described_class.catalog.keys).to match_array(bundled)
  end

  it "builds an alternation that never matches from no words" do
    expect("anything").not_to match(/#{described_class.alternation([])}/)
  end
end
