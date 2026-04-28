# errors are forwarded correctly

    Code
      cov_delta_pr(cov_delta, TRUE)
    Condition
      Error in `cov_delta_pr()`:
      ! `pr` must be a whole number, not `TRUE`.
    Code
      cov_delta_pr(cov_delta, "foo")
    Condition
      Error in `cov_delta_pr()`:
      ! `pr` must be a whole number, not the string "foo".

