test_that("Spring Run cases fall back to Fall Run when SR is false but FR is true", {

  watershed_cases <-
    dplyr::pull(dplyr::filter(modeling_exist, FR_spawn, !SR_spawn), Watershed)

  expect_equal(set_spawning_habitat("Battle Creek", "fr", 123),
               set_spawning_habitat("Battle Creek", "sr", 123))
  expect_equal(set_spawning_habitat("Butte Creek", "fr", 123),
               set_spawning_habitat("Butte Creek", "sr", 123))
  expect_equal(set_spawning_habitat("Cottonwood Creek", "fr", 123),
               set_spawning_habitat("Cottonwood Creek", "sr", 123))
  expect_equal(set_spawning_habitat("Feather River", "fr", 123),
               set_spawning_habitat("Feather River", "sr", 123))
  expect_equal(set_spawning_habitat("Mokelumne River", "fr", 123),
               set_spawning_habitat("Mokelumne River", "sr", 123))
  expect_equal(set_spawning_habitat("Stanislaus River", "fr", 123),
               set_spawning_habitat("Stanislaus River", "sr", 123))
  expect_equal(set_spawning_habitat("Tuolumne River", "fr", 123),
               set_spawning_habitat("Tuolumne River", "sr", 123))

})

test_that("Steelead cases fall back to Fall Run when ST is false but FR is true", {

  watershed_cases <-
    dplyr::pull(dplyr::filter(modeling_exist, FR_spawn, !ST_spawn), Watershed)

  expect_equal(set_spawning_habitat("Battle Creek", "fr", 123),
               set_spawning_habitat("Battle Creek", "st", 123))
  expect_equal(set_spawning_habitat("Butte Creek", "fr", 123),
               set_spawning_habitat("Butte Creek", "st", 123))
  expect_equal(set_spawning_habitat("Cottonwood Creek", "fr", 123),
               set_spawning_habitat("Cottonwood Creek", "st", 123))
  expect_equal(set_spawning_habitat("Bear River", "fr", 123),
               set_spawning_habitat("Bear River", "st", 123))
  expect_equal(set_spawning_habitat("Feather River", "fr", 123),
               set_spawning_habitat("Feather River", "st", 123))
  expect_equal(set_spawning_habitat("Calaveras River", "fr", 123),
               set_spawning_habitat("Calaveras River", "st", 123))
  expect_equal(set_spawning_habitat("Mokelumne River", "fr", 123),
               set_spawning_habitat("Mokelumne River", "st", 123))
  expect_equal(set_spawning_habitat("Merced River", "fr", 123),
               set_spawning_habitat("Merced River", "st", 123))
  expect_equal(set_spawning_habitat("Stanislaus River", "fr", 123),
               set_spawning_habitat("Stanislaus River", "st", 123))
  expect_equal(set_spawning_habitat("Tuolumne River", "fr", 123),
               set_spawning_habitat("Tuolumne River", "st", 123))

})

