# the GitHub comment should contain:
#   * the overall percentage (as badge)
#   * a summary table for the all files or just those modified by the PR
build_comment <- function(x) {
  table_as_string <- to_md(x) |>
    glue::glue_collapse(
      sep = "\n"
    )

  total_coverage <- covr::percent_coverage(x) |>
    round(digits = 2)

  badge_url <- build_badge_url(total_coverage)

  glue::glue(
    "
    ![badge]({badge_url})

    ## Summary

    {table_as_string}

    Results for commit: [insert commit URL here]

    :recycle: Comment updated with the latest results.
    "
  )
}
