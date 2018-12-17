library(cvpiaHabitat)
context('Mokelumne River Habitat')

test_that('FR fry Mokelumne River works', {

  wua <- cvpiaHabitat::mokelumne_river_instream$FR_fry_wua[12]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Mokelumne River' & lifestage == 'rearing'
                          & species == 'fr')$feet
  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('Mokelumne River', 'fr', 'fry', 500), x)


})

test_that('FR juv Mokelumne River works', {

  wua <- cvpiaHabitat::mokelumne_river_instream$FR_juv_wua[12]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Mokelumne River' & lifestage == 'rearing'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('Mokelumne River', 'fr', 'juv', 500), x)

})

test_that('FR spawn Mokelumne River works', {

  wua <- cvpiaHabitat::mokelumne_river_instream$FR_spawn_wua[11]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Mokelumne River' & lifestage == 'spawning'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_spawning_habitat('Mokelumne River', 'fr', 480), x)

})

test_that('ST spawn Mokelumne River works', {

  wua <- cvpiaHabitat::mokelumne_river_instream$ST_spawn_wua[11]
  stream_length <- subset(cvpiaHabitat::watershed_lengths,
                          watershed == 'Mokelumne River' & lifestage == 'spawning'
                          & species == 'fr')$feet

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_spawning_habitat('Mokelumne River', 'st', 480), x)

})

test_that('ST and SR rearing is same as FR', {
  expect_equal(
    set_instream_habitat('Mokelumne River', 'fr', 'fry', 1000),
    set_instream_habitat('Mokelumne River', 'sr', 'fry', 1000),
    set_instream_habitat('Mokelumne River', 'st', 'fry', 1000))

  expect_equal(
    set_instream_habitat('Mokelumne River', 'fr', 'juv', 1000),
    set_instream_habitat('Mokelumne River', 'sr', 'juv', 1000),
    set_instream_habitat('Mokelumne River', 'st', 'juv', 1000))
})
