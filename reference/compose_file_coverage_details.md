# Compose the file coverage details section

the section is made up of a subtitle (heading 3) and a table. if the
input is `NULL`, the output is an empty string.

## Usage

``` r
compose_file_coverage_details(file_cov_df)
```

## Arguments

- file_cov_df:

  a `tibble`, the output of
  [`combine_file_coverage()`](https://dragosmg.github.io/covr2gh/reference/combine_file_coverage.md)

## Value

a glue object, a string with the section content.
