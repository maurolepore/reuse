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

test_that("if x already exists in the board, it's reused not recomputed", {
  board <- pins::board_temp()
  one <- 1 |> reuse("one", board = board)
  two <- 2 |> reuse("one", board = board)
  expect_equal(two, 1)
})

test_that("defaults to using the cache of the reuse package", {
  on.exit(pins::pin_delete(board, "one"), add = TRUE, after = FALSE)

  reuse(1, "one")
  file <- fs::path(rappdirs::user_cache_dir("reuse"), "one.qs")
  board <- pins::board_folder(rappdirs::user_cache_dir("reuse"))
  expect_true(pins::pin_exists(board, "one"))
})

test_that("you can overwrite the cache with an option", {
  withr::local_options(list(reuse.overwrite = TRUE))
  one <- 1 |> reuse("one")
  two <- 2 |> reuse("one")
  expect_equal(two, 2)
})

test_that("you can overwrite the cache", {
  on.exit(pins::pin_delete(reuse_board(), "one"))
  one <- 1 |> reuse("one")
  two <- 2 |> reuse("one", overwrite = TRUE)
  expect_equal(two, 2)
})
