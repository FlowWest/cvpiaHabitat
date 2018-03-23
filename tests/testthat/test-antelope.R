library(cvpiaHabitat)
context('Antelope Creek Habitat')

test_that('FR fry Antelope works', {

  wua1 <- cvpiaHabitat::upper_mid_sac_region_instream$FR_fry_wua[1]
  wua2 <- cvpiaHabitat::upper_mid_sac_region_instream$FR_juv_wua[1]
  stream_length <- cvpiaHabitat::watershed_lengths[[4, 5]]

  x1 <- ((stream_length/1000) * wua1)/10.7639
  x2 <- ((stream_length/1000) * wua2)/10.7639

  expect_equal(
    set_instream_habitat('Antelope Creek', 'fr', 'fry', 50), x1)

  expect_equal(
    set_instream_habitat('Antelope Creek', 'fr', 'juv', 50), x2)
})

test_that('FR spawn Antelope works', {

  wua <- cvpiaHabitat::upper_mid_sac_region_instream$FR_spawn_wua[1]
  stream_length <- cvpiaHabitat::watershed_lengths[[3, 5]]

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_spawning_habitat('Antelope Creek', 'fr',50), x)

})


test_that('SR fry Antelope works', {

  wua1 <- cvpiaHabitat::upper_mid_sac_region_instream$FR_fry_wua[1]
  wua2 <- cvpiaHabitat::upper_mid_sac_region_instream$FR_juv_wua[1]
  stream_length <- cvpiaHabitat::watershed_lengths[[4, 5]]

  x1 <- ((stream_length/1000) * wua1)/10.7639
  x2 <- ((stream_length/1000) * wua2)/10.7639

  expect_equal(
    set_instream_habitat('Antelope Creek', 'sr', 'fry', 50), x1)

  expect_equal(
    set_instream_habitat('Antelope Creek', 'sr', 'juv', 50), x2)
})

test_that('SR spawn Antelope works', {

  wua <- cvpiaHabitat::upper_mid_sac_region_instream$FR_spawn_wua[1]
  stream_length <- cvpiaHabitat::watershed_lengths[[3, 5]]

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_spawning_habitat('Antelope Creek', 'sr',50), x)

})

test_that('FR floodplain Antelope works', {
  expect_equal(
    square_meters_to_acres(set_floodplain_habitat('Antelope Creek', 'fr', 406.32224)),
    cvpiaHabitat::antelope_creek_floodplain[[10,2]],
    tolerance = .01)
})

test_that('SR floodplain Antelope works', {
  expect_equal(
    square_meters_to_acres(set_floodplain_habitat('Antelope Creek', 'sr', 406.32224)),
    cvpiaHabitat::antelope_creek_floodplain[[10,2]],
    tolerance = .01)
})
