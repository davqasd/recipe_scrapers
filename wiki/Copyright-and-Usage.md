# Copyright and Usage

`recipe_scrapers` reads recipes from web pages. What you do with them is up to you, and so is the
responsibility for it.

## What the gem does

The gem:

- reads pages that a website serves to anyone
- turns the recipe on a page into structured data
- does not store, host or redistribute any content
- does not circumvent bot protection or any other technical access control
- makes no claim about the copyright status of the content it reads

## What the user is responsible for

If you use the gem, you are responsible for:

- making sure your use of scraped content complies with the law where you operate
- following each website's terms of service and its `robots.txt`
- getting permission where your use of the content needs it
- meeting any copyright or licensing requirements of the content

## Fair use

Many uses fall under fair use, fair dealing or a similar exception, for example:

- a personal recipe collection
- academic research and analysis
- a transformative use that adds something new
- non-commercial teaching

These exceptions differ by country. Make your own legal assessment for your use and jurisdiction.

## Good practice

- Cache what you fetch, so each page is requested as rarely as possible.
- Keep your request rate low and respect `robots.txt`.
- Credit the source when you show a recipe, and link back to it.
- Read the site's terms of service.
- Handle errors and missing fields, because sites change without notice.

## For contributors

- Keep the gem a neutral tool: better parsing, bug fixes, new sites.
- Do not add features whose only use is to get around a site's access controls.

## Disclaimer

The gem is provided "as is", without warranty of any kind. See [License](License.md).

## Further reading

- [Stanford Libraries: Copyright and Fair Use](https://fairuse.stanford.edu/)
- [EFF: Coders' Rights Project](https://www.eff.org/issues/coders)
