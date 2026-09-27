# Contributing

## Reporting a problem

If a site gives wrong or missing data, or you want a new site supported,
[open an issue](https://github.com/davqasd/recipe_scrapers/issues) with the URL of a recipe page
and what you expected to see. Report a security problem privately instead, as
[SECURITY](SECURITY.md) describes.

## Opening a pull request

1. Fork the repository and clone your fork.
2. Run `bundle install`. You need a Ruby that `recipe_scrapers.gemspec` allows.
3. Create a branch, make your change and add specs for it.
4. Run `bin/ci`. It runs RuboCop, the specs, the YARD check and the check that `gemfiles/` is up
   to date, the same as CI.
5. Push the branch to your fork and open a pull request against `main`.

A good pull request solves the smallest problem it can, with a spec that fails without it. To add
a site, follow [Adding a Site](wiki/Adding-a-Site.md).

## Commit messages

Commits follow [Conventional Commits](https://www.conventionalcommits.org/), and the changelog is
built from them. `feat:`, `fix:`, `perf:`, `deps:` and `revert:` go into it. `docs:`,
`refactor:`, `test:`, `ci:`, `build:` and `chore:` do not. Write the subject for a user of the gem,
such as `fix: read yields written as a range`. A breaking change adds `!` after the type and a
`BREAKING CHANGE:` footer that says what to change.

Each change a user would notice gets a commit of its own, and every commit passes `bin/ci`. A pull
request is squash-merged, so its title is the changelog entry that reaches `main`. When it carries
more than one such change, its description ends with a "Release notes" block that lists the
others, one conventional message per paragraph, and that block becomes the body of the squash
commit, which release-please reads as more entries:

```text
fix: read JSON-LD that repeats a key

fix: find a microdata recipe nested in another item
```

## Repository structure

- `lib/recipe_scrapers/` holds the gem, one namespace per folder: `sources/` reads the page,
  `parsers/` turns text into values, `models/` holds the value objects the gem returns, and
  `http/` fetches the page.
- `lib/recipe_scrapers/sites/` holds one file per supported site.
- `spec/` mirrors `lib/`. `spec/cassettes/` holds the recorded pages, see [Testing](wiki/Testing.md).
- `wiki/` holds the guides. A push to `main` publishes them to the GitHub wiki, so edit them here.

A new file gets a `require_relative` line in `lib/recipe_scrapers.rb`, and its path matches its
constant.

## Code style

- RuboCop's configuration is the style guide.
- No comments in Ruby code, apart from YARD documentation of the public API. Everything public is
  documented, and an internal method or constant is `private`, `private_constant` or
  `@api private`.
- The words of each language live in `lib/recipe_scrapers/parsers/vocabulary/<language>.yml`: the
  ingredient parser's units and qualifiers, and the words that label a numbered step.

## Supported versions

The gem supports every Ruby branch before its end of life, and every minor line of a dependency
that had a release in the last three years. CI runs the specs on every supported Ruby with the
newest dependencies, and on the oldest Ruby with every dependency at its floor:

```console
bin/appraisal install
CI=1 bin/appraisal minimum rspec
```

The floors are in the gemspec, and `Appraisals` pins them for the `minimum` set. Code that exists
only for an old version goes into `lib/recipe_scrapers/compat/` with a `REQUIRED_UNTIL` version, and
`spec/compat_spec.rb` fails once the floor reaches it.

## Releasing

[release-please](https://github.com/googleapis/release-please) keeps a release pull request open
with the next version and its changelog. Merging it tags the release and publishes the gem.
