#' Reuse R objects
#'
#' @inheritParams pins::pin_write
#' @param update Logical. update the cache?
#'
#' @return The R object written to or read from the cache.
#' @export
#'
#' @examples
#' one <- 1 %>% reuse("one")
#' two <- 2 %>% reuse("one")
#' two
#'
#' two <- 2 %>% reuse("one", update = TRUE)
#' two
reuse <- function(x,
                  name,
                  board = board(),
                  type = "qs",
                  update = getOption("reuse.update", default = FALSE)) {
  if (update || !pins::pin_exists(board, name = name)) {
    pins::pin_write(board, x = x, name = name, type = type)
  }
  pins::pin_read(board, name = name)
}

#' @rdname reuse
#' @export
#' @examples
#' withr::local_options(list(reuse.board = pins::board_temp()))
#' board()
#'
#' pins::pin_exists(board(), name = "one")
#' 1 %>% reuse("one")
#' pins::pin_exists(board(), name = "one")
board_reuse <- function() {
  getOption(
    "reuse.board",
    default = pins::board_folder(rappdirs::user_cache_dir("reuse"))
  )
}
