# the GitHub comment should contain:
#   * the overall percentage (as badge) at the top
#   * a topline summary statement:
#     * "merging this PR (PR number & commit hash) into $destination_branch
#     will **increase** / **decrease** / **not change** coverage. The change in
#     coverage is."
#     * it would be great to somehow capture if the added lines are covered by
#     unit tests (or what percentage is)
#   * the H2 (?) title - Summary (or something like Codecov - "Additional
#   details and impacted files").
#   * a summary table for the all files or just those modified by the PR
#     * maybe just those modified by the PR as those would be more relevant.
#     * table could have these columns File, This branch, Destination branch,
#     delta + an indication at file level if coverage is increasing or
#     decreasing
#   * capture the commit hash somehow
#   * maybe something about the target coverage figure
#   * in the future something about direct vs indirect testing
#   * a notice about the fact this is a "sticky" comment that will be updated
#    by subsequent runs
#
# args:
#   * head_coverage (coverage object)
#   * base_coverage (coverage object)
#   * z - pr number
#
compose_comment <- function(
  head_coverage,
  base_coverage,
  owner,
  repo,
  pr_number
) {
  changed_files <- get_changed_files(
    owner = owner,
    repo = repo,
    pr_number = pr_number
  )

  diff_md_table <- compose_coverage_details(
    head_coverage = head_coverage,
    base_coverage = base_coverage,
    changed_files = changed_files
  )

  pr_details <- get_pr_details(
    owner = owner,
    repo = repo,
    pr_number = pr_number
  )

  total_head_coverage <- covr::percent_coverage(head_coverage)
  total_base_coverage <- covr::percent_coverage(base_coverage)
  delta_total_coverage <- round(total_head_coverage - total_base_coverage, 2)

  badge_url <- build_badge_url(total_head_coverage)

  coverage_summary <- compose_coverage_summary(pr_details, delta_total_coverage)

  glue::glue(
    "
    # Coverage report

    ![badge]({badge_url})

    ## Coverage summary

    {coverage_summary}

    ## Coverage details

    {diff_md_table}

    Results for commit: {pr_details$head_sha}

    :recycle: Comment updated with the latest results.
    "
  )
}

# TODO look into logic invalidating the comment when the base_sha changes

# pr_details = a subset of the data we need (the API response)
#  * pr_number
#  * pr_html_url
#  * head_sha
#  * base_name
#  * base_sha
#  * delta in coverage.
compose_coverage_summary <- function(pr_details, delta) {
  delta_translation <- dplyr::case_when(
    delta > 0 ~ "increase",
    delta < 0 ~ "decrease",
    delta == 0 ~ "not change"
  )

  glue::glue(
    "Merging this PR ([#{ pr_details$pr_number}]({pr_details$pr_html_url}) - \\
    {pr_details$head_sha}) into _{pr_details$base_name}_ \\
    ({pr_details$base_sha}) - will **{delta_translation}** coverage."
  )
}

compose_coverage_details <- function(
  head_coverage,
  base_coverage,
  changed_files
) {
  # TODO handle the case when there are no relevant changed files
  # browser()
  head_coverage_digest <- digest_coverage(head_coverage)

  base_coverage_digest <- digest_coverage(base_coverage)

  diff_df <- head_coverage_digest |>
    dplyr::filter(
      file %in% changed_files
    ) |>
    dplyr::left_join(
      base_coverage_digest,
      by = dplyr::join_by(file),
      suffix = c("_head", "_base")
    ) |>
    dplyr::mutate(
      delta = .data$coverage_head - .data$coverage_base,
      delta = dplyr::case_when(
        delta > 0 ~ ":arrow_up:",
        delta < 0 ~ ":arrow_down:",
        delta == 0 ~ ":heavy_equals_sign:"
      ),
      coverage_head = paste0(
        .data$coverage_head,
        "%"
      ),
      coverage_base = paste0(
        .data$coverage_base,
        "%"
      )
    )

  diff_df_names <- diff_df |>
    names() |>
    stringr::str_to_sentence() |>
    stringr::str_replace_all(
      stringr::fixed("_"),
      " "
    ) |>
    stringr::str_replace(
      "Delta",
      "&Delta;"
    )

  names(diff_df) <- diff_df_names

  diff_md_table <- diff_df |>
    knitr::kable(align = "rrrc") |>
    glue::glue_collapse(
      sep = "\n"
    )

  diff_md_table
}
