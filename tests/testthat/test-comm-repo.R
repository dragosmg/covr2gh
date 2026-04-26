test_that("comm_repo can modify a comment repo", {
    comm <- comment("owner/repo")

    expect_identical(
        comm$repo,
        "owner/repo"
    )

    expect_identical(
        comm_repo(comm, "foo/bar")[["repo"]],
        "foo/bar"
    )
})

test_that("comm_repo complains", {
    comm <- comment("owner/repo")

    expect_error(
        comm_repo(comm, 2),
        "`repo` must be a single string, not the number 2."
    )
})

test_that("comm_get_repo", {
    comm <- comment("owner/repo")

    expect_identical(
        comm_get_repo(comm),
        "owner/repo"
    )
})
