# frozen_string_literal: true

RSpec.describe "the registry, against the suite" do
  def spec_for(host)
    File.expand_path("sites/#{RecipeScrapers::SitePath.for(host)}_spec.rb", __dir__)
  end

  def shares_a_covered_declaration?(host)
    entry = RecipeScrapers::Registry.entries[host]
    RecipeScrapers::Registry.entries.any? do |other, value|
      other != host && value.equal?(entry) && File.exist?(spec_for(other))
    end
  end

  def covered?(host)
    File.exist?(spec_for(host)) || shares_a_covered_declaration?(host)
  end

  it "has a spec for every registered host" do
    expect(RecipeScrapers::Registry.hosts.reject { |host| covered?(host) }).to be_empty
  end

  it "registers every host a site spec names" do
    named = Dir[File.expand_path("sites/**/*_spec.rb", __dir__)].
            filter_map { |path| File.read(path)[/^RSpec\.describe "([^"]+\.[a-z]+)"/, 1] }
    expect(named - RecipeScrapers::Registry.hosts).to be_empty
  end
end
