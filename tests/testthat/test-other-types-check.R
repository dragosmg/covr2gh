test_that("is_coverage works", {
    expect_false(
        is_coverage("foo")
    )

    coverage <- readRDS(
        test_path(
            "fixtures",
            "sample_coverage.RDS"
        )
    )

    expect_s3_class(
        coverage,
        "coverage"
    )
})

test_that("check_coverage", {
    coverage <- readRDS(
        test_path(
            "fixtures",
            "sample_coverage.RDS"
        )
    )

    expect_no_error(
        check_coverage(coverage)
    )

    expect_error(
        check_coverage("foo"),
        '`"foo"` must be a covr coverage object, not the string "foo"',
        fixed = TRUE
    )

    expect_error(
        check_coverage(NULL),
        "`NULL` must be a covr coverage object, not `NULL`",
        fixed = TRUE
    )

    expect_no_error(
        check_coverage(NULL, allow_null = TRUE)
    )
})
