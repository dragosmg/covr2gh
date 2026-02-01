test_that("value_to_char() works", {
    expect_identical(
        value_to_char(34.34),
        list(
            num = 34.34,
            char = "34%"
        )
    )

    expect_identical(
        value_to_char(78.4334),
        list(
            num = 78.4334,
            char = "78%"
        )
    )

    expect_identical(
        value_to_char(98.34),
        list(
            num = 98.34,
            char = "98%"
        )
    )

    expect_identical(
        value_to_char(25.34),
        list(
            num = 25.34,
            char = "25%"
        )
    )

    expect_identical(
        value_to_char(69.74),
        list(
            num = 69.74,
            char = "70%"
        )
    )
})

test_that("value_to_char() works with NULL and NA", {
    expect_identical(
        value_to_char(NULL),
        list(
            num = NA_real_,
            char = "unknown"
        )
    )

    expect_identical(
        value_to_char(NA),
        list(
            num = NA_real_,
            char = "unknown"
        )
    )
})

test_that("value_to_char() clamps values gt 100 or lt 0", {
    expect_identical(
        value_to_char(110.78),
        list(
            num = 100,
            char = "100%"
        )
    )

    expect_identical(
        value_to_char(-1),
        list(
            num = 0,
            char = "0%"
        )
    )

    # and complains about it if allowed
    expect_snapshot(
        value_to_char(
            100.78,
            verbose = TRUE
        )
    )

    expect_snapshot(
        value_to_char(
            -1,
            verbose = TRUE
        )
    )
})

test_that("value_width", {
    expect_identical(
        value_width(
            value_to_char(NA)
        ),
        60
    )

    expect_identical(
        value_width(
            value_to_char(NULL)
        ),
        60
    )

    expect_identical(
        value_width(
            value_to_char(5.45)
        ),
        30
    )

    expect_identical(
        value_width(
            value_to_char(15.45)
        ),
        35
    )

    expect_identical(
        value_width(
            value_to_char(45.45)
        ),
        35
    )

    expect_identical(
        value_width(
            value_to_char(100)
        ),
        40
    )

    expect_identical(
        value_width(
            value_to_char(145.45)
        ),
        40
    )
})
