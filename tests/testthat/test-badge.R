test_that("derive_badge_colour() works", {
  coverages <- 1:20 * 5

  expect_identical(
    purrr::map_chr(
      coverages,
      derive_value_colour
    ) |>
      unique(),
    # values for 90 and 100 are identical / duplicates
    unique(coverage_thresholds$colour)
  )
})

test_that("derive_badge_colour() with NULL and NA", {
  expect_identical(
    derive_value_colour(NA_real_),
    "#9f9f9f"
  )

  expect_identical(
    derive_value_colour(NULL),
    "#9f9f9f"
  )
})
