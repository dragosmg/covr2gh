test_that("comm_marker can modify a comment marker", {
    comm <- comment("owner/repo")

    expect_null(comm$marker)

    expect_identical(
        comm_marker(comm)[["marker"]],
        "<!-- covr2gh-marker -->"
    )

    expect_identical(
        comm_marker(comm, "<!-- foo -->")[["marker"]],
        "<!-- foo -->"
    )
})

test_that("comm_marker complains", {
    comm <- comment("owner/repo")

    expect_error(
        comm_marker(comm, 2),
        "`marker` must be a single string, not the number 2."
    )
})

test_that("comm_get_marker", {
    comm <- comment("owner/repo")

    expect_identical(
        comm_get_marker(comm),
        "empty"
    )

    comm_updated <- comm_marker(comm)
    expect_identical(
        comm_get_marker(comm_updated),
        "<!-- covr2gh-marker -->"
    )

    comm_updated2 <- comm_marker(comm, "foo")
    expect_identical(
        comm_get_marker(comm_updated2),
        "foo"
    )
})
