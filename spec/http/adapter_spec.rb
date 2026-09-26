# frozen_string_literal: true

require "recipe_scrapers/http/adapter"

RSpec.describe RecipeScrapers::Http::Adapter do
  let(:adapter) { described_class.new(->(env) { env }) }

  def env_with(context, url: "https://example.com/", proxy: nil)
    Faraday::Env.from(
      method: :get,
      url: URI.parse(url),
      request: Faraday::RequestOptions.new.tap do |options|
        options.context = context
        options.proxy = proxy
      end,
      request_headers: {}
    )
  end

  def http_for(env) = adapter.net_http_connection(env)

  it "is the net http adapter faraday ships with" do
    expect(described_class.superclass).to eq(Faraday::Adapter::NetHttp)
  end

  it "connects to the address the guard pinned" do
    expect(http_for(env_with({ recipe_scrapers_resolve: ["93.184.216.34"] })).ipaddr).to eq("93.184.216.34")
  end

  it "keeps the host name for the handshake and the host header" do
    expect(http_for(env_with({ recipe_scrapers_resolve: ["93.184.216.34"] })).address).to eq("example.com")
  end

  it "connects to an ipv6 address the guard pinned" do
    expect(http_for(env_with({ recipe_scrapers_resolve: ["2606:2800:220:1::248"] })).ipaddr).
      to eq("2606:2800:220:1::248")
  end

  def attempts_for(pinned, unreachable:)
    tried = []
    allow_any_instance_of(described_class).to receive(:perform_request).and_wrap_original do |original, http, env|
      tried << http.ipaddr
      raise Net::OpenTimeout, "execution expired" if unreachable.include?(http.ipaddr)

      original.call(http, env)
    end
    fetch_pinned(pinned)
    tried
  end

  def fetch_pinned(pinned)
    stub_request(:get, "https://example.com/")
    Faraday.new { |faraday| faraday.adapter(described_class) }.
      get("https://example.com/") { |request| request.options.context = { recipe_scrapers_resolve: pinned } }
  end

  it "tries the pinned addresses in the order the guard pinned them" do
    expect(attempts_for(%w[93.184.216.34 93.184.216.35], unreachable: [])).to eq(%w[93.184.216.34])
  end

  it "falls back to the next pinned address when one does not answer" do
    tried = attempts_for(["94.130.17.211", "2a01:4f8:10b:16aa::2"], unreachable: ["94.130.17.211"])
    expect(tried).to eq(["94.130.17.211", "2a01:4f8:10b:16aa::2"])
  end

  it "raises once no pinned address answers" do
    expect { attempts_for(%w[93.184.216.34 93.184.216.35], unreachable: %w[93.184.216.34 93.184.216.35]) }.
      to raise_error(Faraday::ConnectionFailed)
  end

  it "leaves the address unset when nothing pinned the request" do
    expect(http_for(env_with({})).ipaddr).to be_nil
  end

  it "leaves the address unset when there is no context at all" do
    expect(http_for(env_with(nil)).ipaddr).to be_nil
  end

  it "leaves the address unset when the request goes through a proxy" do
    proxy = Faraday::ProxyOptions.from("http://proxy.example:8080")
    expect(http_for(env_with({ recipe_scrapers_resolve: ["93.184.216.34"] }, proxy: proxy)).ipaddr).to be_nil
  end

  it "registers itself under a name the configuration can use" do
    expect(Faraday::Adapter.lookup_middleware(:recipe_scrapers_net_http)).to eq(described_class)
  end
end
