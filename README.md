
<!-- README.md is generated from README.Rmd. Please edit that file -->

# reuse

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/maurolepore/reuse/branch/main/graph/badge.svg)](https://app.codecov.io/gh/maurolepore/reuse?branch=main)
<!-- badges: end -->

The goal of reuse is to avoid re-running slow computations, particularly
in pipes.

`reuse::reuse()` combines features of `pins::pin_read()` and
`pins::pin_write()` with some differences:

-   You can use it anywhere in a pipe.
-   You don’t have to specify the `board` explicitly.
-   You can update the cache inside `reuse()` or globally with
    `options()`.

## Installation

You can install the development version of reuse like so:

``` r
# install.packages("devtools")
devtools::install_github("maurolepore/reuse")
```

## Example

``` r
library(reuse)
```

-   Is plays well with the pipe.
-   It saves computations, reusing the cache if possible.

``` r
one <- 1 %>% reuse("one")
#> Creating new version '20220330T212355Z-4ebb2'
#> Writing to pin 'one'
two <- 2 %>% reuse("one")
two
#> [1] 1
```

-   You can update the cache for one call with the argument `update`.

``` r
two <- 2 %>% reuse("one", update = TRUE)
#> Replacing version '20220330T212355Z-4ebb2' with '20220330T212355Z-63a73'
#> Writing to pin 'one'
two
#> [1] 2
```

-   You can update the cache for one session with the option
    `reuse.update`.

``` r
options(reuse.update = TRUE)

three <- 3 %>% reuse("one")
#> Replacing version '20220330T212355Z-63a73' with '20220330T212355Z-f9a7c'
#> Writing to pin 'one'
three
#> [1] 3
```

-   The default cache folder uses the appropriate directory for Linux,
    Mac, and Windows, via the [rappdirs](https://rappdirs.r-lib.org/)
    package.

``` r
cache_dir <- rappdirs::user_cache_dir("reuse")
dir.exists(file.path(cache_dir, "one"))
#> [1] TRUE
```

-   It’s based on the [pins](https://pins.rstudio.com/) package, which
    you can use to manage your cache folder a.k.a. “board”.

``` r
library(pins)

board <- board_folder(cache_dir)
board %>% pin_meta("one")
#> List of 11
#>  $ file       : chr "one.qs"
#>  $ file_size  : 'fs_bytes' int 46
#>  $ pin_hash   : chr "f9a7c94233173a90"
#>  $ type       : chr "qs"
#>  $ title      : chr "one: a pinned double vector"
#>  $ description: NULL
#>  $ created    : POSIXct[1:1], format: "2022-03-30 18:23:00"
#>  $ api_version: num 1
#>  $ user       : list()
#>  $ name       : chr "one"
#>  $ local      :List of 3
#>   ..$ dir    : 'fs_path' chr "~/.cache/reuse/one/20220330T212355Z-f9a7c"
#>   ..$ url    : NULL
#>   ..$ version: chr "20220330T212355Z-f9a7c"

board %>% pin_delete("one")
```

-   You can use a custom cache folder with the argument `board`.

``` r
custom <- pins::board_folder(tempdir())
1 %>% reuse("abc", board = custom)
#> Creating new version '20220330T212355Z-4ebb2'
#> Writing to pin 'abc'
#> [1] 1

pins::pin_read(board = custom, "abc")
#> [1] 1
```

-   You can use a custom cache folder with the option `reuse.board`.

``` r
options(reuse.board = custom)
1 %>% reuse("def", board = custom)
#> Creating new version '20220330T212355Z-4ebb2'
#> Writing to pin 'def'
#> [1] 1

pins::pin_exists(board = custom, "def")
#> [1] TRUE
```
