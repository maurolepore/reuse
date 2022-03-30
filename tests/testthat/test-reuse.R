test_that("is pipable", {
  data <- datasets::BOD
  expect_equal(reuse(data, "data"), data)
})
