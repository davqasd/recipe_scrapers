# frozen_string_literal: true

RSpec.describe "requiring the gem" do
  it "loads every file under lib" do
    files = Dir[File.expand_path("../lib/**/*.rb", __dir__)].map { |path| File.realpath(path) }
    expect(files - $LOADED_FEATURES).to be_empty
  end
end
