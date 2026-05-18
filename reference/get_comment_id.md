# Identify the covr2gh comment

Comments posted by covr2gh are identified by the presence of the
`"<!-- covr2gh-do-not-delete -->"` marker. `get_comment_id()` looks for
it. If it can find it, it returns the comment ID, otherwise it returns
`NULL`.

## Usage

``` r
get_comment_id(
  repo,
  pr_number,
  marker = covr2gh_marker,
  call = rlang::caller_env()
)
```

## Arguments

- repo:

  (character) the repository name in the GitHub format (`"OWNER/REPO"`).

- pr_number:

  (integer) the PR number

## Value

the comment ID (scalar numeric) or `NULL`

## Details

The output of `get_comment_id()` is then used
[`post_comment()`](https://dragosmg.github.io/covr2gh/reference/post_comment.md)
post a new comment or update an existing one.

## Examples

``` r
if (FALSE) { # \dontrun{
get_comment_id("<owner>/<repo>", 3)
} # }
```
