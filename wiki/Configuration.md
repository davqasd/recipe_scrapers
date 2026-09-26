# Configuration

The settings apply to every `RecipeScrapers.scrape` call.

```ruby
RecipeScrapers.configure do |config|
  config.user_agent = "my-app/1.0 (+https://example.com)"
  config.timeout = 10
end
```

| Setting | Default | Meaning |
|---|---|---|
| `user_agent` | `recipe_scrapers/<version> (+https://github.com/davqasd/recipe_scrapers)` | The `User-Agent` header |
| `timeout` | `15` | Seconds to wait for the whole response |
| `open_timeout` | `5` | Seconds to wait for the connection to open |
| `max_redirects` | `3` | Redirects to follow before `TooManyRedirects` |
| `max_body_bytes` | `5 * 1024 * 1024` | The largest body accepted before `ResponseTooLarge` |
| `allow_private_addresses` | `false` | Fetch hosts that resolve to private or loopback addresses, for local development |
| `retry_options` | `{ max: 2, interval: 1, backoff_factor: 2 }` | Options for [faraday-retry](https://github.com/lostisland/faraday-retry), used on timeouts, refused connections and server errors |
| `resolver` | `nil` | Anything that answers `call(host)` with `IPAddr` addresses, such as a DNS cache. `nil` uses the system resolver |
| `adapter` | `:recipe_scrapers_net_http` | The Faraday adapter |
| `error_tracker` | raises the error again | Gets the error of a failing parser, see [Parsers](Parsers.md) |
| `parsers` | the bundled parsers | The parsers of `parsed_ingredients` and `parsed_nutrients`, see [Parsers](Parsers.md) |
| `connection` | built from the settings above | A Faraday connection to use instead |

`RecipeScrapers.reset_config!` goes back to the defaults.

## Your own connection

```ruby
RecipeScrapers.configure do |config|
  config.connection = MyApp::Fetcher.build
end
```

A connection you assign is used as it is, and the fetch settings above do not apply to it.
That includes the redirect limit, the size limit and the check against private addresses. To keep
them, add the gem's middleware to your connection:

```ruby
config.connection = Faraday.new do |faraday|
  faraday.use RecipeScrapers::Http::FollowRedirects, limit: 3
  faraday.use RecipeScrapers::Http::AddressGuard, allow_private: false
  faraday.use RecipeScrapers::Http::BodyLimit, bytes: 5 * 1024 * 1024
  faraday.response :recipe_scrapers_encoding
  faraday.adapter :recipe_scrapers_net_http
end
```

Keep `FollowRedirects` above `AddressGuard`, so that every redirect is checked and not only the
first request. Keep the `:recipe_scrapers_net_http` adapter too: it connects to the addresses the
guard checked, so a second DNS answer cannot send the request somewhere else.

The gem does not try to get past bot protection. A site that blocks it stays blocked, unless you
assign a connection that does more.
