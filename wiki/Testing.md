# Testing

`bin/ci` runs every check CI runs, see [CONTRIBUTING](../CONTRIBUTING.md#opening-a-pull-request).

## Site specs

Every supported site has a spec and a recorded page, at matching paths:

```
lib/recipe_scrapers/sites/com/recipetineats.rb
spec/sites/com/recipetineats_spec.rb
spec/cassettes/com/recipetineats.yml
```

`RecipeScrapers::SitePath.for("recipetineats.com")` returns `com/recipetineats`, the part the
three paths share. `spec/registry_coverage_spec.rb` fails when a registered host has no spec, or
when a spec names a host that is not registered.

## Cassettes

A cassette holds a response exactly as the site served it, without `Set-Cookie`, so every site is
tested against a real page. The cassettes are recorded with [VCR](https://github.com/vcr/vcr).

- A spec whose cassette exists replays it and makes no request.
- A spec whose cassette is missing fetches the live page and records it. When the page has no
  title or no ingredients, the recording is thrown away and the spec fails, so a bot-protection
  page is never kept.
- With `CI` set, nothing is recorded, and a spec whose cassette is missing fails.

## When a site changes

To check a site against its current page, delete its cassette and run its spec:

```console
rm spec/cassettes/com/recipetineats.yml
bundle exec rspec spec/sites/com/recipetineats_spec.rb
```

The run records the page as it is now. If the spec passes, the site works and the new cassette
can be committed. If it fails, find out which of two things changed:

- The recipe itself, while the gem still reads it correctly. Check the new values against the page
  in a browser, update the spec and commit both.
- The markup, so the gem reads the page wrong. Fix the declaration or the site's class until the
  spec passes.

Never edit a cassette by hand. It is a copy of what the site served, and an edited one tests a page
that never existed. Delete it and record it again.

Delete a cassette only to record that site again on purpose. It is often the only copy of a page
the site no longer serves or now hides behind bot protection. A change to expected values is read
by a person against the page, never accepted because the suite went green.
