test_that("new_name() works with no error", {
  board <- pins::board_temp()
  reuse(1, "old", board)
  expect_true(pins::pin_exists(board = board, "old"))

  none <- NA
  expect_error(new_name("old", "new"), none)
})

test_that("new_name() creates 'new' with no error ", {
  skip("First new_name() needs to gain the argument `board`")
  board <- pins::board_temp()
  reuse(1, "old", board)

  none <- NA
  expect_error(new_name("old", "new"), none)

  expect_true(pins::pin_exists(board = board, "new"))
})

test_that("new_name() takes a `board`", {
  board <- pins::board_temp()

  none <- NA
  expect_error(new_name("old", "new", board = board), none)
})
