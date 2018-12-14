library(cvpiaHabitat)
context('Bear River Habitat')

test_that('FR fry Bear River works', {
  expect_equal(
    set_instream_habitat('Bear River', 'fr', 'fry', 140),
    set_instream_habitat('Bear River', 'fr', 'juv', 140))

})

test_that('FR juv Bear River works', {
  # flow 140
  wua <- cvpiaHabitat::bear_river_instream$FR_juv_wua[3]
  stream_length <- cvpiaHabitat::watershed_lengths[[33, 5]]

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('Bear River', 'fr', 'juv', 140), x)

})

test_that('FR spawn Bear River works', {
  # flow 30
  wua <- cvpiaHabitat::bear_river_instream$FR_spawn_wua[1]
  stream_length <- cvpiaHabitat::watershed_lengths[[32, 5]]

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_spawning_habitat('Bear River', 'fr', 30), x)

})


