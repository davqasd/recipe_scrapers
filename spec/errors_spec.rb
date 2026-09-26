# frozen_string_literal: true

RSpec.describe "errors" do
  it "gives every error a common ancestor" do
    [
      RecipeScrapers::RecipeNotFound,
      RecipeScrapers::UnsupportedSite,
      RecipeScrapers::ResponseTooLarge,
      RecipeScrapers::BlockedAddress,
      RecipeScrapers::TooManyRedirects
    ].each do |klass|
      expect(klass.ancestors).to include(RecipeScrapers::Error)
    end
  end
end
