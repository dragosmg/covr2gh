#' Identify the covr2gh comment
#'
#' Comments posted by covr2gh are identified by the presence of the
#' `"<!-- covr2gh-do-not-delete -->"` marker. `get_comment_id()` looks for it.
#' If it can find it, it returns the comment ID, otherwise it returns `NULL`.
#'
#' The output of `get_comment_id()` is then used `post_comment()` post a new
#' comment or update an existing one.
#'
#' @inheritParams compose_comment repo pr_number
#'
#' @returns the comment ID (scalar numeric) or `NULL`
#'
#' @dev
#' @examples
#' \dontrun{
#' get_comment_id("<owner>/<repo>", 3)
#' }
get_comment_id <- function(
    repo,
    pr_number,
    marker = covr2gh_marker,
    call = rlang::caller_env()
) {
    rlang::check_string(repo, call = call)
    rlang::check_number_whole(pr_number, call = call)

    api_url <- glue::glue(
        "https://api.github.com/repos/{repo}/issues/{pr_number}/comments"
    )

    # TODO add test to confirm everything works with a NULL
    comments_info <- tryCatch(
        glue::glue("GET {api_url}") |>
            gh::gh(),
        error = function(e) NULL
    )

    if (rlang::is_null(comments_info)) {
        return(NULL)
    }

    # identify the comment containing the marker
    comment_index <- comments_info |>
        # look in the comment body
        purrr::map("body") |>
        # detect_index identifies the position of the first match
        purrr::detect_index(
            \(x) stringr::str_detect(x, pattern = marker)
        )

    if (comment_index == 0) {
        return(NULL)
    }

    comments_info[[comment_index]]$id
}


#' Post comment
#'
#' `post_comment()` first checks if a "known" `covr2gh` comment exists on the
#' target pull request. If it does, then it updates it, if it doesn't, then a
#' a new comment is posted.
#'
#' @details
#' Users can also choose to always post a new comment (this always deletes the
#' previous one).
#'
#' @param body (character scalar) the content of the body of the message.
#' @inheritParams compose_comment repo pr_number
#' @param update (logical) update an existing comment or post a new one.
#'   Defaults to `TRUE`.
#'
#' @returns a `gh_response` object containing the API response
#'
#' @export
#' @examples
#' \dontrun{
#' post_comment(
#'   "this is amazing",
#'   repo = "<owner>/<repo>",
#'   pr_number = 3
#' )
#' }
post_comment <- function(
    body,
    repo,
    pr_number,
    update = TRUE
) {
    # TODO add `check_repo()`
    rlang::check_string(body)
    rlang::check_string(repo)
    rlang::check_number_whole(pr_number)
    check_logical(update)

    comment_id <- get_comment_id(
        repo = repo,
        pr_number = pr_number
    )

    if (isFALSE(update) && !rlang::is_null(comment_id)) {
        comm_delete(repo, comment_id)
    }

    if (rlang::is_null(comment_id)) {
        update <- FALSE
    }

    # posting a new comment vs updating an existing one is accomplished by
    # using different endpoints

    if (update) {
        # endpoint for updating an existing one
        api_url <- glue::glue(
            "https://api.github.com/repos/{repo}/issues/comments/{comment_id}"
        )
    } else {
        # endpoint for posting a new issue comment
        api_url <- glue::glue(
            "https://api.github.com/repos/{repo}/issues/{pr_number}/comments"
        )
    }

    response <- glue::glue("POST {api_url}") |>
        gh::gh(body = body)

    invisible(response)
}

#' Delete a comment
#'
#' Thin wrapper for making a `DELETE` request to the issue comments endpoint
#' of the GitHub API.
#'
#' @inheritParams compose_comment repo
#' @param comment_id (numeric) the ID of the issue comment to delete.
#'
#' @returns a `gh_response` object
#'
#' @dev
#' @examples
#' \dontrun{
#' comm_delete("<owner>/<repo>", 4553)
#' }
comm_delete <- function(
    repo,
    comment_id
) {
    api_url <- glue::glue(
        "https://api.github.com/repos/{repo}/issues/comments/{comment_id}"
    )

    response <- glue::glue("DELETE {api_url}") |>
        gh::gh()

    invisible(response)
}
