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

test_that("estimate_width_value()", {
    expect_identical(
        estimate_width_value(
            value_to_char(NA)
        ),
        60
    )

    expect_identical(
        estimate_width_value(
            value_to_char(NULL)
        ),
        60
    )

    expect_identical(
        estimate_width_value(
            value_to_char(5.45)
        ),
        30
    )

    expect_identical(
        estimate_width_value(
            value_to_char(15.45)
        ),
        35
    )

    expect_identical(
        estimate_width_value(
            value_to_char(45.45)
        ),
        35
    )

    expect_identical(
        estimate_width_value(
            value_to_char(100)
        ),
        40
    )

    expect_identical(
        estimate_width_value(
            value_to_char(145.45)
        ),
        40
    )
})

test_that("estimate_text_length_value()", {
    expect_identical(
        estimate_text_length_value(
            value_to_char(NA)
        ),
        50
    )
    expect_identical(
        estimate_text_length_value(
            value_to_char(NULL)
        ),
        50
    )

    expect_identical(
        estimate_text_length_value(
            value_to_char(45.56)
        ),
        26
    )

    expect_identical(
        estimate_text_length_value(
            value_to_char(78.89)
        ),
        26
    )

    expect_identical(
        estimate_text_length_value(
            value_to_char(178.89)
        ),
        31
    )

    expect_identical(
        estimate_text_length_value(
            value_to_char(7)
        ),
        20
    )
})

test_that("derive_badge_params() with NULL and NA", {
    expect_identical(
        derive_badge_params(NA),
        list(
            value_num = NA_real_,
            value_char = "unknown",
            value_col = "#9f9f9f",
            width_label = 60,
            width_value = 60,
            text_length_label = 50,
            text_length_value = 50,
            total_width = 120,
            text_start_value = 90
        )
    )

    expect_identical(
        derive_badge_params(NULL),
        list(
            value_num = NA_real_,
            value_char = "unknown",
            value_col = "#9f9f9f",
            width_label = 60,
            width_value = 60,
            text_length_label = 50,
            text_length_value = 50,
            total_width = 120,
            text_start_value = 90
        )
    )
})

test_that("derive_badge_params() regular cases", {
    expect_identical(
        derive_badge_params(5.67),
        list(
            value_num = 5.67,
            value_char = "6%",
            value_col = "#D9534F",
            width_label = 60,
            width_value = 30,
            text_length_label = 50,
            text_length_value = 20,
            total_width = 90,
            text_start_value = 75
        )
    )

    expect_identical(
        derive_badge_params(15.35),
        list(
            value_num = 15.35,
            value_char = "15%",
            value_col = "#D9534F",
            width_label = 60,
            width_value = 35,
            text_length_label = 50,
            text_length_value = 26,
            total_width = 95,
            text_start_value = 77.5
        )
    )

    expect_identical(
        derive_badge_params(45.69),
        list(
            value_num = 45.69,
            value_char = "46%",
            value_col = "#F0AD4E",
            width_label = 60,
            width_value = 35,
            text_length_label = 50,
            text_length_value = 26,
            total_width = 95,
            text_start_value = 77.5
        )
    )

    expect_identical(
        derive_badge_params(65.69),
        list(
            value_num = 65.69,
            value_char = "66%",
            value_col = "#DFB317",
            width_label = 60,
            width_value = 35,
            text_length_label = 50,
            text_length_value = 26,
            total_width = 95,
            text_start_value = 77.5
        )
    )

    expect_identical(
        derive_badge_params(75.69),
        list(
            value_num = 75.69,
            value_char = "76%",
            value_col = "#A4C61D",
            width_label = 60,
            width_value = 35,
            text_length_label = 50,
            text_length_value = 26,
            total_width = 95,
            text_start_value = 77.5
        )
    )

    expect_identical(
        derive_badge_params(95.69),
        list(
            value_num = 95.69,
            value_char = "96%",
            value_col = "#5CB85C",
            width_label = 60,
            width_value = 35,
            text_length_label = 50,
            text_length_value = 26,
            total_width = 95,
            text_start_value = 77.5
        )
    )

    expect_identical(
        derive_badge_params(100),
        list(
            value_num = 100,
            value_char = "100%",
            value_col = "#5CB85C",
            width_label = 60,
            width_value = 40,
            text_length_label = 50,
            text_length_value = 31,
            total_width = 100,
            text_start_value = 80
        )
    )
})

test_that("derive_badge_params() with gt 100 and lt 0", {
    expect_identical(
        derive_badge_params(1470),
        list(
            value_num = 100,
            value_char = "100%",
            value_col = "#5CB85C",
            width_label = 60,
            width_value = 40,
            text_length_label = 50,
            text_length_value = 31,
            total_width = 100,
            text_start_value = 80
        )
    )

    expect_identical(
        derive_badge_params(-1470),
        list(
            value_num = 0,
            value_char = "0%",
            value_col = "#D9534F",
            width_label = 60,
            width_value = 30,
            text_length_label = 50,
            text_length_value = 20,
            total_width = 90,
            text_start_value = 75
        )
    )
})

test_that("derive_badge_colour()", {
    coverage_values <- purrr::map(1:20 * 5, value_to_char)

    expect_identical(
        purrr::map_chr(
            coverage_values,
            derive_badge_colour
        ) |>
            unique(),
        # values for 90 and 100 are identical -> unique
        unique(coverage_thresholds$colour)
    )
})

test_that("derive_badge_colour() with NULL and NA", {
    expect_identical(
        derive_badge_colour(
            value_to_char(
                NA_real_
            )
        ),
        "#9f9f9f"
    )

    expect_identical(
        derive_badge_colour(
            value_to_char(
                NULL
            )
        ),
        "#9f9f9f"
    )
})
