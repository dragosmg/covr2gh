# Digest file coverage

Takes a `coverage` object (the output of
[`covr::package_coverage()`](http://covr.r-lib.org/reference/package_coverage.md),
extracts the `"filecoverage"` component and transforms it into a
`tibble`. It also extracts the `"totalcoverage"` and adds it as the
`"Overall"` row.

## Usage

``` r
file_coverage(x)
```

## Arguments

- x:

  `<coverage>` object, defaults to
  [`covr::package_coverage()`](http://covr.r-lib.org/reference/package_coverage.md).

## Value

a `tibble` with 2 columns (`File` and `Coverage`) summarising testing
coverage at file level.

## Examples

``` r
if (FALSE) { # \dontrun{
library(covr)

covr::package_coverage("myawesomepkg") |>
  file_coverage()
} # }
```
