# TODO

This text is not a task.

## Bugs

- [ ] line numbers seem to be off. in multigrain it was 1 or 2 lines off.
- [ ] update the wording
    - [ ] "lines added" -> "lines modified". speak of changed (modified) lines not added lines. codecov calls them "modified and coverable".
- [ ] weird behaviour: old (running) checks pick-up the most recent commit and report on it. the comment references a commit for which the checks have not yet finished. I have no idea which version of the repo is being used (probably the most recent one). this could potentially result in duplicated runs. this is an issue for multigrain where runs take > 10 minutes.

## Improvements

And this text neither.

- [ ] Switch to a traffic light system
    - [ ] And it has a subtask!
- [ ] Change the marker to `<!-- covr2gh: do not delete/edit this line -->`
- [ ] "this pr does not contain changes to files that would impact coverage"
    - [ ] the workflow should not run when there are no changes to relevant files, or
    - [ ] the workflow runs, but the output reflects the state and there is no need to compare head and base (basically, exit early)

## Performance

- [ ] cache the covr object for the most recent commit in main

## Storage

- [ ] decide where to store the cache. `gh-pages`?
- [ ] decide where to store the badge. `gh-pages`? (maybe the pkgdown site will find it)

# BACKLOG

- [ ] This task is postponed

# DONE

- [x] This task is done #prio1
- [-] This task has been declined
