# Declarations

Most recipe sites publish schema.org markup, and the gem reads it with no site code. A declaration
is for a site whose markup is missing, incomplete or wrong. It says where each field is in the
HTML, with a CSS selector.

```ruby
RecipeScrapers.register "russianfood.com" do
  encoding "windows-1251"
  title "h1"
  ingredients rows: "tr.ingr_tr_0, tr.ingr_tr_1"
  instructions rows: "div.step_n"
end
```

A declared field wins over the markup. Every field the declaration leaves out still comes from
schema.org, then OpenGraph. A site whose markup is right about the ingredients and wrong about the
yields declares only `yields`.

Selectors are CSS selectors, matched with Nokogiri. MDN has a
[guide to CSS selectors](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_selectors).

## Single values

These fields take a selector, and the gem reads the text of the first element that matches:
`title`, `author`, `description`, `site_name`, `language`, `category`, `cuisine`,
`cooking_method`, `image`, `yields`, `total_time`, `prep_time` and `cook_time`.

```ruby
title "h1.recipe-title"
yields ".recipe-servings"
total_time ".recipe-time-total"
```

The text is cleaned: entities are decoded, `script` and `style` are skipped, and whitespace is
collapsed. `yields` and the times are then read the same way as in schema.org, so an element
holding `1 hour 15 minutes` gives a `total_time` of `75`.

## Lists

These fields take `rows:`, and every element that matches is one line: `ingredients`,
`instructions`, `keywords` and `equipment`.

```ruby
ingredients rows: ".recipe-ingredients li"
instructions rows: ".recipe-steps li"
```

The text of each child of a row is joined with a space, so this row reads as
`"1 tablespoon coconut oil"`:

```html
<li>
  <span class="amount">1</span>
  <span class="unit">tablespoon</span>
  <span class="name">coconut oil</span>
</li>
```

A row with no text is skipped.

Some sites generate class names with a random suffix, like `ingredients_recipeYield__DN65p`, that
changes on every rebuild. Match the stable part instead:

```ruby
yields "[class*='ingredients_recipeYield']"
```

## Ingredient groups

schema.org has no ingredient groups, so they come from the HTML. The gem finds them on its own
on sites built with [WP Recipe Maker](https://wordpress.org/plugins/wp-recipe-maker/),
[Tasty Recipes](https://www.wptasty.com/tasty-recipes) and
[Create by Mediavine](https://www.mediavine.com/mediavine-recipe-card/). It also reads headings
that a site puts into the ingredient list itself as lines ending in a colon, such as
`For the sauce:`.

A site with a layout of its own declares two selectors:

```ruby
ingredient_groups heading: ".ingredient-group h4", item: ".ingredient-group li"
```

- `heading` matches the group headings and nothing else.
- `item` matches the ingredients and nothing else, as many elements as there are lines in
  `ingredients`. When the counts differ, the gem cannot pair them up and returns one group.

Each heading starts a group, and each ingredient joins the group of the heading above it.
Ingredients before the first heading form a group with a `nil` purpose.

## Encoding

A site that sends a legacy encoding without saying so in its headers names it:

```ruby
encoding "windows-1251"
```

## Parsing ingredients or nutrients differently

A declaration can put a parser of its own in front of the bundled one, for this site only. See
[Parsers](Parsers.md) for what a parser is.

```ruby
RecipeScrapers.register "example.com" do
  parser :ingredients, ExampleIngredients, RecipeScrapers::Parsers::Ingredients
end
```

## Reading schema.org differently

When the markup is there but a site structures it in its own way, the site gets a `Scraper`
subclass with its own schema reader. The reader subclasses `RecipeScrapers::Sources::SchemaOrg`
and overrides only what differs:

```ruby
module RecipeScrapers
  module Sites
    module Com
      class SamsungFood < Scraper
        class SchemaReader < Sources::SchemaOrg
          LIST_MARKER = /\A(?:[-*•]|\d+\.)\s+/

          def ingredients = strip_markers(super)
          def instructions_list = strip_markers(super)

          private

          def strip_markers(lines)
            lines&.map { |line| line.sub(LIST_MARKER, "") }
          end
        end

        host "app.samsungfood.com"
        schema_reader SchemaReader
      end
    end
  end
end

RecipeScrapers::Registry.register_class(RecipeScrapers::Sites::Com::SamsungFood)
```

The steps of `recipeInstructions` are read by private methods that can be overridden one at a
time: `section_steps` for a `HowToSection`, `step_steps` for a `HowToStep` and `step_heading` for
the name of a step. `lib/recipe_scrapers/sites/de/chefkoch.rb` and
`lib/recipe_scrapers/sites/fr/madame.rb` do this.

A scraper class sets its own parser with `parser :ingredients, ...`, the same way a declaration
does.
