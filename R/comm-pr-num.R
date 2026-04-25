comm_pr_num <- function(comm, pr = NULL) {
    check_comment(comm)
    rlang::check_number_whole(pr)

    comm$pr_num <- pr
    comm
}


comm_get_pr_num <- function(comm) {
    check_comment(comm)
    comm$pr_num %||% "empty"
}
