# frozen_string_literal: true

RSpec.describe RecipeScrapers::Configuration do
  after { RecipeScrapers.reset_config! }

  it "defaults the adapter to the bundled one" do
    expect(RecipeScrapers.config.adapter).to eq(:recipe_scrapers_net_http)
  end

  it "names the gem and its version in the user agent" do
    expect(RecipeScrapers.config.user_agent).to include("recipe_scrapers/#{RecipeScrapers::VERSION}")
  end

  it "re raises through the default error tracker" do
    expect { RecipeScrapers.config.error_tracker.call(ArgumentError.new("boom")) }.
      to raise_error(ArgumentError, "boom")
  end

  it "parses ingredients and nutrients with the bundled parsers by default" do
    expect(RecipeScrapers.config.parsers).to eq(
      ingredients: [RecipeScrapers::Parsers::Ingredients],
      nutrients: [RecipeScrapers::Parsers::Nutrients]
    )
  end

  it "keeps the parsers of one configuration apart from another" do
    RecipeScrapers.config.parsers[:ingredients].unshift(:custom)
    expect(described_class.new.parsers[:ingredients]).to eq([RecipeScrapers::Parsers::Ingredients])
  end

  it "takes values from a configure block" do
    RecipeScrapers.configure { |config| config.timeout = 3 }
    expect(RecipeScrapers.config.timeout).to eq(3)
  end

  it "builds a faraday connection carrying the guard, the limit and the encoding" do
    expect(RecipeScrapers.config.connection.builder.handlers).to include(
      RecipeScrapers::Http::AddressGuard,
      RecipeScrapers::Http::BodyLimit,
      RecipeScrapers::Http::Encoding
    )
  end

  it "puts the address guard below follow_redirects so every hop is checked" do
    handlers = RecipeScrapers.config.connection.builder.handlers
    redirects = handlers.index { |handler| handler.name.to_s.include?("FollowRedirects") }
    expect(handlers.index(RecipeScrapers::Http::AddressGuard)).to be > redirects
  end

  it "memoizes the connection" do
    config = RecipeScrapers.config
    expect(config.connection).to equal(config.connection)
  end

  it "rebuilds the connection after an attribute changes" do
    config = RecipeScrapers.config
    first = config.connection
    config.timeout = 1
    expect(config.connection).not_to equal(first)
  end

  it "uses an assigned connection as given" do
    mine = Faraday.new
    RecipeScrapers.configure { |config| config.connection = mine }
    expect(RecipeScrapers.config.connection).to equal(mine)
  end

  it "keeps an assigned connection even after another attribute changes" do
    mine = Faraday.new
    RecipeScrapers.configure { |config| config.connection = mine }
    RecipeScrapers.config.timeout = 1
    expect(RecipeScrapers.config.connection).to equal(mine)
  end

  it "does not open libcurl until a connection is built" do
    probe = %(require "recipe_scrapers"; print defined?(Ethon::Curl) ? "yes" : "no")
    expect(`#{RbConfig.ruby} -Ilib -e '#{probe}' 2>/dev/null`).to eq("no")
  end
end
