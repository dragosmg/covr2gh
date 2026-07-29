# get_pr_details() works

    Code
      get_pr_details(repo = "dragosmg/covr2ghdemo", pr_number = 2)
    Output
      $repo
      [1] "dragosmg/covr2ghdemo"
      
      $pr_number
      [1] 2
      
      $is_fork
      [1] FALSE
      
      $head_name
      [1] "add_three"
      
      $head_sha
      [1] "b3b920fde4c4d14db76fd037ee6786df754d3412"
      
      $base_name
      [1] "main"
      
      $base_sha
      [1] "63e9463f904c5c079296dbbe3b8c285cf6d95653"
      
      $pr_html_url
      [1] "https://github.com/dragosmg/covr2ghdemo/pull/2"
      
      $diff_url
      [1] "https://github.com/dragosmg/covr2ghdemo/pull/2.diff"
      
      attr(,"class")
      [1] "covr2gh_pr_details"

# check_pr_details

    Code
      check_pr_details("foo")
    Condition
      Error:
      ! `"foo"` must be a covr2gh pr details object, not the string "foo".

---

    Code
      check_pr_details(1)
    Condition
      Error:
      ! `1` must be a covr2gh pr details object, not the number 1.

