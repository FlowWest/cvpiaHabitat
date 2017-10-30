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
  floodplain_value_at_flow <- function(w, flow) {
    df <- dplyr::filter(test_floodplain_df, Watershed == w, two_yr_14d_flow == flow)
    dplyr::pull(df, 4)/0.000247105
  }

  expect_true(all.equal(set_floodplain_habitat("American River", "fr", 5570),
                        floodplain_value_at_flow("American River", 5570), tolerance=5))

  expect_true(all.equal(set_floodplain_habitat("Bear River", "fr", 927),
                        floodplain_value_at_flow("Bear River", 927), tolerance=5))

  expect_true(all.equal(set_floodplain_habitat("Big Chico Creek", "fr", 336),
                        floodplain_value_at_flow("Big Chico Creek", 336), tolerance=5))

})

