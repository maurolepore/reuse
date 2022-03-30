test_that("is pipable", {
  out <- 1 %>% reuse("one", board = pins::board_temp())
  expect_equal(out, 1)
})

test_that("writes to a given folder", {
  board <- pins::board_temp()
  reuse(1, "one", board = board)
  expect_true(pins::pin_exists(board, "one"))
})

test_that("if x already exists in the board, it's reused not recomputed", {
  board <- pins::board_temp()
  one <- 1 %>% reuse("one", board = board)
  two <- 2 %>% reuse("one", board = board)
  expect_equal(two, 1)
})

test_that("defaults to using the cache of the reuse package", {
  withr::defer(pins::pin_delete(board, "one"))

  board <- pins::board_folder(rappdirs::user_cache_dir("reuse"))
  reuse(1, "one")
  expect_true(pins::pin_exists(board, "one"))
})

test_that("supports overwrite with an argument", {
  board <- pins::board_temp()
  one <- 1 %>% reuse("one", board = board)
  two <- 2 %>% reuse("one", board = board, overwrite = TRUE)
  expect_equal(two, 2)
})

test_that("supports overwrite with an option", {
  withr::local_options(list(reuse.overwrite = TRUE))

  board <- pins::board_temp()
  one <- 1 %>% reuse("one", board = board)
  two <- 2 %>% reuse("one", board = board)
  expect_equal(two, 2)
})
