#' Digest file coverage
#'
#' Take a `coverage` object (the output of [covr::package_coverage()], extract
#' the filecoverage component and transform it into a `data.frame`/`tibble`.
#'
#' @param x `<coverage>` object, defaults to [covr::package_coverage()].
#'
#' @returns a `tibble` with 2 columns (`File` and `Coverage`) summarising
#'   testing coverage at file level.
#'
#' @export
#' @examples
#' \dontrun{
#' library(covr)
#'
#' covr::package_coverage("myawesomepkg") |>
#'   digest_coverage()
#' }
digest_coverage <- function(x = covr::package_coverage()) {
  if (!inherits(x, "coverage")) {
    cli::cli_abort(
      "`x` must be a coverage object"
    )
  }

  output <- x |>
    covr::coverage_to_list() |>
    purrr::pluck(
      "filecoverage"
    ) |>
    tibble::enframe(
      name = "file",
      value = "coverage"
    )

  output
}
