test_that("pr_info", {
    # TODO mock
    expect_snapshot(
        pr_info(
            repo = "dragosmg/covr2ghdemo", # nolint
            pr_number = 2
        )
    )
})

test_that("is_pr_info", {
    test_pr_info <- pr_info(
        repo = "dragosmg/covr2ghdemo", # nolint
        pr_number = 2
    )

    expect_true(is_pr_info(test_pr_info))
    expect_false(is_pr_info("foo"))
})

test_that("check_pr_info", {
    test_pr_info <- pr_info(
        repo = "dragosmg/covr2ghdemo", # nolint
        pr_number = 2
    )

    expect_no_error(check_pr_info(test_pr_info))
    expect_no_error(check_pr_info(NULL, allow_null = TRUE))
    expect_error(
        check_pr_info("foo"),
        '`"foo"` must be a covr2gh pr_info object, not the string "foo"'
    )
})
