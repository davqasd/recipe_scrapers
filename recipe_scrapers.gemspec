# frozen_string_literal: true

require_relative "lib/recipe_scrapers/version"

Gem::Specification.new do |spec|
  spec.name = "recipe_scrapers"
  spec.version = RecipeScrapers::VERSION
  spec.authors = ["David Khotelov"]
  spec.summary = "Extract structured recipes from cooking websites"
  spec.description = "Reads the title, ingredients, steps, times, yields and nutrition of a recipe " \
                     "from its page. Uses the schema.org JSON-LD or microdata the site publishes, " \
                     "falls back to OpenGraph, and takes a short per-site declaration where a site " \
                     "publishes no structured data. Fetches through a Faraday connection guarded " \
                     "against SSRF, or parses HTML you already have."
  spec.homepage = "https://github.com/davqasd/recipe_scrapers"
  spec.license = "MIT"
  spec.metadata = {
    "homepage_uri" => spec.homepage,
    "source_code_uri" => spec.homepage,
    "documentation_uri" => "https://rubydoc.info/gems/recipe_scrapers",
    "bug_tracker_uri" => "#{spec.homepage}/issues",
    "changelog_uri" => "#{spec.homepage}/blob/main/CHANGELOG.md",
    "rubygems_mfa_required" => "true"
  }
  spec.required_ruby_version = ">= 3.3"

  spec.files = Dir["lib/**/*.{rb,yml}", "CHANGELOG.md", "LICENSE", "README.md"]
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", ">= 2.9.0", "< 3"
  spec.add_dependency "faraday-net_http", ">= 3.1.0", "< 4"
  spec.add_dependency "faraday-retry", ">= 2.2.0", "< 3"
  spec.add_dependency "nokogiri", ">= 1.15.0", "< 2"
end
