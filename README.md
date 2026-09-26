# recipe_scrapers

[![GitHub](https://img.shields.io/github/stars/davqasd/recipe_scrapers?style=social)](https://github.com/davqasd/recipe_scrapers)
[![Gem Version](https://img.shields.io/gem/v/recipe_scrapers)](https://rubygems.org/gems/recipe_scrapers)
[![Ruby Version](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Frubygems.org%2Fapi%2Fv1%2Fversions%2Frecipe_scrapers.json&query=%24%5B0%5D.ruby_version&label=ruby)](https://rubygems.org/gems/recipe_scrapers)
[![CI](https://github.com/davqasd/recipe_scrapers/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/davqasd/recipe_scrapers/actions/workflows/ci.yml)
[![License](https://img.shields.io/github/license/davqasd/recipe_scrapers)](LICENSE)

A Ruby gem that reads recipes from cooking websites: the title, ingredients, instructions, times,
yields and nutrition. It uses the [schema.org](https://schema.org/Recipe) markup most recipe sites
publish, falls back to [OpenGraph](https://ogp.me/), and reads the HTML directly for sites that
publish neither. It does not get around bot protection.

## Installation

```console
bundle add recipe_scrapers
```

The gem runs on every Ruby version that has not reached its end of life.

## Usage

```ruby
require "recipe_scrapers"

recipe = RecipeScrapers.scrape("https://www.recipetineats.com/crispy-potato-straws-pommes-paille/")
recipe.title                       # => "Crispy potato straws (Pommes Paille)"
recipe.ingredients[1]              # => "1 1/2 - 2 cups vegetable oil (canola, sunflower or peanut oil)"
recipe.parsed_ingredients[1].to_h  # => { amount: 1.5, unit: "cups", name: "vegetable oil" }
recipe.cook_time                   # => 10
recipe.to_h                        # every field as plain data, ready for JSON
```

To read HTML you already have, without a request:

```ruby
recipe = RecipeScrapers.parse(html, url: url)
```

## Documentation

- [Supported Sites](wiki/Supported-Sites.md): every site the gem reads out of the box
- [Usage](wiki/Usage.md): fetching, other HTTP clients, unsupported sites, errors
- [Recipe Fields](wiki/Recipe-Fields.md): every field with its type and an example
- [Configuration](wiki/Configuration.md): timeouts, size limits, your own connection
- [Parsers](wiki/Parsers.md): your own ingredient and nutrient parsers
- [API reference](https://rubydoc.info/gems/recipe_scrapers)
- [Changelog](CHANGELOG.md)
- [Copyright and Usage](wiki/Copyright-and-Usage.md): what you are responsible for

## Contributing

A site stopped working, or you need a new one? [Open an issue](https://github.com/davqasd/recipe_scrapers/issues)
with the URL of a recipe page. To add it yourself, see [CONTRIBUTING](CONTRIBUTING.md). Report a
security problem privately, see [SECURITY](SECURITY.md).

## License

MIT, see [LICENSE](LICENSE). The pages recorded for the tests are not covered by it, see
[License](wiki/License.md).
