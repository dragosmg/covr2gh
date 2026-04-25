comm_footer <- function(
    comm,
    covr2gh_ver = as.character(utils::packageVersion("covr2gh")),
    covr2gh_url = "https://dragosmg.github.io/covr2gh",
    date = Sys.Date()
) {
    check_comment(comm)
    check_string(covr2gh_ver)
    check_string(covr2gh_url)
    check_date(date)

    comm$footer <- glue::glue_data(
        list(
            date = date,
            covr2gh_ver = covr2gh_ver,
            covr2gh_url = covr2gh_url
        ),
        "<sup>Created on {date} with [covr2gh v{covr2gh_ver}]({covr2gh_url}).</sup>"
    )

    comm
}

comm_get_footer <- function(comm) {
    check_comment(comm)
    comm$footer %||% "empty"
}
