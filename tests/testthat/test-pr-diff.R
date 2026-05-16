test_pr_info <- pr_info(
    repo = "dragosmg/covr2ghdemo", # nolint
    pr_number = 3
)

diffs <- diff(test_pr_info)

test_that("diff", {
    expect_s3_class(
        diffs,
        c("covr2gh_diffs", "list")
    )

    expect_s3_class(
        diffs[[1]],
        "covr2gh_diff"
    )
})

test_that("is_diff & is_diffs", {
    expect_true(is_diffs(diffs))
    expect_true(is_diff(diffs[[1]]))

    expect_false(is_diffs("foo"))
    expect_false(is_diff("foo"))
})

test_that("check_diff & check_diffs", {
    expect_no_error(check_diffs(diffs))
    expect_no_error(check_diff(diffs[[1]]))

    expect_no_error(
        check_diffs(NULL),
        "`NULL` must be a covr2gh diff object, not `NULL`."
    )
    expect_no_error(
        check_diff(NULL)
    )

    expect_error(
        check_diffs("foo"),
        '`"foo"` must be a covr2gh diff object, not the string "foo".'
    )
    expect_error(
        check_diff("foo"),
        '`"foo"` must be a covr2gh diff object, not the string "foo".'
    )
})
