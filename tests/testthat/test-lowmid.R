library(cvpiaHabitat)
context('Lower-mid Sacramento Habitat')

test_that('FR fry Lower Sac works', {

  flow1 <- cvpiaHabitat::lower_mid_sacramento_river_instream$flow_cfs[5]
  flow2 <- cvpiaHabitat::lower_mid_sacramento_river_instream$flow_cfs[4]

  expect_equal(
    set_instream_habitat(watershed = 'Lower-mid Sacramento River',
                         species = 'fr', life_stage = 'fry',
                         flow = flow1, flow2 = flow2),
    35.6/58 * cvpiaHabitat::lower_mid_sacramento_river_instream$rearing_sq_meters[5] +
      22.4/58 * cvpiaHabitat::lower_mid_sacramento_river_instream$rearing_sq_meters[4])
})

test_that('FR juv Lower-mid Sac works', {

  flow1 <- cvpiaHabitat::lower_mid_sacramento_river_instream$flow_cfs[5]
  flow2 <- cvpiaHabitat::lower_mid_sacramento_river_instream$flow_cfs[4]

  expect_equal(
    set_instream_habitat(watershed = 'Lower-mid Sacramento River',
                         species = 'fr', life_stage = 'juv',
                         flow = flow1, flow2 = flow2),
    35.6/58 * cvpiaHabitat::lower_mid_sacramento_river_instream$rearing_sq_meters[5] +
      22.4/58 * cvpiaHabitat::lower_mid_sacramento_river_instream$rearing_sq_meters[4])

})


test_that('FR floodplain Lower-mid Sac works', {

  flow1 <- cvpiaHabitat::lower_mid_sacramento_river_floodplain$flow_cfs[5]
  flow2 <- cvpiaHabitat::lower_mid_sacramento_river_floodplain$flow_cfs[4]

  expect_equal(
    set_floodplain_habitat('Lower-mid Sacramento River', 'fr', flow = flow1, flow2 = flow2),
    35.6/58 * cvpiaHabitat::lower_mid_sacramento_river_floodplain$floodplain_sq_meters[5] +
      22.4/58 * cvpiaHabitat::lower_mid_sacramento_river_floodplain$floodplain_sq_meters[4],
    tolerance = .01)
})

test_that('SR floodplain Lower-mid Sac works', {

  flow1 <- cvpiaHabitat::lower_mid_sacramento_river_floodplain$flow_cfs[5]
  flow2 <- cvpiaHabitat::lower_mid_sacramento_river_floodplain$flow_cfs[4]

  expect_equal(
    set_floodplain_habitat('Lower-mid Sacramento River', 'sr', flow = flow1, flow2 = flow2),
    35.6/58 * cvpiaHabitat::lower_mid_sacramento_river_floodplain$floodplain_sq_meters[5] +
      22.4/58 * cvpiaHabitat::lower_mid_sacramento_river_floodplain$floodplain_sq_meters[4],
    tolerance = .01)
})
