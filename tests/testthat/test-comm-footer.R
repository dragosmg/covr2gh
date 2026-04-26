test_that("comm_footer", {
    # nolint start: nonportable_path_linter
    empty_comment <- comment("owner/repo")

    comment <- empty_comment |>
        comm_footer(
            covr2gh_ver = "0.12.3",
            date = as.Date("2026-02-05")
        )

    expect_identical(
        comment$footer,
        "<sup>Created on 2026-02-05 with [covr2gh v0.12.3](https://dragosmg.github.io/covr2gh).</sup>"
    )

    expect_snapshot(
        comm_footer(empty_comment),
        transform = remove_date_sha_pkg_ver
    )
})

test_that("comm_footer complains with incorrect inputs", {
    empty_comment <- comment("owner/repo")

    expect_error(
        comment("owner/repo") |>
            comm_footer(covr2gh_ver = 2),
        "`covr2gh_ver` must be a single string, not the number 2."
    )

    expect_error(
        comment("owner/repo") |>
            comm_footer(covr2gh_url = 2),
        "`covr2gh_url` must be a single string, not the number 2."
    )

    expect_error(
        comment("owner/repo") |>
            comm_footer(date = 2),
        "`date` must be a single Date, not the number 2."
    )
    # nolint end
})
