# get_diff_content works

    Code
      get_diff_content(pr_details = pr_details)
    Output
      $`R/add_one.R`
      [1] "@@ -9,10 +9,11 @@\n #' add_one(2)\n #' add_one(4)\n add_one <- function(x) {\n-  if (!rlang::is_double(x)) {\n-    cli::cli_abort(\n-      \"`x` must be numeric. You supplied a {.class {class(x)}}\"\n-    )\n-  }\n-  x + 1\n+    if (!is.numeric(x)) {\n+        cli::cli_abort(\n+            \"`x` must be numeric. You supplied a {.class {class(x)}}\",\n+            call = rlang::caller_env()\n+        )\n+    }\n+    x + 1\n }"
      
      $`R/add_three.R`
      [1] "@@ -9,13 +9,14 @@\n #' add_three(2)\n #' add_three(4)\n add_three <- function(x) {\n-  if (!rlang::is_double(x)) {\n-    cli::cli_abort(\n-      \"`x` must be numeric. You supplied a {.class {class(x)}}\"\n-    )\n-  }\n+    if (!is.numeric(x)) {\n+        cli::cli_abort(\n+            \"`x` must be numeric. You supplied a {.class {class(x)}}\"\n+        )\n+    }\n \n-  x |>\n-    add_two() |>\n-    add_one()\n+    x |>\n+        add_one() |>\n+        add_one() |>\n+        add_one()\n }"
      
      $`R/add_two.R`
      [1] "@@ -9,13 +9,13 @@\n #' add_two(2)\n #' add_two(4)\n add_two <- function(x) {\n-  if (!rlang::is_double(x)) {\n-    cli::cli_abort(\n-      \"`x` must be numeric. You supplied a {.class {class(x)}}\"\n-    )\n-  }\n+    if (!is.numeric(x)) {\n+        cli::cli_abort(\n+            \"`x` must be numeric. You supplied a {.class {class(x)}}\"\n+        )\n+    }\n \n-  x |>\n-    add_one() |>\n-    add_one()\n+    x |>\n+        add_one() |>\n+        add_one()\n }"
      
      attr(,"class")
      [1] "covr2gh_diff_content"

# check_diff_content

    Code
      check_diff_content("foo")
    Condition
      Error:
      ! `"foo"` must be a covr2gh diff content object, not the string "foo".

---

    Code
      check_diff_content(1)
    Condition
      Error:
      ! `1` must be a covr2gh diff content object, not the number 1.

