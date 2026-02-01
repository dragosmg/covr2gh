# Build `badge_params`

Take the value and build a list with all the value-dependent parameters
to be injected into the SVG template.

## Usage

``` r
badge_params(value)
```

## Arguments

- value:

  (numeric) coverage value

## Value

a list (a `badge_params` object) with the following elements:

- value_num: the coverage value as numeric (adjusted, if necessary)

- value_char: the coverage value as character

- value_col: the colour for the *value* box

- width_label: the width of the *label* box

- width_value: the width of the *value* box

- text_length_label: the length of the *label* text

- text_length_value: the length of the *value* text

- total_width: the total badge width

- text_start_value: point along the x-axis where the *value* text should
  start
