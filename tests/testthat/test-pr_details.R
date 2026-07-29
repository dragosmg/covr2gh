test_that("get_pr_details() works", {
    skip_if_offline()
    expect_snapshot(
        get_pr_details(
            repo = "dragosmg/covr2ghdemo", # nolint
            pr_number = 2
        )
    )
})

test_that("get_pr_details() complains with incorrect inputs", {
    # `repo` is not scalar
    expect_error(
        get_pr_details(
            repo = c("foo", "bar")
        ),
        "`repo` must be a single string, not a character vector",
        fixed = TRUE
    )

    # `repo` is not character
    expect_error(
        get_pr_details(
            repo = 1
        ),
        "`repo` must be a single string, not the number 1",
        fixed = TRUE
    )

    expect_error(
        get_pr_details(
            repo = FALSE
        ),
        "`repo` must be a single string, not `FALSE`",
        fixed = TRUE
    )

    # `pr_number` is not scalar
    expect_error(
        get_pr_details(
            repo = "dragosmg/covr2ghdemo", # nolint
            pr_number = c(2, 3)
        ),
        "`pr_number` must be a whole number, not a double vector",
        fixed = TRUE
    )

    # `pr_number` is not integerish
    expect_error(
        get_pr_details(
            repo = "dragosmg/covr2ghdemo", # nolint
            pr_number = "foo"
        ),
        '`pr_number` must be a whole number, not the string "foo"',
        fixed = TRUE
    )

    expect_error(
        get_pr_details(
            repo = "dragosmg/covr2ghdemo", # nolint
            pr_number = FALSE
        ),
        "`pr_number` must be a whole number, not `FALSE`",
        fixed = TRUE
    )
})

test_that("is_pr_details", {
    expect_false(is_pr_details("foo"))
    expect_true(
        is_pr_details(
            structure(
                "foo",
                class = "covr2gh_pr_details"
            )
        )
    )
})

test_that("check_pr_details", {
    expect_snapshot(error = TRUE, check_pr_details("foo"))
    expect_snapshot(error = TRUE, check_pr_details(1))

    expect_no_error(
        check_pr_details(
            structure(
                "foo",
                class = "covr2gh_pr_details"
            )
        )
    )

    expect_no_error(
        check_pr_details(
            NULL,
            allow_null = TRUE
        )
    )
})
