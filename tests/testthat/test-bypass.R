library(cvpiaHabitat)
context('Sutter Bypass Habitat')

test_that('Sutter Bypass 2 instream works', {
  expect_equal(
    set_bypass_instream_habitat(bypass = 'sutter2',
                         flow = 4000),
    sutter_bypass_instream[[22, 3]])
})

test_that('Sutter Bypass 2 floodplain works', {

  expect_equal(
    set_bypass_floodplain_habitat(bypass = 'sutter2',
                                flow = 4000),
    sutter_bypass_floodplain[[22, 3]])

})

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
