test_that("get_pr_details() works", {
  skip_if_offline()
  expect_snapshot(
    get_pr_details(
      owner = "dragosmg",
      repo = "covr2mddemo",
      pr_number = 2
    )
  )
})

test_that("get_pr_details() complains with incorrect inputs", {
  # `owner` is not a scalar (i.e. of length 1)
  expect_error(
    get_pr_details(
      owner = c("foo", "bar")
    ),
    "`owner` must be a character scalar.",
    fixed = TRUE
  )

  # `owner` is not character
  expect_error(
    get_pr_details(
      owner = 1
    ),
    "`owner` must be a character scalar.",
    fixed = TRUE
  )

  expect_error(
    get_pr_details(
      owner = FALSE
    ),
    "`owner` must be a character scalar.",
    fixed = TRUE
  )

  # `repo` is not scalar
  expect_error(
    get_pr_details(
      owner = "dragosmg",
      repo = c("foo", "bar")
    ),
    "`repo` must be a character scalar.",
    fixed = TRUE
  )

  # `repo` is not character
  expect_error(
    get_pr_details(
      owner = "dragosmg",
      repo = 1
    ),
    "`repo` must be a character scalar.",
    fixed = TRUE
  )

  expect_error(
    get_pr_details(
      owner = "dragosmg",
      repo = FALSE
    ),
    "`repo` must be a character scalar.",
    fixed = TRUE
  )

  # `pr_number` is not scalar
  expect_error(
    get_pr_details(
      owner = "dragosmg",
      repo = "covr2mddemo",
      pr_number = c(2, 3)
    ),
    "`pr_number` must be an integer-like scalar.",
    fixed = TRUE
  )

  # `pr_number` is not integerish
  expect_error(
    get_pr_details(
      owner = "dragosmg",
      repo = "covr2mddemo",
      pr_number = "foo"
    ),
    "`pr_number` must be an integer-like scalar.",
    fixed = TRUE
  )

  expect_error(
    get_pr_details(
      owner = "dragosmg",
      repo = "covr2mddemo",
      pr_number = FALSE
    ),
    "`pr_number` must be an integer-like scalar.",
    fixed = TRUE
  )
})

test_that("get_changed_files() works", {
  skip_if_offline()
  expect_snapshot(
    get_changed_files(
      owner = "dragosmg",
      repo = "covr2mddemo",
      pr_number = 2
    )
  )
})

test_that("get_changed_files() complains with incorrect inputs", {
  # `owner` is not a scalar (i.e. of length 1)
  expect_error(
    get_changed_files(
      owner = c("foo", "bar")
    ),
    "`owner` must be a character scalar.",
    fixed = TRUE
  )

  # `owner` is not character
  expect_error(
    get_changed_files(
      owner = 1
    ),
    "`owner` must be a character scalar.",
    fixed = TRUE
  )

  expect_error(
    get_changed_files(
      owner = FALSE
    ),
    "`owner` must be a character scalar.",
    fixed = TRUE
  )

  # `repo` is not scalar
  expect_error(
    get_changed_files(
      owner = "dragosmg",
      repo = c("foo", "bar")
    ),
    "`repo` must be a character scalar.",
    fixed = TRUE
  )

  # `repo` is not character
  expect_error(
    get_changed_files(
      owner = "dragosmg",
      repo = 1
    ),
    "`repo` must be a character scalar.",
    fixed = TRUE
  )

  expect_error(
    get_changed_files(
      owner = "dragosmg",
      repo = FALSE
    ),
    "`repo` must be a character scalar.",
    fixed = TRUE
  )

  # `pr_number` is not scalar
  expect_error(
    get_changed_files(
      owner = "dragosmg",
      repo = "covr2mddemo",
      pr_number = c(2, 3)
    ),
    "`pr_number` must be an integer-like scalar.",
    fixed = TRUE
  )

  # `pr_number` is not integerish
  expect_error(
    get_changed_files(
      owner = "dragosmg",
      repo = "covr2mddemo",
      pr_number = "foo"
    ),
    "`pr_number` must be an integer-like scalar.",
    fixed = TRUE
  )

  expect_error(
    get_changed_files(
      owner = "dragosmg",
      repo = "covr2mddemo",
      pr_number = FALSE
    ),
    "`pr_number` must be an integer-like scalar.",
    fixed = TRUE
  )
})
