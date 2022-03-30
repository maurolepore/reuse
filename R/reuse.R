reuse <- function(x, name, board) {
  pins::pin_write(board, x, name)
  x
}
