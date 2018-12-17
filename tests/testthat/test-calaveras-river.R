library(cvpiaHabitat)
context('Calaveras River Habitat')

test_that('FR fry Calaveras River works', {
  expect_equal(
    set_instream_habitat('Calaveras River', 'fr', 'fry', 140),
    set_instream_habitat('Calaveras River', 'st', 'fry', 140))

})

test_that('FR juv Calaveras River works', {
  expect_equal(
    set_instream_habitat('Calaveras River', 'fr', 'juv', 140),
    set_instream_habitat('Calaveras River', 'st', 'juv', 140))

})

test_that('ST fry Calaveras River works', {
  # flow 100
  wua <- cvpiaHabitat::calaveras_river_instream$ST_fry_wua[4]
  stream_length <- cvpiaHabitat::watershed_lengths[[42, 5]]

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('Calaveras River', 'st', 'fry', 100), x)

})


test_that('ST juv Calaveras River works', {
  # flow 100
  wua <- cvpiaHabitat::calaveras_river_instream$ST_juv_wua[4]
  stream_length <- cvpiaHabitat::watershed_lengths[[42, 5]]

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('Calaveras River', 'st', 'juv', 100), x)

})

test_that('ST spawn Calaveras River works', {
  # flow 100
  wua <- cvpiaHabitat::calaveras_river_instream$ST_spawn_wua[4]
  stream_length <- cvpiaHabitat::watershed_lengths[[43, 5]]

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_spawning_habitat('Calaveras River', 'st', 100), x)

})

test_that('FR spawn Calaveras River works', {
  # flow 100
  wua <- cvpiaHabitat::calaveras_river_instream$ST_spawn_wua[4]
  stream_length <- cvpiaHabitat::watershed_lengths[[43, 5]]

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_spawning_habitat('Calaveras River', 'fr', 100), x)

})


