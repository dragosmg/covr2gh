test_that("short_hash works", {
    expect_identical(
        "a" |>
            cli::hash_sha256() |>
            short_hash() |>
            nchar(),
        7L
    )

    expect_identical(
        "a" |>
            cli::hash_sha256() |>
            short_hash(),
        "ca97811"
    )

    expect_identical(
        "a" |>
            cli::hash_sha256() |>
            short_hash(n = 8) |>
            nchar(),
        8L
    )

    expect_identical(
        "a" |>
            cli::hash_sha256() |>
            short_hash(n = 8),
        "ca978112"
    )
})
