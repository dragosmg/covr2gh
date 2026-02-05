# Add line numbers for a head patch

Add line numbers for a head patch

## Usage

``` r
add_line_num_head(head_df)
```

## Arguments

- head_df:

  (tibble) with 4 columns: `raw`, `hunk`, `head`, and `context`

## Value

a tibble with an extra integer column, `line` representing the line
number in "head"
