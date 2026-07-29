test_that("diff_line_coverage", {
    head_coverage <- readRDS(
        test_path(
            "fixtures",
            "head_coverage.RDS"
        )
    )

    pr_details <- get_pr_details(
        repo = "dragosmg/covr2ghdemo", # nolint
        pr_number = 3
    )

    expect_snapshot(
        diff_line_coverage(
            pr_details,
            head_coverage
        )
    )
})
