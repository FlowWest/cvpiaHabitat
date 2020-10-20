library(cvpiaHabitat)
context('Bear River Habitat')

test_that("modeling of species coverage hasn't changed - Bear", {
  modeling <- subset(cvpiaHabitat::modeling_exist, Watershed == 'Bear River')

  expect_equal(modeling$FR_spawn, TRUE)
  expect_equal(modeling$FR_fry, TRUE)
  expect_equal(modeling$FR_juv, TRUE)
  expect_equal(modeling$FR_floodplain, TRUE)

  expect_equal(is.na(modeling$SR_spawn), TRUE)
  expect_equal(is.na(modeling$SR_fry), TRUE)
  expect_equal(is.na(modeling$SR_juv), TRUE)
  expect_equal(is.na(modeling$SR_floodplain), TRUE)

  expect_equal(modeling$ST_spawn, TRUE)
  expect_equal(modeling$ST_fry, TRUE)
  expect_equal(modeling$ST_juv, TRUE)
  expect_equal(modeling$ST_floodplain, TRUE)
  expect_equal(modeling$ST_adult, FALSE)
})

test_that('FR instream Bear River works', {

  fry_not_na_index <- which(!is.na(cvpiaHabitat::bear_river_instream$FR_fry_wua))[1]
  juv_not_na_index <- which(!is.na(cvpiaHabitat::bear_river_instream$FR_juv_wua))[1]
  spawn_not_na_index <- which(!is.na(cvpiaHabitat::bear_river_instream$FR_spawn_wua))[1]

  fry_wua <- cvpiaHabitat::bear_river_instream$FR_fry_wua[fry_not_na_index]
  juv_wua <- cvpiaHabitat::bear_river_instream$FR_juv_wua[juv_not_na_index]
  spawn_wua <- cvpiaHabitat::bear_river_instream$FR_spawn_wua[spawn_not_na_index]

  rearing_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                  watershed == 'Bear River' & lifestage == 'rearing'
                                  & species == 'fr')$feet
  spawning_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                   watershed == 'Bear River' & lifestage == 'spawning'
                                   & species == 'fr')$feet

  fryx <- (((rearing_stream_length/1000) * fry_wua)/10.7639)
  juvx <- (((rearing_stream_length/1000) * juv_wua)/10.7639)
  spawnx <- (((spawning_stream_length/1000) * spawn_wua)/10.7639)

  fry_flow <- cvpiaHabitat::bear_river_instream$flow_cfs[fry_not_na_index]
  juv_flow <- cvpiaHabitat::bear_river_instream$flow_cfs[juv_not_na_index]
  spawn_flow <- cvpiaHabitat::bear_river_instream$flow_cfs[spawn_not_na_index]

  expect_equal(
    set_instream_habitat('Bear River', 'fr', 'fry', fry_flow), fryx)
  expect_equal(
    set_instream_habitat('Bear River', 'fr', 'juv', juv_flow), juvx)
  expect_equal(
    set_spawning_habitat('Bear River', 'fr', spawn_flow), spawnx)
})

test_that('ST instream Bear River works', {

  fry_not_na_index <- which(!is.na(cvpiaHabitat::bear_river_instream$ST_fry_wua))[1]
  juv_not_na_index <- which(!is.na(cvpiaHabitat::bear_river_instream$ST_juv_wua))[1]
  spawn_not_na_index <- which(!is.na(cvpiaHabitat::bear_river_instream$ST_spawn_wua))[1]

  fry_wua <- cvpiaHabitat::bear_river_instream$ST_fry_wua[fry_not_na_index]
  juv_wua <- cvpiaHabitat::bear_river_instream$ST_juv_wua[juv_not_na_index]
  spawn_wua <- cvpiaHabitat::bear_river_instream$ST_spawn_wua[spawn_not_na_index]
  #TODO - there is no steelhead extent for bear river - is fall run ok? (Issue #205)
  rearing_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                  watershed == 'Bear River' & lifestage == 'rearing'
                                  & species == 'fr')$feet
  spawning_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                   watershed == 'Bear River' & lifestage == 'spawning'
                                   & species == 'fr')$feet

  fryx <- (((rearing_stream_length/1000) * fry_wua)/10.7639)
  juvx <- (((rearing_stream_length/1000) * juv_wua)/10.7639)
  spawnx <- (((spawning_stream_length/1000) * spawn_wua)/10.7639)

  fry_flow <- cvpiaHabitat::bear_river_instream$flow_cfs[fry_not_na_index]
  juv_flow <- cvpiaHabitat::bear_river_instream$flow_cfs[juv_not_na_index]
  spawn_flow <- cvpiaHabitat::bear_river_instream$flow_cfs[spawn_not_na_index]

  expect_equal(
    set_instream_habitat('Bear River', 'st', 'fry', fry_flow), fryx)
  expect_equal(
    set_instream_habitat('Bear River', 'st', 'juv', juv_flow), juvx)
  expect_equal(
    set_spawning_habitat('Bear River', 'st', spawn_flow), spawnx)
})


test_that('FR floodplain Bear River works', {
  first_flood_index <-  which(cvpiaHabitat::bear_river_floodplain$FR_floodplain_acres > 0)[1]

  flow <- cvpiaHabitat::bear_river_floodplain$flow_cfs[first_flood_index]
  floodplain <- subset(cvpiaHabitat::bear_river_floodplain,flow_cfs == flow)$FR_floodplain_acres

  expect_equal(
    square_meters_to_acres(set_floodplain_habitat('Bear River', 'fr', flow)),
    floodplain,
    tolerance = .01)
})

