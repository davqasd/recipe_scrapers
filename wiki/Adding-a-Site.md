# Adding a Site

Set up the repository first, as [CONTRIBUTING](../CONTRIBUTING.md) describes.

## 1. Check that the site is missing

Look for its file under `lib/recipe_scrapers/sites/`, or ask in code:

```ruby
RecipeScrapers::Registry.for("https://www.example.com/recipes/pancakes")
# => nil when the site is not supported
```

## 2. Pick a recipe page

Choose a recipe with several steps, because a recipe that reads as a single step usually means the
steps were not read correctly. If the site groups its ingredients on some recipes, pick one with
groups.

## 3. See what the page already publishes

Most recipe sites publish schema.org markup, and then the site needs no code. Read the page
without the site check:

```ruby
require "net/http"
require "recipe_scrapers"

url = "https://www.example.com/recipes/pancakes"
html = Net::HTTP.get(URI(url))
pp RecipeScrapers.parse(html, url: url, supported_only: false).to_h
```

Compare the output with the page in a browser: the title, every ingredient line, every step and
the ingredient groups.

## 4. Register the site

The file lives at `lib/recipe_scrapers/sites/<top-level domain>/<first label>.rb`, and
`RecipeScrapers::SitePath.for("example.com")` returns that path, here `com/example`.

If the output was right, the file is one line:

```ruby
# frozen_string_literal: true

RecipeScrapers.register "example.com"
```

If some fields were wrong or missing, declare where they are. See
[Declarations](Declarations.md).

```ruby
# frozen_string_literal: true

RecipeScrapers.register "example.com" do
  ingredients rows: ".recipe-ingredients li"
  instructions rows: ".recipe-steps li"
end
```

If the markup is there but has to be read in its own way, write a `Scraper` subclass. See
[Declarations](Declarations.md#when-selectors-are-not-enough).

A site that serves the same recipes on several domains registers them together:

```ruby
RecipeScrapers.register "bonviveur.com", also: ["bonviveur.es"]
```

## 5. Write the spec

The spec lives at the same path as the site file, here `spec/sites/com/example_spec.rb`:

```ruby
# frozen_string_literal: true

RSpec.describe "example.com" do
  subject(:recipe) { scrape_cassette("com/example", url: "https://www.example.com/recipes/pancakes") }

  it "reads the title" do
    expect(recipe.title).to eq("Pancakes")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq(["200 g flour", "2 eggs", "300 ml milk"])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Whisk everything into a smooth batter.",
      "Fry in a hot pan until golden on both sides."
    ])
  end
end
```

A full spec covers every field, not only these three. Any spec under `spec/sites/` shows the set:
the parsed ingredients, the groups, the metadata, the nutrients and their parsed form, and one
link. A field the page does not publish is asserted as `nil`. For a recipe with groups, assert each
purpose and how many lines it holds:

```ruby
it "splits the ingredients into the groups the page names" do
  expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
    to eq([["COATING", 2], ["CHURROS", 8]])
end
```

Check every expected value against the page in a browser. A value copied from the gem's output
without that check proves nothing.

## 6. Run it

```console
bundle exec rspec spec/sites/com/example_spec.rb
```

The first run fetches the page and records it in `spec/cassettes/com/example.yml`. Every later run
replays the recording. See [Testing](Testing.md). Try a few other recipes of the site in the console
as well, to catch the cases one page does not show.

## 7. List it

Add the host to [Supported Sites](Supported-Sites.md), in alphabetical order, as
`- [example.com](https://example.com/)`. A site registered with `also:` gets one line per host.
Raise the number of sites at the top of the page by the lines you added. It matches
`RecipeScrapers::Registry.hosts.size`.

## 8. Submit

Commit the site file, the spec, the cassette and the updated list together, run `bin/ci`, and
open a pull request.
