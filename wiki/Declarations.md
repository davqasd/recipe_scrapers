# Declarations

Most recipe sites publish schema.org markup, and the gem reads it with no site code. A declaration
is for a site whose markup is missing or wrong. It says where a field is on the page, with a CSS
selector.

```ruby
RecipeScrapers.register "russianfood.com" do
  encoding "windows-1251"
  title "h1"
  ingredients rows: "tr.ingr_tr_0, tr.ingr_tr_1"
  instructions rows: "div.step_n"
end
```

A declared field replaces what the markup says. Every field left out still comes from the markup,
so a site that gets only the yields wrong declares only `yields`. MDN has a
[guide to CSS selectors](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_selectors).

## Single values

`title`, `author`, `description`, `site_name`, `language`, `category`, `cuisine`,
`cooking_method`, `image`, `yields`, `total_time`, `prep_time` and `cook_time` take a selector.
The gem reads the text of the first element that matches.

```ruby
title "h1.recipe-title"
yields ".recipe-servings"
total_time ".recipe-time-total"
```

Times and yields are read the same way as in schema.org, so `1 hour 15 minutes` gives a
`total_time` of `75`.

## Lists

`ingredients`, `instructions`, `keywords` and `equipment` take `rows:`. Every element that
matches is one line, read as the page shows it, without a list marker such as `- ` or `1. `.

```ruby
ingredients rows: ".recipe-ingredients li"
instructions rows: ".recipe-steps li"
```

Two options cover the common layouts that are not one element per line:

| Option | For |
|---|---|
| `split: true` | a whole list in one element, one line per `<br>` or paragraph |
| `skip: "<selector>"` | something inside a row that is not part of the text, such as a step number |

```ruby
ingredients rows: ".recipe-ingredients p", split: true
instructions rows: ".recipe-step", skip: ".step-number"
```

When a site generates class names with a random suffix, such as `ingredients_recipeYield__DN65p`,
match the part that stays:

```ruby
yields "[class*='ingredients_recipeYield']"
```

## Ingredient groups

The gem finds ingredient groups on its own on sites built with
[WP Recipe Maker](https://wordpress.org/plugins/wp-recipe-maker/),
[Tasty Recipes](https://www.wptasty.com/tasty-recipes) and
[Create by Mediavine](https://www.mediavine.com/mediavine-recipe-card/), and in a list whose
headings end with a colon, such as `For the sauce:`. Any other layout declares where the headings
are:

```ruby
ingredient_groups heading: ".ingredient-group h4", item: ".ingredient-group li"
```

`item` has to match the ingredient lines and nothing else. When the headings are lines of a split
row, declare `heading` alone:

```ruby
ingredients rows: ".ingredients p", split: true
ingredient_groups heading: ".ingredients strong"
```

## Encoding

A site that sends a legacy encoding without naming it in its headers declares it:

```ruby
encoding "windows-1251"
```

## Parsing ingredients or nutrients differently

A declaration can put a parser of its own in front of the bundled one, for this site only. See
[Parsers](Parsers.md).

```ruby
RecipeScrapers.register "example.com" do
  parser :ingredients, ExampleIngredients, RecipeScrapers::Parsers::Ingredients
end
```

## When selectors are not enough

A site whose markup is there but needs reading in its own way gets a `Scraper` subclass instead
of a declaration. `lib/recipe_scrapers/sites/de/chefkoch.rb` is a short example.
