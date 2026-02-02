# Get the PR diff

Sends a GET request to the GitHub API and retrieves the files modified
by the PR. It then subsets these to only includes files under `R/` or
`src/`.

## Usage

``` r
get_diff_text(pr_details, relevant_files, call = rlang::caller_env())
```

## Arguments

- pr_details:

  a `<pr_details>` object representing a subset of the pull request
  metadata we need. The output of
  [`get_pr_details()`](https://dragosmg.github.io/covr2gh/reference/get_pr_details.md).

- relevant_files:

  (character) files with changes in coverage

- call:

  the execution environment to surface the error message from. Defaults
  to
  [`rlang::caller_env()`](https://rlang.r-lib.org/reference/stack.html).

## Value

a character vector containing the names of the changed files.

## Examples

``` r
if (FALSE) { # \dontrun{
pr_details <- get_pr_details("<owner>/<repo>", 2)
# TODO example
relevant_files <-
diff_text <- get_diff_text(pr_details, relevant_files)
} # }
```
