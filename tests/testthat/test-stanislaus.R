library(cvpiaHabitat)
context('Stanislaus River Habitat')

test_that('FR fry Stanislaus River works', {
  # flow 250
  wua <- cvpiaHabitat::stanislaus_river_instream$FR_fry_wua[6]
  stream_length <- cvpiaHabitat::watershed_lengths[[50, 5]]

  x <- ((stream_length/1000) * wua)/10.7639

  expect_equal(
    set_instream_habitat('Stanislaus River', 'fr', 'fry', 250), x)

})

# test_that('ST fry Stanislaus River works', {
#   # flow 250
#   wua <- cvpiaHabitat::stanislaus_river_instream$ST_fry_wua[6]
#   stream_length <- cvpiaHabitat::watershed_lengths[[50, 5]]
#   glimpse(cvpiaHabitat::watershed_lengths)
#   filter(cvpiaHabitat::watershed_lengths, species == 'st', watershed == 'Stanislaus River')
#   x <- ((stream_length/1000) * wua)/10.7639
#
#   expect_equal(
#     set_instream_habitat('Stanislaus River', 'fr', 'fry', 250), x)
#
# })
#
# View(cvpiaHabitat::modeling_exist)
