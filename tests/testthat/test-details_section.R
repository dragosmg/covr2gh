test_that("compose_details_section works", {
    file_coverage_delta <- tibble::tibble(
        # nolint start: nonportable_path_linter
        file_name = c("R/add_one.R", "Overall"),
        coverage_head = c(33.3, 28.6),
        coverage_base = c(40, 31.6),
        delta = c(-6.7, -3)
    )

    line_coverage_delta <- tibble::tibble(
        file_name = c("R/add_one.R", "R/add_three.R", "R/add_two.R"),
        # nolint end
        lines_modified = c(6L, 8L, 1L),
        lines_covered = c(2L, 0L, 1L),
        missing = c("13-16", "12-15, 18-21", NA)
    )

    expect_snapshot(
        compose_details_section(
            file_cov_delta = file_coverage_delta,
            line_cov_delta = line_coverage_delta
        )
    )

    expect_snapshot(error = TRUE, {
        compose_details_section(
            file_cov_delta = file_coverage_delta,
            line_cov_delta = "foo"
        )
    })

    expect_s3_class(
        compose_details_section(
            file_cov_delta = file_coverage_delta,
            line_cov_delta = line_coverage_delta
        ),
        "glue"
    )

    expect_snapshot({
        compose_details_section(
            file_cov_delta = file_coverage_delta,
            line_cov_delta = NULL
        )
    })

    expect_snapshot({
        compose_details_section(
            file_cov_delta = NULL,
            line_cov_delta = line_coverage_delta
        )
    })
})
