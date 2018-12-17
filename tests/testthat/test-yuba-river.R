library(cvpiaHabitat)
context('Yuba River Habitat')

test_that('FR fry Yuba River works', {

  wua <- cvpiaHabitat::yuba_river_instream$FR_fry_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Yuba River' & lifestage == 'rearing'
                          & species == 'fr')$feet
  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('Yuba River', 'fr', 'fry', 900), x)


})

test_that('FR juv Yuba River works', {

  wua <- cvpiaHabitat::yuba_river_instream$FR_juv_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Yuba River' & lifestage == 'rearing'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('Yuba River', 'fr', 'juv', 900), x)

})

test_that('FR spawn Yuba River works', {

  wua <- cvpiaHabitat::yuba_river_instream$FR_spawn_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Yuba River' & lifestage == 'spawning'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_spawning_habitat('Yuba River', 'fr', 900), x)

})


test_that('SR spawn Yuba River works', {

  wua <- cvpiaHabitat::yuba_river_instream$SR_spawn_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Yuba River' & lifestage == 'spawning'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_spawning_habitat('Yuba River', 'sr', 900), x)

})


test_that('ST fry Yuba River works', {

  wua <- cvpiaHabitat::yuba_river_instream$ST_fry_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Yuba River' & lifestage == 'rearing'
                          & species == 'fr')$feet
  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('Yuba River', 'st', 'fry', 900), x)


})

test_that('ST juv Yuba River works', {

  wua <- cvpiaHabitat::yuba_river_instream$ST_juv_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Yuba River' & lifestage == 'rearing'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('Yuba River', 'st', 'juv', 900), x)

})

test_that('ST spawn Yuba River works', {

  wua <- cvpiaHabitat::yuba_river_instream$ST_spawn_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Yuba River' & lifestage == 'spawning'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_spawning_habitat('Yuba River', 'st', 900), x)

})


test_that('SR rearing are same as ST', {

  expect_equal(
    set_instream_habitat('Yuba River', 'st', 'fry', 2500),
    set_instream_habitat('Yuba River', 'sr', 'fry', 2500))

  expect_equal(
    set_instream_habitat('Yuba River', 'st', 'juv', 2500),
    set_instream_habitat('Yuba River', 'sr', 'juv', 2500))

})
