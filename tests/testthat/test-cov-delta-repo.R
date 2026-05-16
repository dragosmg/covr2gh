test_that("can get and set repo", {
    # nolint start: nonportable_path_linter
    cov_delta1 <- cov_delta("owner/repo")
    cov_delta2 <- cov_delta_repo(cov_delta1, "foo/bar")
    expect_equal(cov_delta_get_repo(cov_delta2), "foo/bar")
})

test_that("errors are handled correctly", {
    cov_delta <- cov_delta("owner/repo")
    # nolint end

    expect_snapshot(error = TRUE, {
        cov_delta |> cov_delta_get_repo(TRUE)
        cov_delta |> cov_delta_get_repo(2)
    })
})
