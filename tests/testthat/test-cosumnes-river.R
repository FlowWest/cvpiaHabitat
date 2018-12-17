library(cvpiaHabitat)
context('Cosumnes River Habitat')

test_that('FR fry Cosumnes River works', {

  wua <- cvpiaHabitat::cosumnes_river_instream$FR_fry_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Cosumnes River' & lifestage == 'rearing'
                          & species == 'fr')$feet
  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('Cosumnes River', 'fr', 'fry', 1000), x)


})

test_that('FR juv Cosumnes River works', {

  wua <- cvpiaHabitat::cosumnes_river_instream$FR_juv_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Cosumnes River' & lifestage == 'rearing'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('Cosumnes River', 'fr', 'juv', 1000), x)

})

test_that('FR spawn Cosumnes River works', {

  wua <- cvpiaHabitat::cosumnes_river_instream$FR_spawn_wua[4]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Cosumnes River' & lifestage == 'spawning'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_spawning_habitat('Cosumnes River', 'fr', 400), x)

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
