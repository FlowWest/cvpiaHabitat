library(cvpiaHabitat)
context('Clear Creek Habitat')

test_that('FR fry Clear Creek works', {

  wua1 <- cvpiaHabitat::clear_creek_instream$FR_fry_wua[1]
  wua2 <- cvpiaHabitat::clear_creek_instream$FR_juv_wua[1]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Clear Creek' & species == 'fr' & lifestage == 'rearing')$feet

  x1 <- ((stream_length/1000) * wua1)/10.7639
  x2 <- ((stream_length/1000) * wua2)/10.7639

  expect_equal(
    set_instream_habitat('Clear Creek', 'fr', 'fry', 50), x1)

  expect_equal(
    set_instream_habitat('Clear Creek', 'fr', 'juv', 50), x2)
})

test_that('FR spawn Clear Creek works', {

  wua <- cvpiaHabitat::clear_creek_instream$FR_spawn_wua[1]
  stream_length <- cvpiaHabitat::watershed_lengths[[14, 5]]

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_spawning_habitat('Clear Creek', 'fr',50), x)

})


test_that('SR fry Clear works', {

  wua1 <- cvpiaHabitat::clear_creek_instream$SR_fry_wua[1]
  wua2 <- cvpiaHabitat::clear_creek_instream$SR_juv_wua[1]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Clear Creek' & species == 'sr' & lifestage == 'rearing')$feet
  x1 <- ((stream_length/1000) * wua1)/10.7639
  x2 <- ((stream_length/1000) * wua2)/10.7639

  expect_equal(
    set_instream_habitat('Clear Creek', 'sr', 'fry', 50), x1)

  expect_equal(
    set_instream_habitat('Clear Creek', 'sr', 'juv', 50), x2)
})

test_that('SR spawn Clear Creek works', {

  wua <- cvpiaHabitat::clear_creek_instream$SR_spawn_wua[1]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Clear Creek' & species == 'sr' & lifestage == 'spawning')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_spawning_habitat('Clear Creek', 'sr',50), x)

})

test_that('ST fry Clear works', {

  wua1 <- cvpiaHabitat::clear_creek_instream$ST_fry_wua[1]
  wua2 <- cvpiaHabitat::clear_creek_instream$ST_juv_wua[1]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Clear Creek' & species == 'st' & lifestage == 'rearing')$feet

  x1 <- ((stream_length/1000) * wua1)/10.7639
  x2 <- ((stream_length/1000) * wua2)/10.7639

  expect_equal(
    set_instream_habitat('Clear Creek', 'st', 'fry', 50), x1)

  expect_equal(
    set_instream_habitat('Clear Creek', 'st', 'juv', 50), x2)
})

test_that('ST spawn Clear Creek works', {

  wua <- cvpiaHabitat::clear_creek_instream$ST_spawn_wua[1]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Clear Creek' & species == 'st' & lifestage == 'spawning')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_spawning_habitat('Clear Creek', 'st',50), x)

})


test_that('FR floodplain Clear Creek works', {
  expect_equal(
    square_meters_to_acres(set_floodplain_habitat('Clear Creek', 'fr', 1665.526227 )),
    cvpiaHabitat::clear_creek_floodplain[[24,2]],
    tolerance = .01)
})

test_that('SR floodplain Clear Creek works', {
  expect_equal(
    square_meters_to_acres(set_floodplain_habitat('Clear Creek', 'sr', 1665.526227)),
    cvpiaHabitat::clear_creek_floodplain[[24, 3]],
    tolerance = .01)
})
