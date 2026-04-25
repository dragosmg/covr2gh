comm_repo <- function(comm, repo) {
    check_comment(comm)
    check_string(repo)

    comm$repo <- repo
    comm
}

comm_get_repo <- function(comm) {
    check_comment(comm)
    comm$repository
}
