library(cvpiaHabitat)
context('Battle Creek Habitat')

test_that("modeling of species coverage hasn't changed since v2.0 - Battle", {
  modeling <- subset(cvpiaHabitat::modeling_exist, Watershed == 'Battle Creek')

  expect_equal(modeling$FR_spawn, TRUE)
  expect_equal(modeling$FR_fry, TRUE)
  expect_equal(modeling$FR_juv, TRUE)
  expect_equal(modeling$FR_floodplain, FALSE)

  expect_equal(modeling$SR_spawn, TRUE)
  expect_equal(modeling$SR_fry, TRUE)
  expect_equal(modeling$SR_juv, TRUE)
  expect_equal(modeling$SR_floodplain, FALSE)

  expect_equal(modeling$ST_spawn, TRUE)
  expect_equal(modeling$ST_fry, TRUE)
  expect_equal(modeling$ST_juv, TRUE)
  expect_equal(modeling$ST_floodplain, FALSE)
  expect_equal(modeling$ST_adult, TRUE)
})

test_that('FR instream Battle Creek works', {

  fry_not_na_index <- which(!is.na(cvpiaHabitat::battle_creek_instream$FR_fry_wua))[1]
  juv_not_na_index <- which(!is.na(cvpiaHabitat::battle_creek_instream$FR_juv_wua))[1]
  spawn_not_na_index <- which(!is.na(cvpiaHabitat::battle_creek_instream$FR_spawn_wua))[1]

  fry_wua <- cvpiaHabitat::battle_creek_instream$FR_fry_wua[fry_not_na_index]
  juv_wua <- cvpiaHabitat::battle_creek_instream$FR_juv_wua[juv_not_na_index]
  spawn_wua <- cvpiaHabitat::battle_creek_instream$FR_spawn_wua[spawn_not_na_index]

  rearing_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                  watershed == 'Battle Creek' & lifestage == 'rearing'
                                  & species == 'fr')$feet
  spawning_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                   watershed == 'Battle Creek' & lifestage == 'spawning'
                                   & species == 'fr')$feet

  fryx <- (((rearing_stream_length/1000) * fry_wua)/10.7639)
  juvx <- (((rearing_stream_length/1000) * juv_wua)/10.7639)
  spawnx <- (((spawning_stream_length/1000) * spawn_wua)/10.7639)

  fry_flow <- cvpiaHabitat::battle_creek_instream$flow_cfs[fry_not_na_index]
  juv_flow <- cvpiaHabitat::battle_creek_instream$flow_cfs[juv_not_na_index]
  spawn_flow <- cvpiaHabitat::battle_creek_instream$flow_cfs[spawn_not_na_index]

  expect_equal(
    set_instream_habitat('Battle Creek', 'fr', 'fry', fry_flow), fryx)
  expect_equal(
    set_instream_habitat('Battle Creek', 'fr', 'juv', juv_flow), juvx)
  expect_equal(
    set_spawning_habitat('Battle Creek', 'fr', spawn_flow), spawnx)
})

test_that('SR instream Battle Creek works', {

  fry_not_na_index <- which(!is.na(cvpiaHabitat::battle_creek_instream$SR_fry_wua))[1]
  juv_not_na_index <- which(!is.na(cvpiaHabitat::battle_creek_instream$SR_juv_wua))[1]
  spawn_not_na_index <- which(!is.na(cvpiaHabitat::battle_creek_instream$SR_spawn_wua))[1]

  fry_wua <- cvpiaHabitat::battle_creek_instream$SR_fry_wua[fry_not_na_index]
  juv_wua <- cvpiaHabitat::battle_creek_instream$SR_juv_wua[juv_not_na_index]
  spawn_wua <- cvpiaHabitat::battle_creek_instream$SR_spawn_wua[spawn_not_na_index]

  rearing_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                  watershed == 'Battle Creek' & lifestage == 'rearing'
                                  & species == 'sr')$feet
  spawning_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                   watershed == 'Battle Creek' & lifestage == 'spawning'
                                   & species == 'sr')$feet

  fryx <- (((rearing_stream_length/1000) * fry_wua)/10.7639)
  juvx <- (((rearing_stream_length/1000) * juv_wua)/10.7639)
  spawnx <- (((spawning_stream_length/1000) * spawn_wua)/10.7639)

  fry_flow <- cvpiaHabitat::battle_creek_instream$flow_cfs[fry_not_na_index]
  juv_flow <- cvpiaHabitat::battle_creek_instream$flow_cfs[juv_not_na_index]
  spawn_flow <- cvpiaHabitat::battle_creek_instream$flow_cfs[spawn_not_na_index]

  expect_equal(
    set_instream_habitat('Battle Creek', 'sr', 'fry', fry_flow), fryx)
  expect_equal(
    set_instream_habitat('Battle Creek', 'sr', 'juv', juv_flow), juvx)
  expect_equal(
    set_spawning_habitat('Battle Creek', 'sr', spawn_flow), spawnx)
})

test_that('ST instream Battle Creek works', {

  fry_not_na_index <- which(!is.na(cvpiaHabitat::battle_creek_instream$ST_fry_wua))[1]
  juv_not_na_index <- which(!is.na(cvpiaHabitat::battle_creek_instream$ST_juv_wua))[1]
  spawn_not_na_index <- which(!is.na(cvpiaHabitat::battle_creek_instream$ST_spawn_wua))[1]

  fry_wua <- cvpiaHabitat::battle_creek_instream$ST_fry_wua[fry_not_na_index]
  juv_wua <- cvpiaHabitat::battle_creek_instream$ST_juv_wua[juv_not_na_index]
  spawn_wua <- cvpiaHabitat::battle_creek_instream$ST_spawn_wua[spawn_not_na_index]

  rearing_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                  watershed == 'Battle Creek' & lifestage == 'rearing'
                                  & species == 'st')$feet
  spawning_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                   watershed == 'Battle Creek' & lifestage == 'spawning'
                                   & species == 'st')$feet

  fryx <- (((rearing_stream_length/1000) * fry_wua)/10.7639)
  juvx <- (((rearing_stream_length/1000) * juv_wua)/10.7639)
  spawnx <- (((spawning_stream_length/1000) * spawn_wua)/10.7639)

  fry_flow <- cvpiaHabitat::battle_creek_instream$flow_cfs[fry_not_na_index]
  juv_flow <- cvpiaHabitat::battle_creek_instream$flow_cfs[juv_not_na_index]
  spawn_flow <- cvpiaHabitat::battle_creek_instream$flow_cfs[spawn_not_na_index]

  expect_equal(
    set_instream_habitat('Battle Creek', 'st', 'fry', fry_flow), fryx)
  expect_equal(
    set_instream_habitat('Battle Creek', 'st', 'juv', juv_flow), juvx)
  expect_equal(
    set_spawning_habitat('Battle Creek', 'st', spawn_flow), spawnx)
})

#this test should fail for now (10/01/20) until stream length & set-instream-habitat.R code updated
test_that('ST adult Battle Creek works', {

  adult_not_na_index <- which(!is.na(cvpiaHabitat::battle_creek_instream$ST_adult_wua))[1]
  adult_wua <- cvpiaHabitat::battle_creek_instream$ST_adult_wua[adult_not_na_index]

  adult_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                  watershed == 'Battle Creek' & lifestage == 'adult'
                                  & species == 'st')$feet

  adultx <- (((adult_stream_length/1000) * adult_wua)/10.7639)

  adult_flow <- cvpiaHabitat::battle_creek_instream$flow_cfs[adult_not_na_index]

  expect_equal(
    set_instream_habitat('Battle Creek', 'st', 'adult', adult_flow), adultx)

})
