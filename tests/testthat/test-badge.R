test_that("derive_badge_value() works", {
  expect_identical(
    derive_badge_value(
      10.234
    ),
    "10.23%25"
  )

  expect_identical(
    derive_badge_value(
      56.943
    ),
    "56.94%25"
  )

  expect_identical(
    derive_badge_value(
      90.51235454
    ),
    "90.51%25"
  )
})

test_that("derive_badge_value() complains", {
  expect_error(
    derive_badge_value(
      c(10.234, 38.399)
    ),
    "`percentage` must be a scalar double.",
    fixed = TRUE
  )

  expect_error(
    derive_badge_value(
      "foo"
    ),
    "`percentage` must be a scalar double.",
    fixed = TRUE
  )

  expect_error(
    derive_badge_value(
      TRUE
    ),
    "`percentage` must be a scalar double.",
    fixed = TRUE
  )
})

test_that("derive_badge_colour() works", {
  expect_identical(
    derive_badge_colour(10),
    "red"
  )

  expect_identical(
    derive_badge_colour(50),
    "orange"
  )

  expect_identical(
    derive_badge_colour(60),
    "yellow"
  )

  expect_identical(
    derive_badge_colour(70),
    "yellowgreen"
  )

  expect_identical(
    derive_badge_colour(80),
    "green"
  )

  expect_identical(
    derive_badge_colour(90),
    "brightgreen"
  )

  expect_identical(
    derive_badge_colour(NA_real_),
    "lightgrey"
  )

  expect_identical(
    derive_badge_colour(NULL),
    "lightgrey"
  )
})

test_that("derive_badge_colour() complains", {
  expect_error(
    derive_badge_colour(c(78.5, 32.5)),
    "`percentage` must be a scalar double.",
    fixed = TRUE
  )

  expect_error(
    derive_badge_colour("foo"),
    "`percentage` must be a scalar double.",
    fixed = TRUE
  )

  expect_error(
    derive_badge_colour(TRUE),
    "`percentage` must be a scalar double.",
    fixed = TRUE
  )
})

test_that("build_badge_url() works", {
  expect_snapshot(
    build_badge_url(10)
  )
})

test_that("build_badge_url() with NA and NULL", {
  expect_snapshot(
    build_badge_url(NA_real_)
  )

  expect_snapshot(
    build_badge_url(NULL)
  )
})

test_that("build_badge_url() complains", {
  # with non-scalar numeric inputs
  expect_snapshot(
    error = TRUE,
    build_badge_url(c(75, 80))
  )

  # with non-numeric inputs
  expect_snapshot(
    error = TRUE,
    build_badge_url("foo")
  )

  expect_snapshot(
    error = TRUE,
    build_badge_url(TRUE)
  )

  expect_snapshot(
    error = TRUE,
    build_badge_url(list(75))
  )
})
