# TODO
# * badge does not need to be supplied by the user. is derived from head_cov
# * footer does not need to be supplied
#     * (maybe allow users to switch it off) -> advertise == TRUE/ FALSE
# * marker does not need to be supplied by the user
# * summary is calculated
# * details is calculated
# * body is calculated

# TODO the workflow should not run when there are no changes to relevant files
# TODO or the workflow runs, but the output reflects the state and there is no
# need to compare head and base (basically, exit early)

# TODO "this pr does not contain changes to files that would impact coverage"

# TODO badge in gh-pages?
# TODO covr object cached in gh-pages?
# TODO cache the covr object for the most recent commit in main?

# TODO change marker to <!-- covr2gh: do not delete/edit this line -->

# * cov_delta is the input (created with `cov_delta()` and `new_cov_delta()`):
#   * it needs
#     * repo - set with `cov_delta_repo()`
#     * pr - set with `cov_delta_pr()`
#     * head_cov - set_with `cov_delta_head()`
#     * base_cov - set with `cov_delta_base()`

# * comment is the output
#   * we need to get the PR details (what do we call the function)

# * prepare: should prepare make all the API calls and get all the info needed?
#   * cov_delta_report:
#   * get_pr_details(): remove and replace with 2 functions
#   * pr_request: input
#   * pr_info: output (the response to the PR API request)
#   * pr_api_request -> perform -> pr_info (response)

# * handle

# * weird behaviour: old (running) checks pick-up the most recent commit and
# report on it. the comment references a commit for which the checks have not
# yet finished. I have no idea which version of the repo is being used
# (probably the most recent one). this could potentially result in duplicated
# runs. this is an issue for multigrain where runs take > 10 minutes.

# * speak of changed (modified) lines not added lines. codecov calls them
# "modified and coverable"

# * line reference seems off (in multigrain it was 1 or 2 lines off)

# we create a cov_delta object
head_cov <- readRDS("dev/covr_head_pr_33_demo.rds")
base_cov <- readRDS("dev/covr_base_pr_33_demo.rds")

cov_delta_demo <- cov_delta("dragosmg/covr2ghdemo") |>
    cov_delta_pr(33) |>
    cov_delta_head(head_cov) |>
    cov_delta_base(base_cov)
