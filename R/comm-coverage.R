comm_head_cov <- function(comm, head_cov) {
    check_comment(comm)
    check_coverage(head_cov)

    comm$head_coverage <- head_cov
    comm
}

comm_get_head_cov <- function(comm) {
    check_comment(comm)

    head_cov <- comm$head_coverage

    perc_head_cov <- dplyr::if_else(
        is.null(head_cov),
        "empty",
        paste0(round(covr::percent_coverage(head_cov), 1), "%")
    )

    perc_head_cov
}

comm_base_cov <- function(comm, base_cov) {
    check_comment(comm)
    check_coverage(base_cov)

    comm$base_coverage <- base_cov
    comm
}

comm_get_base_cov <- function(comm) {
    check_comment(comm)

    base_cov <- comm$base_coverage

    perc_base_cov <- dplyr::if_else(
        is.null(base_cov),
        "empty",
        paste0(round(covr::percent_coverage(base_cov), 1), "%")
    )

    perc_base_cov
}
