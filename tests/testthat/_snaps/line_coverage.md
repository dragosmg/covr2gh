# compose_line_coverage_details with df

    Code
      compose_line_coverage_details(line_cov)
    Output
      ### Coverage for added lines
      
      |    File| Lines added| Lines tested| Coverage|
      |-------:|-----------:|------------:|--------:|
      | R/foo.R|           5|            2|      40%|
      | R/bar.R|           4|            4|     100%|
      | R/baz.R|          10|            6|      60%|
      |   Total|          19|           12|   63.16%|

# compose_line_coverage_summary works

    Code
      compose_line_coverage_summary(NULL)
    Output
      [1] ":heavy_equals_sign: Diff coverage: No lines added to relevant files."

---

    Code
      compose_line_coverage_summary(line_cov)
    Output
      :x:  Diff coverage: 63.16% (12 out of 19 added lines are covered by tests). Target coverage is at least `80%`.

---

    Code
      compose_line_coverage_summary(line_cov, target = 40)
    Output
      :white_check_mark:  Diff coverage: 63.16% (12 out of 19 added lines are covered by tests). Target coverage is at least `40%`.

