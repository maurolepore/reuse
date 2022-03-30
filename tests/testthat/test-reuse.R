test_that("is pipable", {
  board <- pins::board_temp()
  data <- datasets::BOD
  out <- data |> reuse("data", board = board)
  expect_equal(out, data)
})

test_that("writes to a given folder", {
  board <- pins::board_temp()
  data <- datasets::BOD
  reuse(data, "data", board = board)
  expect_true(pins::pin_exists(board, "data"))
})
