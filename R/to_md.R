to_md <- function(x, align = "rr") {
  x |>
    digest_coverage() |>
    knitr::kable(
      align = align
    )
}
