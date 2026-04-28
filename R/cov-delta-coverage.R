cov_delta_head_cov <- function(cov_delta, head_cov) {
    check_cov_delta(cov_delta)
    check_coverage(head_cov)

    cov_delta$head_coverage <- head_cov
    cov_delta
}

cov_delta_get_head_cov <- function(cov_delta) {
    check_cov_delta(cov_delta)

    head_cov <- cov_delta$head_coverage

    perc_head_cov <- dplyr::if_else(
        is.null(head_cov),
        "empty",
        paste0(round(covr::percent_coverage(head_cov), 1), "%")
    )

    perc_head_cov
}

cov_delta_base_cov <- function(cov_delta, base_cov) {
    check_cov_delta(cov_delta)
    check_coverage(base_cov)

    cov_delta$base_coverage <- base_cov
    cov_delta
}

cov_delta_get_base_cov <- function(cov_delta) {
    check_cov_delta(cov_delta)

    base_cov <- cov_delta$base_coverage

    perc_base_cov <- dplyr::if_else(
        is.null(base_cov),
        "empty",
        paste0(round(covr::percent_coverage(base_cov), 1), "%")
    )

    perc_base_cov
}
