#' Get pull request details
#'
#' Sends a GET request to the GitHub API and fetches the PR details. The output
#' contains a subset of these, needed for downstream use.
#'
#' @inheritParams compose_comment repo pr_number
#' @param call the execution environment to surface the error message from.
#'   Defaults to [rlang::caller_env()].
#'
#' @returns an object of class `pr_details` - a list with the following
#' elements:
#'   * `repo`: GitHub repository (the value passed to the `repo` input argument)
#'   * `pr_number`: pull request number (the value passed to the `pr_number`
#'      argument)
#'   * `head_name`: name of the current branch
#'   * `head_sha`: the sha of the last commit in the current branch
#'   * `base_name`: the name of the destination branch
#'   * `base_sha`: the sha of most recent commit on the destination branch
#'   * `pr_html_url`: the URL to the PR HTML branch
#'   * `diff_url`: the diff URL
#'
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' get_pr_details("<owner>/<myawesomerepo>", 2)
#' }
get_pr_details <- function(
    repo,
    pr_number,
    call = rlang::caller_env()
) {
    # TODO check for GitHub format (`OWNER/REPO`)
    rlang::check_string(repo, call = call)
    rlang::check_number_whole(pr_number, call = call)

    pr_api_url <- glue::glue(
        "https://api.github.com/repos/{repo}/pulls/{pr_number}"
    )

    pr_info <- glue::glue("GET {pr_api_url}") |>
        gh::gh()

    output <- structure(
        list(
            repo = repo,
            pr_number = pr_number,
            is_fork = pr_info$head$repo$fork,
            head_name = pr_info$head$ref,
            head_sha = pr_info$head$sha,
            base_name = pr_info$base$ref,
            base_sha = pr_info$base$sha,
            pr_html_url = pr_info$html_url,
            diff_url = pr_info$diff_url
        ),
        class = "covr2gh_pr_details"
    )

    output
}

is_pr_details <- function(x) {
    inherits(x, "covr2gh_pr_details")
}

check_pr_details <- function(
    x,
    ...,
    allow_null = FALSE,
    arg = rlang::caller_arg(x),
    call = rlang::caller_env()
) {
    if (!missing(x)) {
        if (is_pr_details(x)) {
            return(invisible(NULL))
        }
        if (allow_null && rlang::is_null(x)) {
            return(invisible(NULL))
        }
    }

    rlang::stop_input_type(
        x,
        "a covr2gh pr details object",
        ...,
        allow_null = allow_null,
        arg = arg,
        call = call
    )
}


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
    diff_content <- get_diff_content(
        pr_details = pr_details
    )

    if (rlang::is_empty(diff_content)) {
        return(NULL)
    }

    added_lines <- diff_content |>
        purrr::map(
            extract_added_lines
        ) |>
        purrr::list_rbind(
            names_to = "file_name"
        )

    line_coverage <- head_coverage |>
        covr::tally_coverage(by = "line") |>
        tibble::as_tibble()

    # this prevents errors when there are no added / modified lines, but the
    # diff_content is not empty
    if (rlang::is_empty(added_lines)) {
        return(NULL)
    }

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
