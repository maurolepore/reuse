test_that("is pipable", {
  board <- pins::board_temp()
  x <- 1
  out <- x |> reuse("one", board = board)
  expect_equal(out, x)
})

test_that("writes to a given folder", {
  board <- pins::board_temp()
  x <- 1
  reuse(x, "one", board = board)
  expect_true(pins::pin_exists(board, "one"))
})

test_that("if x exists in the board, it's reused not recomputed", {
  board <- pins::board_temp()
  x <- 1
  x |> reuse("one", board = board)
  pins::pin_read(board, "one")

  x <- 2
  one <- x |> reuse("one", board = board)

  expect_equal(one, 1)
  expect_equal(pins::pin_read(board, "one"), 1)
})
