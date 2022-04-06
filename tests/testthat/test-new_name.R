test_that("new_name() works with no error", {
  board <- pins::board_temp()
  reuse(1, "old", board)
  expect_true(pins::pin_exists(board = board, "old"))

  none <- NA
  expect_error(new_name("old", "new"), none)
})
