# frozen_string_literal: true

RSpec.describe RecipeScrapers::Http::Encoding do
  def fetch(body:, content_type:)
    connection = Faraday.new do |faraday|
      faraday.response :recipe_scrapers_encoding
      faraday.adapter :test do |stub|
        stub.get("/") { [200, { "Content-Type" => content_type }, body] }
      end
    end
    connection.get("/").body
  end

  let(:cyrillic) { "Омлет" }

  it "decodes a windows-1251 body announced in the header", :aggregate_failures do
    result = fetch(
      body: cyrillic.encode("windows-1251").b,
      content_type: "text/html; charset=windows-1251"
    )
    expect(result).to eq(cyrillic)
    expect(result.encoding).to eq(Encoding::UTF_8)
  end

  it "decodes a windows-1251 body announced only in a meta tag" do
    html = %(<meta http-equiv="Content-Type" content="text/html; charset=windows-1251"><h1>#{cyrillic}</h1>)
    expect(fetch(body: html.encode("windows-1251").b, content_type: "text/html")).to include(cyrillic)
  end

  it "decodes a meta charset short form" do
    html = %(<meta charset="windows-1251"><h1>#{cyrillic}</h1>)
    expect(fetch(body: html.encode("windows-1251").b, content_type: "text/html")).to include(cyrillic)
  end

  it "leaves a utf-8 body alone" do
    result = fetch(
      body: cyrillic.dup.force_encoding(Encoding::BINARY),
      content_type: "text/html; charset=utf-8"
    )
    expect(result).to eq(cyrillic)
  end

  it "falls back to utf-8 when the declared charset is nonsense" do
    expect(fetch(body: cyrillic.dup.b, content_type: "text/html; charset=not-a-charset")).to eq(cyrillic)
  end
end
