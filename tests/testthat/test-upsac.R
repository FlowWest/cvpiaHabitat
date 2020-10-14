library(cvpiaHabitat)
context('Upper Sacramento Habitat')

test_that("modeling of species coverage hasn't changed since v2.0 - Upper Sac", {
  modeling <- subset(cvpiaHabitat::modeling_exist, Watershed == 'Upper Sacramento River')

  expect_equal(modeling$FR_spawn, TRUE)
  expect_equal(modeling$FR_fry, FALSE)
  expect_equal(modeling$FR_juv, FALSE)
  expect_equal(modeling$FR_floodplain, FALSE)

  expect_equal(modeling$WR_spawn, TRUE)
  expect_equal(modeling$WR_fry, FALSE)
  expect_equal(modeling$WR_juv, TRUE)
  expect_equal(modeling$WR_floodplain, TRUE)

  expect_equal(modeling$LFR_spawn, TRUE)
  expect_equal(modeling$LFR_fry, FALSE)
  expect_equal(modeling$LFR_juv, FALSE)
  expect_equal(modeling$LFR_floodplain, FALSE)

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

test_that('FR juv Upper Sac River works', {

  flow1 <- cvpiaHabitat::upper_sacramento_river_instream$flow_cfs[1]

  expect_equal(
    set_instream_habitat(watershed = 'Upper Sacramento River',
                         species = 'fr', life_stage = 'juv',
                         flow = flow1),
    cvpiaHabitat::upper_sacramento_river_instream$rearing_sq_meters[1])

})

test_that('FR spawn Upper Sac works', {

  spawn_not_na_index1 <- which(!is.na(cvpiaHabitat::upper_sac_ACID_boards_in$FR_spawn_WUA))[1]
  spawn_not_na_index2 <- which(!is.na(cvpiaHabitat::upper_sac_ACID_boards_out$FR_spawn_WUA))[1]

  spawn_wua1 <- cvpiaHabitat::upper_sac_ACID_boards_in$FR_spawn_WUA[spawn_not_na_index1]
  spawn_wua2 <- cvpiaHabitat::upper_sac_ACID_boards_out$FR_spawn_WUA[spawn_not_na_index2]

  spawning_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                   watershed == 'Upper Sacramento River' & lifestage == 'spawning'
                                   & species == 'fr')$feet

  spawnx1 <- ((spawning_stream_length/1000) * spawn_wua1)/10.7639
  spawnx2 <- ((spawning_stream_length/1000) * spawn_wua2)/10.7639

  spawn_flow1 <- cvpiaHabitat::upper_sac_ACID_boards_in$flow_cfs[spawn_not_na_index1]
  spawn_flow2 <- cvpiaHabitat::upper_sac_ACID_boards_out$flow_cfs[spawn_not_na_index2]

  expect_equal(
    set_spawning_habitat(watershed = 'Upper Sacramento River',
                         species = 'fr', flow = spawn_flow1, month = 5), spawnx1)

  expect_equal(
    set_spawning_habitat(watershed = 'Upper Sacramento River',
                         species = 'fr', flow = spawn_flow2, month = 2), spawnx2)
})

test_that('ST spawn Upper Sac works', {
  wua1 <- cvpiaHabitat::upper_sac_ACID_boards_in$ST_spawn_WUA[1]
  wua2 <- cvpiaHabitat::upper_sac_ACID_boards_out$ST_spawn_WUA[1]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[cvpiaHabitat::watershed_lengths$watershed == 'Upper Sacramento River' &
                                                                cvpiaHabitat::watershed_lengths$lifestage == 'spawning','feet'])

  x1 <- ((stream_length/1000) * wua1)/10.7639
  x2 <- ((stream_length/1000) * wua2)/10.7639

  flow1 <- cvpiaHabitat::upper_sac_ACID_boards_in$flow_cfs[1]
  flow2 <- cvpiaHabitat::upper_sac_ACID_boards_out$flow_cfs[1]

  expect_equal(
    set_spawning_habitat(watershed = 'Upper Sacramento River',
                         species = 'st', flow = flow1, month = 5), x1)

  expect_equal(
    set_spawning_habitat(watershed = 'Upper Sacramento River',
                         species = 'st', flow = flow2, month = 2), x2)
})

test_that('FR floodplain Upper Sac River works', {
  first_flood_index <-  which(cvpiaHabitat::upper_sacramento_river_floodplain$floodplain_sq_meters > 0)[1]

  flow <- cvpiaHabitat::upper_sacramento_river_floodplain$flow_cfs[first_flood_index]
  floodplain <- subset(cvpiaHabitat::upper_sacramento_river_floodplain,flow_cfs == flow)$floodplain_sq_meters

  expect_equal(
    set_floodplain_habitat('Upper Sacramento River', 'fr', flow),
    floodplain,
    tolerance = .01)
})


# Tests for species/habitat without modeling (FALSE modeling_exists) ----

test_that('SR floodplain Upper Sac River works', {
  first_flood_index <-  which(cvpiaHabitat::upper_sacramento_river_floodplain$floodplain_sq_meters > 0)[1]

  flow <- cvpiaHabitat::upper_sacramento_river_floodplain$flow_cfs[first_flood_index]
  floodplain <- subset(cvpiaHabitat::upper_sacramento_river_floodplain,flow_cfs == flow)$floodplain_sq_meters

  expect_equal(
    set_floodplain_habitat('Upper Sacramento River', 'sr', flow),
    floodplain,
    tolerance = .01)
})
