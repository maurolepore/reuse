test_that("takes a custom `board`", {
  board <- pins::board_temp()
  reuse(1, "old", board)
  expect_no_error(new_name("old", "new", board = board))
})

test_that("uses a default board", {
  default <- board()
  withr::defer(pins::pin_delete(default, "new"))

  reuse(1, "old")
  new_name("old", "new")

  expect_false(pins::pin_exists(default, "old"))
  expect_true(pins::pin_exists(default, "new"))
})

test_that("replaces the old name with the new name", {
  board <- pins::board_temp()
  x <- 1
  reuse(x, "old", board)

  out <- new_name("old", "new", board)
  expect_false(pins::pin_exists(board = board, "old"))
  expect_true(pins::pin_exists(board = board, "new"))
  expect_equal(out, x)
})
