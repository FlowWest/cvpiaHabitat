library(cvpiaHabitat)
context('Upper Mid Sac Region Habitat')

test_that("modeling of species coverage hasn't changed - Upper Mid Sac Region", {
  modeling <- subset(cvpiaHabitat::modeling_exist, Watershed == 'Upper Mid Sac Region')

  expect_equal(modeling$FR_spawn, TRUE)
  expect_equal(modeling$FR_fry, TRUE)
  expect_equal(modeling$FR_juv, TRUE)
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

test_that('FR instream Upper Mid Sac Region works', {

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
