library(cvpiaHabitat)
context('Feather River Habitat')

test_that('FR fry Feather River works', {

  wua <- cvpiaHabitat::feather_river_instream$FR_fry_wua[9]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Feather River' & lifestage == 'rearing'
                          & species == 'fr')$feet
  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('Feather River', 'fr', 'fry', 2500), x)


})

test_that('FR juv Feather River works', {

  wua <- cvpiaHabitat::feather_river_instream$FR_juv_wua[9]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Feather River' & lifestage == 'rearing'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('Feather River', 'fr', 'juv', 2500), x)

})

test_that('FR spawn Feather River works', {

  wua <- cvpiaHabitat::feather_river_instream$FR_spawn_wua[9]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Feather River' & lifestage == 'spawning'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_spawning_habitat('Feather River', 'fr', 2500), x)

})

test_that('ST and SR are same as FR', {
  expect_equal(
    set_instream_habitat('Feather River', 'fr', 'fry', 2500),
    set_instream_habitat('Feather River', 'sr', 'fry', 2500),
    set_instream_habitat('Feather River', 'st', 'fry', 2500))

  expect_equal(
    set_instream_habitat('Feather River', 'fr', 'juv', 2500),
    set_instream_habitat('Feather River', 'sr', 'juv', 2500),
    set_instream_habitat('Feather River', 'st', 'juv', 2500))

  expect_equal(
    set_spawning_habitat('Feather River', 'fr', 2500),
    set_spawning_habitat('Feather River', 'sr', 2500),
    set_spawning_habitat('Feather River', 'st', 2500))
})
