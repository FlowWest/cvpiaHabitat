library(cvpiaHabitat)
context('Mokelumne River Habitat')

test_that("modeling of species coverage hasn't changed since v2.0 - Mokelumne", {
  modeling <- subset(cvpiaHabitat::modeling_exist, Watershed == 'Mokelumne River')

  expect_equal(modeling$FR_spawn, TRUE)
  expect_equal(modeling$FR_fry, TRUE)
  expect_equal(modeling$FR_juv, TRUE)
  expect_equal(modeling$FR_floodplain, TRUE)

  expect_equal(modeling$SR_spawn, FALSE)
  expect_equal(modeling$SR_fry, FALSE)
  expect_equal(modeling$SR_juv, FALSE)
  expect_equal(modeling$SR_floodplain, FALSE)

  expect_equal(modeling$ST_spawn, TRUE)
  expect_equal(modeling$ST_fry, FALSE)
  expect_equal(modeling$ST_juv, FALSE)
  expect_equal(modeling$ST_floodplain, FALSE)
  expect_equal(modeling$ST_adult, FALSE)
})

test_that('FR instream Mokelumne River works', {

  fry_not_na_index <- which(!is.na(cvpiaHabitat::mokelumne_river_instream$FR_fry_wua))[1]
  juv_not_na_index <- which(!is.na(cvpiaHabitat::mokelumne_river_instream$FR_juv_wua))[1]
  spawn_not_na_index <- which(!is.na(cvpiaHabitat::mokelumne_river_instream$FR_spawn_wua))[1]

  fry_wua <- cvpiaHabitat::mokelumne_river_instream$FR_fry_wua[fry_not_na_index]
  juv_wua <- cvpiaHabitat::mokelumne_river_instream$FR_juv_wua[juv_not_na_index]
  spawn_wua <- cvpiaHabitat::mokelumne_river_instream$FR_spawn_wua[spawn_not_na_index]

  rearing_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                  watershed == 'Mokelumne River' & lifestage == 'rearing'
                                  & species == 'fr')$feet
  spawning_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                   watershed == 'Mokelumne River' & lifestage == 'spawning'
                                   & species == 'fr')$feet

  fryx <- (((rearing_stream_length/1000) * fry_wua)/10.7639)
  juvx <- (((rearing_stream_length/1000) * juv_wua)/10.7639)
  spawnx <- (((spawning_stream_length/1000) * spawn_wua)/10.7639)

  fry_flow <- cvpiaHabitat::mokelumne_river_instream$flow_cfs[fry_not_na_index]
  juv_flow <- cvpiaHabitat::mokelumne_river_instream$flow_cfs[juv_not_na_index]
  spawn_flow <- cvpiaHabitat::mokelumne_river_instream$flow_cfs[spawn_not_na_index]

  expect_equal(
    set_instream_habitat('Mokelumne River', 'fr', 'fry', fry_flow), fryx)
  expect_equal(
    set_instream_habitat('Mokelumne River', 'fr', 'juv', juv_flow), juvx)
  expect_equal(
    set_spawning_habitat('Mokelumne River', 'fr', spawn_flow), spawnx)
})

test_that('ST spawn Mokelumne River works', {

  spawn_not_na_index <- which(!is.na(cvpiaHabitat::mokelumne_river_instream$ST_spawn_wua))[1]
  spawn_wua <- cvpiaHabitat::mokelumne_river_instream$ST_spawn_wua[spawn_not_na_index]

  #TODO - there is no steelhead extent for mokelumne river - is fall run ok? (Issue #205)
  spawning_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                   watershed == 'Mokelumne River' & lifestage == 'spawning'
                                   & species == 'fr')$feet

  spawnx <- (((spawning_stream_length/1000) * spawn_wua)/10.7639)

  spawn_flow <- cvpiaHabitat::mokelumne_river_instream$flow_cfs[spawn_not_na_index]
  expect_equal(
    set_spawning_habitat('Mokelumne River', 'st', spawn_flow), spawnx)

})

test_that('FR floodplain Mokelumne River works', {
  first_flood_index <-  which(cvpiaHabitat::mokelumne_river_floodplain$FR_floodplain_acres > 0)[1]

  flow <- cvpiaHabitat::mokelumne_river_floodplain$flow_cfs[first_flood_index]
  floodplain <- subset(cvpiaHabitat::mokelumne_river_floodplain,flow_cfs == flow)$FR_floodplain_acres

  expect_equal(
    square_meters_to_acres(set_floodplain_habitat('Mokelumne River', 'fr', flow)),
    floodplain,
    tolerance = .01)
})

test_that('ST and SR rearing is same as FR', {
  expect_equal(
    set_instream_habitat('Mokelumne River', 'fr', 'fry', 1000),
    set_instream_habitat('Mokelumne River', 'sr', 'fry', 1000),
    set_instream_habitat('Mokelumne River', 'st', 'fry', 1000))

  expect_equal(
    set_instream_habitat('Mokelumne River', 'fr', 'juv', 1000),
    set_instream_habitat('Mokelumne River', 'sr', 'juv', 1000),
    set_instream_habitat('Mokelumne River', 'st', 'juv', 1000))
})

