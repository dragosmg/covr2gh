# Delete a comment

Thin wrapper for making a `DELETE` request to the issue comments
endpoint of the GitHub API.

## Usage

``` r
delete_comment(repo, comment_id)
```

## Arguments

- repo:

  (character) the repository name in the GitHub format (`"OWNER/REPO"`).

- comment_id:

  (numeric) the ID of the issue comment to delete.

## Value

a `gh_response` object

## Examples

``` r
if (FALSE) { # \dontrun{
delete_comment("<owner>/<repo>", 4553)
} # }
```
