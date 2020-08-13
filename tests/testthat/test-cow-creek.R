library(cvpiaHabitat)
context('Cow Creek Habitat')

test_that('FR fry Cow Creek works', {

  wua <- cvpiaHabitat::cow_creek_instream$FR_fry_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Cow Creek' & lifestage == 'rearing'
                          & species == 'fr')$feet
  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::cow_creek_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('Cow Creek', 'fr', 'fry', flow), x)


})

test_that('FR juv Cow Creek works', {

  wua <- cvpiaHabitat::cow_creek_instream$FR_juv_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Cow Creek' & lifestage == 'rearing'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::cow_creek_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('Cow Creek', 'fr', 'juv', flow), x)

})

test_that('FR spawn Cow Creek works', {

  wua <- cvpiaHabitat::upper_mid_sac_region_instream$FR_spawn_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Cow Creek' & lifestage == 'spawning'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::upper_mid_sac_region_instream$flow_cfs[10]
  expect_equal(
    set_spawning_habitat('Cow Creek', 'fr', flow), x)

})


test_that('ST fry Cow Creek works', {

  wua <- cvpiaHabitat::cow_creek_instream$FR_fry_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Cow Creek' & lifestage == 'rearing'
                          & species == 'st')$feet
  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::cow_creek_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('Cow Creek', 'st', 'fry', flow), x)


})

test_that('ST juv Cow Creek works', {

  wua <- cvpiaHabitat::cow_creek_instream$FR_juv_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Cow Creek' & lifestage == 'rearing'
                          & species == 'st')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::cow_creek_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('Cow Creek', 'st', 'juv', flow), x)

})

test_that('ST spawn Cow Creek works', {

  wua <- cvpiaHabitat::upper_mid_sac_region_instream$FR_spawn_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Cow Creek' & lifestage == 'spawning'
                          & species == 'st')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::upper_mid_sac_region_instream$flow_cfs[10]
  expect_equal(
    set_spawning_habitat('Cow Creek', 'st', flow), x)

})
