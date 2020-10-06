library(cvpiaHabitat)
context('San Joaquin River Habitat')

test_that("modeling of species coverage hasn't changed since v2.0 - San Joaquin", {
  modeling <- subset(cvpiaHabitat::modeling_exist, Watershed == 'San Joaquin River')

  expect_equal(modeling$FR_spawn, FALSE)
  expect_equal(modeling$FR_fry, FALSE)
  expect_equal(modeling$FR_juv, FALSE)
  expect_equal(modeling$FR_floodplain, TRUE)

  expect_equal(is.na(modeling$SR_spawn), TRUE)
  expect_equal(modeling$SR_fry, FALSE)
  expect_equal(modeling$SR_juv, FALSE)
  expect_equal(modeling$SR_floodplain, FALSE)

  expect_equal(is.na(modeling$ST_spawn), TRUE)
  expect_equal(modeling$ST_fry, FALSE)
  expect_equal(modeling$ST_juv, FALSE)
  expect_equal(modeling$ST_floodplain, FALSE)
  expect_equal(modeling$ST_adult, FALSE)
})

test_that('FR fry San Joaquin River works', {

  wua <- cvpiaHabitat::san_joaquin_river_instream$FR_fry_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'San Joaquin River' & lifestage == 'rearing'
                          & species == 'fr')$feet
  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::san_joaquin_river_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('San Joaquin River', 'fr', 'fry', flow), x)


})

test_that('FR juv San Joaquin River works', {

  wua <- cvpiaHabitat::san_joaquin_river_instream$FR_juv_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'San Joaquin River' & lifestage == 'rearing'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  flow <- cvpiaHabitat::san_joaquin_river_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('San Joaquin River', 'fr', 'juv', flow), x)

})

test_that('FR spawn San Joaquin River works', {

  x <- NA

  expect_equal(
    set_spawning_habitat('San Joaquin River', 'fr', 400), x)

})


test_that('ST and SR = FR San Joaquin River works', {

  expect_equal(
    set_spawning_habitat('San Joaquin River', 'fr', 275),
    set_spawning_habitat('San Joaquin River', 'sr', 275),
    set_spawning_habitat('San Joaquin River', 'st', 275))

  expect_equal(
    set_instream_habitat('San Joaquin River', 'fr', 'fry', 1000),
    set_instream_habitat('San Joaquin River', 'sr', 'fry', 1000),
    set_instream_habitat('San Joaquin River', 'st', 'fry', 1000))

  expect_equal(
    set_instream_habitat('San Joaquin River', 'fr', 'juv', 1000),
    set_instream_habitat('San Joaquin River', 'sr', 'juv', 1000),
    set_instream_habitat('San Joaquin River', 'st', 'juv', 1000))

})

test_that('FR floodplain San Joaquin River works', {
  first_flood_index <-  which(cvpiaHabitat::san_joaquin_river_floodplain$FR_floodplain_acres > 0)[1]

  flow <- cvpiaHabitat::san_joaquin_river_floodplain$flow_cfs[first_flood_index]
  floodplain <- subset(cvpiaHabitat::san_joaquin_river_floodplain,flow_cfs == flow)$FR_floodplain_acres

  expect_equal(
    square_meters_to_acres(set_floodplain_habitat('San Joaquin River', 'fr', flow)),
    floodplain,
    tolerance = .01)
})

# Tests for species/habitat without modeling (FALSE modeling_exists) ----

test_that('FR rearing San Joaquin River works', {

  fry_not_na_index <- which(!is.na(cvpiaHabitat::san_joaquin_river_instream$FR_fry_wua))[1]
  juv_not_na_index <- which(!is.na(cvpiaHabitat::san_joaquin_river_instream$FR_juv_wua))[1]

  fry_wua <- cvpiaHabitat::san_joaquin_river_instream$FR_fry_wua[fry_not_na_index]
  juv_wua <- cvpiaHabitat::san_joaquin_river_instream$FR_juv_wua[juv_not_na_index]

  rearing_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                  watershed == 'San Joaquin River' & lifestage == 'rearing'
                                  & species == 'fr')$feet

  fryx <- (((rearing_stream_length/1000) * fry_wua)/10.7639)
  juvx <- (((rearing_stream_length/1000) * juv_wua)/10.7639)

  fry_flow <- cvpiaHabitat::san_joaquin_river_instream$flow_cfs[fry_not_na_index]
  juv_flow <- cvpiaHabitat::san_joaquin_river_instream$flow_cfs[juv_not_na_index]

  expect_equal(
    set_instream_habitat('San Joaquin River', 'fr', 'fry', fry_flow), fryx)
  expect_equal(
    set_instream_habitat('San Joaquin River', 'fr', 'juv', juv_flow), juvx)
})
