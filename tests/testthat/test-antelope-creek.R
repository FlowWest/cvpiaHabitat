library(cvpiaHabitat)
context('Antelope Creek Habitat')

test_that("modeling of species coverage hasn't changed since v2.0 - Antelope", {
  modeling <- subset(cvpiaHabitat::modeling_exist, Watershed == 'Antelope Creek')

  expect_equal(modeling$FR_spawn, FALSE)
  expect_equal(modeling$FR_fry, FALSE)
  expect_equal(modeling$FR_juv, FALSE)
  expect_equal(modeling$FR_floodplain, FALSE)

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

# Tests for species without modeling (FALSE modeling_exists) ----

test_that('FR instream Antelope Creek works', {

  fry_not_na_index <- which(!is.na(cvpiaHabitat::upper_mid_sac_region_instream$FR_fry_wua))[1]
  juv_not_na_index <- which(!is.na(cvpiaHabitat::upper_mid_sac_region_instream$FR_juv_wua))[1]
  spawn_not_na_index <- which(!is.na(cvpiaHabitat::upper_mid_sac_region_instream$FR_spawn_wua))[1]

  fry_wua <- cvpiaHabitat::upper_mid_sac_region_instream$FR_fry_wua[fry_not_na_index]
  juv_wua <- cvpiaHabitat::upper_mid_sac_region_instream$FR_juv_wua[juv_not_na_index]
  spawn_wua <- cvpiaHabitat::upper_mid_sac_region_instream$FR_spawn_wua[spawn_not_na_index]

  rearing_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                  watershed == 'Antelope Creek' & lifestage == 'rearing'
                                  & species == 'fr')$feet
  spawning_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                   watershed == 'Antelope Creek' & lifestage == 'spawning'
                                   & species == 'fr')$feet

  fryx <- (((rearing_stream_length/1000) * fry_wua)/10.7639)
  juvx <- (((rearing_stream_length/1000) * juv_wua)/10.7639)
  spawnx <- (((spawning_stream_length/1000) * spawn_wua)/10.7639)

  fry_flow <- cvpiaHabitat::upper_mid_sac_region_instream$flow_cfs[fry_not_na_index]
  juv_flow <- cvpiaHabitat::upper_mid_sac_region_instream$flow_cfs[juv_not_na_index]
  spawn_flow <- cvpiaHabitat::upper_mid_sac_region_instream$flow_cfs[spawn_not_na_index]

  expect_equal(
    set_instream_habitat('Antelope Creek', 'fr', 'fry', fry_flow), fryx)
  expect_equal(
    set_instream_habitat('Antelope Creek', 'fr', 'juv', juv_flow), juvx)
  expect_equal(
    set_spawning_habitat('Antelope Creek', 'fr', spawn_flow), spawnx)
})

test_that('SR instream Antelope Creek works', {

  fry_not_na_index <- which(!is.na(cvpiaHabitat::upper_mid_sac_region_instream$FR_fry_wua))[1]
  juv_not_na_index <- which(!is.na(cvpiaHabitat::upper_mid_sac_region_instream$FR_juv_wua))[1]
  spawn_not_na_index <- which(!is.na(cvpiaHabitat::upper_mid_sac_region_instream$FR_spawn_wua))[1]

  fry_wua <- cvpiaHabitat::upper_mid_sac_region_instream$FR_fry_wua[fry_not_na_index]
  juv_wua <- cvpiaHabitat::upper_mid_sac_region_instream$FR_juv_wua[juv_not_na_index]
  spawn_wua <- cvpiaHabitat::upper_mid_sac_region_instream$FR_spawn_wua[spawn_not_na_index]

  rearing_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                  watershed == 'Antelope Creek' & lifestage == 'rearing'
                                  & species == 'fr')$feet
  spawning_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                   watershed == 'Antelope Creek' & lifestage == 'spawning'
                                   & species == 'fr')$feet

  fryx <- (((rearing_stream_length/1000) * fry_wua)/10.7639)
  juvx <- (((rearing_stream_length/1000) * juv_wua)/10.7639)
  spawnx <- (((spawning_stream_length/1000) * spawn_wua)/10.7639)

  fry_flow <- cvpiaHabitat::upper_mid_sac_region_instream$flow_cfs[fry_not_na_index]
  juv_flow <- cvpiaHabitat::upper_mid_sac_region_instream$flow_cfs[juv_not_na_index]
  spawn_flow <- cvpiaHabitat::upper_mid_sac_region_instream$flow_cfs[spawn_not_na_index]

  expect_equal(
    set_instream_habitat('Antelope Creek', 'sr', 'fry', fry_flow), fryx)
  expect_equal(
    set_instream_habitat('Antelope Creek', 'sr', 'juv', juv_flow), juvx)
  expect_equal(
    set_spawning_habitat('Antelope Creek', 'sr', spawn_flow), spawnx)
})


test_that('FR floodplain Antelope Creek works', {
  first_flood_index <-  which(cvpiaHabitat::antelope_creek_floodplain$FR_floodplain_acres > 0)[1]

  flow <- cvpiaHabitat::antelope_creek_floodplain$flow_cfs[first_flood_index]
  floodplain <- subset(cvpiaHabitat::antelope_creek_floodplain,flow_cfs == flow)$FR_floodplain_acres

  expect_equal(
    square_meters_to_acres(set_floodplain_habitat('Antelope Creek', 'fr', flow)),
    floodplain,
    tolerance = .01)
})

test_that('SR floodplain Antelope Creek works', {
  first_flood_index <-  which(cvpiaHabitat::antelope_creek_floodplain$SR_floodplain_acres > 0)[1]

  flow <- cvpiaHabitat::antelope_creek_floodplain$flow_cfs[first_flood_index]
  floodplain <- subset(cvpiaHabitat::antelope_creek_floodplain,flow_cfs == flow)$SR_floodplain_acres

  expect_equal(
    square_meters_to_acres(set_floodplain_habitat('Antelope Creek', 'sr', flow)),
    floodplain,
    tolerance = .01)
})
