library(cvpiaHabitat)
context('Lower Sacramento Habitat')

test_that("modeling of species coverage hasn't changed since v2.0 - Lower Sac", {
  modeling <- subset(cvpiaHabitat::modeling_exist, Watershed == 'Lower Sacramento River')

  expect_equal(is.na(modeling$FR_spawn), TRUE)
  expect_equal(modeling$FR_fry, FALSE)
  expect_equal(modeling$FR_juv, FALSE)
  expect_equal(modeling$FR_floodplain, FALSE)

  expect_equal(is.na(modeling$SR_spawn), TRUE)
  expect_equal(modeling$SR_fry, FALSE)
  expect_equal(modeling$SR_juv, FALSE)
  expect_equal(modeling$SR_floodplain, FALSE)

  expect_equal(is.na(modeling$WR_spawn), TRUE)
  expect_equal(modeling$WR_fry, FALSE)
  expect_equal(modeling$WR_juv, TRUE)
  expect_equal(modeling$WR_floodplain, TRUE)

  expect_equal(is.na(modeling$ST_spawn), TRUE)
  expect_equal(modeling$ST_fry, FALSE)
  expect_equal(modeling$ST_juv, FALSE)
  expect_equal(modeling$ST_floodplain, FALSE)
  expect_equal(modeling$ST_adult, FALSE)
})

test_that('FR juv Lower Sac River works', {

  flow1 <- cvpiaHabitat::lower_sacramento_river_instream$flow_cfs[1]

  expect_equal(
    set_instream_habitat(watershed = 'Lower Sacramento River',
                         species = 'fr', life_stage = 'juv',
                         flow = flow1),
    cvpiaHabitat::lower_sacramento_river_instream$rearing_sq_meters[1])

})

test_that('FR floodplain Lower Sac River works', {
  first_flood_index <-  which(cvpiaHabitat::lower_sacramento_river_floodplain$floodplain_sq_meters > 0)[1]

  flow <- cvpiaHabitat::lower_sacramento_river_floodplain$flow_cfs[first_flood_index]
  floodplain <- subset(cvpiaHabitat::lower_sacramento_river_floodplain,flow_cfs == flow)$floodplain_sq_meters

  expect_equal(
    set_floodplain_habitat('Lower Sacramento River', 'fr', flow),
    floodplain,
    tolerance = .01)
})
