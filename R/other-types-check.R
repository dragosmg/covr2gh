check_date <- function(
    x,
    ...,
    allow_null = FALSE,
    arg = rlang::caller_arg(x),
    call = rlang::caller_env()
) {
    if (!missing(x) && lubridate::is.Date(x) && length(x) == 1) {
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

    if (!missing(x) && length(x) == 1) {
        return(invisible())
    }
}
