pr_info <- function(repo, pr_number) {
    # TODO repo check?
    check_character(repo)
    check_number_whole(pr_number)

    pr_response <- gh::gh(
        "GET /repos/{repo}/pulls/{pr_number}", # nolint nonportable_path_linter
        repo = repo,
        pr_number = pr_number
    )
    # TODO handle API request errors
    # TODO mock for testing

    # TODO decide how to print the commit hash
    head_hash <- pr_response$head$sha
    base_hash <- pr_response$base$sha

    output <- structure(
        list(
            repo = repo,
            pr_number = pr_number,
            is_fork = pr_response$head$repo$fork,
            head = list(
                label = pr_response$head$label,
                ref = pr_response$head$ref,
                hash = head_hash
            ),
            base = list(
                label = pr_response$base$label,
                ref = pr_response$base$ref,
                hash = base_hash
            ),
            pr_html_url = pr_response$html_url
        ),
        class = "covr2gh_pr_info"
    )

    output
}

#' @export
print.covr2gh_pr_info <- function(x, ...) {
    cli::cat_line(cli::format_inline("{.cls {class(x)}}"))

    cli::cat_line(cli::format_inline("{.strong Repo:} {.val {x$repo}}"))
    cli::cat_line(cli::format_inline("{.strong PR:} {.val {x$pr_number}}"))

    cli::cat_line(cli::format_inline("{.strong Fork:} {.val {x$is_fork}}"))

    bullets_with_header("Head:", x$head)

    bullets_with_header("Base", x$base)

    cli::cat_line(cli::format_inline(
        "{.strong PR URL:} {.url {x$pr_html_url}}"
    ))
}

is_pr_info <- function(x) {
    inherits(x, "covr2gh_pr_info")
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
