# Notice for the recorded pages

This notice covers the content of `spec/cassettes` only. The MIT license in `LICENSE` covers the
code and does not extend to these files.

Each cassette is a recipe page as its website served it, recorded to test that the gem reads the
page correctly. The pages are kept under the copyright exceptions that allow limited use of a work
for technical testing, among them fair use in the United States and fair dealing in the United
Kingdom, Canada and Australia.

## Purpose

The recordings exist to:

- test the scrapers against real pages
- verify that a change to the engine keeps every site working
- show, in a spec, what a site's markup looks like

## Ownership

The recipe content in these files belongs to its authors and websites: the titles, the ingredient
lists, the instructions, the images, the descriptions and everything else on the page. This project
claims no ownership of any of it.

## Attribution

Each cassette sits at a path named after its website. `spec/cassettes/com/recipetineats.yml`
holds a page of recipetineats.com, and the request inside it names the exact URL.

## Limits on use

- The recordings are used only to test the software.
- Each site has one page, the least a test needs.
- They are not used commercially and are not part of the published gem.
- They do not stand in for the original page or reduce its value.
- Any of them is removed on request.

## Removal

If you hold the copyright to a page recorded here and want it removed, open an issue at
<https://github.com/davqasd/recipe_scrapers/issues>. The recording and the spec that depends on it
are deleted.
