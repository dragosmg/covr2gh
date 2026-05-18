# Post comment

`post_comment()` first checks if a "known" `covr2gh` comment exists on
the target pull request. If it does, then it updates it, if it doesn't,
then a a new comment is posted.

## Usage

``` r
post_comment(body, repo, pr_number, update = TRUE)
```

## Arguments

- body:

  (character scalar) the content of the body of the message.

- repo:

  (character) the repository name in the GitHub format (`"OWNER/REPO"`).

- pr_number:

  (integer) the PR number

- update:

  (logical) update an existing comment or post a new one. Defaults to
  `TRUE`.

## Value

a `gh_response` object containing the API response

## Details

Users can also choose to always post a new comment (this always deletes
the previous one).

## Examples

``` r
if (FALSE) { # \dontrun{
post_comment(
  "this is amazing",
  repo = "<owner>/<repo>",
  pr_number = 3
)
} # }
```
