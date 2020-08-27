library(cvpiaHabitat)
context('Battle Creek Habitat')

test_that("modeling of species coverage hasn't changed since v2.0 - Battle", {
  modeling <- subset(cvpiaHabitat::modeling_exist, Watershed == 'Battle Creek')

  expect_equal(modeling$FR_spawn, TRUE)
  expect_equal(modeling$FR_fry, TRUE)
  expect_equal(modeling$FR_juv, TRUE)
  expect_equal(modeling$FR_floodplain, FALSE)

  expect_equal(modeling$SR_spawn, FALSE)
  expect_equal(modeling$SR_fry, FALSE)
  expect_equal(modeling$SR_juv, FALSE)
  expect_equal(modeling$SR_floodplain, FALSE)

  expect_equal(modeling$ST_spawn, TRUE)
  expect_equal(modeling$ST_fry, TRUE)
  expect_equal(modeling$ST_juv, TRUE)
  expect_equal(modeling$ST_floodplain, FALSE)
  expect_equal(modeling$ST_adult, TRUE)
})

test_that('FR rearing Battle Creek works', {
  # flow 100
  wua1 <- cvpiaHabitat::battle_creek_instream$FR_fry_wua[10]
  wua2 <- cvpiaHabitat::battle_creek_instream$FR_juv_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Battle Creek' & lifestage == 'rearing'
                          & species == 'fr')$feet

  x1 <- ((stream_length/1000) * wua1)/10.7639
  x2 <- ((stream_length/1000) * wua2)/10.7639

  flow = cvpiaHabitat::battle_creek_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('Battle Creek', 'fr', 'fry', flow), x1)
  expect_equal(
    set_instream_habitat('Battle Creek', 'fr', 'juv', 26), x2)

})

test_that('SR rearing Battle Creek works', {
  # flow 100
  wua1 <- cvpiaHabitat::battle_creek_instream$FR_fry_wua[10]
  wua2 <- cvpiaHabitat::battle_creek_instream$FR_juv_wua[10]

  stream_length = subset(cvpiaHabitat::watershed_lengths,
         watershed == 'Battle Creek' & lifestage == 'rearing'
         & species == 'sr')$feet

  x1 <- ((stream_length/1000) * wua1)/10.7639
  x2 <- ((stream_length/1000) * wua2)/10.7639

  flow = cvpiaHabitat::battle_creek_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('Battle Creek', 'sr', 'fry', flow), x1)
  expect_equal(
    set_instream_habitat('Battle Creek', 'sr', 'juv', flow), x2)

})


test_that('ST rearing Battle Creek works', {
  # flow 100
  wua1 <- cvpiaHabitat::battle_creek_instream$ST_fry_wua[10]
  wua2 <- cvpiaHabitat::battle_creek_instream$ST_juv_wua[10]

  stream_length = subset(cvpiaHabitat::watershed_lengths,
                         watershed == 'Battle Creek' & lifestage == 'rearing'
                         & species == 'st')$feet

  x1 <- ((stream_length/1000) * wua1)/10.7639
  x2 <- ((stream_length/1000) * wua2)/10.7639

  flow = cvpiaHabitat::battle_creek_instream$flow_cfs[10]
  expect_equal(
    set_instream_habitat('Battle Creek', 'st', 'fry', flow), x1)
  expect_equal(
    set_instream_habitat('Battle Creek', 'st', 'juv', flow), x2)

})

# spawning
test_that('FR spawn Battle Creek works', {
  # flow 100
  wua <- cvpiaHabitat::battle_creek_instream$FR_spawn_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Battle Creek' & lifestage == 'spawning'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  flow = cvpiaHabitat::battle_creek_instream$flow_cfs[10]
  expect_equal(
    set_spawning_habitat('Battle Creek', 'fr', flow), x)

})

test_that('SR spawn Battle Creek works', {
  # flow 100
  wua <- cvpiaHabitat::battle_creek_instream$FR_spawn_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Battle Creek' & lifestage == 'spawning'
                          & species == 'sr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  flow = cvpiaHabitat::battle_creek_instream$flow_cfs[10]
  expect_equal(
    set_spawning_habitat('Battle Creek', 'sr', flow), x)

})

test_that('ST spawn Battle Creek works', {
  # flow 100
  wua <- cvpiaHabitat::battle_creek_instream$ST_spawn_wua[10]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Battle Creek' & lifestage == 'spawning'
                          & species == 'st')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  flow = cvpiaHabitat::battle_creek_instream$flow_cfs[10]
  expect_equal(
    set_spawning_habitat('Battle Creek', 'st', flow), x)

})
