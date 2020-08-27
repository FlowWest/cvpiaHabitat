library(cvpiaHabitat)
context('Cottonwood Creek Habitat')

test_that('FR fry Cottonwood Creek works', {

  wua <- cvpiaHabitat::cottonwood_creek_instream$FR_fry_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Cottonwood Creek' & lifestage == 'rearing'
                          & species == 'fr')$feet
  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::cottonwood_creek_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('Cottonwood Creek', 'fr', 'fry', flow), x)

})

test_that('FR juv Cottonwood Creek works', {

  wua <- cvpiaHabitat::cottonwood_creek_instream$FR_juv_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Cottonwood Creek' & lifestage == 'rearing'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::cottonwood_creek_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('Cottonwood Creek', 'fr', 'juv', flow), x)

})

test_that('FR spawn Cottonwood Creek works', {

  wua <- cvpiaHabitat::cottonwood_creek_instream$FR_spawn_wua[9]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Cottonwood Creek' & lifestage == 'spawning'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::cottonwood_creek_instream$flow_cfs[9]
  expect_equal(
    set_spawning_habitat('Cottonwood Creek', 'fr', flow), x)

})

test_that('FR floodplain Cottonwood Creek works', {
  flow <- cvpiaHabitat::cottonwood_creek_floodplain$flow_cfs[24]
  floodplain <- as.numeric(cvpiaHabitat::cottonwood_creek_floodplain[cvpiaHabitat::cottonwood_creek_floodplain$flow_cfs == flow,
                                                                "FR_floodplain_acres"])
  expect_equal(
    square_meters_to_acres(set_floodplain_habitat('Cottonwood Creek', 'fr', flow)),
    floodplain,
    tolerance = .01)
})
