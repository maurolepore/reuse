#' Reuse R objects
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
                  board = board_reuse(),
                  type = "qs",
                  overwrite = getOption("reuse.overwrite", default = FALSE)) {
  if (overwrite || !pins::pin_exists(board, name = name)) {
    pins::pin_write(board, x = x, name = name, type = type)
  }
  pins::pin_read(board, name = name)
}

#' @rdname reuse
#' @examples
#' withr::local_options(list(reuse.board = pins::board_temp()))
#' board_reuse()
#'
#' pins::pin_exists(board_reuse(), name = "one")
#' 1 %>% reuse("one")
#' pins::pin_exists(board_reuse(), name = "one")
board_reuse <- function() {
  getOption(
    "reuse.board",
    default = pins::board_folder(rappdirs::user_cache_dir("reuse"))
  )
}
