# frozen_string_literal: true

RSpec.describe RecipeScrapers::SitePath do
  it "puts a site in the directory of the last label of its host", :aggregate_failures do
    expect(described_class.for("russianfood.com")).to eq("com/russianfood")
    expect(described_class.for("eda.ru")).to eq("ru/eda")
    expect(described_class.for("bbc.co.uk")).to eq("uk/bbc")
  end

  it "names the file after the first label, with underscores for dashes", :aggregate_failures do
    expect(described_class.for("aldi-nord.de")).to eq("de/aldi_nord")
    expect(described_class.for("101cookbooks.com")).to eq("com/101cookbooks")
  end
end
