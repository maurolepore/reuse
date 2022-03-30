
<!-- README.md is generated from README.Rmd. Please edit that file -->

# reuse

<!-- badges: start -->
<!-- badges: end -->

The goal of reuse is to reuse R objects.

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

-   Is pipable.
-   It saves computations, reusing the cache if possible.

``` r
one <- 1 %>% reuse("one")
#> Guessing `type = 'rds'`
#> Creating new version '20220330T184203Z-10a5d'
#> Writing to pin 'one'
two <- 2 %>% reuse("one")
two
#> [1] 1
```

-   You can overwrite the cache for one call with the argument
    `overwrite`.

``` r
two <- 2 %>% reuse("one", overwrite = TRUE)
#> Guessing `type = 'rds'`
#> Replacing version '20220330T184203Z-10a5d' with '20220330T184203Z-30a9b'
#> Writing to pin 'one'
two
#> [1] 2
```

-   You can overwrite the cache for one session with the option
    `reuse.overwrite`.

``` r
options(reuse.overwrite = TRUE)

three <- 3 %>% reuse("one")
#> Guessing `type = 'rds'`
#> Replacing version '20220330T184203Z-30a9b' with '20220330T184203Z-30ea3'
#> Writing to pin 'one'
three
#> [1] 3
```

-   By default it uses the appropriate directory for Linux, Mac, and
    Windows, via the [rappdirs](https://rappdirs.r-lib.org/) package.

``` r
cache_dir <- rappdirs::user_cache_dir("reuse")
list.files(cache_dir)
#> [1] "one"
```

-   It’s based on the [pins](https://pins.rstudio.com/) package, which
    you can use to manage your cached objects.

``` r
library(pins)
pin_delete(board = board_folder(cache_dir), names = "one")
list.files(cache_dir)
#> character(0)
```
