# frozen_string_literal: true

RSpec.describe "compatibility shims" do
  let(:gemspec) { Gem::Specification.load(File.expand_path("../recipe_scrapers.gemspec", __dir__)) }

  def lowest(requirement)
    requirement.requirements.filter_map { |operator, version| version if operator == ">=" }.min
  end

  def floors
    runtime = gemspec.runtime_dependencies.to_h { |dependency| [dependency.name, lowest(dependency.requirement)] }
    runtime.merge("ruby" => lowest(gemspec.required_ruby_version))
  end

  def shims
    return [] unless RecipeScrapers.const_defined?(:Compat, false)

    RecipeScrapers::Compat.constants.map { |name| RecipeScrapers::Compat.const_get(name) }
  end

  it "reads a floor for ruby and every runtime dependency" do
    expect(floors.keys).to match_array(["ruby", *gemspec.runtime_dependencies.map(&:name)])
  end

  it "has no shim for a version the gemspec no longer supports" do
    expired = shims.select do |shim|
      shim::REQUIRED_UNTIL.any? { |name, version| floors.fetch(name) >= Gem::Version.new(version) }
    end
    expect(expired).to be_empty
  end
end
