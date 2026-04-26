# covr2gh_comment print method

    Code
      comment("owner/repo")
    Output
      <covr2gh_comment>
      Repo: owner/repo
      PR: empty
      Head coverage: empty
      Base coverage: empty
      Marker: empty
      Footer: empty

---

    Code
      comm_footer(comm_marker(comm_head_cov(comm_base_cov(comm_pr_num(comment(
        "owner/repo"), 81), base_coverage), head_coverage), "test"))
    Output
      <covr2gh_comment>
      Repo: owner/repo
      PR: 81
      Head coverage: 28.6%
      Base coverage: 31.6%
      Marker: test
      Footer: <sup>Created on 2026-04-26 with [covr2gh v0.0.0.9033](https://dragosmg.github.io/covr2gh).</sup>

