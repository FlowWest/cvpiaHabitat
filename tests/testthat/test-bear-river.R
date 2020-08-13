library(cvpiaHabitat)
context('Bear River Habitat')

test_that('FR fry Bear River works', {
  flow <- cvpiaHabitat::bear_river_instream$flow_cfs[3]
  expect_equal(
    set_instream_habitat('Bear River', 'fr', 'fry', flow),
    set_instream_habitat('Bear River', 'fr', 'juv', flow))

})

test_that('FR juv Bear River works', {
  # flow 140
  wua <- cvpiaHabitat::bear_river_instream$FR_juv_wua[3]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[cvpiaHabitat::watershed_lengths$watershed == 'Bear River'
                                                   & cvpiaHabitat::watershed_lengths$lifestage == 'rearing',
                                                   'feet'])

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::bear_river_instream$flow_cfs[3]
  expect_equal(
    set_instream_habitat('Bear River', 'fr', 'juv', flow), x)

})

test_that('FR spawn Bear River works', {
  # flow 30
  wua <- cvpiaHabitat::bear_river_instream$FR_spawn_wua[1]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[cvpiaHabitat::watershed_lengths$watershed == 'Bear River'
                                                              & cvpiaHabitat::watershed_lengths$lifestage == 'spawning',
                                                              'feet'])

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::bear_river_instream$flow_cfs[1]
  expect_equal(
    set_spawning_habitat('Bear River', 'fr', flow), x)

})


