library(cvpiaHabitat)
context('Cosumnes River Habitat')

test_that("modeling of species coverage hasn't changed - Cosumnes", {
  modeling <- subset(cvpiaHabitat::modeling_exist, Watershed == 'Cosumnes River')

  expect_equal(modeling$FR_spawn, FALSE)
  expect_equal(modeling$FR_fry, FALSE)
  expect_equal(modeling$FR_juv, FALSE)
  expect_equal(modeling$FR_floodplain, TRUE)

  expect_equal(is.na(modeling$SR_spawn), TRUE)
  expect_equal(is.na(modeling$SR_fry), TRUE)
  expect_equal(is.na(modeling$SR_juv), TRUE)
  expect_equal(is.na(modeling$SR_floodplain), TRUE)

  expect_equal(modeling$ST_spawn, FALSE)
  expect_equal(modeling$ST_fry, FALSE)
  expect_equal(modeling$ST_juv, FALSE)
  expect_equal(modeling$ST_floodplain, TRUE)
  expect_equal(modeling$ST_adult, FALSE)
})

test_that('FR instream Cosumnes River works', {

  fry_not_na_index <- which(!is.na(cvpiaHabitat::cosumnes_river_instream$FR_fry_wua))[1]
  juv_not_na_index <- which(!is.na(cvpiaHabitat::cosumnes_river_instream$FR_juv_wua))[1]
  spawn_not_na_index <- which(!is.na(cvpiaHabitat::cosumnes_river_instream$FR_spawn_wua))[1]

  fry_wua <- cvpiaHabitat::cosumnes_river_instream$FR_fry_wua[fry_not_na_index]
  juv_wua <- cvpiaHabitat::cosumnes_river_instream$FR_juv_wua[juv_not_na_index]
  spawn_wua <- cvpiaHabitat::cosumnes_river_instream$FR_spawn_wua[spawn_not_na_index]

  rearing_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                  watershed == 'Cosumnes River' & lifestage == 'rearing'
                                  & species == 'fr')$feet
  spawning_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                   watershed == 'Cosumnes River' & lifestage == 'spawning'
                                   & species == 'fr')$feet

  fry_m2 <- (((rearing_stream_length/1000) * fry_wua)/10.7639)
  juv_m2 <- (((rearing_stream_length/1000) * juv_wua)/10.7639)
  spawn_m2 <- (((spawning_stream_length/1000) * spawn_wua)/10.7639)

  fry_flow <- cvpiaHabitat::cosumnes_river_instream$flow_cfs[fry_not_na_index]
  juv_flow <- cvpiaHabitat::cosumnes_river_instream$flow_cfs[juv_not_na_index]
  spawn_flow <- cvpiaHabitat::cosumnes_river_instream$flow_cfs[spawn_not_na_index]

  expect_equal(
    set_instream_habitat('Cosumnes River', 'fr', 'fry', fry_flow), fry_m2)
  expect_equal(
    set_instream_habitat('Cosumnes River', 'fr', 'juv', juv_flow), juv_m2)
  expect_equal(
    set_spawning_habitat('Cosumnes River', 'fr', spawn_flow), spawn_m2)
})

test_that('FR fry Cosumnes River works', {

  wua <- cvpiaHabitat::cosumnes_river_instream$FR_fry_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Cosumnes River' & lifestage == 'rearing'
                          & species == 'fr')$feet
  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::cosumnes_river_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('Cosumnes River', 'fr', 'fry', flow), x)


})

test_that('FR juv Cosumnes River works', {

  wua <- cvpiaHabitat::cosumnes_river_instream$FR_juv_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Cosumnes River' & lifestage == 'rearing'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::cosumnes_river_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('Cosumnes River', 'fr', 'juv', flow), x)

})

test_that('FR spawn Cosumnes River works', {

  wua <- cvpiaHabitat::cosumnes_river_instream$FR_spawn_wua[4]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Cosumnes River' & lifestage == 'spawning'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::cosumnes_river_instream$flow_cfs[4]
  expect_equal(
    set_spawning_habitat('Cosumnes River', 'fr', flow), x)

})


test_that('ST = FR Cosumnes River works', {

  expect_equal(
    set_spawning_habitat('Cosumnes River', 'fr', 275),
    set_spawning_habitat('Cosumnes River', 'st', 275))

  expect_equal(
    set_instream_habitat('Cosumnes River', 'fr', 'fry', 1000),
    set_instream_habitat('Cosumnes River', 'st', 'fry', 1000))

  expect_equal(
    set_instream_habitat('Cosumnes River', 'fr', 'juv', 1000),
    set_instream_habitat('Cosumnes River', 'st', 'juv', 1000))

})
