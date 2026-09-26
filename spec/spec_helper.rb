# frozen_string_literal: true

require "fileutils"
require "ipaddr"
require "json"
require "yaml"
require "vcr"
require "recipe_scrapers"
require "webmock/rspec"

Dir[File.expand_path("support/**/*.rb", __dir__)].each { |file| require file }

WebMock.disable_net_connect!

VCR.configure do |config|
  config.cassette_library_dir = File.expand_path("cassettes", __dir__)
  config.hook_into :webmock
  config.default_cassette_options = { record: ENV["CI"] ? :none : :once, allow_playback_repeats: true }
  config.before_record do |interaction|
    next interaction.ignore! if interaction.response.status.code.zero?

    interaction.response.headers.delete("Set-Cookie")
  end
end

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :expect }
  config.disable_monkey_patching!
  config.order = :random
  config.include CassetteHelpers
end
