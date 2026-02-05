# Split (un-combine) diff text

Reverse-engineer the combined view of the diff.

## Usage

``` r
diff_split(diff_text)
```

## Arguments

- diff_text:

  (character) string with the diff contents

## Value

a list with 2 tibbles:

- `head_lines`: the numbered lines that were added in head

- `base_lines`: the numbered lines that were removed from base

Each `tibble` has 2 columns: `line` and \`source“
