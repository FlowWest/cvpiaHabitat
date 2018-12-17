library(cvpiaHabitat)
context('San Joaquin River Habitat')

test_that('FR fry San Joaquin River works', {

  wua <- cvpiaHabitat::san_joaquin_river_instream$FR_fry_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'San Joaquin River' & lifestage == 'rearing'
                          & species == 'fr')$feet
  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('San Joaquin River', 'fr', 'fry', 450), x)


})

test_that('FR juv San Joaquin River works', {

  wua <- cvpiaHabitat::san_joaquin_river_instream$FR_juv_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'San Joaquin River' & lifestage == 'rearing'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('San Joaquin River', 'fr', 'juv', 450), x)

})

test_that('FR spawn San Joaquin River works', {

  x <- NA

  expect_equal(
    set_spawning_habitat('San Joaquin River', 'fr', 400), x)

})


test_that('ST and SR = FR San Joaquin River works', {

  expect_equal(
    set_spawning_habitat('San Joaquin River', 'fr', 275),
    set_spawning_habitat('San Joaquin River', 'sr', 275),
    set_spawning_habitat('San Joaquin River', 'st', 275))

  expect_equal(
    set_instream_habitat('San Joaquin River', 'fr', 'fry', 1000),
    set_instream_habitat('San Joaquin River', 'sr', 'fry', 1000),
    set_instream_habitat('San Joaquin River', 'st', 'fry', 1000))

  expect_equal(
    set_instream_habitat('San Joaquin River', 'fr', 'juv', 1000),
    set_instream_habitat('San Joaquin River', 'sr', 'juv', 1000),
    set_instream_habitat('San Joaquin River', 'st', 'juv', 1000))

})
