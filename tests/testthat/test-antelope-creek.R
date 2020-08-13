library(cvpiaHabitat)
context('Antelope Creek Habitat')

test_that('FR fry Antelope works', {

  wua1 <- cvpiaHabitat::upper_mid_sac_region_instream$FR_fry_wua[1]
  wua2 <- cvpiaHabitat::upper_mid_sac_region_instream$FR_juv_wua[1]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[cvpiaHabitat::watershed_lengths$watershed == "Antelope Creek" &
                                                     cvpiaHabitat::watershed_lengths$lifestage == "rearing",
                                                   "feet"])

  x1 <- (((stream_length/1000) * wua1)/10.7639)
  x2 <- (((stream_length/1000) * wua2)/10.7639)

  flow <- cvpiaHabitat::upper_mid_sac_region_instream$flow_cfs[1]
  expect_equal(
    set_instream_habitat('Antelope Creek', 'fr', 'fry', flow), x1)

  expect_equal(
    set_instream_habitat('Antelope Creek', 'fr', 'juv', flow), x2)
})

test_that('FR spawn Antelope works', {

  wua <- cvpiaHabitat::upper_mid_sac_region_instream$FR_spawn_wua[1]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[cvpiaHabitat::watershed_lengths$watershed == "Antelope Creek" &
                                                     cvpiaHabitat::watershed_lengths$lifestage == "spawning",
                                                   "feet"])

  x <- (((stream_length/1000) * wua)/10.7639)

  flow <- cvpiaHabitat::upper_mid_sac_region_instream$flow_cfs[1]
  expect_equal(
    set_spawning_habitat('Antelope Creek', 'fr',flow), x)

})


test_that('SR fry Antelope works', {

  wua1 <- cvpiaHabitat::upper_mid_sac_region_instream$FR_fry_wua[1]
  wua2 <- cvpiaHabitat::upper_mid_sac_region_instream$FR_juv_wua[1]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[cvpiaHabitat::watershed_lengths$watershed == "Antelope Creek" &
                                                     cvpiaHabitat::watershed_lengths$lifestage == "rearing",
                                                   "feet"])

  x1 <- (((stream_length/1000) * wua1)/10.7639)
  x2 <- (((stream_length/1000) * wua2)/10.7639)

  flow <- cvpiaHabitat::upper_mid_sac_region_instream$flow_cfs[1]
  expect_equal(
    set_instream_habitat('Antelope Creek', 'sr', 'fry', flow), x1)

  expect_equal(
    set_instream_habitat('Antelope Creek', 'sr', 'juv', flow), x2)
})

test_that('SR spawn Antelope works', {

  wua <- cvpiaHabitat::upper_mid_sac_region_instream$FR_spawn_wua[1]
  stream_length <- as.numeric(cvpiaHabitat::watershed_lengths[cvpiaHabitat::watershed_lengths$watershed == "Antelope Creek" &
                                                     cvpiaHabitat::watershed_lengths$lifestage == "spawning",
                                                   "feet"])

  x <- (((stream_length/1000) * wua)/10.7639)

  flow <- cvpiaHabitat::upper_mid_sac_region_instream$flow_cfs[1]
  expect_equal(
    set_spawning_habitat('Antelope Creek', 'sr',flow), x)

})

test_that('FR floodplain Antelope works', {
  flow <- cvpiaHabitat::antelope_creek_floodplain$flow_cfs[10]
  floodplain <- as.numeric(cvpiaHabitat::antelope_creek_floodplain[cvpiaHabitat::antelope_creek_floodplain$flow_cfs == flow,
                                                        "FR_floodplain_acres"])
  expect_equal(
    square_meters_to_acres(set_floodplain_habitat('Antelope Creek', 'fr', flow)),
    floodplain,
    tolerance = .01)
})

test_that('SR floodplain Antelope works', {
  flow <- cvpiaHabitat::antelope_creek_floodplain$flow_cfs[10]
  floodplain <- as.numeric(cvpiaHabitat::antelope_creek_floodplain[cvpiaHabitat::antelope_creek_floodplain$flow_cfs == flow,
                                                        "FR_floodplain_acres"])
  expect_equal(
    square_meters_to_acres(set_floodplain_habitat('Antelope Creek', 'sr', flow)),
    floodplain,
    tolerance = .01)
})
