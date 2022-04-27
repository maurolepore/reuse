test_that("it plays well with the pipe", {
  out <- 1 %>% reuse("one", board = pins::board_temp())
  expect_equal(out, 1)
})

test_that("by default uses board_reuse()", {
  default <- board_reuse()
  withr::defer(pins::pin_delete(default, "one"))
  reuse(1, "one")
  expect_true(pins::pin_exists(default, "one"))
})

test_that("writes to a custom board with an argument", {
  default <- reuse::board_reuse()
  custom <- pins::board_temp()

  reuse(1, "one", board = custom)
  expect_false(pins::pin_exists(default, "one"))
  expect_true(pins::pin_exists(custom, "one"))
})

test_that("writes to a custom board with an option", {
  custom <- pins::board_temp()
  withr::local_options(list(reuse.board = custom))

  reuse(1, "one")
  expect_true(pins::pin_exists(custom, "one"))
})

test_that("if x already exists in the board, it's reused not recomputed", {
  board <- pins::board_temp()
  one <- 1 %>% reuse("one", board = board)
  two <- 2 %>% reuse("one", board = board)
  expect_equal(two, 1)
})

test_that("updates an object with an argument", {
  board <- pins::board_temp()
  one <- 1 %>% reuse("one", board = board)
  two <- 2 %>% reuse("one", board = board, update = TRUE)
  expect_equal(two, 2)
})

test_that("updates an object with an option", {
  withr::local_options(list(reuse.update = TRUE))
  board <- pins::board_temp()
  one <- 1 %>% reuse("one", board = board)
  two <- 2 %>% reuse("one", board = board)
  expect_equal(two, 2)
})

test_that("by default saves files as .qs", {
  board <- pins::board_temp()

  reuse(1, "one", board = board)
  type <- pins::pin_meta(board = board, "one")$type
  expect_equal(type, "qs")
})
