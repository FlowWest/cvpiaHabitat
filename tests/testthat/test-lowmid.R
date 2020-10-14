library(cvpiaHabitat)
context('Lower-mid Sacramento Habitat')

test_that("modeling of species coverage hasn't changed - Lower mid Sac", {
  modeling <- subset(cvpiaHabitat::modeling_exist, Watershed == 'Lower-mid Sacramento River')

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

test_that('FR fry Lower Sac works', {

  flow1 <- cvpiaHabitat::lower_mid_sacramento_river_instream$flow_cfs[5]
  flow2 <- cvpiaHabitat::lower_mid_sacramento_river_instream$flow_cfs[4]

  expect_equal(
    set_instream_habitat(watershed = 'Lower-mid Sacramento River',
                         species = 'fr', life_stage = 'fry',
                         flow = flow1, flow2 = flow2),
    35.6/58 * cvpiaHabitat::lower_mid_sacramento_river_instream$rearing_sq_meters[5] +
      22.4/58 * cvpiaHabitat::lower_mid_sacramento_river_instream$rearing_sq_meters[4])
})

test_that('FR juv Lower-mid Sac works', {

  flow1 <- cvpiaHabitat::lower_mid_sacramento_river_instream$flow_cfs[5]
  flow2 <- cvpiaHabitat::lower_mid_sacramento_river_instream$flow_cfs[4]

  expect_equal(
    set_instream_habitat(watershed = 'Lower-mid Sacramento River',
                         species = 'fr', life_stage = 'juv',
                         flow = flow1, flow2 = flow2),
    35.6/58 * cvpiaHabitat::lower_mid_sacramento_river_instream$rearing_sq_meters[5] +
      22.4/58 * cvpiaHabitat::lower_mid_sacramento_river_instream$rearing_sq_meters[4])

})


test_that('FR floodplain Lower-mid Sac works', {

  flow1 <- cvpiaHabitat::lower_mid_sacramento_river_floodplain$flow_cfs[5]
  flow2 <- cvpiaHabitat::lower_mid_sacramento_river_floodplain$flow_cfs[4]

  expect_equal(
    set_floodplain_habitat('Lower-mid Sacramento River', 'fr', flow = flow1, flow2 = flow2),
    35.6/58 * cvpiaHabitat::lower_mid_sacramento_river_floodplain$floodplain_sq_meters[5] +
      22.4/58 * cvpiaHabitat::lower_mid_sacramento_river_floodplain$floodplain_sq_meters[4],
    tolerance = .01)
})

test_that('SR floodplain Lower-mid Sac works', {

  flow1 <- cvpiaHabitat::lower_mid_sacramento_river_floodplain$flow_cfs[5]
  flow2 <- cvpiaHabitat::lower_mid_sacramento_river_floodplain$flow_cfs[4]

  expect_equal(
    set_floodplain_habitat('Lower-mid Sacramento River', 'sr', flow = flow1, flow2 = flow2),
    35.6/58 * cvpiaHabitat::lower_mid_sacramento_river_floodplain$floodplain_sq_meters[5] +
      22.4/58 * cvpiaHabitat::lower_mid_sacramento_river_floodplain$floodplain_sq_meters[4],
    tolerance = .01)
})
