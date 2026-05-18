# Transform a line coverage tibble to markdown

Adds a total row, make column names more readable. Then transforms it to
markdown which gets collapsed into a single string.

## Usage

``` r
line_cov_to_md(line_cov_delta, align = "lrrrl")
```

## Arguments

- line_cov_delta:

  (`tibble`) diff line coverage data. The output of
  [`get_diff_line_coverage()`](https://dragosmg.github.io/covr2gh/reference/get_diff_line_coverage.md)

- align:

  Column alignment: a character vector consisting of `'l'` (left), `'c'`
  (center) and/or `'r'` (right). By default or if `align = NULL`,
  numeric columns are right-aligned, and other columns are left-aligned.
  If `length(align) == 1L`, the string will be expanded to a vector of
  individual letters, e.g. `'clc'` becomes `c('c', 'l', 'c')`, unless
  the output format is LaTeX.

## Value

a markdown table as a string
