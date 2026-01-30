short_hash <- function(hash, n = 7) {
    stringr::str_sub(hash, 1, n)
}
