# Recipe Fields

`scrape` and `parse` return a `RecipeScrapers::Models::Recipe`. Every field below is a method on it.
Sites differ in what they publish, so any field can be `nil`.

Unless noted, the examples come from
<https://www.recipetineats.com/crispy-potato-straws-pommes-paille/>.

| Field | Type | Holds |
|---|---|---|
| `url` | String | The address the recipe was read from |
| `canonical_url` | String | The canonical link of the page, or `url` when there is none |
| `host` | String | The host of `url`, without `www.` |
| `title` | String | `"Crispy potato straws (Pommes Paille)"` |
| `description` | String | A sentence or short paragraph about the recipe |
| `author` | String | `"Nagi"`. Several authors are joined with a comma |
| `site_name` | String | `"RecipeTin Eats"` |
| `language` | String | A language tag, such as `"en-US"` |
| `image` | String | The absolute URL of the main image |
| `ingredients` | Array of String | The ingredient lines as the page writes them |
| `parsed_ingredients` | Array of `Models::Ingredient` | The same lines split into amount, unit and name |
| `ingredient_groups` | Array of `Models::IngredientGroup` | The ingredients under the headings the page shows |
| `instructions_list` | Array of String | The steps. A section heading is an entry of its own |
| `instructions` | String | The steps joined with `"\n"` |
| `yields` | String | `"4 servings"` or `"12 items"` |
| `total_time`, `prep_time`, `cook_time` | Integer | Minutes |
| `category` | String | The course, such as `"Sides"` |
| `cuisine` | String | `"French"` |
| `cooking_method` | String | `"Oven"` |
| `keywords` | Array of String | `["matchstick fries", "pommes pailles", ...]` |
| `dietary_restrictions` | Array of String | schema.org [RestrictedDiet](https://schema.org/RestrictedDiet) values, such as `"GlutenFreeDiet"` |
| `equipment` | Array of String | The tools a recipe needs. schema.org has no field for them, so only a site that lists them in its [declaration](Declarations.md) fills it |
| `nutrients` | Hash of String | The nutrition facts as the page writes them |
| `parsed_nutrients` | Array of `Models::Nutrient` | The same facts split into name, unit and amount |
| `ratings` | Float | The average rating, `nil` before anybody rates |
| `ratings_count` | Integer | The ratings behind the average, or the reviews when the page gives no count |
| `links` | Array of String | The `href` of every link on the page |

## Ingredients

`ingredients` holds the lines as the page writes them. A line that is only a separator, such as
`*`, is left out. A line that ends in a colon and has no digit, such as `For the sauce:`, is a group
heading. It goes to `ingredient_groups` and not to `ingredients`.

`parsed_ingredients` splits every line into an amount, a unit and a name, in the same order:

```ruby
recipe.ingredients
# => ["1 potato (Aus: Sebago, US: russet, UK: Maris Piper), or other starchy or all-rounder potato (Note 1)",
#     "1 1/2 - 2 cups vegetable oil (canola, sunflower or peanut oil)",
#     "Sea salt flakes (, crushed with fingers into a powder)"]

recipe.parsed_ingredients.map(&:to_h)
# => [{ amount: 1.0, unit: nil, name: "potato, or other starchy or all-rounder potato" },
#     { amount: 1.5, unit: "cups", name: "vegetable oil" },
#     { amount: nil, unit: nil, name: "Sea salt flakes" }]
```

- `amount` is a Float rounded to two places. `½` reads as `0.5` and `1/3` as `0.33`. A range keeps
  its lower bound, and a number written as a word counts. A pinch or a dash with no number reads
  as `1.0`.
- `unit` is a unit word of the recipe language or a metric unit, as the page writes it. Any other
  word stays in `name`.
- Text in parentheses is dropped, and so is a second measure after a slash or a plus, so
  `1 cup/240 ml milk` reads as one cup of milk.

## Ingredient groups

`ingredient_groups` holds the ingredients under the headings the page shows, such as "For the
dough" and "For the filling". Each `Models::IngredientGroup` has a `purpose`, which is the heading,
its `ingredients` and their `parsed_ingredients`. A recipe without groups gives one group with a
`nil` purpose.

From <https://cafedelites.com/best-churros-recipe/>:

```ruby
recipe.ingredient_groups.map { |group| [group.purpose, group.parsed_ingredients.first.to_h] }
# => [["COATING", { amount: 0.5, unit: "cup", name: "sugar" }],
#     ["CHURROS", { amount: 4.0, unit: "ounces", name: "butter" }]]
```

The groups always hold the lines of `ingredients`, in the same order.

## Nutrients

`nutrients` holds the nutrition facts as the page publishes them, usually per serving, keyed by the
schema.org [NutritionInformation](https://schema.org/NutritionInformation) property.
`parsed_nutrients` splits every value into a name, a unit and an amount, and leaves out a value
with no number.

From <https://40aprons.com/rosemary-raspberry-vodka-fizz/>:

```ruby
recipe.nutrients.first(2).to_h
# => { "servingSize" => "1 cocktail", "calories" => "357 kcal" }

recipe.parsed_nutrients.first(2).map(&:to_h)
# => [{ name: "servingSize", unit: "cocktail", amount: 1.0 },
#     { name: "calories", unit: "kcal", amount: 357.0 }]
```

- `amount` keeps every decimal the page writes. A zero stays `0.0`.
- Mass and energy units are written as `g`, `mg`, `µg`, `kcal` and `kJ`, whatever the page calls
  them. Other units stay as written.

## Times and yields

The times are minutes, read from ISO 8601 durations (`PT1H30M`) or from text such as
`1 hour 30 minutes`. A time the gem cannot read for certain is `nil`, not a guess.

```ruby
recipe.prep_time   # => 10
recipe.cook_time   # => 10
recipe.total_time  # => nil
recipe.yields      # => "1 servings"
```

## `to_h`

`to_h` returns every field as plain data. The value objects inside it become hashes too, so the
result can go straight to JSON.

```ruby
recipe.to_h
# => { url: "https://www.recipetineats.com/crispy-potato-straws-pommes-paille/",
#      title: "Crispy potato straws (Pommes Paille)", author: "Nagi", ... }
```
