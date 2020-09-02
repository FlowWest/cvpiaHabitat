library(cvpiaHabitat)
context('Sutter Bypass Habitat')

test_that("modeling of species coverage hasn't changed since v2.0 - Sutter Bypass", {
  modeling <- subset(cvpiaHabitat::modeling_exist, Watershed == 'Sutter Bypass')

  expect_equal(is.na(modeling$FR_spawn), TRUE)
  expect_equal(modeling$FR_fry, TRUE)
  expect_equal(modeling$FR_juv, TRUE)
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

test_that('Sutter Bypass 2 instream works', {
  bypass2_not_na_index <- which(!is.na(cvpiaHabitat::sutter_bypass_habitat$'Sutter Bypass 2'))[1]

  bypass2 <- cvpiaHabitat::sutter_bypass_habitat$'Sutter Bypass 2'[bypass2_not_na_index]
  flow = sutter_bypass_habitat$flow_cfs[bypass2_not_na_index]

  expect_equal(
    set_bypass_habitat(bypass = 'sutter2',
                         flow = flow),
    bypass2)
})

test_that('Sutter Bypass 2 floodplain works', {

  expect_equal(
    set_bypass_floodplain_habitat(bypass = 'sutter2',
                                flow = 4000),
    sutter_bypass_floodplain[[22, 3]])

})

#FIGURE OUT WHAT TODO HERE W FLOODPLAIN
test_that('Sutter Bypass 1 instream works', {
  expect_equal(
    set_bypass_instream_habitat(bypass = 'sutter1',
                                flow = 4000),
    sutter_bypass_instream[[22, 2]])
})

test_that('Sutter Bypass 1 floodplain works', {

  expect_equal(
    set_bypass_floodplain_habitat(bypass = 'sutter1',
                                  flow = 4000),
    sutter_bypass_floodplain[[22, 2]])

})

test_that('Yolo Bypass 1 instream works', {
  expect_equal(
    set_bypass_instream_habitat(bypass = 'yolo1',
                                flow = 100),
    yolo_bypass_instream[[10, 2]])
})

test_that('Yolo Bypass 1 floodplain works', {

  expect_equal(
    set_bypass_floodplain_habitat(bypass = 'yolo1',
                                  flow = 200000),
    yolo_bypass_floodplain[[2, 2]])

})

test_that('Yolo Bypass 2 instream works', {
  expect_equal(
    set_bypass_instream_habitat(bypass = 'yolo2',
                                flow = 100),
    yolo_bypass_instream[[10, 3]])
})

test_that('Yolo Bypass 2 floodplain works', {

  expect_equal(
    set_bypass_floodplain_habitat(bypass = 'yolo2',
                                  flow = 200000),
    yolo_bypass_floodplain[[2, 3]])

})
