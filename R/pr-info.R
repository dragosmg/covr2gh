pr_info <- function(repo, pr_number) {
    check_character(repo)
    check_number_whole(pr_number)

    pr_info <- gh::gh(
        "GET /repos/{repo}/pulls/{pr_number}", # nolint nonportable_path_linter
        repo = repo,
        pr_number = pr_number
    )

    output <- structure(
        list(
            repo = repo,
            pr_number = pr_number,
            is_fork = pr_info$head$repo$fork,
            head = list(
                label = pr_info$head$label,
                ref = pr_info$head$ref,
                sha = pr_info$head$sha
            ),
            base = list(
                label = pr_info$base$label,
                ref = pr_info$base$ref,
                sha = pr_info$base$sha
            )
        ),
        class = "pr_info"
    )

    output
}

#' @export
print.pr_info <- function(x, ...) {
    cli::cat_line(cli::format_inline("{.cls {class(x)}}"))

    cli::cat_line(cli::format_inline("{.strong Repo:} {.val {x$repo}}"))
    cli::cat_line(cli::format_inline("{.strong PR:} {.val {x$pr_number}}"))

    cli::cat_line(cli::format_inline("{.strong Fork:} {.val {x$is_fork}}"))

    bullets_with_header("Head:", x$head)

    bullets_with_header("Base", x$base)
}

is_pr_info <- function(x) {
    inherits(x, "pr_info")
}

check_pr_info <- function(
    pr_info,
    arg = rlang::caller_arg(pr_info),
    call = rlang::caller_env(),
    allow_null = FALSE
) {
    if (!missing(pr_info)) {
        if (is_pr_info(pr_info)) {
            return(invisible(NULL))
        }

        if (allow_null && is.null(pr_info)) {
            return(invisible(NULL))
        }
    }

    stop_input_type(
        pr_info,
        "a covr2gh pr_info object",
        allow_null = allow_null,
        arg = arg,
        call = call
    )
}
