# line_cov_to_md works

    Code
      line_cov_to_md(tibble::tibble(file = c("foo.R", "bar.R", "baz.R"), lines_added = c(
        5, 4, 10), lines_covered = c(2, 4, 6), which_lines = c("1-4, 8", "5-8",
        "1-5, 8-10, 15, 16")))
    Output
      |  File| Lines added| Lines tested| Coverage|Which lines       |
      |-----:|-----------:|------------:|--------:|:-----------------|
      | foo.R|           5|            2|      40%|1-4, 8            |
      | bar.R|           4|            4|     100%|5-8               |
      | baz.R|          10|            6|      60%|1-5, 8-10, 15, 16 |
      | Total|          19|           12|   63.16%|                  |

# line_cov_loss_to_md

    Code
      line_cov_loss_to_md(tibble::tibble(file = "R/badge.R", lines_loss_cov = 6L,
        which_lines = "87-89, 92, 93, 96"))
    Output
      |      File| Lines w/ coverage loss|Which lines       |
      |---------:|----------------------:|:-----------------|
      | R/badge.R|                      6|87-89, 92, 93, 96 |
      |     Total|                      6|                  |

