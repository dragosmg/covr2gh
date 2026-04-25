test_that("comm_repo can modify a comment repo", {
    comm <- comment("sample/repo")

    comm_mod <- comm |>
        comm_repo(
            "foo/bar"
        )

    expect_identical(
        comm_mod$repo,
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
