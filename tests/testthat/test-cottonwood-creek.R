library(cvpiaHabitat)
context('Cottonwood Creek Habitat')

test_that("modeling of species coverage hasn't changed since v2.0 - Cottonwood", {
  modeling <- subset(cvpiaHabitat::modeling_exist, Watershed == 'Cottonwood Creek')

  expect_equal(modeling$FR_spawn, TRUE)
  expect_equal(modeling$FR_fry, TRUE)
  expect_equal(modeling$FR_juv, TRUE)
  expect_equal(modeling$FR_floodplain, TRUE)

  expect_equal(modeling$SR_spawn, FALSE)
  expect_equal(modeling$SR_fry, FALSE)
  expect_equal(modeling$SR_juv, FALSE)
  expect_equal(modeling$SR_floodplain, TRUE)

  expect_equal(modeling$ST_spawn, FALSE)
  expect_equal(modeling$ST_fry, TRUE)
  expect_equal(modeling$ST_juv, TRUE)
  expect_equal(modeling$ST_floodplain, TRUE)
  expect_equal(modeling$ST_adult, FALSE)
})

test_that('FR instream Cottonwood Creek works', {

  fry_not_na_index <- which(!is.na(cvpiaHabitat::cottonwood_creek_instream$FR_fry_wua))[1]
  juv_not_na_index <- which(!is.na(cvpiaHabitat::cottonwood_creek_instream$FR_juv_wua))[1]
  spawn_not_na_index <- which(!is.na(cvpiaHabitat::cottonwood_creek_instream$FR_spawn_wua))[1]

  fry_wua <- cvpiaHabitat::cottonwood_creek_instream$FR_fry_wua[fry_not_na_index]
  juv_wua <- cvpiaHabitat::cottonwood_creek_instream$FR_juv_wua[juv_not_na_index]
  spawn_wua <- cvpiaHabitat::cottonwood_creek_instream$FR_spawn_wua[spawn_not_na_index]

  rearing_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                  watershed == 'Cottonwood Creek' & lifestage == 'rearing'
                                  & species == 'fr')$feet
  spawning_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                   watershed == 'Cottonwood Creek' & lifestage == 'spawning'
                                   & species == 'fr')$feet

  fryx <- (((rearing_stream_length/1000) * fry_wua)/10.7639)
  juvx <- (((rearing_stream_length/1000) * juv_wua)/10.7639)
  spawnx <- (((spawning_stream_length/1000) * spawn_wua)/10.7639)

  fry_flow <- cvpiaHabitat::cottonwood_creek_instream$flow_cfs[fry_not_na_index]
  juv_flow <- cvpiaHabitat::cottonwood_creek_instream$flow_cfs[juv_not_na_index]
  spawn_flow <- cvpiaHabitat::cottonwood_creek_instream$flow_cfs[spawn_not_na_index]

  expect_equal(
    set_instream_habitat('Cottonwood Creek', 'fr', 'fry', fry_flow), fryx)
  expect_equal(
    set_instream_habitat('Cottonwood Creek', 'fr', 'juv', juv_flow), juvx)
  expect_equal(
    set_spawning_habitat('Cottonwood Creek', 'fr', spawn_flow), spawnx)
})

test_that('ST rearing Cottonwood Creek works', {

  fry_not_na_index <- which(!is.na(cvpiaHabitat::cottonwood_creek_instream$ST_fry_wua))[1]
  juv_not_na_index <- which(!is.na(cvpiaHabitat::cottonwood_creek_instream$ST_juv_wua))[1]


  fry_wua <- cvpiaHabitat::cottonwood_creek_instream$ST_fry_wua[fry_not_na_index]
  juv_wua <- cvpiaHabitat::cottonwood_creek_instream$ST_juv_wua[juv_not_na_index]


  rearing_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                  watershed == 'Cottonwood Creek' & lifestage == 'rearing'
                                  & species == 'st')$feet

  fryx <- (((rearing_stream_length/1000) * fry_wua)/10.7639)
  juvx <- (((rearing_stream_length/1000) * juv_wua)/10.7639)

  fry_flow <- cvpiaHabitat::cottonwood_creek_instream$flow_cfs[fry_not_na_index]
  juv_flow <- cvpiaHabitat::cottonwood_creek_instream$flow_cfs[juv_not_na_index]

  expect_equal(
    set_instream_habitat('Cottonwood Creek', 'st', 'fry', fry_flow), fryx)
  expect_equal(
    set_instream_habitat('Cottonwood Creek', 'st', 'juv', juv_flow), juvx)
})

test_that('FR floodplain Cottonwood Creek works', {
  first_flood_index <-  which(cvpiaHabitat::cottonwood_creek_floodplain$FR_floodplain_acres > 0)[1]

  flow <- cvpiaHabitat::cottonwood_creek_floodplain$flow_cfs[first_flood_index]
  floodplain <- subset(cvpiaHabitat::cottonwood_creek_floodplain,flow_cfs == flow)$FR_floodplain_acres

  expect_equal(
    square_meters_to_acres(set_floodplain_habitat('Cottonwood Creek', 'fr', flow)),
    floodplain,
    tolerance = .01)
})

