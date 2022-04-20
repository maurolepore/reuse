#' Title
#'
#' @inheritParams reuse
#' @param old String. The name of the old object.
#' @param new String. The name of the new object.
#'
#' @return The object stored as 'new'.
#' @export
#'
#' @examples
#' board <- pins::board_temp()
#' reuse(1, "old", board)
#' new_name("old", "new", board)
#' reuse(name = "new")
new_name <- function(old, new, board) {
  new_pin <- pins::pin_read(board, old)
  new <- reuse(new_pin, new, board)

  pins::pin_delete(board, old)

  invisible(new)
}
