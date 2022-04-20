new_name <- function(old, new, board) {
  new_pin <- pins::pin_read(board, old)
  new <- reuse(new_pin, new, board)

  pins::pin_delete(board, old)

  invisible(new)
}
