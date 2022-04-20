test_that("creates 'new' with no error ", {
  board <- pins::board_temp()
  reuse(1, "old", board)

  none <- NA
  expect_error(new_name("old", "new", board), none)

  expect_true(pins::pin_exists(board = board, "new"))
})

test_that("takes a `board`", {
  board <- pins::board_temp()
  reuse(1, "old", board)
  none <- NA
  expect_error(new_name("old", "new", board = board), none)
})

test_that("deletes 'old' in the end with no error", {
  board <- pins::board_temp()
  reuse(1, "old", board)

  none <- NA
  expect_error(new_name("old", "new", board), none)

  expect_false(pins::pin_exists(board = board, "old"))
})

test_that("returns the object 'new'", {
  board <- pins::board_temp()
  x <- reuse(1, "old", board)
  out <- new_name("old", "new", board)
  expect_equal(out, x)
})
