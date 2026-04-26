comm_head_cov <- function(comm, head_cov) {
    check_comment(comm)
    check_coverage(head_cov)

    comm$head_coverage <- head_cov
    comm
}

comm_get_head_cov <- function(comm) {
    check_comment(comm)

    cov <- comm$head_coverage

    perc_cov <- dplyr::if_else(
        is.null(cov),
        "empty",
        paste0(round(covr::percent_coverage(cov), 1), "%")
    )

    perc_cov
}

comm_base_cov <- function(comm, base_cov) {
    check_comment(comm)
    check_coverage(base_cov)

    comm$base_coverage <- base_cov
    comm
}

comm_get_base_cov <- function(comm) {
    check_comment(comm)

    cov <- comm$base_coverage

    perc_cov <- dplyr::if_else(
        is.null(cov),
        "empty",
        paste0(round(covr::percent_coverage(cov), 1), "%")
    )

    perc_cov
}
