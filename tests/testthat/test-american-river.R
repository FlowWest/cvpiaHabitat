library(cvpiaHabitat)
context('American River Habitat')

test_that("modeling of species coverage hasn't changed since v2.0 - American", {
  modeling <- cvpiaHabitat::modeling_exist %>%
    filter(Watershed == "American River")
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
  expect_equal(modeling$ST_adult, FALSE)
})

test_that('FR fry American River works', {
  # flow 300
  wua <- cvpiaHabitat::american_river_instream$FR_fry_wua[6]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[cvpiaHabitat::watershed_lengths$watershed == "American River" &
                                                     cvpiaHabitat::watershed_lengths$lifestage == "rearing",
                                                   "feet"])

  x <- (((stream_length/1000) * wua)/10.7639)

  flow <- cvpiaHabitat::american_river_instream$flow_cfs[6]
  expect_equal(
    set_instream_habitat('American River', 'fr', 'fry', flow), x)

})

test_that('FR juv American River works', {
  # flow 300
  wua <- cvpiaHabitat::american_river_instream$FR_juv_wua[6]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[cvpiaHabitat::watershed_lengths$watershed == "American River" &
                                                     cvpiaHabitat::watershed_lengths$lifestage == "rearing",
                                                   "feet"])

  x <- (((stream_length/1000) * wua)/10.7639)

  flow <- cvpiaHabitat::american_river_instream$flow_cfs[6]
  expect_equal(
    set_instream_habitat('American River', 'fr', 'juv', flow), x)

})

test_that('FR spawn American River works', {
  # flow 300
  wua <- cvpiaHabitat::american_river_instream$FR_spawn_wua[6]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[cvpiaHabitat::watershed_lengths$watershed == "American River" &
                                                     cvpiaHabitat::watershed_lengths$lifestage == "spawning",
                                                   "feet"])

  x <- (((stream_length/1000) * wua)/10.7639)

  flow <- cvpiaHabitat::american_river_instream$flow_cfs[6]
  expect_equal(
    set_spawning_habitat('American River', 'fr', flow), x)

})

test_that('ST spawn American River works', {
  # flow 300
  wua <- cvpiaHabitat::american_river_instream$ST_spawn_wua[6]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[cvpiaHabitat::watershed_lengths$watershed == "American River" &
                                                     cvpiaHabitat::watershed_lengths$lifestage == "spawning",
                                                   "feet"])

  x <- (((stream_length/1000) * wua)/10.7639)

  flow <- cvpiaHabitat::american_river_instream$flow_cfs[6]
  expect_equal(
    set_spawning_habitat('American River', 'st', flow), x)

})
