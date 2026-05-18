is_coverage <- function(x) {
    inherits(x, "coverage")
}

check_coverage <- function(
    coverage,
    ...,
    allow_null = FALSE,
    arg = rlang::caller_arg(coverage),
    call = rlang::caller_env()
) {
    if (!missing(coverage)) {
        if (is_coverage(coverage)) {
            return(invisible(NULL))
        }
        if (allow_null && rlang::is_null(coverage)) {
            return(invisible(NULL))
        }
    }

    rlang::stop_input_type(
        coverage,
        "a coverage object",
        ...,
        allow_na = FALSE,
        allow_null = allow_null,
        arg = arg,
        call = call
    )
}
