# frozen_string_literal: true

RSpec.describe RecipeScrapers::Http::FollowRedirects do
  def connection(limit: 3, &routes)
    Faraday.new do |faraday|
      faraday.use :recipe_scrapers_follow_redirects, limit: limit
      faraday.adapter(:test, &routes)
    end
  end

  [301, 302, 303, 307, 308].each do |status|
    it "follows a #{status}" do
      response = connection do |stub|
        stub.get("https://a.example/") { [status, { "Location" => "https://b.example/" }, ""] }
        stub.get("https://b.example/") { [200, {}, "landed"] }
      end.get("https://a.example/")

      expect(response.body).to eq("landed")
    end
  end

  it "resolves a relative location against the url it redirected from" do
    response = connection do |stub|
      stub.get("https://a.example/recipes/old") { [301, { "Location" => "new?id=1" }, ""] }
      stub.get("https://a.example/recipes/new?id=1") { [200, {}, "landed"] }
    end.get("https://a.example/recipes/old")

    expect(response.body).to eq("landed")
  end

  it "reports the url it landed on" do
    response = connection do |stub|
      stub.get("https://a.example/") { [302, { "Location" => "https://b.example/final" }, ""] }
      stub.get("https://b.example/final") { [200, {}, "landed"] }
    end.get("https://a.example/")

    expect(response.env.url.to_s).to eq("https://b.example/final")
  end

  it "drops the fragment of the location" do
    response = connection do |stub|
      stub.get("https://a.example/") { [302, { "Location" => "/final#recipe" }, ""] }
      stub.get("https://a.example/final") { [200, {}, "landed"] }
    end.get("https://a.example/")

    expect(response.body).to eq("landed")
  end

  it "escapes the characters a location should not carry raw" do
    response = connection do |stub|
      stub.get("https://a.example/") { [302, { "Location" => "/r/borsch ukrainian" }, ""] }
      stub.get("https://a.example/r/borsch%20ukrainian") { [200, {}, "landed"] }
    end.get("https://a.example/")

    expect(response.body).to eq("landed")
  end

  it "returns the redirect itself when it names no location" do
    response = connection do |stub|
      stub.get("https://a.example/") { [302, {}, "nowhere"] }
    end.get("https://a.example/")

    expect(response.status).to eq(302)
  end

  it "follows as many hops as the limit allows" do
    response = connection(limit: 2) do |stub|
      stub.get("https://a.example/1") { [302, { "Location" => "/2" }, ""] }
      stub.get("https://a.example/2") { [302, { "Location" => "/3" }, ""] }
      stub.get("https://a.example/3") { [200, {}, "landed"] }
    end.get("https://a.example/1")

    expect(response.body).to eq("landed")
  end

  it "raises once the hops go past the limit" do
    looping = connection(limit: 2) do |stub|
      stub.get("https://a.example/loop") { [302, { "Location" => "/loop" }, ""] }
    end

    expect { looping.get("https://a.example/loop") }.
      to raise_error(RecipeScrapers::TooManyRedirects, /2/)
  end

  it "drops the authorization header when the redirect leaves the host" do
    seen = nil
    connection do |stub|
      stub.get("https://a.example/") { [302, { "Location" => "https://b.example/" }, ""] }
      stub.get("https://b.example/") { |env| [200, {}, (seen = env.request_headers["Authorization"]).to_s] }
    end.get("https://a.example/", nil, "Authorization" => "Bearer secret")

    expect(seen).to be_nil
  end

  it "keeps the authorization header when the redirect stays on the host" do
    seen = nil
    connection do |stub|
      stub.get("https://a.example/") { [302, { "Location" => "/next" }, ""] }
      stub.get("https://a.example/next") { |env| [200, {}, (seen = env.request_headers["Authorization"]).to_s] }
    end.get("https://a.example/", nil, "Authorization" => "Bearer secret")

    expect(seen).to eq("Bearer secret")
  end
end
