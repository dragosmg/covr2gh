check_date <- function(
    x,
    ...,
    allow_null = FALSE,
    arg = rlang::caller_arg(x),
    call = rlang::caller_env()
) {
    if (!missing(x) && inherits(x, "Date") && length(x) == 1) {
        return(invisible())
    }

    stop_input_type(
        x,
        "a single Date",
        ...,
        allow_null = allow_null,
        arg = arg,
        call = call
    )
}

check_repository <- function(
    x,
    ...,
    allow_null = FALSE,
    arg = rlang::caller_arg(x),
    call = rlang::caller_env()
) {
    check_character(x)

    # TODO this is not finished. finish it
    if (!missing(x) && length(x) == 1) {
        return(invisible())
    }
}

is_coverage <- function(x) {
    inherits(x, "coverage")
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
