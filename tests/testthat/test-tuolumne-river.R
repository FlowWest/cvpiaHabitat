library(cvpiaHabitat)
context('Tuolumne River Habitat')

test_that('FR fry Tuolumne River works', {

  wua <- cvpiaHabitat::tuolumne_river_instream$FR_fry_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Tuolumne River' & lifestage == 'rearing'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('Tuolumne River', 'fr', 'fry', 275), x)

})

test_that('FR juv Tuolumne River works', {

  wua <- cvpiaHabitat::tuolumne_river_instream$FR_juv_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Tuolumne River' & lifestage == 'rearing'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('Tuolumne River', 'fr', 'juv', 275), x)

})

test_that('FR spawn Tuolumne River works', {

  wua <- cvpiaHabitat::tuolumne_river_instream$FR_spawn_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Tuolumne River' & lifestage == 'spawning'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_spawning_habitat('Tuolumne River', 'fr', 275), x)

})

test_that('ST fry Tuolumne River works', {

  wua <- cvpiaHabitat::tuolumne_river_instream$ST_fry_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Tuolumne River' & lifestage == 'rearing'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('Tuolumne River', 'st', 'fry', 275), x)

})

test_that('ST juv Tuolumne River works', {

  wua <- cvpiaHabitat::tuolumne_river_instream$ST_juv_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Tuolumne River' & lifestage == 'rearing'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('Tuolumne River', 'st', 'juv', 275), x)

})

test_that('ST spawn Tuolumne River works', {

  wua <- cvpiaHabitat::tuolumne_river_instream$ST_spawn_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Tuolumne River' & lifestage == 'spawning'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_spawning_habitat('Tuolumne River', 'st', 275), x)

})



test_that('SR and ST are the same Tuolumne River', {

  expect_equal(
    set_spawning_habitat('Tuolumne River', 'fr', 275),
    set_spawning_habitat('Tuolumne River', 'sr', 275))

  expect_equal(
    set_instream_habitat('Tuolumne River', 'st', 'fry', 275),
    set_instream_habitat('Tuolumne River', 'sr', 'fry', 275))

  expect_equal(
    set_instream_habitat('Tuolumne River', 'st', 'juv', 275),
    set_instream_habitat('Tuolumne River', 'sr', 'juv', 275))

})
