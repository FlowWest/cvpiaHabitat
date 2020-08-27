library(cvpiaHabitat)
context('Calaveras River Habitat')

test_that('FR fry Calaveras River works', {
  flow <-
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
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[cvpiaHabitat::watershed_lengths$watershed == "Calaveras River" &
                                                                cvpiaHabitat::watershed_lengths$lifestage == "rearing",
                                                              "feet"])

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::calaveras_river_instream$flow_cfs[4]
  expect_equal(
    set_instream_habitat('Calaveras River', 'st', 'fry', flow), x)

})


test_that('ST juv Calaveras River works', {
  # flow 100
  wua <- cvpiaHabitat::calaveras_river_instream$ST_juv_wua[4]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[cvpiaHabitat::watershed_lengths$watershed == "Calaveras River" &
                                                                cvpiaHabitat::watershed_lengths$lifestage == "rearing",
                                                              "feet"])

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::calaveras_river_instream$flow_cfs[4]
  expect_equal(
    set_instream_habitat('Calaveras River', 'st', 'juv', flow), x)

})

test_that('ST spawn Calaveras River works', {
  # flow 100
  wua <- cvpiaHabitat::calaveras_river_instream$ST_spawn_wua[4]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[cvpiaHabitat::watershed_lengths$watershed == "Calaveras River" &
                                                                cvpiaHabitat::watershed_lengths$lifestage == "spawning",
                                                              "feet"])

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::calaveras_river_instream$flow_cfs[4]
  expect_equal(
    set_spawning_habitat('Calaveras River', 'st', flow), x)

})

test_that('FR spawn Calaveras River works', {
  # flow 100
  wua <- cvpiaHabitat::calaveras_river_instream$ST_spawn_wua[4]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[cvpiaHabitat::watershed_lengths$watershed == "Calaveras River" &
                                                                cvpiaHabitat::watershed_lengths$lifestage == "spawning",
                                                              "feet"])

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::calaveras_river_instream$flow_cfs[4]
  expect_equal(
    set_spawning_habitat('Calaveras River', 'fr', flow), x)

})


