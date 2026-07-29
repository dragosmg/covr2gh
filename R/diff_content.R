#' Get the PR diff
#'
#' Sends a GET request to the GitHub API and retrieves the full PR diff, which
#' is a (comparison) between base (the starting point for the comparison) and
#' head (the endpoint). The diff is then filtered to only include the "relevant
#' files".
#'
#' @param pr_details a `pr_details` object.
#'
#' @returns a named list where the names are file names and the content of each
#' element is the patch for the specific file.
#'
#' @noRd
#' @examples
#' \dontrun{
#' pr_details <- get_pr_details("<owner>/<repo>", 2)
#'
#' diff_content <- get_diff_content(pr_details)
#' }
get_diff_content <- function(pr_details) {
    check_pr_details(pr_details)

    # the endpoint can be used to compare branches. once the PR is merged and
    # the head is deleted it returns a 404. comparing commits can be used, but
    # the separation between commit hashes is 2-dots (`..`), not 3

    req_url <- glue::glue_data(
        list(
            repo = pr_details$repo,
            base = pr_details$base_name,
            head = pr_details$head_name
        ),
        "https://api.github.com/repos/{repo}/compare/{base}...{head}"
    )

    # TODO tryCatch
    reply <- glue::glue("GET {req_url}") |>
        gh::gh()

    # get the patch element and use filename as name
    pull_patch <- function(x) {
        output <- list(x$patch)
        names(output) <- x$filename
        output
    }

    output <- reply$files |>
        purrr::keep(\(x) stringr::str_starts(x$filename, "R/|src/")) |>
        purrr::discard(\(x) stringr::str_ends(x$filename, ".rda")) |>
        purrr::map(pull_patch) |>
        purrr::list_flatten()

    structure(
        output,
        class = "covr2gh_diff_content"
    )
}

is_diff_content <- function(x) {
    inherits(x, "covr2gh_diff_content")
}

check_diff_content <- function(
    x,
    ...,
    allow_null = FALSE,
    arg = rlang::caller_arg(x),
    call = rlang::caller_env()
) {
    if (!missing(x)) {
        if (is_diff_content(x)) {
            return(invisible(NULL))
        }
        if (allow_null && rlang::is_null(x)) {
            return(invisible(NULL))
        }
    }

    rlang::stop_input_type(
        x,
        "a covr2gh diff content object",
        ...,
        allow_null = allow_null,
        arg = arg,
        call = call
    )
}
