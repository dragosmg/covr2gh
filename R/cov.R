is_coverage <- function(x) {
    inherits(x, 'coverage')
}

check_coverage <- function(
    cov,
    arg = rlang::caller_arg(cov),
    call = rlang::caller_env(),
    allow_null = FALSE
) {
    if (!missing(cov)) {
        if (is_coverage(cov)) {
            return(invisible(NULL))
        }

        if (allow_null && is.null(cov)) {
            return(invisible(NULL))
        }
    }

    stop_input_type(
        cov,
        "a covr coverage object",
        allow_null = allow_null,
        arg = arg,
        call = call
    )
}
