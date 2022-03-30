#' Reuse R objects if possible
#'
#' @inheritParams pins::pin_write
#' @param overwrite Logical. Overwrite the cache?
#'
#' @return The R object written to or read from the cache.
#' @export
#'
#' @examples
#' one <- 1 %>% reuse("one")
#' two <- 2 %>% reuse("one")
#' two
#'
#' two <- 2 %>% reuse("one", overwrite = TRUE)
#' two
reuse <- function(x,
                  name,
                  board = pins::board_folder(rappdirs::user_cache_dir("reuse")),
                  overwrite = getOption("reuse.overwrite", default = FALSE)) {
  if (overwrite || !pins::pin_exists(board, name = name)) {
    pins::pin_write(board, x = x, name = name)
  }
  pins::pin_read(board, name = name)
}

reuse_board <- function() pins::board_folder(rappdirs::user_cache_dir("reuse"))
