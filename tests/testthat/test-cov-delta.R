test_that("cov_delta", {
    expect_s3_class(
        cov_delta("owner/repo"), # nolint nonportable_path_linter
        "covr2gh_cov_delta"
    )
})

test_that("is_cov_delta", {
    expect_true(
        is_cov_delta(
            cov_delta("owner/repo") # nolint nonportable_path_linter
        )
    )

    expect_false(
        is_cov_delta(
            "foo"
        )
    )
})


test_that("check_cov_delta", {
    expect_no_error(
        check_cov_delta(
            cov_delta("owner/repo") # nolint nonportable_path_linter
        )
    )

    expect_no_error(
        check_cov_delta(
            NULL,
            allow_null = TRUE
        )
    )

    expect_error(
        check_cov_delta(
            "foo"
        )
    )
})
