cov_delta_digest <- function(cov_delta) {
    check_cov_delta(cov_delta)
    browser()
    repo <- cov_delta_get_repo(cov_delta)
    pr <- cov_delta_get_pr(cov_delta)

    pr_info <- pr_info(repo, pr)

    diff <- diff(pr_info)

    diff
}
