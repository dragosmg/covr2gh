test_that("comm_repo can modify a comment repo", {
    comm <- comment("sample/repo")

    expect_identical(
        comm$repo,
        "sample/repo"
    )

    expect_identical(
        comm_repo(comm, "foo/bar")[["repo"]],
        "foo/bar"
    )
})

test_that("comm_repo complains", {
    comm <- comment("sample/repo")

    expect_error(
        comm_repo(comm, 2),
        "`repo` must be a single string, not the number 2."
    )
})

test_that("comm_get_repo", {
    comm <- comment("sample/repo")

    expect_identical(
        comm_get_repo(comm),
        "sample/repo"
    )
})
