comment <- function(repo) {
    new_comment(repo)
}

new_comment <- function(
    repo,
    pr_num = NULL,
    head_coverage = NULL,
    base_coverage = NULL,
    marker = NULL,
    badge = NULL,
    summary = NULL,
    details = NULL,
    body = NULL,
    footer = NULL,
    error_call = rlang::caller_env()
) {
    # TODO add check_repo
    # check_string(repo, call = error_call)

    structure(
        list(
            repo = repo,
            pr_num = pr_num,
            head_coverage = head_coverage,
            base_coverage = base_coverage,
            marker = NULL,
            badge = NULL,
            summary = NULL,
            details = NULL,
            body = NULL,
            footer = NULL
        ),
        class = "covr2gh_comment"
    )
}

is_comment <- function(x) {
    inherits(x, "covr2gh_comment")
}

check_comment <- function(
    comm,
    arg = rlang::caller_arg(comm),
    call = rlang::caller_env(),
    allow_null = FALSE
) {
    if (!missing(comm)) {
        if (is_comment(comm)) {
            return(invisible(NULL))
        }

        if (allow_null && is.null(comm)) {
            return(invisible(NULL))
        }
    }

    stop_input_type(
        comm,
        "an covr2gh comment object",
        allow_null = allow_null,
        arg = arg,
        call = call
    )
}

#' @export
print.covr2gh_comment <- function(x, ...) {
    cli::cat_line(cli::format_inline("{.cls {class(x)}}"))

    cli::cat_line(cli::format_inline("{.strong Repo:} {comm_get_repo(x)}"))
    cli::cat_line(cli::format_inline("{.strong PR:} {comm_get_pr_num(x)}"))

    cli::cat_line(
        cli::format_inline(
            "{.strong Head coverage:} {comm_get_head_cov(x)}"
        )
    )
    cli::cat_line(
        cli::format_inline(
            "{.strong Base coverage:} {comm_get_base_cov(x)}"
        )
    )

    cli::cat_line(cli::format_inline("{.strong Marker:} {comm_get_marker(x)}"))

    cli::cat_line(
        cli::format_inline(
            "{.strong Footer:} {comm_get_footer(x)}"
        )
    )
}
