#' Get the line coverage for the diff
#'
#' Are the modified lines covered by unit tests?
#' Does this in several steps:
#'   * get the text of the git diff (the combined diff format)
#'   * extracts the added (?) - maybe modified - lines and calculates the new
#'   line numbers
#'   * does a bit of shuffling of the head coverage data to summarise at
#'   line level
#'   * summarises the number of lines added and number of lines covered by
#'   tests at file level
#'
#'
#' @inheritParams get_pr_details
#' @inheritParams compose_coverage_summary
#' @inheritParams compose_comment
#'
#' @returns a `tibble` with 3 columns:
#'   * file: file name
#'   * lines_modified (lines_added?): total number of lines that would be added
#'   by merging the PR
#'   * lines_covered: number of added (?) - maybe modified - lines covered by
#'   unit tests
#'
#' @keywords internal
get_diff_line_coverage <- function(
    pr_details,
    head_coverage
) {
    check_pr_details(pr_details)
    check_coverage(head_coverage)

    diff_content <- get_diff_content(pr_details)

    if (rlang::is_empty(diff_content)) {
        return(NULL)
    }

    added_lines <- diff_content |>
        purrr::map(extract_added_lines) |>
        purrr::list_rbind(names_to = "file_name")

    # this prevents errors when there are no added / modified lines, but the
    # diff_content is not empty
    if (rlang::is_empty(added_lines)) {
        return(NULL)
    }

    line_coverage <- head_coverage |>
        covr::tally_coverage(by = "line") |>
        tibble::as_tibble()

    diff_line_coverage <- added_lines |>
        dplyr::left_join(
            line_coverage,
            by = dplyr::join_by(
                "file_name" == "filename",
                "line"
            )
        ) |>
        # missing coverage value implies the line does not contain runnable code
        dplyr::filter(
            !is.na(.data$value)
        ) |>
        dplyr::mutate(
            covered = .data$value != 0
        )

    # if we're left with 0 rows by this point -> all lines changed are
    # non-runnable -> return NULL
    if (nrow(diff_line_coverage) == 0) {
        return(NULL)
    }

    missing_cov <- diff_line_coverage |>
        dplyr::filter(
            !.data$covered
        ) |>
        dplyr::group_by(
            .data$file_name
        ) |>
        dplyr::summarise(
            missing = find_intervals(.data$line)
        ) |>
        dplyr::ungroup()

    totals <- diff_line_coverage |>
        dplyr::group_by(
            .data$file_name
        ) |>
        dplyr::summarise(
            # lines_added = dplyr::n(), # nolint
            lines_modified = dplyr::n(),
            lines_covered = sum(.data$covered)
        ) |>
        dplyr::ungroup()

    output <- totals |>
        dplyr::left_join(
            missing_cov,
            by = dplyr::join_by(
                "file_name"
            )
        )

    output
}
