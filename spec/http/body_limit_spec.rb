# frozen_string_literal: true

RSpec.describe RecipeScrapers::Http::BodyLimit do
  def fetch(body:, headers: {}, bytes: 20)
    connection = Faraday.new do |faraday|
      faraday.use :recipe_scrapers_body_limit, bytes: bytes
      faraday.adapter :test do |stub|
        stub.get("/") { [200, headers, body] }
      end
    end
    connection.get("/").body
  end

  it "lets a small body through" do
    expect(fetch(body: "small")).to eq("small")
  end

  it "refuses a body whose content length is over the limit" do
    expect { fetch(body: "x", headers: { "Content-Length" => "999" }) }.
      to raise_error(RecipeScrapers::ResponseTooLarge, /999/)
  end

  it "refuses a body that is over the limit with no content length" do
    expect { fetch(body: "x" * 50) }.to raise_error(RecipeScrapers::ResponseTooLarge)
  end
end
