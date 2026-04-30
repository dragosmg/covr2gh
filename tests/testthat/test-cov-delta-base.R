test_that("cov_delta_base_cov can modify the base coverage", {
    cov_delta <- cov_delta("owner/repo")

    coverage1 <- readRDS(
        test_path(
            "fixtures",
            "head_coverage.RDS"
        )
    )

    coverage2 <- readRDS(
        test_path(
            "fixtures",
            "base_coverage.RDS"
        )
    )

    expect_null(cov_delta$base_coverage)

    cov_delta <- cov_delta_base_cov(cov_delta, coverage1)
    expect_identical(
        cov_delta$base_coverage,
        coverage1
    )

    cov_delta <- cov_delta_base_cov(cov_delta, coverage2)
    expect_identical(
        cov_delta$base_coverage,
        coverage2
    )
})

test_that("cov_delta_get_base_cov", {
    cov_delta <- cov_delta("owner/repo")
    # nolint end

    coverage1 <- readRDS(
        test_path(
            "fixtures",
            "head_coverage.RDS"
        )
    )

    coverage2 <- readRDS(
        test_path(
            "fixtures",
            "base_coverage.RDS"
        )
    )

    expect_identical(
        cov_delta_get_base_cov(cov_delta),
        "empty"
    )

    cov_delta <- cov_delta_base_cov(cov_delta, coverage1)
    expect_identical(
        cov_delta_get_base_cov(cov_delta),
        "28.6%"
    )

    cov_delta <- cov_delta_base_cov(cov_delta, coverage2)
    expect_identical(
        cov_delta_get_base_cov(cov_delta),
        "31.6%"
    )
})
