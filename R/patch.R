patch <- function(pr_info) {
    check_pr_info(pr_info)

    # nolint start: nonportable_path_linter
    reply <- gh::gh(
        "GET /repos/{repo}/compare/{base_ref}...{head_ref}",
        repo = pr_info$repo,
        base_ref = pr_info$base$ref,
        head_ref = pr_info$head$ref
    )
    # nolint end

    # get the patch element and use filename as name
    pluck_filename_patch <- function(x) {
        output <- list(
            file = x$filename,
            patch = stringr::str_split_1(x$patch, stringr::fixed("\n"))
        )

        structure(
            output,
            class = "patch"
        )
    }

    output <- reply$files |>
        purrr::keep(\(x) stringr::str_starts(x$filename, "R/|src/")) |>
        purrr::map(pluck_filename_patch) |>
        purrr::list_flatten()

    output
}

#' @export
print.patch <- function(x, ...) {
    cli::cat_line(cli::format_inline("{.cls {class(x)}}"))

    cli::cat_line(cli::format_inline("{.strong File:} {.file {x$file}}"))

    cli::cat_line(cli::format_inline("{.strong Patch:}"))

    cli::cat_bullet(x$patch, bullet = "")
}

is_patch <- function(x) {
    inherits(x, "patch")
}

patches <- function(x) {
    if (!is_list(x) || !purrr::every(x, is_patch)) {
        abort("Expected a list of patches")
    }

    structure(x, class = c("patches", "list"), names = names2(x))
}

check_patch <- function(
    patch,
    arg = rlang::caller_arg(patch),
    call = rlang::caller_env(),
    allow_null = FALSE
) {
    if (!missing(patch)) {
        if (is_patch(patch)) {
            return(invisible(NULL))
        }

        if (allow_null && is.null(patch)) {
            return(invisible(NULL))
        }
    }

    stop_input_type(
        patch,
        "a covr2gh patch object",
        allow_null = allow_null,
        arg = arg,
        call = call
    )
}
