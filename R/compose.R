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

#' Compose a coverage comment
#'
#' @param head_coverage (coverage) active / current branch (`HEAD`) coverage.
#'   The output of [covr::package_coverage()] on the branch.
#' @param base_coverage (coverage) base / target branch coverage (coverage for
#'   the branch merging into). The output of [covr::package_coverage()] on the
#'   branch.
#' @inheritParams get_pr_details
#' @param marker (character scalar) string used to identify an issue
#'   comment generated with covr2md. Defaults to
#'   `"<!-- covr2md-code-coverage -->"`.
#' @param keep_all_files (logical) include all files in the diff coverage table
#'   or just those modified by the PR.
#' @inheritParams knitr::kable
#'
#' @returns a character scalar with the content of the GitHub comment
#'
#' @export
#' @examples
#' \dontrun{
#' head_coverage <- covr::package_coverage()
#' system2("git", c("checkout", "main"))
#' base_coverage <- covr::package_coverage()
#'
#' compose_comment(
#'   head_coverage = head_coverage,
#'   base_coverage = base_coverage,
#'   repo = "dragosmg/covr2mddemo",
#'   pr_number = 3
#' )
#' }
compose_comment <- function(
  head_coverage,
  base_coverage,
  repo,
  pr_number,
  marker = "<!-- covr2md-code-coverage -->",
  keep_all_files = FALSE,
  align = "rrrc"
) {
  # TODO add some checks on inputs
  # FIXME

  if (isFALSE(keep_all_files)) {
    changed_files <- get_changed_files(
      repo = repo,
      pr_number = pr_number
    )
  }

  if (rlang::is_empty(changed_files)) {
    cli::cli_alert_info(
      "No coverage relevant files changed. Returning all files"
    )
    keep_all_files <- TRUE
  }

  httr2::curl_help()

  diff_md_table <- compose_coverage_details(
    head_coverage = head_coverage,
    base_coverage = base_coverage,
    changed_files = changed_files,
    keep_all_files = keep_all_files,
    align = align
  )
  # browser()
  pr_details <- get_pr_details(
    repo = repo,
    pr_number = pr_number
  )

  basehead <- glue::glue("{pr_details$base_name}...{pr_details$head_name}")

  req_url <- glue::glue(
    "https://api.github.com/repos/{repo}/compare/{basehead}"
  )

  # TODO maybe identify orphan tests?
  # ! check

  # we can use this to somehow get the lines of code added
  reply <- glue::glue("GET {req_url}") |>
    gh::gh()

  line_details <- reply$files |>
    purrr::keep(~ .x$filename %in% changed_files)

  diff_text <- line_details[[1]]$patch
  diff_lines <- diff_text |>
    stringr::str_split("\n")

  line_details |>
    purrr::map(~ purrr::keep_at(.x, c("filename", "patch"))) |>
    purrr::map(
      ~ tibble::tibble(
        file = .x$filename,
        patch = .x$patch
      )
    ) |>
    purrr::list_rbind() |>
    dplyr::mutate(
      patch = stringr::str_split(patch, "\n")
    ) |>
    tidyr::unnest(patch) |>
    dplyr::group_by(file) |>
    dplyr::mutate(
      num = dplyr::row_number()
    ) |>
    dplyr::ungroup() |>
    dplyr::select(
      file,
      num,
      patch
    )

  # TODO see how this behaves with more complicated diffs - eg a tfrmt one
  # TODO move this logic out -> its focus is to identify which lines in head
  # have seen modifications in the PR. Then we can see what percentage of these
  # are covered by tests
  new_line_numbers_df <- tibble::tibble(
    line = diff_lines[[1]]
  ) |>
    dplyr::mutate(
      num = dplyr::row_number()
    ) |>
    dplyr::mutate(
      hunk_header = stringr::str_detect(line, "@@"),
      new_start = dplyr::if_else(
        hunk_header,
        stringr::str_extract(line, "\\+(\\d+)"),
        NA_character_
      ),
      new_start = stringr::str_remove_all(
        new_start,
        stringr::fixed("+")
      ),
      new_start = as.numeric(new_start)
    ) |>
    dplyr::mutate(
      include = dplyr::case_when(
        hunk_header ~ 0,
        stringr::str_starts(line, stringr::fixed("++")) ~ 0,
        stringr::str_starts(line, stringr::fixed("-"), negate = TRUE) ~ 1,
        .default = 0
      ),
      increment = dplyr::lag(include),
      prep = dplyr::coalesce(new_start, increment),
      new_line = cumsum(prep),
      new_line = dplyr::if_else(
        include == 0,
        NA_real_,
        new_line
      )
    )

  b <- new_line_numbers_df |>
    dplyr::select(num, line, new_line) |>
    dplyr::mutate(
      added = stringr::str_starts(
        line,
        stringr::fixed("+")
      )
    )

  a <- covr:::to_report_data(head_coverage) |>
    purrr::pluck("full") |>
    purrr::list_rbind(names_to = "file")

  hunk_header <- diff_lines[[1]][1]
  # confirm by checking the hunk header contains @@
  stringr::str_detect(hunk_header, "@@")
  output_line_diff_start <-
    total_head_coverage <- covr::percent_coverage(head_coverage)
  total_base_coverage <- covr::percent_coverage(base_coverage)
  delta_total_coverage <- round(total_head_coverage - total_base_coverage, 2)

  badge_url <- build_badge_url(total_head_coverage)

  coverage_summary <- compose_coverage_summary(
    pr_details,
    delta_total_coverage
  )

  # TODO update URL with the correct pkgdown one once there is one
  sup <- glue::glue(
    "<sup>Created on {Sys.Date()} with \\
    [covr2md {packageVersion('covr2md')}](https://reprex.tidyverse.org)</sup>"
  )

  glue::glue(
    "
    {marker}

    ## Coverage summary

    ![badge]({badge_url})

    {coverage_summary}

    <details>

    <summary>Details on impacted files</summary>
    <br/>

    {diff_md_table}

    </details>

    <br/>


    :recycle: Comment updated with the latest results.

    {sup}
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

#' Compose coverage summary
#'
#' Builds the top level sentences of the summary.
#'
#' @param pr_details a `<pr_details>` object representing a subset of the pull
#'   request metadata we need. The output of [get_pr_details()].
#' @param delta (numeric scalar) difference in total coverage between head of
#'   current branch and base branch.
#'
#' @returns a string (character scalar) containing the text for the coverage
#'   summary.
#'
#' @keywords internal
#' @examples
#' \dontrun{
#' pr_details <- get_pr_details(
#'   repo = "dragosmg/covr2mddemo",
#'   pr_number = 2
#' )
#'
#' coverage_summary <- compose_coverage_summary(
#'   pr_details = pr_details,
#'   delta = 20.43
#' )
#' }
compose_coverage_summary <- function(pr_details, delta) {
  delta_translation <- dplyr::case_when(
    delta > 0 ~ "increase",
    delta < 0 ~ "decrease",
    delta == 0 ~ "not change"
  )

  by_delta <- glue::glue(" by `{delta}` percentage points")

  by_delta <- dplyr::if_else(
    delta == 0,
    "",
    by_delta
  )

  emoji <- dplyr::if_else(
    delta >= 0,
    ":white_check_mark: ",
    ":x: "
  )

  glue::glue(
    "{emoji}Merging PR [#{ pr_details$pr_number}]({pr_details$pr_html_url}) \\
    ({pr_details$head_sha}) into _{pr_details$base_name}_ \\
    ({pr_details$base_sha}) - will **{delta_translation}** coverage{by_delta}."
  )
}

#' Compose coverage details
#'
#' @inheritParams compose_comment
#' @param changed_files (character) names of files changed by the PR. Usually
#'   the output of [get_changed_files()].
#'
#' @returns a markdown table of changes in coverage at file level between the
#'   head and base branches.
#'
#' @keywords internal
#' @examples
#' \dontrun{
#' changed_files <- get_changed_files(
#'   repo = "dragosmg/covr2mddemo",
#'   pr_number = 2
#' )
#'
#' coverage_details <- compose_coverage_details(
#'   head_coverage = head_coverage,
#'   base_coverage = base_coverage,
#'   changed_files = changed_files
#' )
#' }
compose_coverage_details <- function(
  head_coverage,
  base_coverage,
  changed_files,
  keep_all_files = FALSE,
  align = "rrrc"
) {
  # TODO handle the case when there are no relevant changed files
  # TODO think about when we would want to return all the files
  # (keep_all_files = TRUE), not just those touched by the PR
  diff_df <- derive_diff_df(
    head_coverage = head_coverage,
    base_coverage = base_coverage,
    changed_files = changed_files,
    keep_all_files = keep_all_files
  )

  diff_df_to_md(
    diff_df,
    align = align
  )
}
