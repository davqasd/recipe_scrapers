# Parsers

`parsed_ingredients` and `parsed_nutrients` come from parsers. The bundled ones work with no setup.
Add your own when a site writes its ingredients or nutrients in a way they do not read.

## Writing a parser

A parser is anything that answers `call(text, language:)`. It gets one ingredient line or one
nutrient value, and the language tag of the recipe, such as `"en-US"` or `nil`. It returns a hash,
or `nil` when it cannot read the text.

- An ingredient parser returns `amount`, `unit` and `name`.
- A nutrient parser returns `unit` and `amount`. It can add `name`, which otherwise is the key the
  value came under, such as `"calories"`.

A key left out is `nil`.

```ruby
grams_only = lambda do |text, language:|
  amount = text[/\A(\d+)\s*g\b/, 1]
  next nil unless amount

  { amount: amount.to_f, unit: "g", name: text.sub(/\A\d+\s*g\s*/, "") }
end
```

## Adding it

Put your parser in front of the bundled one:

```ruby
RecipeScrapers.configure do |config|
  config.parsers[:ingredients].unshift(grams_only)
end
```

The parsers are tried in order, and the first one that returns a hash wins. Every line yours
returns `nil` for still goes to the bundled parser. Only `:ingredients` and `:nutrients` take
parsers.

## When a parser fails

A parser that raises, or returns a key the field does not have, is skipped for that line, and the
next parser is tried. The error goes to `error_tracker`, which raises it again by default. To
report it and carry on instead:

```ruby
RecipeScrapers.configure do |config|
  config.error_tracker = ->(error) { warn(error.full_message) }
end
```
