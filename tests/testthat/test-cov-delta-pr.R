test_that("can get and set pr", {
    # nolint start: nonportable_path_linter
    cov_delta1 <- cov_delta("owner/repo")
    cov_delta2 <- cov_delta_pr(cov_delta1, 90)
    expect_equal(cov_delta_get_pr(cov_delta2), 90)
})

test_that("errors are handled correctly", {
    cov_delta <- cov_delta("owner/repo")
    # nolint end

    expect_snapshot(error = TRUE, {
        cov_delta |> cov_delta_pr(TRUE)
        cov_delta |> cov_delta_pr("foo")
    })
})
