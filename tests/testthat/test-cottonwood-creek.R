library(cvpiaHabitat)
context('Cottonwood Creek Habitat')

test_that('FR fry Cottonwood Creek works', {

  wua <- cvpiaHabitat::cottonwood_creek_instream$FR_fry_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Cottonwood Creek' & lifestage == 'rearing'
                          & species == 'fr')$feet
  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('Cottonwood Creek', 'fr', 'fry', 95), x)

})

test_that('FR juv Cottonwood Creek works', {

  wua <- cvpiaHabitat::cottonwood_creek_instream$FR_juv_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Cottonwood Creek' & lifestage == 'rearing'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('Cottonwood Creek', 'fr', 'juv', 95), x)

})

test_that('FR spawn Cottonwood Creek works', {

  wua <- cvpiaHabitat::cottonwood_creek_instream$FR_spawn_wua[9]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Cottonwood Creek' & lifestage == 'spawning'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_spawning_habitat('Cottonwood Creek', 'fr', 86), x)

})
