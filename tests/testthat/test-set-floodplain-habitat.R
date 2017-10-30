test_that("known flows are mapped to correct habitat value", {

  df_value_at_flow <- function(d, col, flow) {
    d[d$flow_cfs == flow, col][[1]]/0.000247105
  }

  #American River
  expect_equal(set_floodplain_habitat("American River", "fr", 200),
               df_value_at_flow(american_river_floodplain, 2, 200))
  expect_equal(set_floodplain_habitat("American River", "st", 200),
               df_value_at_flow(american_river_floodplain, 3, 200))
  expect_equal(set_floodplain_habitat("American River", "fr", 11200),
               df_value_at_flow(american_river_floodplain, 2, 11200))
  expect_equal(set_floodplain_habitat("American River", "st", 11200),
               df_value_at_flow(american_river_floodplain, 3, 11200))

  #Bear River
  expect_equal(set_floodplain_habitat("Bear River", "fr", 10),
               df_value_at_flow(bear_river_floodplain, 2, 10))
  expect_equal(set_floodplain_habitat("Bear River", "st", 10),
               df_value_at_flow(bear_river_floodplain, 3, 10))
})

test_that("interpolated values are within a reasonable epsilon", {

  are_within_epsilon <- function(watershed, epsilon = 5) {
    test_df <- dplyr::filter(test_floodplain_df, Watershed == watershed)
    test_flow <- test_df$two_yr_14d_flow
    target_value <- test_df$existing_fp_acres/0.000247105
    approx_value <- set_floodplain_habitat(watershed, "fr", test_flow)

    all.equal(target_value, approx_value, tolerance = epsilon)
  }

  expect_true(are_within_epsilon("American River"))

  expect_true(are_within_epsilon("Bear River"))

  expect_true(are_within_epsilon("Big Chico Creek"))

})

