test_that("comment works", {
    expect_s3_class(
        comment("sample/repo"),
        "covr2gh_comment"
    )
})

test_that("is_comment", {
    expect_true(
        is_comment(
            comment("sample/repo")
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
            comment("sample/repo")
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
    expect_snapshot(
        comment("sample/repo")
    )
})
