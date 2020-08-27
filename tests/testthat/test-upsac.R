library(cvpiaHabitat)
context('Upper Sacramento Habitat')

test_that('FR fry Upper Sac works', {

  expect_equal(
    set_instream_habitat(watershed = 'Upper Sacramento River',
                         species = 'fr', life_stage = 'fry',
                         flow = 3000), cvpiaHabitat::upper_sacramento_river_instream[[3, 2]])

  expect_equal(
    set_instream_habitat(watershed = 'Upper Sacramento River',
                         species = 'fr', life_stage = 'fry',
                         flow = 200000), cvpiaHabitat::upper_sacramento_river_instream[[81, 2]])
})

test_that('FR juv Upper Sac works', {

  expect_equal(
    set_instream_habitat(watershed = 'Upper Sacramento River',
                         species = 'fr', life_stage = 'juv',
                         flow = 3000), cvpiaHabitat::upper_sacramento_river_instream[[3, 2]])

  expect_equal(
    set_instream_habitat(watershed = 'Upper Sacramento River',
                         species = 'fr', life_stage = 'juv',
                         flow = 6000), cvpiaHabitat::upper_sacramento_river_instream[[9, 2]])
})

test_that('FR spawn Upper Sac works', {
  wua1 <- cvpiaHabitat::upper_sac_ACID_boards_in$FR_spawn_WUA[1]
  wua2 <- cvpiaHabitat::upper_sac_ACID_boards_out$FR_spawn_WUA[1]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[cvpiaHabitat::watershed_lengths$watershed == 'Upper Sacramento River' &
                                                     cvpiaHabitat::watershed_lengths$lifestage == 'spawning','feet'])

  x1 <- ((stream_length/1000) * wua1)/10.7639
  x2 <- ((stream_length/1000) * wua2)/10.7639

  flow1 <- cvpiaHabitat::upper_sac_ACID_boards_in$flow_cfs[1]
  flow2 <- cvpiaHabitat::upper_sac_ACID_boards_out$flow_cfs[1]

  expect_equal(
    set_spawning_habitat(watershed = 'Upper Sacramento River',
                         species = 'fr', flow = flow1, month = 5), x1)

  expect_equal(
    set_spawning_habitat(watershed = 'Upper Sacramento River',
                         species = 'fr', flow = flow2, month = 2), x2)
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

test_that('FR floodplain Upper Sac works', {
  floodplain <- cvpiaHabitat::upper_sacramento_river_floodplain$floodplain_sq_meters[5]
  flow <- cvpiaHabitat::upper_sacramento_river_floodplain$flow_cfs[5]

  expect_equal(
    set_floodplain_habitat('Upper Sacramento River', 'fr', flow),
    floodplain,
    tolerance = .01)
})

# ----- modeling doesn't exist here
test_that('SR floodplain Upper Sac works', {
  floodplain <- cvpiaHabitat::upper_sacramento_river_floodplain$floodplain_sq_meters[5]
  flow <- cvpiaHabitat::upper_sacramento_river_floodplain$flow_cfs[5]

  expect_equal(
    set_floodplain_habitat('Upper Sacramento River', 'sr', flow),
    floodplain,
    tolerance = .01)
})
