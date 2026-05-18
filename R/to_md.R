#' Transform the file coverage tibble into markdown
#'
#' Makes the column names human readable, formats the data, and adds an
#' interpretation column. The transforms the output to markdown and collapses
#' into a single string.
#'
#' @param file_cov_delta a `tibble`, the output of [combine_file_coverage()].
#' @inheritParams knitr::kable
#'
#' @returns a character scalar containing markdown version of the diff df
#'   collapsed into a single string.
#'
#' @dev
file_cov_to_md <- function(file_cov_delta, align = "lrrcc") {
    if (is.null(file_cov_delta)) {
        return("")
    }

    file_cov_delta_prep <- file_cov_delta |>
        dplyr::mutate(
            # add a brief visual interpretation of the delta with arrows or
            # equal sign
            interpretation = dplyr::case_when(
                delta > 0 ~ ":arrow_up:",
                delta < 0 ~ ":arrow_down:",
                delta == 0 ~ ":heavy_equals_sign:"
            ),
            # add % to figures
            coverage_head = paste0(
                .data$coverage_head,
                "%"
            ),
            coverage_base = paste0(
                .data$coverage_base,
                "%"
            )
        )

    # rename to something more human readable
    file_cov_delta_prep_names <- file_cov_delta_prep |>
        names() |>
        stringr::str_to_sentence() |>
        stringr::str_replace_all(
            stringr::fixed("_"),
            " "
        ) |>
        stringr::str_replace(
            stringr::fixed("Delta"),
            "&Delta;"
        ) |>
        stringr::str_replace(
            stringr::fixed("Interpretation"),
            ""
        )

    names(file_cov_delta_prep) <- file_cov_delta_prep_names

    file_cov_delta_prep |>
        knitr::kable(
            align = align
        ) |>
        stringr::str_replace_all(
            "NA%|NA",
            "-"
        ) |>
        glue::glue_collapse(
            sep = "\n"
        )
}

#' Transform a line coverage tibble to markdown
#'
#' Adds a total row, make column names more readable. Then transforms it to
#' markdown which gets collapsed into a single string.
#'
#' @param line_cov_delta (`tibble`) diff line coverage data. The output of
#'   [get_diff_line_coverage()]
#' @inheritParams knitr::kable
#'
#' @returns a markdown table as a string
#'
#' @dev
line_cov_to_md <- function(
    line_cov_delta,
    align = "lrrrl"
) {
    if (is.null(line_cov_delta)) {
        return("")
    }

    total_row <- line_cov_delta |>
        dplyr::summarise(
            lines_modified = sum(.data$lines_modified),
            lines_covered = sum(.data$lines_covered)
        ) |>
        dplyr::mutate(
            file_name = "Total",
            .before = "lines_modified"
        )

    output <- dplyr::bind_rows(
        line_cov_delta,
        total_row
    ) |>
        dplyr::mutate(
            coverage = round(
                (.data$lines_covered / .data$lines_modified) * 100,
                1
            ),
            coverage = paste0(
                .data$coverage,
                "%"
            ),
            missing = dplyr::if_else(
                is.na(.data$missing),
                "",
                .data$missing
            )
        ) |>
        dplyr::select(
            `File name` = "file_name",
            `Lines modified` = "lines_modified",
            `Lines tested` = "lines_covered",
            Coverage = "coverage",
            Missing = "missing"
        )

    output |>
        knitr::kable(
            align = align
        ) |>
        glue::glue_collapse(
            sep = "\n"
        )
}
