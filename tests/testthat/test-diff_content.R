test_that("get_diff_content works", {
    # nolint start: nonportable_path_linter
    pr_details <- get_pr_details(
        "dragosmg/covr2ghdemo",
        3
    )
    # nolint end

    expect_snapshot(
        get_diff_content(
            pr_details = pr_details
        )
    )
})

test_that("is_diff_content", {
    expect_false(is_diff_content("foo"))
    expect_true(
        is_diff_content(
            structure(
                "foo",
                class = "covr2gh_diff_content"
            )
        )
    )
})

test_that("check_diff_content", {
    expect_snapshot(error = TRUE, check_diff_content("foo"))
    expect_snapshot(error = TRUE, check_diff_content(1))

    expect_no_error(
        check_diff_content(
            structure(
                "foo",
                class = "covr2gh_diff_content"
            )
        )
    )

    expect_no_error(
        check_diff_content(
            NULL,
            allow_null = TRUE
        )
    )
})
