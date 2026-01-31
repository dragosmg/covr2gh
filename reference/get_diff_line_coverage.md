# Get the line coverage for the diff

Are the added lines covered by unit tests? Does this in several steps:

- get the text of the git diff (the combined diff format)

- extracts the added lines and calculates the new line numbers

- does a bit of shuffling of the head coverage data to summarise at line
  level

- summarises the number of lines added and number of lines covered by
  tests at file level

## Usage

``` r
get_diff_line_coverage(repo, pr_details, relevant_files, head_coverage)
```

## Arguments

- repo:

  (character) the repository name in the GitHub format (`"OWNER/REPO"`).

- pr_details:

  a `<pr_details>` object representing a subset of the pull request
  metadata we need. The output of
  [`get_pr_details()`](https://dragosmg.github.io/covr2gh/reference/get_pr_details.md).

- relevant_files:

  (character) files with changes in coverage

- head_coverage:

  (coverage) active / current branch (`HEAD`) coverage. The output of
  [`covr::package_coverage()`](http://covr.r-lib.org/reference/package_coverage.md)
  on the branch.

## Value

a `tibble` with 3 columns:

- file: file name

- lines_added: total number of lines that would be added by merging the
  PR

- lines_covered: number of added lines covered by unit tests
