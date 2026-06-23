# compose_comment works

    Code
      compose_comment(head_coverage, base_coverage, repo = "dragosmg/covr2ghdemo",
        pr_number = 3)
    Output
      <!-- covr2gh: do not delete/edit this line -->
      
      ## :safety_vest: Coverage summary
      
      ![badge](https://img.shields.io/badge/coverage-29%25-E4804E.svg)
      
      :yellow_circle: Merging PR [#3](https://github.com/dragosmg/covr2ghdemo/pull/3) ([`<removed-commit-sha>`](head_sha_url)) into _main_ ([`<removed-commit-sha>`](base_sha_url)) will **decrease** overall coverage by `3` percentage points.
      :red_circle:  Diff coverage is `28.6%` (`6` out of `21` modified lines are covered by tests). It's good practice to aim for at least `31.6%` (the base branch test coverage).
      
      <details>
      <summary>Details</summary>
      
      ### Files with changes in coverage
      
      |File name   | Coverage head| Coverage base| &Delta; |              |
      |:-----------|-------------:|-------------:|:-------:|:------------:|
      |R/add_one.R |         33.3%|           40%|  -6.7   | :arrow_down: |
      |Overall     |         28.6%|         31.6%|  -3.0   | :arrow_down: |
      
      ### Coverage for modified lines
      
      |File name     | Lines modified| Lines tested| Coverage|Missing      |
      |:-------------|--------------:|------------:|--------:|:------------|
      |R/add_one.R   |              6|            2|    33.3%|13-16        |
      |R/add_three.R |              8|            0|       0%|12-15, 18-21 |
      |R/add_two.R   |              7|            4|    57.1%|13-15        |
      |Total         |             21|            6|    28.6%|             |
      </details>
      
      :recycle: Comment updated with the latest results.
      
      <sup>Created on <removed-date> with [covr2gh v<x.y.z>](https://dragosmg.github.io/covr2gh).</sup>

---

    Code
      compose_comment(head_coverage, base_coverage, repo = "dragosmg/covr2ghdemo",
        pr_number = 3, diff_cov_target = 40)
    Output
      <!-- covr2gh: do not delete/edit this line -->
      
      ## :safety_vest: Coverage summary
      
      ![badge](https://img.shields.io/badge/coverage-29%25-E4804E.svg)
      
      :yellow_circle: Merging PR [#3](https://github.com/dragosmg/covr2ghdemo/pull/3) ([`<removed-commit-sha>`](head_sha_url)) into _main_ ([`<removed-commit-sha>`](base_sha_url)) will **decrease** overall coverage by `3` percentage points.
      :red_circle:  Diff coverage is `28.6%` (`6` out of `21` modified lines are covered by tests). The minimum accepted coverage is `40%`.
      
      <details>
      <summary>Details</summary>
      
      ### Files with changes in coverage
      
      |File name   | Coverage head| Coverage base| &Delta; |              |
      |:-----------|-------------:|-------------:|:-------:|:------------:|
      |R/add_one.R |         33.3%|           40%|  -6.7   | :arrow_down: |
      |Overall     |         28.6%|         31.6%|  -3.0   | :arrow_down: |
      
      ### Coverage for modified lines
      
      |File name     | Lines modified| Lines tested| Coverage|Missing      |
      |:-------------|--------------:|------------:|--------:|:------------|
      |R/add_one.R   |              6|            2|    33.3%|13-16        |
      |R/add_three.R |              8|            0|       0%|12-15, 18-21 |
      |R/add_two.R   |              7|            4|    57.1%|13-15        |
      |Total         |             21|            6|    28.6%|             |
      </details>
      
      :recycle: Comment updated with the latest results.
      
      <sup>Created on <removed-date> with [covr2gh v<x.y.z>](https://dragosmg.github.io/covr2gh).</sup>

