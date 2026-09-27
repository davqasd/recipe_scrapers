# Usage

## Fetching and parsing

`RecipeScrapers.scrape` fetches a page and reads its recipe. `RecipeScrapers.parse` reads HTML you
already have and makes no request.

```ruby
recipe = RecipeScrapers.scrape(url)
recipe = RecipeScrapers.parse(html, url: url)
```

Pass `parse` the page's own URL. The host picks the site, and relative links in the page resolve
against it.

## Using another HTTP client

`scrape` fetches with timeouts, retries, a redirect limit, a size limit and protection against
requests to private addresses. See [Configuration](Configuration.md).

To fetch with anything else, pass the HTML to `parse`:

```ruby
require "net/http"

url = "https://www.recipetineats.com/crispy-potato-straws-pommes-paille/"
html = Net::HTTP.get(URI(url))
recipe = RecipeScrapers.parse(html, url: url)
```

The protections of `scrape` do not apply to a request the gem does not make.

## Reading a recipe

`scrape` and `parse` return a `RecipeScrapers::Models::Recipe`. Every field is a method on it, and
a field the page does not publish is `nil`. [Recipe Fields](Recipe-Fields.md) lists them all.

```ruby
recipe.title
recipe.ingredients
recipe.parsed_ingredients
recipe.ingredient_groups
recipe.instructions_list
recipe.total_time
recipe.nutrients
recipe.parsed_nutrients
```

The recipe is a frozen value object, so it is safe to cache and to compare. `to_h` returns plain
data: the parsed ingredients, the ingredient groups and the parsed nutrients become hashes as well.

```ruby
recipe.to_h[:parsed_ingredients][1]
# => { amount: 1.5, unit: "cups", name: "vegetable oil" }

JSON.generate(recipe.to_h)
```

## Unsupported sites

`scrape` and `parse` raise `UnsupportedSite` for a host the gem does not list. Pass
`supported_only: false` to read any page that publishes schema.org or OpenGraph markup:

```ruby
recipe = RecipeScrapers.scrape(url, supported_only: false)
```

[Supported Sites](Supported-Sites.md) lists the supported hosts, and so does
`RecipeScrapers::Registry.hosts`.

## Errors

Every error the gem raises inherits from `RecipeScrapers::Error`.

| Error | Raised when |
|---|---|
| `UnsupportedSite` | The host is not supported and `supported_only` is on |
| `RecipeNotFound` | The page has no recipe title or no ingredients |
| `BlockedAddress` | The host resolves to no address, or to a private, loopback or other non-public one |
| `TooManyRedirects` | The redirects go on past `max_redirects` |
| `ResponseTooLarge` | The body is larger than `max_body_bytes` |

Timeouts and refused connections raise Faraday's own errors, after the retries in `retry_options`.
An HTTP error status raises nothing. The body is read like any other page, so a 404 page usually
ends in `RecipeNotFound`.

```ruby
begin
  recipe = RecipeScrapers.scrape(url)
rescue RecipeScrapers::UnsupportedSite
  recipe = RecipeScrapers.scrape(url, supported_only: false)
rescue RecipeScrapers::RecipeNotFound
  recipe = nil
end
```
