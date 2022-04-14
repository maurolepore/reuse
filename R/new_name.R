new_name <- function(old, new, board) {

  board <- board

  old_name <- deparse(substitute(old))

  new_pin <- pins::pin_read(board, old_name)

  new_name <- deparse(substitute(new))

  new <- reuse(new_pin, new_name, board)

  test <- expect_true(pins::pin_exists(board = board, "new"))

  return(test)
}

