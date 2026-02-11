test_that("coverage utils work", {
    expect_false(
        is_coverage("foo")
    )

    cov <- readRDS(
        test_path(
            "fixtures",
            "sample_coverage.RDS"
        )
    )

    # cov <- covr::package_coverage()

    expect_s3_class(
        cov,
        "coverage"
    )

    expect_no_error(
        check_coverage(cov)
    )

    expect_error(
        check_coverage("foo"),
        '`"foo"` must be a covr coverage object, not the string "foo"',
        fixed = TRUE
    )

    expect_error(
        check_coverage(NULL),
        '`NULL` must be a covr coverage object, not `NULL`',
        fixed = TRUE
    )

    expect_no_error(
        check_coverage(NULL, allow_null = TRUE)
    )
})
