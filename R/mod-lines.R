mod_lines <- function(patch) {
    check_patch(patch)

    output <- tibble::tibble(
        file = patch$file,
        raw = patch$patch
    ) |>
        classify_lines() |>
        # looking from the HEAD pov
        dplyr::filter(
            .data$hunk | .data$context | .data$head,
            !.data$merge
        ) |>
        dplyr::select(
            -"base",
            -"merge"
        ) |>
        add_line_num() |>
        dplyr::filter(
            !.data$hunk,
            .data$head
        ) |>
        dplyr::select(
            "line",
            "raw"
        ) |>
        dplyr::mutate(
            source = stringr::str_remove(
                .data$raw,
                "^\\+"
            )
        ) |>
        dplyr::select(
            -"raw"
        )

    output
}
