# the GitHub comment should contain:
#   * the overall percentage (as badge) at the top
#   * a topline summary statement:
#     * "merging this PR (PR number & commit hash) into $destination_branch
#     will **increase** / **decrease** / **not change** coverage. The change in
#     coverage is."
#   * the H2 (?) title - Summary (or something like Codecov - "Additional
#   details and impacted files").
#   * a summary table for the all files or just those modified by the PR
#     * maybe just those modified by the PR as those would be more relevant
#   * capture the commit hash somehow
#   * maybe something about the target coverage figure
#   * in the future something about direct vs indirect testing
#   * a notice about the fact this is a "sticky" comment that will be updated
#    by subsequent runs
build_comment <- function(x) {
  table_as_string <- to_md(x) |>
    glue::glue_collapse(
      sep = "\n"
    )

  total_coverage <- covr::percent_coverage(x)

  badge_url <- build_badge_url(total_coverage)

  glue::glue(
    "
    ![badge]({badge_url})

    ## Coverage summary

    {table_as_string}

    Results for commit: [insert commit hash / URL here]

    :recycle: Comment updated with the latest results.
    "
  )
}
