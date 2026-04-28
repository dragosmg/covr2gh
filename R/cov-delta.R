cov_delta <- function(repo) {
    new_cov_delta(repo)
}

new_cov_delta <- function(
    repo,
    pr = NULL,
    head_cov = NULL,
    base_cov = NULL,
    call = rlang::caller_env()
) {
    # TODO add a check_repo() function
    check_string(repo, call = call)

    structure(
        list(
            repo = repo,
            pr = pr,
            head_cov = head_cov,
            base_cov = base_cov
        ),
        class = "covr2gh_cov_delta"
    )
}

is_cov_delta <- function(x) {
    inherits(x, "covr2gh_cov_delta")
}

check_cov_delta <- function(
    cov_delta,
    arg = rlang::caller_arg(cov_delta),
    call = rlang::caller_env(),
    allow_null = FALSE
) {
    if (!missing(cov_delta)) {
        if (is_cov_delta(cov_delta)) {
            return(invisible(NULL))
        }

        if (allow_null && is.null(cov_delta)) {
            return(invisible(NULL))
        }
    }

    stop_input_type(
        cov_delta,
        "an covr2gh `cov_delta` object",
        allow_null = allow_null,
        arg = arg,
        call = call
    )
}

#' @export
print.covr2gh_cov_delta <- function(x, ...) {
    cli::cat_line(cli::format_inline("{.cls {class(x)}}"))

    cli::cat_line(cli::format_inline("{.strong Repo:} {cov_delta_get_repo(x)}"))
    cli::cat_line(cli::format_inline("{.strong PR:} {cov_delta_get_pr(x)}"))

    cli::cat_line(
        cli::format_inline(
            "{.strong Head coverage:} {cov_delta_get_head_cov(x)}"
        )
    )
    cli::cat_line(
        cli::format_inline(
            "{.strong Base coverage:} {cov_delta_get_base_cov(x)}"
        )
    )
}
