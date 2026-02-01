# Derive the colour for the value part of the badge

Maps a value to a certain interval and chooses the corresponding colour.

## Usage

``` r
derive_badge_colour(badge_value, colours = coverage_thresholds)
```

## Arguments

- badge_value:

  a `badge_value` object representing a coverage percentage

- colours:

  (`tibble`) a tibble with 2 columns `value` (threshold) and `colour`.

## Value

a colour hexcode as string

## Examples

``` r
if (FALSE) { # \dontrun{
derive_badge_colour(5)
} # }
```
