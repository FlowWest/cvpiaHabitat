library(cvpiaHabitat)
context('Big Chico Creek Habitat')

test_that("modeling of species coverage hasn't changed - Big Chico", {
  modeling <- subset(cvpiaHabitat::modeling_exist, Watershed == 'Big Chico Creek')

  expect_equal(modeling$FR_spawn, FALSE)
  expect_equal(modeling$FR_fry, FALSE)
  expect_equal(modeling$FR_juv, FALSE)
  expect_equal(modeling$FR_floodplain, TRUE)

  expect_equal(modeling$SR_spawn, FALSE)
  expect_equal(modeling$SR_fry, FALSE)
  expect_equal(modeling$SR_juv, FALSE)
  expect_equal(modeling$SR_floodplain, FALSE)

  expect_equal(modeling$ST_spawn, FALSE)
  expect_equal(modeling$ST_fry, FALSE)
  expect_equal(modeling$ST_juv, FALSE)
  expect_equal(modeling$ST_floodplain, FALSE)
  expect_equal(modeling$ST_adult, FALSE)
})

test_that('FR floodplain Big Chico Creek works', {
  first_flood_index <-  which(cvpiaHabitat::big_chico_creek_floodplain$FR_floodplain_acres > 0)[1]

  flow <- cvpiaHabitat::big_chico_creek_floodplain$flow_cfs[first_flood_index]
  floodplain <- subset(cvpiaHabitat::big_chico_creek_floodplain,flow_cfs == flow)$FR_floodplain_acres

  expect_equal(
    square_meters_to_acres(set_floodplain_habitat('Big Chico Creek', 'fr', flow)),
    floodplain,
    tolerance = .01)
})
