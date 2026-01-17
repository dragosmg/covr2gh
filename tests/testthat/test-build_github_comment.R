test_that("build_comment() works", {
  coverage <- readRDS(test_path("fixtures", "sample_coverage.RDS"))

  expect_snapshot(
    build_comment(
      coverage
    )
  )
})
