cov_delta_repo <- function(cov_delta, repo) {
    check_cov_delta(cov_delta)
    # TODO add a check_repo
    check_string(repo)

    cov_delta$repo <- repo
    cov_delta
}

cov_delta_get_repo <- function(cov_delta) {
    check_cov_delta(cov_delta)
    cov_delta$repo
}
