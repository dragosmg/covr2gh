#  build a badge which needs to be in 2 places:
#   * in the PR comment
#   * in the Readme
#   * maybe stored in a separate branch (e.g. coverage-artifacts)?
generate_badge <- function(value) {
  # enforce value being between 0 and 100
  # TODO message about it
  # TODO test
  # > value = NULL
  # > max(min(value, 100), 0)
  # [1] 100
  value <- max(min(value, 100), 0)

  char_value <- dplyr::if_else(
    is.null(value) | is.na(value),
    "unknown",
    paste0(round(value), "%")
  )

  # the values hardcoded below generally work. i did not want to go down the
  # rabbit hole of trying to make the widths of the label and value boxes
  # entirely adaptive since:
  #   - the text in the label will always be "coverage"
  #   - the font family and font size are not controlled by the user
  #   - the height of the badge is the "standard" 20

  label_width <- 60
  value_width <- dplyr::case_when(
    char_value == "unknown" ~ label_width,
    char_value == "100%" ~ 40,
    nchar(char_value) < 3 ~ 30,
    .default = 35
  )

  text_length_label <- 50
  text_length_value <- dplyr::case_when(
    char_value == "unknown" ~ text_length_label,
    char_value == "100%" ~ 31,
    nchar(char_value) < 3 ~ 20,
    .default = 26
  )

  total_width <- label_width + value_width

  text_value_start <- label_width + value_width / 2

  value_colour <- derive_value_colour(value)

  value_colour <- "#9f9f9f"

  if (char_value != "unknown") {
    idx <- findInterval(
      value,
      coverage_thresholds$value,
      rightmost.closed = TRUE
    )

    value_colour <- coverage_thresholds$colour[idx]
  }

  glue::glue(
    badge_boilerplate,
    .trim = TRUE
  )
}

badge_boilerplate <- '
  <svg xmlns="http://www.w3.org/2000/svg"
        width="{total_width}"
        height="20"
        role="img"
        aria-label="coverage: {char_value}">

    <title>
        coverage: {char_value}
    </title>

    <defs>
        <!-- rounded corners -->
        <clipPath id="clipr">
            <rect width="{total_width}"
                    height="20"
                    rx="3"
                    fill="#fff"/>
        </clipPath>

        <!-- subtle gradient overlay -->
        <linearGradient id="gradient"
                        x2="0"
                        y2="100%">
            <stop offset="0"
                    stop-color="#bbb"
                    stop-opacity="0.1"/>
            <stop offset="1" stop-opacity="0.1"/>
        </linearGradient>
    </defs>

    <!-- badge background -->
    <g clip-path="url(#clipr)">
        <rect width="{label_width}"
                height="20"
                fill="#555"/>
        <rect x="{label_width}"
                width="{value_width}"
                height="20"
                fill="{value_colour}"/>
        <rect width="{total_width}"
                height="20"
                fill="url(#gradient)"/>
    </g>

    <!-- badge text -->
    <g fill="#fff"
        text-anchor="middle"
        font-family="Verdana,Geneva,DejaVu Sans,sans-serif"
        font-size="11"
        >

        <!-- label shadow -->
        <text aria-hidden="true"
                x="31"
                y="15"
                fill="#010101"
                fill-opacity="0.3"
                textLength="{text_length_label}">
            coverage
        </text>

        <!-- label text -->
        <text x="31"
                y="14"
                fill="#fff"
                textLength="{text_length_label}">
            coverage
        </text>

        <!-- value shadow -->
        <text aria-hidden="true"
                x="{text_value_start}"
                y="15"
                fill="#010101"
                fill-opacity="0.3"
                textLength="{text_length_value}">
          {char_value}
        </text>

        <!-- value text -->
        <text x="{text_value_start}"
                y="14"
                fill="#fff"
                textLength="{text_length_value}">
          {char_value}
        </text>
    </g>
</svg>
'

coverage_thresholds <- tibble::tibble(
  value = c(0, 30, 50, 65, 80, 90, 100),
  colour = c(
    "#D9534F",
    "#E4804E",
    "#F0AD4E",
    "#DFB317",
    "#A4C61D",
    "#5CB85C",
    "#5CB85C"
  )
)

derive_value_colour <- function(
  value,
  colours = coverage_thresholds
) {
  if (is.null(value) || is.na(value)) {
    value_colour <- "#9f9f9f"
    return(value_colour)
  }

  idx <- findInterval(
    value,
    coverage_thresholds$value,
    rightmost.closed = TRUE
  )

  value_colour <- coverage_thresholds$colour[idx]

  value_colour
}
