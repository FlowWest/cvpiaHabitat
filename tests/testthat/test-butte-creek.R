library(cvpiaHabitat)
context('Butte Creek Habitat')

test_that("modeling of species coverage hasn't changed since v2.0 - Butte", {
  modeling <- subset(cvpiaHabitat::modeling_exist, Watershed == 'Butte Creek')

  expect_equal(modeling$FR_spawn, FALSE)
  expect_equal(modeling$FR_fry, FALSE)
  expect_equal(modeling$FR_juv, FALSE)
  expect_equal(modeling$FR_floodplain, TRUE)

  expect_equal(modeling$SR_spawn, TRUE)
  expect_equal(modeling$SR_fry, TRUE)
  expect_equal(modeling$SR_juv, TRUE)
  expect_equal(modeling$SR_floodplain, TRUE)

  expect_equal(modeling$ST_spawn, TRUE)
  expect_equal(modeling$ST_fry, FALSE)
  expect_equal(modeling$ST_juv, FALSE)
  expect_equal(modeling$ST_floodplain, TRUE)
  expect_equal(modeling$ST_adult, FALSE)
})

test_that('FR rearing Butte Creek works', {

  fry_not_na_index <- which(!is.na(cvpiaHabitat::butte_creek_instream$FR_fry_wua))[1]
  juv_not_na_index <- which(!is.na(cvpiaHabitat::butte_creek_instream$FR_juv_wua))[1]

  fry_wua <- cvpiaHabitat::butte_creek_instream$FR_fry_wua[fry_not_na_index]
  juv_wua <- cvpiaHabitat::butte_creek_instream$FR_juv_wua[juv_not_na_index]

  rearing_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                  watershed == 'Butte Creek' & lifestage == 'rearing'
                                  & species == 'fr')$feet

  fryx <- (((rearing_stream_length/1000) * fry_wua)/10.7639)
  juvx <- (((rearing_stream_length/1000) * juv_wua)/10.7639)

  fry_flow <- cvpiaHabitat::butte_creek_instream$flow_cfs[fry_not_na_index]
  juv_flow <- cvpiaHabitat::butte_creek_instream$flow_cfs[juv_not_na_index]

  expect_equal(
    set_instream_habitat('Butte Creek', 'fr', 'fry', fry_flow), fryx)
  expect_equal(
    set_instream_habitat('Butte Creek', 'fr', 'juv', juv_flow), juvx)
})

test_that('SR spawning Butte Creek works', {

  spawn_not_na_index <- which(!is.na(cvpiaHabitat::butte_creek_instream$SR_spawn_wua))[1]
  spawn_wua <- cvpiaHabitat::butte_creek_instream$SR_spawn_wua[spawn_not_na_index]

  spawning_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                   watershed == 'Butte Creek' & lifestage == 'spawning'
                                   & species == 'sr')$feet

  spawnx <- (((spawning_stream_length/1000) * spawn_wua)/10.7639)
  spawn_flow <- cvpiaHabitat::butte_creek_instream$flow_cfs[spawn_not_na_index]

  expect_equal(
    set_spawning_habitat('Butte Creek', 'sr', spawn_flow), spawnx)
})

test_that('ST spawning Butte Creek works', {

  spawn_not_na_index <- which(!is.na(cvpiaHabitat::butte_creek_instream$ST_spawn_wua))[1]
  spawn_wua <- cvpiaHabitat::butte_creek_instream$ST_spawn_wua[spawn_not_na_index]

  spawning_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                   watershed == 'Butte Creek' & lifestage == 'spawning'
                                   & species == 'st')$feet

  spawnx <- (((spawning_stream_length/1000) * spawn_wua)/10.7639)
  spawn_flow <- cvpiaHabitat::butte_creek_instream$flow_cfs[spawn_not_na_index]

  expect_equal(
    set_spawning_habitat('Butte Creek', 'st', spawn_flow), spawnx)
})

test_that('FR floodplain Butte Creek works', {
  first_flood_index <-  which(cvpiaHabitat::butte_creek_floodplain$FR_floodplain_acres > 0)[1]

  flow <- cvpiaHabitat::butte_creek_floodplain$flow_cfs[first_flood_index]
  floodplain <- subset(cvpiaHabitat::butte_creek_floodplain,flow_cfs == flow)$FR_floodplain_acres

  expect_equal(
    square_meters_to_acres(set_floodplain_habitat('Butte Creek', 'fr', flow)),
    floodplain,
    tolerance = .01)
})

test_that('SR floodplain Butte Creek works', {
  first_flood_index <-  which(cvpiaHabitat::butte_creek_floodplain$SR_floodplain_acres > 0)[1]

  flow <- cvpiaHabitat::butte_creek_floodplain$flow_cfs[first_flood_index]
  floodplain <- subset(cvpiaHabitat::butte_creek_floodplain,flow_cfs == flow)$SR_floodplain_acres

  expect_equal(
    square_meters_to_acres(set_floodplain_habitat('Butte Creek', 'sr', flow)),
    floodplain,
    tolerance = .01)
})

test_that('ST floodplain Butte Creek works', {
  first_flood_index <-  which(cvpiaHabitat::butte_creek_floodplain$ST_floodplain_acres > 0)[1]

  flow <- cvpiaHabitat::butte_creek_floodplain$flow_cfs[first_flood_index]
  floodplain <- subset(cvpiaHabitat::butte_creek_floodplain,flow_cfs == flow)$ST_floodplain_acres

  expect_equal(
    square_meters_to_acres(set_floodplain_habitat('Butte Creek', 'st', flow)),
    floodplain,
    tolerance = .01)
})
