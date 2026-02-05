# Classify lines

`-`: line appears in base, but not in head (was deleted) `+`: line
appears in head, but not in base (was added) `++`: line was added, but
does not appear in either head or base it indicates a line that did not
exist in either parent and was introduced by the merge resolution itself
`@`: hunk header

## Usage

``` r
classify_lines(raw_diff_df)
```

## Arguments

- raw_diff_df:

  (tibble) a raw diff tibble with a single column named \`raw

## Value

a tibble with 5 additional columns, all logical, classifying the rows
into:

- hunk:

- base: present only in base (deleted)

- head: present only in head (added)

- merge: present neither in head nor in base

- context: present both in head and in base
