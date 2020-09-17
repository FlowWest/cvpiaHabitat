library(cvpiaHabitat)
context('Stanislaus River Habitat')

test_that("modeling of species coverage hasn't changed since v2.0 - Stanislaus", {
  modeling <- subset(cvpiaHabitat::modeling_exist, Watershed == 'Stanislaus River')

  expect_equal(modeling$FR_spawn, TRUE)
  expect_equal(modeling$FR_fry, TRUE)
  expect_equal(modeling$FR_juv, TRUE)
  expect_equal(modeling$FR_floodplain, TRUE)

  expect_equal(modeling$SR_spawn, FALSE)
  expect_equal(modeling$SR_fry, FALSE)
  expect_equal(modeling$SR_juv, FALSE)
  expect_equal(modeling$SR_floodplain, FALSE)

  expect_equal(modeling$ST_spawn, FALSE)
  expect_equal(modeling$ST_fry, TRUE)
  expect_equal(modeling$ST_juv, TRUE)
  expect_equal(modeling$ST_floodplain, FALSE)
  expect_equal(modeling$ST_adult, FALSE)
})

test_that('FR instream Stanislaus River works', {

  fry_not_na_index <- which(!is.na(cvpiaHabitat::stanislaus_river_instream$FR_fry_wua))[1]
  juv_not_na_index <- which(!is.na(cvpiaHabitat::stanislaus_river_instream$FR_juv_wua))[1]
  spawn_not_na_index <- which(!is.na(cvpiaHabitat::stanislaus_river_instream$FR_spawn_wua))[1]

  fry_wua <- cvpiaHabitat::stanislaus_river_instream$FR_fry_wua[fry_not_na_index]
  juv_wua <- cvpiaHabitat::stanislaus_river_instream$FR_juv_wua[juv_not_na_index]
  spawn_wua <- cvpiaHabitat::stanislaus_river_instream$FR_spawn_wua[spawn_not_na_index]

  rearing_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                  watershed == 'Stanislaus River' & lifestage == 'rearing'
                                  & species == 'fr')$feet
  spawning_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                   watershed == 'Stanislaus River' & lifestage == 'spawning'
                                   & species == 'fr')$feet

  fryx <- (((rearing_stream_length/1000) * fry_wua)/10.7639)
  juvx <- (((rearing_stream_length/1000) * juv_wua)/10.7639)
  spawnx <- (((spawning_stream_length/1000) * spawn_wua)/10.7639)

  fry_flow <- cvpiaHabitat::stanislaus_river_instream$flow_cfs[fry_not_na_index]
  juv_flow <- cvpiaHabitat::stanislaus_river_instream$flow_cfs[juv_not_na_index]
  spawn_flow <- cvpiaHabitat::stanislaus_river_instream$flow_cfs[spawn_not_na_index]

  expect_equal(
    set_instream_habitat('Stanislaus River', 'fr', 'fry', fry_flow), fryx)
  expect_equal(
    set_instream_habitat('Stanislaus River', 'fr', 'juv', juv_flow), juvx)
  expect_equal(
    set_spawning_habitat('Stanislaus River', 'fr', spawn_flow), spawnx)
})

test_that('ST rearing Stanislaus River works', {

  fry_not_na_index <- which(!is.na(cvpiaHabitat::stanislaus_river_instream$ST_fry_wua))[1]
  juv_not_na_index <- which(!is.na(cvpiaHabitat::stanislaus_river_instream$ST_juv_wua))[1]

  fry_wua <- cvpiaHabitat::stanislaus_river_instream$ST_fry_wua[fry_not_na_index]
  juv_wua <- cvpiaHabitat::stanislaus_river_instream$ST_juv_wua[juv_not_na_index]

  rearing_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                  watershed == 'Stanislaus River' & lifestage == 'rearing'
                                  & species == 'fr')$feet

  fryx <- (((rearing_stream_length/1000) * fry_wua)/10.7639)
  juvx <- (((rearing_stream_length/1000) * juv_wua)/10.7639)

  fry_flow <- cvpiaHabitat::stanislaus_river_instream$flow_cfs[fry_not_na_index]
  juv_flow <- cvpiaHabitat::stanislaus_river_instream$flow_cfs[juv_not_na_index]

  expect_equal(
    set_instream_habitat('Stanislaus River', 'st', 'fry', fry_flow), fryx)
  expect_equal(
    set_instream_habitat('Stanislaus River', 'st', 'juv', juv_flow), juvx)
})

test_that('FR floodplain Stanislaus River works', {
  first_flood_index <-  which(cvpiaHabitat::stanislaus_river_floodplain$FR_floodplain_acres > 0)[1]

  flow <- cvpiaHabitat::stanislaus_river_floodplain$flow_cfs[first_flood_index]
  floodplain <- subset(cvpiaHabitat::stanislaus_river_floodplain,flow_cfs == flow)$FR_floodplain_acres

  expect_equal(
    square_meters_to_acres(set_floodplain_habitat('Stanislaus River', 'fr', flow)),
    floodplain,
    tolerance = .01)
})

test_that('SR and ST is same as FR Stanislaus River', {

  expect_equal(
    set_spawning_habitat('Stanislaus River', 'fr', 250),
    set_spawning_habitat('Stanislaus River', 'sr', 250),
    set_spawning_habitat('Stanislaus River', 'st', 250))

  expect_equal(
    set_instream_habitat('Stanislaus River', 'fr', 'fry', 250),
    set_instream_habitat('Stanislaus River', 'sr', 'fry', 250),
    set_instream_habitat('Stanislaus River', 'st', 'fry', 250))

  expect_equal(
    set_instream_habitat('Stanislaus River', 'fr', 'juv', 250),
    set_instream_habitat('Stanislaus River', 'sr', 'juv', 250),
    set_instream_habitat('Stanislaus River', 'st', 'juv', 250))

})
