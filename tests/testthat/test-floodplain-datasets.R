zero_range <- function(x, tol = .Machine$double.eps ^ 0.5) {
  if (length(x) == 1) return(TRUE)
  x <- range(x) / mean(x)
  isTRUE(all.equal(x[1], x[2], tolerance = tol))
}

column_names <- c("flow_cfs", "floodplain_acres", "watershed", "species")

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
  expect_true(zero_range(rows_of_each(yolo_bypass_floodplain)))
  expect_true(zero_range(rows_of_each(american_river_floodplain)))
  expect_true(zero_range(rows_of_each(north_delta_floodplain)))
  expect_true(zero_range(rows_of_each(calaveras_river_floodplain)))
  expect_true(zero_range(rows_of_each(san_joaquin_river_floodplain)))
  expect_true(zero_range(rows_of_each(stanislaus_river_floodplain)))
  expect_true(zero_range(rows_of_each(tuolumne_river_floodplain)))
  expect_true(zero_range(rows_of_each(cosumnes_river_floodplain)))
  expect_true(zero_range(rows_of_each(mokelumne_river_floodplain)))

})


test_that("all datasets have the correct colnames", {
  compare_colnames <- function(df) {
    sum(colnames(df) != column_names)
  }

  expect_equal(0, compare_colnames(cottonwood_creek_floodplain))
  expect_equal(0, compare_colnames(bear_river_floodplain))
  expect_equal(0, compare_colnames(big_chico_creek_floodplain))
  expect_equal(0, compare_colnames(butte_creek_floodplain))
  expect_equal(0, compare_colnames(yolo_bypass_floodplain))
  expect_equal(0, compare_colnames(american_river_floodplain))
  expect_equal(0, compare_colnames(north_delta_floodplain))
  expect_equal(0, compare_colnames(calaveras_river_floodplain))
  expect_equal(0, compare_colnames(san_joaquin_river_floodplain))
  expect_equal(0, compare_colnames(stanislaus_river_floodplain))
  expect_equal(0, compare_colnames(tuolumne_river_floodplain))
  expect_equal(0, compare_colnames(cosumnes_river_floodplain))
  expect_equal(0, compare_colnames(mokelumne_river_floodplain))

})
