library(cvpiaHabitat)
context('American River Habitat')

test_that('FR fry American River works', {
  # flow 300
  wua <- cvpiaHabitat::american_river_instream$FR_fry_wua[6]
  stream_length <- cvpiaHabitat::watershed_lengths[[40, 5]]

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('American River', 'fr', 'fry', 300), x)

})

test_that('FR juv American River works', {
  # flow 300
  wua <- cvpiaHabitat::american_river_instream$FR_juv_wua[6]
  stream_length <- cvpiaHabitat::watershed_lengths[[40, 5]]

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('American River', 'fr', 'fry', 300), x)

})

test_that('FR spawn American River works', {
  # flow 300
  wua <- cvpiaHabitat::american_river_instream$FR_juv_wua[6]
  stream_length <- cvpiaHabitat::watershed_lengths[[40, 5]]

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('American River', 'fr', 'fry', 300), x)

})
