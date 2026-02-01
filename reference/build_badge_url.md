# Build the URL to the badge SVG

This is needed since the Markdown comment on GitHub does not allow
embedded images (e.g. as data URI
https://en.wikipedia.org/wiki/Data_URI_scheme). In theory we could
encode an image as a base64 string and then use this with an `<img>` tag
in HTML (GitHub supports some tags in markdown). For example, we could
accomplish this with
[`knitr::image_uri()`](https://rdrr.io/pkg/knitr/man/image_uri.html).

## Usage

``` r
build_badge_url(pr_details, value)
```

## Arguments

- pr_details:

  a `pr_details` object (the output of
  [`get_pr_details()`](https://dragosmg.github.io/covr2gh/reference/get_pr_details.md))

- value:

  (numeric) coverage value

## Value

a glue string.

## Details

We have 2 choices:

- upload the badge to a separate, "storage" branch, or

- use an external URL (e.g. shields)

The whole issue (that started this package) is that, in enterprise
settings, using an external URL might not be possible. In a public repo,
using a storage branch should not work when the PR comes from a fork (as
the automatic GHA token only has read privileges). In conclusion, we can
make a distinction between PR from forks (will use an external URL) vs
non-forks (which will upload the badge to the storage branch).

Once the PR is merged the workflow triggered on push to main will be
able to upload the badge to the storage branch since it's no longer an
"external" activity.
