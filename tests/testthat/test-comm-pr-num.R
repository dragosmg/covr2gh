test_that("comm_pr_num", {
    # nolint start: nonportable_path_linter
    comm <- comment("owner/repo")

    expect_null(comm$pr_num)

    expect_identical(comm_pr_num(comm, 89)[["pr_num"]], 89)
})

test_that("comm_pr_num complains", {
    comm <- comment("owner/repo")

    expect_error(
        comm_pr_num(comm, "foo"),
        '`pr` must be a whole number, not the string "foo".'
    )
})

test_that("comm_get_pr_num", {
    comm <- comment("owner/repo")
    # nolint end

    expect_identical(
        comm_get_pr_num(comm),
        "empty"
    )

    comm_updated <- comm_pr_num(comm, 89)

    expect_identical(
        comm_get_pr_num(comm_updated),
        89
    )
})
