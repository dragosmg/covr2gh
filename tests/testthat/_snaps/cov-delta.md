# covr2gh_cov_delta print method

    Code
      cov_delta("owner/repo")
    Output
      <covr2gh_cov_delta>
      Repo: owner/repo
      PR: empty
      Head coverage: empty
      Base coverage: empty

---

    Code
      cov_delta("owner/repo")
    Output
      <covr2gh_cov_delta>
      Repo: owner/repo
      PR: empty
      Head coverage: empty
      Base coverage: empty

---

    Code
      cov_delta_head(cov_delta_base(cov_delta_pr(cov_delta("owner/repo"), 81),
      base_coverage), head_coverage)
    Output
      <covr2gh_cov_delta>
      Repo: owner/repo
      PR: 81
      Head coverage: 28.6%
      Base coverage: 31.6%

