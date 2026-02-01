# Transform a coverage value into char

Outputs both values as both are used downstream by various other
helpers. If the input values are `NA` or `NULL` it converts them to
`"unknown"`. If the values are greater than 100 or less than 0 it
adjusts them to these values

## Usage

``` r
badge_value(value, verbose = FALSE, call = rlang::caller_env())
```

## Arguments

- value:

  (numeric) coverage value. Can also be `NA` or `NULL`

- verbose:

  (logical) if we want messages around the clamping. Default is `FALSE`.

- call:

  (call) defaults to
  [`rlang::caller_env()`](https://rlang.r-lib.org/reference/stack.html)

## Value

a list with 2 element:

- `num`: the value as numeric

- `char`: the value as character

## Examples

``` r
if (FALSE) { # \dontrun{
badge_value(26.78)
} # }
```
