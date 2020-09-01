library(cvpiaHabitat)
context('American River Habitat')

test_that("modeling of species coverage hasn't changed since v2.0 - American", {
  modeling <- subset(cvpiaHabitat::modeling_exist, Watershed == 'American River')

  expect_equal(modeling$FR_spawn, TRUE)
  expect_equal(modeling$FR_fry, TRUE)
  expect_equal(modeling$FR_juv, TRUE)
  expect_equal(modeling$FR_floodplain, TRUE)

  expect_equal(is.na(modeling$SR_spawn), TRUE)
  expect_equal(is.na(modeling$SR_fry), TRUE)
  expect_equal(is.na(modeling$SR_juv), TRUE)
  expect_equal(is.na(modeling$SR_floodplain), TRUE)

  expect_equal(modeling$ST_spawn, TRUE)
  expect_equal(modeling$ST_fry, FALSE)
  expect_equal(modeling$ST_juv, FALSE)
  expect_equal(modeling$ST_floodplain, TRUE)
  expect_equal(modeling$ST_adult, FALSE)
})

test_that('FR instream American River works', {

  fry_not_na_index <- which(!is.na(cvpiaHabitat::american_river_instream$FR_fry_wua))[1]
  juv_not_na_index <- which(!is.na(cvpiaHabitat::american_river_instream$FR_juv_wua))[1]
  spawn_not_na_index <- which(!is.na(cvpiaHabitat::american_river_instream$FR_spawn_wua))[1]

  fry_wua <- cvpiaHabitat::american_river_instream$FR_fry_wua[fry_not_na_index]
  juv_wua <- cvpiaHabitat::american_river_instream$FR_juv_wua[juv_not_na_index]
  spawn_wua <- cvpiaHabitat::american_river_instream$FR_spawn_wua[spawn_not_na_index]

  rearing_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'American River' & lifestage == 'rearing'
                          & species == 'fr')$feet
  spawning_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                  watershed == 'American River' & lifestage == 'spawning'
                                  & species == 'fr')$feet

  fryx <- (((rearing_stream_length/1000) * fry_wua)/10.7639)
  juvx <- (((rearing_stream_length/1000) * juv_wua)/10.7639)
  spawnx <- (((spawning_stream_length/1000) * spawn_wua)/10.7639)

  fry_flow <- cvpiaHabitat::american_river_instream$flow_cfs[fry_not_na_index]
  juv_flow <- cvpiaHabitat::american_river_instream$flow_cfs[juv_not_na_index]
  spawn_flow <- cvpiaHabitat::american_river_instream$flow_cfs[spawn_not_na_index]

  expect_equal(
    set_instream_habitat('American River', 'fr', 'fry', fry_flow), fryx)
  expect_equal(
    set_instream_habitat('American River', 'fr', 'juv', juv_flow), juvx)
  expect_equal(
    set_spawning_habitat('American River', 'fr', spawn_flow), spawnx)
})


test_that('ST spawn American River works', {
  # flow 300
  first_not_na_habitat_index <- which(!is.na(cvpiaHabitat::american_river_instream$ST_spawn_wua))[1]

  wua <- cvpiaHabitat::american_river_instream$ST_spawn_wua[first_not_na_habitat_index]
  #TODO - there is no steelhead extent for american - is fall run ok? (Issue #205)
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'American River' & lifestage == 'spawning'
                          & species == 'fr')$feet

  x <- (((stream_length/1000) * wua)/10.7639)

  flow <- cvpiaHabitat::american_river_instream$flow_cfs[first_not_na_habitat_index]
  expect_equal(
    set_spawning_habitat('American River', 'st', flow), x)

})

test_that('FR floodplain American works', {
  first_flood_index <-  which(cvpiaHabitat::american_river_floodplain$FR_floodplain_acres > 0)[1]

  flow <- cvpiaHabitat::american_river_floodplain$flow_cfs[first_flood_index]
  floodplain <- subset(cvpiaHabitat::american_river_floodplain,flow_cfs == flow)$FR_floodplain_acres

  expect_equal(
    square_meters_to_acres(set_floodplain_habitat('American River', 'fr', flow)),
    floodplain,
    tolerance = .01)
})

test_that('ST floodplain American works', {
  first_flood_index <-  which(cvpiaHabitat::american_river_floodplain$ST_floodplain_acres > 0)[1]

  flow <- cvpiaHabitat::american_river_floodplain$flow_cfs[first_flood_index]
  floodplain <- subset(cvpiaHabitat::american_river_floodplain,flow_cfs == flow)$ST_floodplain_acres

  expect_equal(
    square_meters_to_acres(set_floodplain_habitat('American River', 'st', flow)),
    floodplain,
    tolerance = .01)
})
