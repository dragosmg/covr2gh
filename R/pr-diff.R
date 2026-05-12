diff <- function(pr_info) {
    check_pr_info(pr_info)

    # nolint start: nonportable_path_linter
    # TODO handle error
    response <- gh::gh(
        "GET /repos/{repo}/compare/{base_ref}...{head_ref}",
        repo = pr_info$repo,
        base_ref = pr_info$base$ref,
        head_ref = pr_info$head$ref
    )
    # nolint end
    browser()
    # get the patch element and use filename as name
    pluck_filename_patch <- function(x) {
        output <- list(
            file = x$filename,
            patch = stringr::str_split_1(x$patch, stringr::fixed("\n"))
        )

        structure(
            output,
            class = "covr2gh_diff"
        )
    }

    output <- response$files |>
        purrr::keep(\(x) stringr::str_starts(x$filename, "R/|src/")) |>
        purrr::map(pluck_filename_patch) |>
        purrr::list_flatten()

    output
}

#' @export
print.covr2gh_diff <- function(x, ...) {
    cli::cat_line(cli::format_inline("{.cls {class(x)}}"))

    cli::cat_line(cli::format_inline("{.strong File:} {.file {x$file}}"))

    cli::cat_line(cli::format_inline("{.strong Diff:}"))

    cli::cat_bullet(x$patch, bullet = "")
}

is_diff <- function(x) {
    inherits(x, "covr2gh_diff")
}

check_diff <- function(
    diff,
    arg = rlang::caller_arg(diff),
    call = rlang::caller_env(),
    allow_null = FALSE
) {
    if (!missing(diff)) {
        if (is_diff(diff)) {
            return(invisible(NULL))
        }

        if (allow_null && is.null(diff)) {
            return(invisible(NULL))
        }
    }

    stop_input_type(
        diff,
        "a covr2gh diff object",
        allow_null = allow_null,
        arg = arg,
        call = call
    )
}

diff_get_file <- function(diff) {
    check_diff(diff)
    diff$file
}

new_diffs <- function(x) {
    if (!is_list(x) || !purrr::every(x, is_diff)) {
        rlang::abort("Expected a list of covr2gh diffs")
    }

    structure(
        x,
        class = c("covr2gh_diffs", "list"),
        names = names2(x)
    )
}

print.covr2gh_diffs <- function(x, ...) {
    cli::cat_line("<list_of<covr2gh diffs>>\n")
    print(unclass(x), ...)
}

is_diffs <- function(x) {
    inherits(x, "covr2gh_diffs")
}

check_diffs <- function(
    diffs,
    arg = rlang::caller_arg(diffs),
    call = rlang::caller_env(),
    allow_null = FALSE
) {
    if (!missing(diffs)) {
        if (is_diffs(diffs)) {
            return(invisible(NULL))
        }

        if (allow_null && is.null(diffs)) {
            return(invisible(NULL))
        }
    }

    stop_input_type(
        diffs,
        "a covr2gh diff object",
        allow_null = allow_null,
        arg = arg,
        call = call
    )
}

diffs_get_files <- function(diffs) {
    check_diffs()
}
