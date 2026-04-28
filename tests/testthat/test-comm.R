skip("refactoring")
test_that("comment works", {
    expect_s3_class(
        comment("owner/repo"), # nolint nonportable_path_linter
        "covr2gh_comment"
    )
})

test_that("is_comment", {
    expect_true(
        is_comment(
            comment("owner/repo") # nolint nonportable_path_linter
        )
    )

    expect_false(
        is_comment(
            "foo"
        )
    )
})

test_that("check_comment", {
    expect_no_error(
        check_comment(
            comment("owner/repo") # nolint nonportable_path_linter
        )
    )

    expect_no_error(
        check_comment(
            NULL,
            allow_null = TRUE
        )
    )

    expect_error(
        check_comment(
            "foo"
        )
    )
})

test_that("covr2gh_comment print method", {
    # empty comment
    expect_snapshot(
        comment("owner/repo") # nolint nonportable_path_linter
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
        comment("owner/repo") |> # nolint nonportable_path_linter
            comm_pr_num(81) |>
            comm_base_cov(base_coverage) |>
            comm_head_cov(head_coverage) |>
            comm_marker("test") |>
            comm_footer()
    )
})
