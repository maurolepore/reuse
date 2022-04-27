#' Rename an R object you're reusing
#'
#' @inheritParams reuse
#' @param old,new String. The name of the old and new objects.
#'
#' @return The object stored as 'new'.
#' @export
#'
#' @examples
#' library(pins)
#'
#' board <- board_temp()
#' x <- 1
#'
#' x %>% reuse("old", board)
#' pin_exists("old", board = board)
#'
#' "old" %>% new_name("new", board)
#' pin_exists("old", board = board)
#' pin_exists("new", board = board)
new_name <- function(old, new, board = reuse::board()) {
  new_pin <- pins::pin_read(board = board, old)
  new <- reuse(new_pin, new, board)

  pins::pin_delete(board, old)

  invisible(new)
}
