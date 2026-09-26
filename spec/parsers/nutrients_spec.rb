# frozen_string_literal: true

RSpec.describe RecipeScrapers::Parsers::Nutrients do
  def parsed(text) = described_class.call(text)&.to_h&.slice(:amount, :unit)

  it "splits a value into an amount and a unit" do
    expect(parsed("12.5 g")).to eq(amount: 12.5, unit: "g")
  end

  it "reads a unit glued to the amount" do
    expect(parsed("310mg")).to eq(amount: 310.0, unit: "mg")
  end

  it "reads a decimal written with a comma" do
    expect(parsed("1,5 g")).to eq(amount: 1.5, unit: "g")
  end

  it "keeps every decimal the site writes" do
    expect(parsed("0.001 g")).to eq(amount: 0.001, unit: "g")
  end

  it "keeps a zero amount" do
    expect(parsed("0 g")).to eq(amount: 0.0, unit: "g")
  end

  it "writes a spelled out mass unit as its symbol" do
    expect(parsed("12 grams sugar")).to eq(amount: 12.0, unit: "g")
    expect(parsed("8 milligrams sodium")).to eq(amount: 8.0, unit: "mg")
  end

  it "writes every spelling of the kilocalorie as kcal" do
    expect(["249 calories", "138 кКал", "90 KCAL", "150 cal"].map { |text| parsed(text)[:unit] }).to all(eq("kcal"))
  end

  it "writes a cyrillic gram as g" do
    expect(parsed("6 г.")).to eq(amount: 6.0, unit: "g")
  end

  it "keeps a unit it has no symbol for as written" do
    expect(parsed("1 serving")).to eq(amount: 1.0, unit: "serving")
  end

  it "reads an amount a label comes before" do
    expect(parsed("Sugars 16g")).to eq(amount: 16.0, unit: "g")
  end

  it "leaves the unit empty for a bare number" do
    expect(parsed("219")).to eq(amount: 219.0, unit: nil)
  end

  it "reads a fraction" do
    expect(parsed("1/2 cup")).to eq(amount: 0.5, unit: "cup")
  end

  it "drops the text in parentheses" do
    expect(parsed("1 pieces (approx 30g)")).to eq(amount: 1.0, unit: "pieces")
  end

  it "does not read a connector as the unit" do
    expect(parsed("1 /4 of recipe")).to eq(amount: 0.25, unit: nil)
  end

  it "leaves the name to the caller, which knows the key the value sat under" do
    expect(described_class.call("12.5 g").name).to be_nil
  end

  it "reads nothing from a value with no number" do
    expect(parsed("Easy Garlic Chicken")).to be_nil
  end
end
