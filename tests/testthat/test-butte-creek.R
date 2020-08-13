library(cvpiaHabitat)
context('Butte Creek Habitat')

test_that('FR fry Butte Creek works', {
  # flow 100
  wua <- cvpiaHabitat::butte_creek_instream$FR_fry_wua[10]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[
    cvpiaHabitat::watershed_lengths$watershed == 'Butte Creek' &
      cvpiaHabitat::watershed_lengths$lifestage == 'rearing' &
      cvpiaHabitat::watershed_lengths$species == 'fr', 'feet'])

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::butte_creek_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('Butte Creek', 'fr', 'fry', flow), x)

})

test_that('FR juv Butte Creek works', {
  # flow 100
  wua <- cvpiaHabitat::butte_creek_instream$FR_juv_wua[10]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[
    cvpiaHabitat::watershed_lengths$watershed == 'Butte Creek' &
      cvpiaHabitat::watershed_lengths$lifestage == 'rearing' &
      cvpiaHabitat::watershed_lengths$species == 'fr', 'feet'])

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::butte_creek_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('Butte Creek', 'fr', 'juv', flow), x)

})


test_that('SR fry Butte Creek works', {
  # flow 100
  wua <- cvpiaHabitat::butte_creek_instream$FR_fry_wua[10]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[
    cvpiaHabitat::watershed_lengths$watershed == 'Butte Creek' &
      cvpiaHabitat::watershed_lengths$lifestage == 'rearing' &
      cvpiaHabitat::watershed_lengths$species == 'sr', 'feet'])

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::butte_creek_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('Butte Creek', 'sr', 'fry', flow), x)

})

test_that('SR juv Butte Creek works', {
  # flow 100
  wua <- cvpiaHabitat::butte_creek_instream$FR_juv_wua[10]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[
    cvpiaHabitat::watershed_lengths$watershed == 'Butte Creek' &
      cvpiaHabitat::watershed_lengths$lifestage == 'rearing' &
      cvpiaHabitat::watershed_lengths$species == 'sr', 'feet'])

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::butte_creek_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('Butte Creek', 'sr', 'juv', flow), x)

})

test_that('ST fry Butte Creek works', {
  # flow 100
  wua <- cvpiaHabitat::butte_creek_instream$FR_fry_wua[10]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[
    cvpiaHabitat::watershed_lengths$watershed == 'Butte Creek' &
      cvpiaHabitat::watershed_lengths$lifestage == 'rearing' &
      cvpiaHabitat::watershed_lengths$species == 'st', 'feet'])

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::butte_creek_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('Butte Creek', 'st', 'fry', flow), x)

})

test_that('ST juv Butte Creek works', {
  # flow 100
  wua <- cvpiaHabitat::butte_creek_instream$FR_juv_wua[10]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[
    cvpiaHabitat::watershed_lengths$watershed == 'Butte Creek' &
      cvpiaHabitat::watershed_lengths$lifestage == 'rearing' &
      cvpiaHabitat::watershed_lengths$species == 'st', 'feet'])

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::butte_creek_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('Butte Creek', 'st', 'juv', flow), x)

})

# spawning
test_that('FR spawn Butte Creek works', {
  # flow 100
  wua <- cvpiaHabitat::butte_creek_instream$FR_spawn_wua[10]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[
    cvpiaHabitat::watershed_lengths$watershed == 'Butte Creek' &
      cvpiaHabitat::watershed_lengths$lifestage == 'spawning' &
      cvpiaHabitat::watershed_lengths$species == 'fr', 'feet'])

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::butte_creek_instream$flow_cfs[10]
  expect_equal(
    set_spawning_habitat('Butte Creek', 'fr', flow), x)

})

test_that('SR spawn Butte Creek works', {
  # flow 100
  wua <- cvpiaHabitat::butte_creek_instream$FR_spawn_wua[10]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[
    cvpiaHabitat::watershed_lengths$watershed == 'Butte Creek' &
      cvpiaHabitat::watershed_lengths$lifestage == 'spawning' &
      cvpiaHabitat::watershed_lengths$species == 'sr', 'feet'])

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::butte_creek_instream$flow_cfs[10]
  expect_equal(
    set_spawning_habitat('Butte Creek', 'sr', flow), x)

})

test_that('ST spawn Butte Creek works', {
  # flow 100
  wua <- cvpiaHabitat::butte_creek_instream$FR_spawn_wua[10]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[
    cvpiaHabitat::watershed_lengths$watershed == 'Butte Creek' &
      cvpiaHabitat::watershed_lengths$lifestage == 'spawning' &
      cvpiaHabitat::watershed_lengths$species == 'st', 'feet'])

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::butte_creek_instream$flow_cfs[10]
  expect_equal(
    set_spawning_habitat('Butte Creek', 'st', flow), x)

})
