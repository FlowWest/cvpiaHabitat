library(cvpiaHabitat)
context('Sutter Bypass Habitat')

# Sutter bypass -----

test_that("modeling of species coverage hasn't changed - Sutter Bypass", {
  modeling <- subset(cvpiaHabitat::modeling_exist, Watershed == 'Sutter Bypass')

  expect_equal(is.na(modeling$FR_spawn), TRUE)
  expect_equal(modeling$FR_fry, FALSE)
  expect_equal(modeling$FR_juv, FALSE)
  expect_equal(is.na(modeling$FR_floodplain), TRUE)

  expect_equal(is.na(modeling$SR_spawn), TRUE)
  expect_equal(modeling$SR_fry, FALSE)
  expect_equal(modeling$SR_juv, FALSE)
  expect_equal(is.na(modeling$SR_floodplain), TRUE)

  expect_equal(is.na(modeling$WR_spawn), TRUE)
  expect_equal(modeling$WR_fry, FALSE)
  expect_equal(modeling$WR_juv, TRUE)
  expect_equal(is.na(modeling$WR_floodplain), TRUE)

  expect_equal(is.na(modeling$ST_spawn), TRUE)
  expect_equal(modeling$ST_fry, FALSE)
  expect_equal(modeling$ST_juv, FALSE)
  expect_equal(is.na(modeling$ST_floodplain), TRUE)
  expect_equal(modeling$ST_adult, FALSE)
})


test_that('Sutter Bypass 1 instream works', {
  bypass1_not_na_index <- which(!is.na(cvpiaHabitat::sutter_bypass_habitat$'Sutter Bypass 1'))[1]

  bypass1 <- cvpiaHabitat::sutter_bypass_habitat$'Sutter Bypass 1'[bypass1_not_na_index]
  flow = sutter_bypass_habitat$flow_cfs[bypass1_not_na_index]

  expect_equal(
    set_bypass_habitat(bypass = 'sutter1',
                       flow = flow),
    bypass1)
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


# Yolo bypass -----

test_that("modeling of species coverage hasn't changed - Yolo Bypass", {
  modeling <- subset(cvpiaHabitat::modeling_exist, Watershed == 'Yolo Bypass')

  expect_equal(is.na(modeling$FR_spawn), TRUE)
  expect_equal(modeling$FR_fry, FALSE)
  expect_equal(modeling$FR_juv, FALSE)
  expect_equal(is.na(modeling$FR_floodplain), TRUE)

  expect_equal(is.na(modeling$SR_spawn), TRUE)
  expect_equal(modeling$SR_fry, FALSE)
  expect_equal(modeling$SR_juv, FALSE)
  expect_equal(is.na(modeling$SR_floodplain), TRUE)

  expect_equal(is.na(modeling$WR_spawn), TRUE)
  expect_equal(modeling$WR_fry, FALSE)
  expect_equal(modeling$WR_juv, TRUE)
  expect_equal(is.na(modeling$WR_floodplain), TRUE)

  expect_equal(is.na(modeling$ST_spawn), TRUE)
  expect_equal(modeling$ST_fry, FALSE)
  expect_equal(modeling$ST_juv, FALSE)
  expect_equal(is.na(modeling$ST_floodplain), TRUE)
  expect_equal(modeling$ST_adult, FALSE)
})

test_that('Yolo Bypass 1 instream works', {
  bypass1_not_na_index <- which(!is.na(cvpiaHabitat::yolo_bypass_habitat$'Yolo Bypass 1'))[1]

  bypass1 <- cvpiaHabitat::yolo_bypass_habitat$'Yolo Bypass 1'[bypass1_not_na_index]
  flow = yolo_bypass_habitat$flow_cfs[bypass1_not_na_index]

  expect_equal(
    set_bypass_habitat(bypass = 'yolo1',
                       flow = flow),
    bypass1)
})

test_that('Yolo Bypass 2 instream works', {
  bypass2_not_na_index <- which(!is.na(cvpiaHabitat::yolo_bypass_habitat$'Yolo Bypass 2'))[1]

  bypass2 <- cvpiaHabitat::yolo_bypass_habitat$'Yolo Bypass 2'[bypass2_not_na_index]
  flow = yolo_bypass_habitat$flow_cfs[bypass2_not_na_index]

  expect_equal(
    set_bypass_habitat(bypass = 'yolo2',
                       flow = flow),
    bypass2)
})
