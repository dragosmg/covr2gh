# Get the PR diff

Sends a GET request to the GitHub API and retrieves the full PR diff,
which is a (comparison) between base (the starting point for the
comparison) and head (the endpoint). The diff is then filtered to only
include the "relevant files".

## Usage

``` r
get_diff_text(pr_details)
```

## Arguments

- pr_details:

  a `pr_details` object.

## Value

a named list where the names are file names and the content of each
element is the patch for the specific file.

## Examples

``` r
if (FALSE) { # \dontrun{
pr_details <- get_pr_details("<owner>/<repo>", 2)

diff_text <- get_diff_text(pr_details)
} # }
```
