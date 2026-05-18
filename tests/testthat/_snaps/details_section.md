# compose_details_section works

    Code
      compose_details_section(file_cov_delta = file_coverage_delta, line_cov_delta = line_coverage_delta)
    Output
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
      |R/add_two.R   |              1|            1|     100%|             |
      |Total         |             15|            3|      20%|             |
      </details>

---

    Code
      compose_details_section(file_cov_delta = file_coverage_delta, line_cov_delta = "foo")
    Condition
      Error:
      ! `line_cov_delta` must be a data frame or `NULL`, not the string "foo".

---

    Code
      compose_details_section(file_cov_delta = file_coverage_delta, line_cov_delta = NULL)
    Output
      <details>
      <summary>Details</summary>
      
      ### Files with changes in coverage
      
      |File name   | Coverage head| Coverage base| &Delta; |              |
      |:-----------|-------------:|-------------:|:-------:|:------------:|
      |R/add_one.R |         33.3%|           40%|  -6.7   | :arrow_down: |
      |Overall     |         28.6%|         31.6%|  -3.0   | :arrow_down: |
      
      
      
      
      </details>

---

    Code
      compose_details_section(file_cov_delta = NULL, line_cov_delta = line_coverage_delta)
    Output
      

