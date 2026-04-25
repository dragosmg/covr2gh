comm_marker <- function(
    comm,
    marker = "<!-- covr2gh-marker -->"
) {
    check_comment(comm)
    check_string(marker)

    comm$marker <- marker
    comm
}

comm_get_marker <- function(comm) {
    check_comment(comm)
    comm$marker %||% "empty"
}
