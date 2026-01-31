# Identify the covr2gh comment

Comments are identified by a specific "marker", in itself a comment.
This is hardcoded to `"<!-- covr2gh-do-not-delete -->"`.
`get_comment_id()` looks for this marker. If it can find it, it returns
the comment ID, otherwise it returns `NULL`.

## Usage

``` r
get_comment_id(repo, pr_number, call = rlang::caller_env())
```

## Arguments

- repo:

  (character) the repository name in the GitHub format (`"OWNER/REPO"`).

- pr_number:

  (integer) the PR number

- call:

  the execution environment to surface the error message from. Defaults
  to
  [`rlang::caller_env()`](https://rlang.r-lib.org/reference/stack.html).

## Value

a numeric scalar representing the comment id or `NULL`

## Details

The output of `get_comment_id()` is the used
[`post_comment()`](https://dragosmg.github.io/covr2gh/reference/post_comment.md)
post a new comment or update an existing one.

## Examples

``` r
if (FALSE) { # \dontrun{
get_comment_id("<owner>/<repo>", 3)
} # }
```
