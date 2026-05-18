# Digest file coverage

Takes a `coverage` object (the output of
[`covr::package_coverage()`](http://covr.r-lib.org/reference/package_coverage.md),
extracts the `"filecoverage"` component and transforms it into a
`tibble`. Additionally, it extracts the `"totalcoverage"` element and
adds it as the `"Overall"` row.

## Usage

``` r
file_coverage_digest(coverage, call = rlang::caller_env())
```

## Arguments

- coverage:

  a `<coverage>` object, the output of a call to
  [`covr::package_coverage()`](http://covr.r-lib.org/reference/package_coverage.md).

- call:

  The execution environment of a currently running function, e.g.
  `caller_env()`. The function will be mentioned in error messages as
  the source of the error. See the `call` argument of
  [`abort()`](https://rlang.r-lib.org/reference/abort.html) for more
  information.

## Value

a `tibble` with 2 columns (`File` and `Coverage`) summarising testing
coverage at file level.

## Examples

``` r
if (FALSE) { # \dontrun{
library(covr)

coverage <- covr::package_coverage("myawesomepkg")
file_coverage_digest(coverage)
} # }
```
