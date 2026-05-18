# Compose the line coverage details section

The section is made up of a subtitle (Heading 3) and a Markdown table.
If the input object is `NULL` an empty string is returned.

## Usage

``` r
compose_line_coverage_details(line_cov_delta)
```

## Arguments

- line_cov_delta:

  a `tibble` the output of
  [`get_diff_line_coverage()`](https://dragosmg.github.io/covr2gh/reference/get_diff_line_coverage.md)

## Value

a `glue` string

## Details

This section will be part of the "More details" collapsible section of
the GitHub comment.
