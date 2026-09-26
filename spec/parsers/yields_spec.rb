# frozen_string_literal: true

RSpec.describe RecipeScrapers::Parsers::Yields do
  it "normalizes a count of servings" do
    expect(described_class.parse("4 servings")).to eq("4 servings")
  end

  it "normalizes a sentence naming servings" do
    expect(described_class.parse("Serves 6")).to eq("6 servings")
  end

  it "keeps a unit the text names" do
    expect(described_class.parse("12 cookies")).to eq("12 items")
  end

  it "reads a bare number as servings" do
    expect(described_class.parse(8)).to eq("8 servings")
  end

  it "returns nil when there is no number" do
    expect(described_class.parse("a plateful")).to be_nil
  end
end
