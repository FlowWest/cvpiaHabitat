library(cvpiaHabitat)
context('Stanislaus River Habitat')

test_that('FR fry Stanislaus River works', {

  wua <- cvpiaHabitat::stanislaus_river_instream$FR_fry_wua[6]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Stanislaus River' & lifestage == 'rearing'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::stanislaus_river_instream$flow_cfs[6]
  expect_equal(
    set_instream_habitat('Stanislaus River', 'fr', 'fry', flow), x)

})

test_that('FR juv Stanislaus River works', {

  wua <- cvpiaHabitat::stanislaus_river_instream$FR_juv_wua[6]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Stanislaus River' & lifestage == 'rearing'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::stanislaus_river_instream$flow_cfs[6]
  expect_equal(
    set_instream_habitat('Stanislaus River', 'fr', 'juv', flow), x)

})

test_that('FR spawn Stanislaus River works', {

  wua <- cvpiaHabitat::stanislaus_river_instream$FR_spawn_wua[6]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Stanislaus River' & lifestage == 'spawning'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::stanislaus_river_instream$flow_cfs[6]
  expect_equal(
    set_spawning_habitat('Stanislaus River', 'fr', flow), x)

})

test_that('SR and ST is same as FR Stanislaus River', {

  expect_equal(
    set_spawning_habitat('Stanislaus River', 'fr', 250),
    set_spawning_habitat('Stanislaus River', 'sr', 250),
    set_spawning_habitat('Stanislaus River', 'st', 250))

  expect_equal(
    set_instream_habitat('Stanislaus River', 'fr', 'fry', 250),
    set_instream_habitat('Stanislaus River', 'sr', 'fry', 250),
    set_instream_habitat('Stanislaus River', 'st', 'fry', 250))

  expect_equal(
    set_instream_habitat('Stanislaus River', 'fr', 'juv', 250),
    set_instream_habitat('Stanislaus River', 'sr', 'juv', 250),
    set_instream_habitat('Stanislaus River', 'st', 'juv', 250))

})
