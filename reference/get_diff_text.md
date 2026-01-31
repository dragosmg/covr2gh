# Get the PR diff

Sends a GET request to the GitHub API and retrieves the files modified
by the PR. It then subsets these to only includes files under `R/` or
`src/`.

## Usage

``` r
get_diff_text(repo, pr_details, relevant_files, call = rlang::caller_env())
```

## Arguments

- repo:

  (character) the repository name in the GitHub format (`"OWNER/REPO"`).

- call:

  the execution environment to surface the error message from. Defaults
  to
  [`rlang::caller_env()`](https://rlang.r-lib.org/reference/stack.html).

## Value

a character vector containing the names of the changed files.

## Examples

``` r
if (FALSE) { # \dontrun{
get_diff_text("<owner>/<repo>", 2)
} # }
```
