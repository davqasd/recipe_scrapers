# frozen_string_literal: true

require "ipaddr"

RSpec.describe RecipeScrapers::Http::AddressGuard do
  def connection(addresses, allow_private: false)
    resolver = ->(_host) { Array(addresses).map { |address| IPAddr.new(address) } }
    Faraday.new do |faraday|
      faraday.use :recipe_scrapers_address_guard, allow_private: allow_private, resolver: resolver
      faraday.adapter :test do |stub|
        stub.get("https://example.com/") { |env| [200, {}, env.request.context.to_h.to_s] }
      end
    end
  end

  it "allows a public address" do
    expect(connection("93.184.216.34").get("https://example.com/").status).to eq(200)
  end

  it "pins the request to the address it validated" do
    expect(connection("93.184.216.34").get("https://example.com/").body).
      to include('["93.184.216.34"]')
  end

  it "pins every validated address in the order the resolver returned them" do
    expect(connection(["2606:2800:220:1::248", "93.184.216.34"]).get("https://example.com/").body).
      to include('["2606:2800:220:1::248", "93.184.216.34"]')
  end

  %w[127.0.0.1 10.0.0.5 192.168.1.1 169.254.169.254 224.0.0.1 0.0.0.0 100.64.0.1].each do |address|
    it "blocks #{address}" do
      expect { connection(address).get("https://example.com/") }.
        to raise_error(RecipeScrapers::BlockedAddress, /#{Regexp.escape(address)}/)
    end
  end

  it "blocks an ipv6 loopback" do
    expect { connection("::1").get("https://example.com/") }.
      to raise_error(RecipeScrapers::BlockedAddress)
  end

  it "blocks an ipv4 mapped ipv6 loopback" do
    expect { connection("::ffff:127.0.0.1").get("https://example.com/") }.
      to raise_error(RecipeScrapers::BlockedAddress)
  end

  it "blocks when any resolved address is private" do
    expect { connection(["93.184.216.34", "127.0.0.1"]).get("https://example.com/") }.
      to raise_error(RecipeScrapers::BlockedAddress)
  end

  it "allows a private address when the configuration says to" do
    expect(connection("10.0.0.5", allow_private: true).get("https://example.com/").status).to eq(200)
  end

  it "raises when the host resolves to nothing" do
    expect { connection([]).get("https://example.com/") }.
      to raise_error(RecipeScrapers::BlockedAddress, /did not resolve/)
  end
end
RSpec.describe "the guard against a redirect" do
  def connection(resolver)
    Faraday.new do |faraday|
      faraday.use :recipe_scrapers_follow_redirects, limit: 3
      faraday.use :recipe_scrapers_address_guard, allow_private: false, resolver: resolver
      faraday.adapter :test do |stub|
        stub.get("https://public.example/") { [302, { "Location" => "http://internal.example/" }, ""] }
        stub.get("http://internal.example/") { [200, {}, "secret"] }
      end
    end
  end

  let(:resolver) do
    lambda do |host|
      host == "public.example" ? [IPAddr.new("93.184.216.34")] : [IPAddr.new("169.254.169.254")]
    end
  end

  it "checks the hop, not only the first request" do
    expect { connection(resolver).get("https://public.example/") }.
      to raise_error(RecipeScrapers::BlockedAddress, /169\.254\.169\.254/)
  end

  it "still follows a redirect to a public address" do
    always_public = ->(_host) { [IPAddr.new("93.184.216.34")] }
    expect(connection(always_public).get("https://public.example/").body).to eq("secret")
  end
end
