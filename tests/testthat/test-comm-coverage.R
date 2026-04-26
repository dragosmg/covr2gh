test_that("comm_head_cov can modify the head coverage", {
    comm <- comment("owner/repo")

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

    expect_null(comm$head_coverage)

    comm <- comm_head_cov(comm, coverage1)
    expect_identical(
        comm$head_coverage,
        coverage1
    )

    comm <- comm_head_cov(comm, coverage2)
    expect_identical(
        comm$head_coverage,
        coverage2
    )
})


test_that("comm_get_head_cov", {
    comm <- comment("owner/repo")

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
        comm_get_head_cov(comm),
        "empty"
    )

    comm <- comm_head_cov(comm, coverage1)
    expect_identical(
        comm_get_head_cov(comm),
        "28.6%"
    )

    comm <- comm_head_cov(comm, coverage2)
    expect_identical(
        comm_get_head_cov(comm),
        "31.6%"
    )
})

test_that("comm_base_cov can modify the base coverage", {
    comm <- comment("owner/repo")

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

    expect_null(comm$base_coverage)

    comm <- comm_base_cov(comm, coverage1)
    expect_identical(
        comm$base_coverage,
        coverage1
    )

    comm <- comm_base_cov(comm, coverage2)
    expect_identical(
        comm$base_coverage,
        coverage2
    )
})

test_that("comm_get_base_cov", {
    comm <- comment("owner/repo")

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
        comm_get_base_cov(comm),
        "empty"
    )

    comm <- comm_base_cov(comm, coverage1)
    expect_identical(
        comm_get_base_cov(comm),
        "28.6%"
    )

    comm <- comm_base_cov(comm, coverage2)
    expect_identical(
        comm_get_base_cov(comm),
        "31.6%"
    )
})
