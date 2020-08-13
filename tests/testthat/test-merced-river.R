library(cvpiaHabitat)
context('Merced River Habitat')

test_that('FR fry Merced River works', {

  wua <- cvpiaHabitat::merced_river_instream$FR_fry_wua[9]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Merced River' & lifestage == 'rearing'
                          & species == 'fr')$feet
  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::merced_river_instream$flow_cfs[9]
  expect_equal(
    set_instream_habitat('Merced River', 'fr', 'fry', flow), x)


})

test_that('FR juv Merced River works', {

  wua <- cvpiaHabitat::merced_river_instream$FR_juv_wua[9]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Merced River' & lifestage == 'rearing'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::merced_river_instream$flow_cfs[9]
  expect_equal(
    set_instream_habitat('Merced River', 'fr', 'juv', flow), x)

})

test_that('FR spawn Merced River works', {

  wua <- cvpiaHabitat::merced_river_instream$FR_spawn_wua[9]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Merced River' & lifestage == 'spawning'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::merced_river_instream$flow_cfs[9]
  expect_equal(
    set_spawning_habitat('Merced River', 'fr', flow), x)

})

test_that('ST is same as FR', {
  expect_equal(
    set_instream_habitat('Merced River', 'fr', 'fry', 2500),
    set_instream_habitat('Merced River', 'st', 'fry', 2500))

  expect_equal(
    set_instream_habitat('Merced River', 'fr', 'juv', 2500),
    set_instream_habitat('Merced River', 'st', 'juv', 2500))

  expect_equal(
    set_spawning_habitat('Merced River', 'fr', 2500),
    set_spawning_habitat('Merced River', 'st', 2500))
})
