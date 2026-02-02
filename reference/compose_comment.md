# Compose a coverage comment

Compose a coverage comment

## Usage

``` r
compose_comment(
  head_coverage,
  base_coverage,
  repo,
  pr_number,
  diff_cov_target = NULL
)
```

## Arguments

- head_coverage:

  (coverage) active / current branch (`HEAD`) coverage. The output of
  [`covr::package_coverage()`](http://covr.r-lib.org/reference/package_coverage.md)
  on the head branch.

- base_coverage:

  (coverage) base / target branch coverage (coverage for the branch
  merging into). The output of
  [`covr::package_coverage()`](http://covr.r-lib.org/reference/package_coverage.md)
  on the base branch.

- repo:

  (character) the repository name in the GitHub format (`"OWNER/REPO"`).

- pr_number:

  (integer) the PR number

- diff_cov_target:

  (numeric) minimum accepted diff coverage. Defaults to `NULL` which is
  then interpreted as overall base branch coverage.

## Value

a character scalar with the content of the GitHub comment

## Examples

``` r
if (FALSE) { # \dontrun{
coverage_head <- covr::package_coverage()
system("git checkout main")
coverage_main <- covr::package_coverage()

compose_comment(
  head_coverage = coverage_head,
  base_coverage = coverage_main,
  repo = "<owner>/<repo>",
  pr_number = 3
)
} # }
```
