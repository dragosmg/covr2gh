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
        ),
        '`"foo"` must be an covr2gh `cov_delta` object, not the string "foo".'
    )
})


test_that("covr2gh_cov_delta print method", {
    # empty comment
    expect_snapshot(
        cov_delta("owner/repo") # nolint nonportable_path_linter
    )

    head_coverage <- readRDS(
        test_path(
            "fixtures",
            "head_coverage.RDS"
        )
    )
    base_coverage <- readRDS(
        test_path(
            "fixtures",
            "base_coverage.RDS"
        )
    )

    expect_snapshot(
        cov_delta("owner/repo") # nolint nonportable_path_linter
    )

    expect_snapshot(
        cov_delta("owner/repo") |> # nolint nonportable_path_linter
            cov_delta_pr(81) |>
            cov_delta_base(base_coverage) |>
            cov_delta_head(head_coverage)
    )
})
