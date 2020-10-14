library(cvpiaHabitat)
context('Feather River Habitat')

test_that("modeling of species coverage hasn't changed - Feather", {
  modeling <- subset(cvpiaHabitat::modeling_exist, Watershed == 'Feather River')

  expect_equal(modeling$FR_spawn, TRUE)
  expect_equal(modeling$FR_fry, TRUE)
  expect_equal(modeling$FR_juv, TRUE)
  expect_equal(modeling$FR_floodplain, TRUE)

  expect_equal(modeling$SR_spawn, FALSE)
  expect_equal(modeling$SR_fry, FALSE)
  expect_equal(modeling$SR_juv, FALSE)
  expect_equal(modeling$SR_floodplain, TRUE)

  expect_equal(modeling$ST_spawn, TRUE)
  expect_equal(modeling$ST_fry, FALSE)
  expect_equal(modeling$ST_juv, FALSE)
  expect_equal(modeling$ST_floodplain, TRUE)
  expect_equal(modeling$ST_adult, FALSE)
})

test_that('FR instream Feather River works', {

  fry_not_na_index <- which(!is.na(cvpiaHabitat::feather_river_instream$FR_fry_wua))[1]
  juv_not_na_index <- which(!is.na(cvpiaHabitat::feather_river_instream$FR_juv_wua))[1]
  spawn_not_na_index <- which(!is.na(cvpiaHabitat::feather_river_instream$FR_spawn_wua))[1]

  fry_wua <- cvpiaHabitat::feather_river_instream$FR_fry_wua[fry_not_na_index]
  juv_wua <- cvpiaHabitat::feather_river_instream$FR_juv_wua[juv_not_na_index]
  spawn_wua <- cvpiaHabitat::feather_river_instream$FR_spawn_wua[spawn_not_na_index]

  rearing_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                  watershed == 'Feather River' & lifestage == 'rearing'
                                  & species == 'fr')$feet
  spawning_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                   watershed == 'Feather River' & lifestage == 'spawning'
                                   & species == 'fr')$feet

  fry_m2 <- (((rearing_stream_length/1000) * fry_wua)/10.7639)
  juv_m2 <- (((rearing_stream_length/1000) * juv_wua)/10.7639)
  spawn_m2 <- (((spawning_stream_length/1000) * spawn_wua)/10.7639)

  fry_flow <- cvpiaHabitat::feather_river_instream$flow_cfs[fry_not_na_index]
  juv_flow <- cvpiaHabitat::feather_river_instream$flow_cfs[juv_not_na_index]
  spawn_flow <- cvpiaHabitat::feather_river_instream$flow_cfs[spawn_not_na_index]

  expect_equal(
    set_instream_habitat('Feather River', 'fr', 'fry', fry_flow), fry_m2)
  expect_equal(
    set_instream_habitat('Feather River', 'fr', 'juv', juv_flow), juv_m2)
  expect_equal(
    set_spawning_habitat('Feather River', 'fr', spawn_flow), spawn_m2)
})


test_that('ST spawn Feather River works', {

  spawn_not_na_index <- which(!is.na(cvpiaHabitat::feather_river_instream$ST_spawn_wua))[1]
  spawn_wua <- cvpiaHabitat::feather_river_instream$ST_spawn_wua[spawn_not_na_index]

  #TODO - there is no steelhead extent for feather river - is fall run ok? (Issue #205)
  spawning_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                   watershed == 'Feather River' & lifestage == 'spawning'
                                   & species == 'fr')$feet

  spawn_m2 <- (((spawning_stream_length/1000) * spawn_wua)/10.7639)

  spawn_flow <- cvpiaHabitat::feather_river_instream$flow_cfs[spawn_not_na_index]
  expect_equal(
    set_spawning_habitat('Feather River', 'st', spawn_flow), spawn_m2)

})

test_that('FR floodplain Feather River works', {
  first_flood_index <-  which(cvpiaHabitat::feather_river_floodplain$FR_floodplain_acres > 0)[1]

  flow <- cvpiaHabitat::feather_river_floodplain$flow_cfs[first_flood_index]
  floodplain <- subset(cvpiaHabitat::feather_river_floodplain,flow_cfs == flow)$FR_floodplain_acres

  expect_equal(
    square_meters_to_acres(set_floodplain_habitat('Feather River', 'fr', flow)),
    floodplain,
    tolerance = .01)
})

test_that('SR and FR are same for spawning', {
  expect_equal(
    set_spawning_habitat('Feather River', 'fr', 2500),
    set_spawning_habitat('Feather River', 'sr', 2500))
})

test_that('ST and SR rearing are same as FR', {

  expect_equal(
    set_instream_habitat('Feather River', 'fr', 'juv', 2500),
    set_instream_habitat('Feather River', 'sr', 'juv', 2500),
    set_instream_habitat('Feather River', 'st', 'juv', 2500))

  expect_equal(
    set_spawning_habitat('Feather River', 'fr', 2500),
    set_spawning_habitat('Feather River', 'sr', 2500),
    set_spawning_habitat('Feather River', 'st', 2500))
})
