# covr2gh

> Test Coverage Summary on ‘GitHub’

On a GitHub pull request, {covr2gh} runs {covr}’s `package_coverage()`
on both branches involved. It compares the two outputs, prepares a
summary and posts it as a comment. Coverage information is helpful when
reviewing a pull request.

## Installation

You can install the development version of {covr2gh} from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("dragosmg/covr2gh")
```

## Usage

You use it in a package. It comes with a helper function that generates
a GitHub action workflow. This also adds a badge to your Readme if it
can find the {usethis} badge “block” (`<!-- badges: start -->` and
`<!-- badges: end -->`).

``` r
covr2gh::use_covr2gh_action()
```
