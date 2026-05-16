short_hash <- function(hash, n = 7) {
    stringr::str_sub(hash, 1, n)
}

find_intervals <- function(x) {
    run_diff <- c(1, diff(x))
    diff_list <- split(x, cumsum(run_diff != 1))

    purrr::map_chr(diff_list, collapse_interval) |>
        stringr::str_flatten_comma()
}

collapse_interval <- function(x) {
    if (length(x) == 1) {
        as.character(x)
    } else if (length(x) == 2) {
        stringr::str_flatten_comma(x)
    } else {
        paste0(x[1], "-", x[length(x)])
    }
}

bullets_with_header <- function(header, x) {
    if (length(x) == 0) {
        return()
    }

    cli::cat_line(cli::format_inline("{.strong {header}}"))
    bullets(x)
}

bullets <- function(x) {
    as_simple <- function(x) {
        if (is.atomic(x) && length(x) == 1) {
            if (is.character(x)) {
                paste0('"', x, '"')
            } else {
                format(x)
            }
        } else {
            # if (is_commit_hash(x)) {
            #     format(x)
            # } else {
            paste0("<", class(x)[[1L]], ">")
            # }
        }
    }

    # nolint start: object_usage_linter
    values <- purrr::map_chr(x, as_simple)
    bullet_names <- format(names(x))
    bullet_names <- gsub(" ", "\u00a0", bullet_names, fixed = TRUE)

    for (i in seq_along(x)) {
        cli::cat_line(cli::format_inline(
            "* {.field {bullet_names[[i]]}}: {values[[i]]}"
        ))
    }
    # nolint end
}
