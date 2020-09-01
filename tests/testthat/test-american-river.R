library(cvpiaHabitat)
context('American River Habitat')

test_that("modeling of species coverage hasn't changed since v2.0 - American", {
  modeling <- subset(cvpiaHabitat::modeling_exist, Watershed == 'American River')

  expect_equal(modeling$FR_spawn, TRUE)
  expect_equal(modeling$FR_fry, TRUE)
  expect_equal(modeling$FR_juv, TRUE)
  expect_equal(modeling$FR_floodplain, TRUE)

  expect_equal(is.na(modeling$SR_spawn), TRUE)
  expect_equal(is.na(modeling$SR_fry), TRUE)
  expect_equal(is.na(modeling$SR_juv), TRUE)
  expect_equal(is.na(modeling$SR_floodplain), TRUE)

  expect_equal(modeling$ST_spawn, TRUE)
  expect_equal(modeling$ST_fry, FALSE)
  expect_equal(modeling$ST_juv, FALSE)
  expect_equal(modeling$ST_floodplain, TRUE)
  expect_equal(modeling$ST_adult, FALSE)
})

test_that('FR rearing American River works', {
  # flow 300

  first_not_na_habitat_index1 <- which(!is.na(cvpiaHabitat::american_river_instream$FR_fry_wua))[1]
  first_not_na_habitat_index2 <- which(!is.na(cvpiaHabitat::american_river_instream$FR_juv_wua))[1]

  wua1 <- cvpiaHabitat::american_river_instream$FR_fry_wua[first_not_na_habitat_index1]
  wua2 <- cvpiaHabitat::american_river_instream$FR_juv_wua[first_not_na_habitat_index2]

  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'American River' & lifestage == 'rearing'
                          & species == 'fr')$feet

  x1 <- (((stream_length/1000) * wua1)/10.7639)
  x2 <- (((stream_length/1000) * wua2)/10.7639)

  flow1 <- cvpiaHabitat::american_river_instream$flow_cfs[first_not_na_habitat_index1]
  flow2 <- cvpiaHabitat::american_river_instream$flow_cfs[first_not_na_habitat_index2]

  expect_equal(
    set_instream_habitat('American River', 'fr', 'fry', flow1), x1)
  expect_equal(
    set_instream_habitat('American River', 'fr', 'juv', flow2), x2)

})


test_that('FR spawn American River works', {
  # flow 300
  first_not_na_habitat_index <- which(!is.na(cvpiaHabitat::american_river_instream$FR_spawn_wua))[1]

  wua = cvpiaHabitat::american_river_instream$FR_spawn_wua[first_not_na_habitat_index]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'American River' & lifestage == 'spawning'
                          & species == 'fr')$feet

  x <- (((stream_length/1000) * wua)/10.7639)

  flow <- cvpiaHabitat::american_river_instream$flow_cfs[first_not_na_habitat_index]
  expect_equal(
    set_spawning_habitat('American River', 'fr', flow), x)

})

test_that('ST spawn American River works', {
  # flow 300
  first_not_na_habitat_index <- which(!is.na(cvpiaHabitat::american_river_instream$ST_spawn_wua))[1]

  wua <- cvpiaHabitat::american_river_instream$ST_spawn_wua[first_not_na_habitat_index]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[cvpiaHabitat::watershed_lengths$watershed == "American River" &
                                                     cvpiaHabitat::watershed_lengths$lifestage == "spawning",
                                                   "feet"])

  x <- (((stream_length/1000) * wua)/10.7639)

  flow <- cvpiaHabitat::american_river_instream$flow_cfs[first_not_na_habitat_index]
  expect_equal(
    set_spawning_habitat('American River', 'st', flow), x)

})

test_that('FR floodplain American works', {
  first_flood_index <-  which(cvpiaHabitat::american_river_floodplain$FR_floodplain_acres > 0)[1]

  flow <- cvpiaHabitat::american_river_floodplain$flow_cfs[first_flood_index]
  floodplain <- subset(cvpiaHabitat::american_river_floodplain,flow_cfs == flow)$FR_floodplain_acres

  expect_equal(
    square_meters_to_acres(set_floodplain_habitat('American River', 'fr', flow)),
    floodplain,
    tolerance = .01)
})
