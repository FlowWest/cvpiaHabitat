library(cvpiaHabitat)
context('Battle Creek Habitat')

test_that('FR fry Battle Creek works', {
  # flow 100
  wua <- cvpiaHabitat::battle_creek_instream$FR_fry_wua[10]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[
    cvpiaHabitat::watershed_lengths$watershed == 'Battle Creek' &
      cvpiaHabitat::watershed_lengths$lifestage == 'rearing' &
      cvpiaHabitat::watershed_lengths$species == 'fr', 'feet'])

  x <- ((stream_length/1000) * wua)/10.7639

  flow = cvpiaHabitat::battle_creek_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('Battle Creek', 'fr', 'fry', flow), x)

})

test_that('FR juv Battle Creek works', {
  # flow 100
  wua <- cvpiaHabitat::battle_creek_instream$FR_juv_wua[10]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[
    cvpiaHabitat::watershed_lengths$watershed == 'Battle Creek' &
      cvpiaHabitat::watershed_lengths$lifestage == 'rearing' &
      cvpiaHabitat::watershed_lengths$species == 'fr', 'feet'])

  x <- ((stream_length/1000) * wua)/10.7639

  flow = cvpiaHabitat::battle_creek_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('Battle Creek', 'fr', 'juv', 26), x)

})


test_that('SR fry Battle Creek works', {
  # flow 100
  wua <- cvpiaHabitat::battle_creek_instream$FR_fry_wua[10]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[
    cvpiaHabitat::watershed_lengths$watershed == 'Battle Creek' &
      cvpiaHabitat::watershed_lengths$lifestage == 'rearing' &
      cvpiaHabitat::watershed_lengths$species == 'sr', 'feet'])

  x <- ((stream_length/1000) * wua)/10.7639

  flow = cvpiaHabitat::battle_creek_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('Battle Creek', 'sr', 'fry', flow), x)

})

test_that('SR juv Battle Creek works', {
  # flow 100
  wua <- cvpiaHabitat::battle_creek_instream$FR_juv_wua[10]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[
    cvpiaHabitat::watershed_lengths$watershed == 'Battle Creek' &
      cvpiaHabitat::watershed_lengths$lifestage == 'rearing' &
      cvpiaHabitat::watershed_lengths$species == 'sr', 'feet'])

  x <- ((stream_length/1000) * wua)/10.7639

  flow = cvpiaHabitat::battle_creek_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('Battle Creek', 'sr', 'juv', flow), x)

})

test_that('ST fry Battle Creek works', {
  # flow 100
  wua <- cvpiaHabitat::battle_creek_instream$FR_fry_wua[10]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[
    cvpiaHabitat::watershed_lengths$watershed == 'Battle Creek' &
      cvpiaHabitat::watershed_lengths$lifestage == 'rearing' &
      cvpiaHabitat::watershed_lengths$species == 'st', 'feet'])

  x <- ((stream_length/1000) * wua)/10.7639

  flow = cvpiaHabitat::battle_creek_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('Battle Creek', 'st', 'fry', flow), x)

})

test_that('ST juv Battle Creek works', {
  # flow 100
  wua <- cvpiaHabitat::battle_creek_instream$FR_juv_wua[10]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[
    cvpiaHabitat::watershed_lengths$watershed == 'Battle Creek' &
      cvpiaHabitat::watershed_lengths$lifestage == 'rearing' &
      cvpiaHabitat::watershed_lengths$species == 'st', 'feet'])

  x <- ((stream_length/1000) * wua)/10.7639

  flow = cvpiaHabitat::battle_creek_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('Battle Creek', 'st', 'juv', flow), x)

})

# test_that('ST adult Battle Creek works', {
#   # flow 100
#   wua <- cvpiaHabitat::battle_creek_instream$ST_adult_wua[10]
#   stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[
#     cvpiaHabitat::watershed_lengths$watershed == 'Battle Creek' &
#       cvpiaHabitat::watershed_lengths$lifestage == 'rearing' &
#       cvpiaHabitat::watershed_lengths$species == 'fr', 'feet'])
#
#   x <- ((stream_length/1000) * wua)/10.7639
#
#   flow = cvpiaHabitat::battle_creek_instream$flow_cfs[10]
#   expect_equal(
#     set_instream_habitat('Battle Creek', 'st', 'adult', flow), x)
#
# })


# spawning
test_that('FR spawn Battle Creek works', {
  # flow 100
  wua <- cvpiaHabitat::battle_creek_instream$FR_spawn_wua[10]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[
    cvpiaHabitat::watershed_lengths$watershed == 'Battle Creek' &
      cvpiaHabitat::watershed_lengths$lifestage == 'spawning' &
      cvpiaHabitat::watershed_lengths$species == 'fr', 'feet'])

  x <- ((stream_length/1000) * wua)/10.7639

  flow = cvpiaHabitat::battle_creek_instream$flow_cfs[10]
  expect_equal(
    set_spawning_habitat('Battle Creek', 'fr', flow), x)

})

test_that('SR spawn Battle Creek works', {
  # flow 100
  wua <- cvpiaHabitat::battle_creek_instream$FR_spawn_wua[10]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[
    cvpiaHabitat::watershed_lengths$watershed == 'Battle Creek' &
      cvpiaHabitat::watershed_lengths$lifestage == 'spawning' &
      cvpiaHabitat::watershed_lengths$species == 'sr', 'feet'])

  x <- ((stream_length/1000) * wua)/10.7639

  flow = cvpiaHabitat::battle_creek_instream$flow_cfs[10]
  expect_equal(
    set_spawning_habitat('Battle Creek', 'sr', flow), x)

})

test_that('ST spawn Battle Creek works', {
  # flow 100
  wua <- cvpiaHabitat::battle_creek_instream$FR_spawn_wua[10]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[
    cvpiaHabitat::watershed_lengths$watershed == 'Battle Creek' &
      cvpiaHabitat::watershed_lengths$lifestage == 'spawning' &
      cvpiaHabitat::watershed_lengths$species == 'st', 'feet'])

  x <- ((stream_length/1000) * wua)/10.7639

  flow = cvpiaHabitat::battle_creek_instream$flow_cfs[10]
  expect_equal(
    set_spawning_habitat('Battle Creek', 'st', flow), x)

})
