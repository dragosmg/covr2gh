test_that("post_comment, get_comment_id & comm_delete work", {
    skip_if_offline()
    skip_on_ci()
    expect_no_error(
        a <- post_comment(
            body = glue::glue(
                "{test_marker} <br> {Sys.Date()}: today's test \\
                :sweat_smile:"
            ),
            repo = "dragosmg/covr2ghdemo", # nolint
            pr_number = 3
        )
    )

    expect_s3_class(a, "gh_response")

    expect_no_error(
        get_comment_id(
            repo = "dragosmg/covr2ghdemo", # nolint
            pr_number = 3
        )
    )

    expect_no_error(
        d <- comm_delete(
            repo = "dragosmg/covr2ghdemo", # nolint
            comment_id = a$id
        )
    )

    expect_s3_class(d, "gh_response")

    skip("temp skip")
    expect_identical(
        get_comment_id(
            repo = "dragosmg/covr2ghdemo", # nolint
            pr_number = 2
        ),
        3826887442
    )
})
