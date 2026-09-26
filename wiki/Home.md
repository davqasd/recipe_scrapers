# recipe_scrapers

A Ruby gem that reads recipes from cooking websites. It gives every site the same fields: the
title, the ingredients as written and split into amount, unit and name, the instructions, times,
yields, nutrition and [more](Recipe-Fields.md).

```ruby
recipe = RecipeScrapers.scrape("https://www.recipetineats.com/crispy-potato-straws-pommes-paille/")
recipe.title  # => "Crispy potato straws (Pommes Paille)"
recipe.to_h   # every field as plain data
```

## Using the gem

- [Supported Sites](Supported-Sites.md): every site the gem reads out of the box
- [Usage](Usage.md): fetching, other HTTP clients, unsupported sites, errors
- [Recipe Fields](Recipe-Fields.md): every field with its type and an example
- [Configuration](Configuration.md): timeouts, size limits, your own connection
- [Parsers](Parsers.md): your own ingredient and nutrient parsers
- [API reference](https://rubydoc.info/gems/recipe_scrapers)

## Adding a site

- [Adding a Site](Adding-a-Site.md): from a recipe URL to a pull request
- [Declarations](Declarations.md): where the fields are on a site without usable markup
- [Testing](Testing.md): recorded pages, and what to do when a site changes

## Copyright

- [Copyright and Usage](Copyright-and-Usage.md): what the gem does and what you are responsible for
- [License](License.md): the code and the recorded pages
