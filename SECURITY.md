# Security Policy

## Supported versions

Only the latest release gets security fixes. If you find a problem in an older version, check
first whether the latest release still has it.

## Reporting a vulnerability

Report it privately through
[GitHub's vulnerability reporting](https://github.com/davqasd/recipe_scrapers/security/advisories/new),
not in a public issue. Include the version, what an attacker can do, and the steps or the page that
shows it. The fix and the advisory are published together, and the report credits you unless you
ask it not to.

## What counts

These are vulnerabilities:

- A URL that makes `RecipeScrapers.scrape` connect to a private, loopback or other non-public
  address, directly, through a redirect or through DNS.
- A response that gets past `max_body_bytes`, or a redirect chain that gets past `max_redirects`.
- A page whose HTML or markup makes parsing hang or use unbounded memory.

These are not:

- A connection you assign yourself, which the gem uses as it is. See
  [Configuration](wiki/Configuration.md#your-own-connection).
- `allow_private_addresses` set to `true`.
- Wrong or missing recipe data. [Open an issue](https://github.com/davqasd/recipe_scrapers/issues)
  for that.
