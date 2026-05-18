test_that("is_coverage", {
    head_coverage <- readRDS(
        test_path(
            "fixtures",
            "head_coverage.RDS"
        )
    )

    expect_true(is_coverage(head_coverage))
    expect_false(is_coverage("foo"))
})

test_that("check_coverage", {
    head_coverage <- readRDS(
        test_path(
            "fixtures",
            "head_coverage.RDS"
        )
    )

    expect_no_error(check_coverage(head_coverage))
    expect_no_error(
        check_coverage(NULL, allow_null = TRUE)
    )
    expect_error(
        check_coverage("foo"),
        '`"foo"` must be a coverage object, not the string "foo".'
    )
})
