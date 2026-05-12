# TODO
# * badge does not need to be supplied by the user. is derived from head_cov
# * footer does not need to be supplied
#     * (maybe allow users to switch it off) -> advertise == TRUE/ FALSE
# * marker does not need to be supplied by the user
# * summary is calculated
# * details is calculated
# * body is calculated

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

# we create a cov_delta object
head_cov <- readRDS("dev/covr_head_pr_33_demo.rds")
base_cov <- readRDS("dev/covr_base_pr_33_demo.rds")

cov_delta_demo <- cov_delta("dragosmg/covr2ghdemo") |>
    cov_delta_pr(33) |>
    cov_delta_head(head_cov) |>
    cov_delta_base(base_cov)
