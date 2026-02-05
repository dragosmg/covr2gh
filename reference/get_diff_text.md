# Get the PR diff

Sends a GET request to the GitHub API and retrieves the full PR diff,
which is a (comparison) between base (the starting point for the
comparison) and head (the endpoint). The diff is then filtered to only
include the "relevant files".

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

  (character) files we are interested in. These are either being changed
  by the PR, their coverage has changed or new files (for which test
  coverage in base should be `NA`).

- call:

  the execution environment to surface the error message from. Defaults
  to
  [`rlang::caller_env()`](https://rlang.r-lib.org/reference/stack.html).

## Value

a named list where the names are file names and the content of each
element is the patch for the specific file.

## Examples

``` r
if (FALSE) { # \dontrun{
pr_details <- get_pr_details("<owner>/<repo>", 2)
relevant_files <- c("R/foo.R", "R/bar.R")
diff_text <- get_diff_text(pr_details, relevant_files)
} # }
```
