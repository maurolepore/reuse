test_that("takes a custom `board`", {
  board <- pins::board_temp()
  reuse(1, "old", board)
  expect_no_error(new_name("old", "new", board = board))
})

# TODO: Tests it uses a default board board_reuse()

test_that("deletes 'old' in the end with no error", {
  board <- pins::board_temp()
  reuse(1, "old", board)


  expect_no_error(new_name("old", "new", board))

  expect_false(pins::pin_exists(board = board, "old"))
})

test_that("returns the object 'new'", {
  board <- pins::board_temp()
  x <- reuse(1, "old", board)
  out <- new_name("old", "new", board)
  expect_equal(out, x)
})
