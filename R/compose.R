# used to identify a comment posted with covr2gh
covr2gh_marker <- "<!-- covr2gh: do not delete/edit this line -->"
test_marker <- "<!-- covr2gh-test -->"

#' Compose a coverage comment
#'
#' @param head_coverage (coverage) active / current branch (`HEAD`) coverage.
#'   The output of [covr::package_coverage()] on the head branch.
#' @param base_coverage (coverage) base / target branch coverage (coverage for
#'   the branch merging into). The output of [covr::package_coverage()] on the
#'   base branch.
#' @param repo (character) the repository name in the GitHub format
#'   (`"OWNER/REPO"`).
#' @param pr_number (integer) the PR number
#' @param diff_cov_target (numeric) minimum accepted diff coverage. Defaults to
#'   `NULL` which is then interpreted as overall base branch coverage.
#'
#' @returns a character scalar with the content of the GitHub comment
#'
#' @export
#' @examples
#' \dontrun{
#' coverage_head <- covr::package_coverage()
#' system("git checkout main")
#' coverage_main <- covr::package_coverage()
#'
#' compose_comment(
#'   head_coverage = coverage_head,
#'   base_coverage = coverage_main,
#'   repo = "<owner>/<repo>",
#'   pr_number = 3
#' )
#' }
compose_comment <- function(
    head_coverage,
    base_coverage,
    repo,
    pr_number,
    diff_cov_target = NULL
) {
    our_target <- FALSE

    # TODO add some checks on inputs
    pr_details <- get_pr_details(
        repo = repo,
        pr_number = pr_number
    )

    total_head_coverage <- covr::percent_coverage(head_coverage)
    total_base_coverage <- covr::percent_coverage(base_coverage)

    if (is.null(diff_cov_target)) {
        diff_cov_target <- total_base_coverage
        our_target <- TRUE
    }

    delta_total_coverage <- round(
        total_head_coverage - total_base_coverage,
        1
    )

    coverage_summary <- compose_coverage_summary(
        pr_details,
        delta_total_coverage
    )

    file_cov_delta <- combine_file_coverage(
        head_coverage = head_coverage,
        base_coverage = base_coverage
    )

    line_cov_delta <- get_diff_line_coverage(
        pr_details = pr_details,
        head_coverage = head_coverage
    )

    line_cov_summary <- compose_line_coverage_summary(
        line_cov_delta,
        target = diff_cov_target,
        our_target = our_target
    )

    details_section <- compose_details_section(
        file_cov_delta = file_cov_delta,
        line_cov_delta = line_cov_delta
    )

    glue::glue_data(
        list(
            comment = covr2gh_marker,
            badge_url = build_badge_url(total_head_coverage),
            coverage_summary = coverage_summary,
            line_cov_summary = line_cov_summary,
            details_section = details_section,
            footer = compose_footer()
        ),
        "{comment}

        ## :safety_vest: Coverage summary

        ![badge]({badge_url})

        {coverage_summary}
        {line_cov_summary}

        {details_section}

        :recycle: Comment updated with the latest results.

        {footer}"
    )
}

# TODO look into logic invalidating the comment when the base_sha changes

#' Compose coverage summary
#'
#' Builds the top level sentences of the summary.
#'
#' @param pr_details a `<pr_details>` object representing a subset of the pull
#'   request metadata we need. The output of [get_pr_details()].
#' @param delta (numeric scalar) difference in total coverage between head of
#'   current branch and base branch.
#'
#' @returns a string (character scalar) containing the text for the coverage
#'   summary.
#'
#' @dev
#' @examples
#' \dontrun{
#' pr_details <- get_pr_details(
#'   repo = "<owner>/<repo>",
#'   pr_number = 2
#' )
#'
#' coverage_summary <- compose_coverage_summary(
#'   pr_details = pr_details,
#'   delta = 20.43
#' )
#' }
compose_coverage_summary <- function(pr_details, delta) {
    delta_translation <- dplyr::case_when(
        delta > 0 ~ "increase",
        delta < 0 ~ "decrease",
        delta == 0 ~ "not change"
    )

    by_delta <- glue::glue(" by `{abs(delta)}` percentage points")

    by_delta <- dplyr::if_else(
        delta == 0,
        "",
        by_delta
    )

    emoji <- dplyr::case_when(
        delta >= 0 ~ ":green_circle:",
        delta >= -5 ~ ":yellow_circle:",
        .default = ":red_circle: "
    )

    head_sha_url <- glue::glue_data(
        list(
            repo = pr_details$repo,
            head_sha = pr_details$head_sha
        ),
        "https://github.com/{repo}/commit/{head_sha}"
    )

    base_sha_url <- glue::glue_data(
        list(
            repo = pr_details$repo,
            base_sha = pr_details$base_sha
        ),
        "https://github.com/{repo}/commit/{base_sha}"
    )

    glue::glue_data(
        list(
            emoji = emoji,
            pr_number = pr_details$pr_number,
            pr_html_url = pr_details$pr_html_url,
            short_hash_head = short_hash(pr_details$head_sha),
            head_sha_url = head_sha_url,
            short_hash_base = short_hash(pr_details$base_sha),
            base_sha_url = base_sha_url,
            delta_translation = delta_translation,
            by_delta = by_delta
        ),
        "{emoji} Merging PR [#{pr_number}]({pr_html_url}) \\
        ([`{short_hash_head}`](head_sha_url)) into _{pr_details$base_name}_ \\
        ([`{short_hash_base}`](base_sha_url)) will **{delta_translation}** \\
        overall coverage{by_delta}."
    )
}
