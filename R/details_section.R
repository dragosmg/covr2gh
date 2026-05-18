# brings together file coverage details and line coverage details
compose_details_section <- function(
    file_cov_delta,
    line_cov_delta,
    call = rlang::caller_env()
) {
    rlang::check_data_frame(
        file_cov_delta,
        allow_null = TRUE,
        call = call
    )
    rlang::check_data_frame(
        line_cov_delta,
        allow_null = TRUE,
        call = call
    )

    files <- setdiff(file_cov_delta$file_name, "Overall")

    if (rlang::is_empty(files)) {
        return(glue::as_glue(""))
    }

    file_coverage_details <- compose_file_coverage_details(
        file_cov_delta
    )

    line_coverage_details <- compose_line_coverage_details(
        line_cov_delta
    )

    # TODO probably not realistic / testable. for compose_file_coverage() to
    # return "" it would mean file_cov_delta is NULL -> the
    # rlang::is_empty(files) condition would have kicked in by now
    if (file_coverage_details == "" && line_coverage_details == "") {
        return(glue::as_glue(""))
    }

    details_section <- glue::glue_data(
        list(
            file_coverage_details = file_coverage_details,
            line_coverage_details = line_coverage_details
        ),
        "
        <details>
        <summary>Details</summary>

        {file_coverage_details}

        {line_coverage_details}
        </details>
        "
    )

    details_section
}
