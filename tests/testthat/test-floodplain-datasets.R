zero_range <- function(x, tol = .Machine$double.eps ^ 0.5) {
  if (length(x) == 1) return(TRUE)
  x <- range(x) / mean(x)
  isTRUE(all.equal(x[1], x[2], tolerance = tol))
}

test_that("datasets have equal length for each species", {
  rows_of_each <- function(df) {
    df %>% dplyr::group_by(species) %>%
      dplyr::summarise(total = n()) %>%
      dplyr::pull(total)
  }

  expect_true(zero_range(rows_of_each(bear_river_floodplain)))
  expect_true(zero_range(rows_of_each(big_chico_creek_floodplain)))
  expect_true(zero_range(rows_of_each(cottonwood_creek_floodplain)))
  expect_true(zero_range(rows_of_each(butte_creek_floodplain)))
  expect_true(zero_range(rows_of_each(cottonwood_creek_floodplain)))
  expect_true(zero_range(rows_of_each(deer_creek_floodplain)))
  expect_true(zero_range(rows_of_each(feather_river_floodplain)))
  expect_true(zero_range(rows_of_each(yuba_river_floodplain)))
})
