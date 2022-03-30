reuse <- function(x, name, board) {
  if (!pins::pin_exists(board, name = name)) {
    pins::pin_write(board, x = x, name = name)
  }
  pins::pin_read(board, name = name)
}
