test_that("cell freq", {
  cells_true <- as.vector(table(df))
  cells_app <- c(n_exposure1_outcome1,n_exposure1_outcome0,n_exposure0_outcome1,n_exposure0_outcome0)
  expect_setequal(cells_true, cells_app)
})