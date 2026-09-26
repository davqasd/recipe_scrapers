# frozen_string_literal: true

module CassetteHelpers
  REPLAY_ADDRESSES = [IPAddr.new("203.0.113.1")].freeze
  REPLAY_RESOLVER = ->(_host) { REPLAY_ADDRESSES }

  class NotARecipe < StandardError; end

  def self.path(name)
    File.join(VCR.configuration.cassette_library_dir, "#{name}.yml")
  end

  def scrape_cassette(name, url:)
    return replay(name, url) if File.exist?(CassetteHelpers.path(name))

    record(name, url)
  end

  private

  def replay(name, url)
    VCR.use_cassette(name) { RecipeScrapers.scrape(url, connection: connection(REPLAY_RESOLVER)) }
  end

  def record(name, url)
    recipe = VCR.use_cassette(name) { RecipeScrapers.scrape(url, connection: connection(nil)) }
    raise NotARecipe, "#{url} has no title or no ingredients" unless recipe.title && recipe.ingredients

    recipe
  rescue StandardError
    FileUtils.rm_f(CassetteHelpers.path(name))
    raise
  end

  def connection(resolver)
    configuration = RecipeScrapers::Configuration.new
    configuration.resolver = resolver
    configuration.connection
  end
end
