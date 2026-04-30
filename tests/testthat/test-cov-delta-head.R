test_that("cov_delta_head can modify the head coverage", {
    # nolint start: nonportable_path_linter
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

    expect_null(cov_delta$head_coverage)

    cov_delta <- cov_delta_head(cov_delta, coverage1)
    expect_identical(
        cov_delta$head_coverage,
        coverage1
    )

    cov_delta <- cov_delta_head(cov_delta, coverage2)
    expect_identical(
        cov_delta$head_coverage,
        coverage2
    )
})

test_that("cov_delta_get_head", {
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

    expect_identical(
        cov_delta_get_head(cov_delta),
        "empty"
    )

    cov_delta <- cov_delta_head(cov_delta, coverage1)
    expect_identical(
        cov_delta_get_head(cov_delta),
        "28.6%"
    )

    cov_delta <- cov_delta_head(cov_delta, coverage2)
    expect_identical(
        cov_delta_get_head(cov_delta),
        "31.6%"
    )
})
