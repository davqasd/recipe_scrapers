# frozen_string_literal: true

RSpec.describe RecipeScrapers::Sources::SchemaOrg::IngredientList do
  it "reads a flat list of lines" do
    expect(described_class.parse(["1 beet", "2 carrots"])).to eq(["1 beet", "2 carrots"])
  end

  it "flattens a list the site grouped into sublists" do
    expect(described_class.parse([["1 beet"], ["2 carrots", "salt"]])).to eq(["1 beet", "2 carrots", "salt"])
  end

  it "reads a single line the site published as a string" do
    expect(described_class.parse("1 beet")).to eq(["1 beet"])
  end

  it "collapses the whitespace and the markup in a line" do
    expect(described_class.parse(["  1 <b>large</b>\n  beet  "])).to eq(["1 large beet"])
  end

  it "drops a line that is blank once normalized" do
    expect(described_class.parse(["1 beet", "   ", nil])).to eq(["1 beet"])
  end

  it "returns nil when nothing is published" do
    expect(described_class.parse(nil)).to be_nil
  end

  it "returns nil when every line is blank" do
    expect(described_class.parse(["", " "])).to be_nil
  end

  it "joins a property value into a value, a unit and a name" do
    item = { "@type" => "PropertyValue", "value" => "2", "unitText" => "cups", "name" => "flour" }
    expect(described_class.parse([item])).to eq(["2 cups flour"])
  end

  it "falls back to the unit code when a property value names no unit text" do
    item = { "@type" => "PropertyValue", "value" => "2", "unitCode" => "C62", "name" => "eggs" }
    expect(described_class.parse([item])).to eq(["2 C62 eggs"])
  end

  it "leaves out the unit a property value omits" do
    item = { "@type" => "PropertyValue", "value" => "2", "name" => "eggs" }
    expect(described_class.parse([item])).to eq(["2 eggs"])
  end
end
