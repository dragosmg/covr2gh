cov_delta_pr <- function(cov_delta, pr) {
    check_cov_delta(cov_delta)
    rlang::check_number_whole(pr)

    cov_delta$pr <- pr
    cov_delta
}

cov_delta_get_pr <- function(cov_delta) {
    check_cov_delta(cov_delta)
    cov_delta$pr %||% "empty"
}
