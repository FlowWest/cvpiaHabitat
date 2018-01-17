library(tidyverse)
library(devtools)

weeks_inundated <- bind_rows(
  read_rds('data-raw/floodplain_inundation_thresholds/yuba_inundated.rds'),
  read_rds('data-raw/floodplain_inundation_thresholds/big_chico_inundated.rds'),
  read_rds('data-raw/floodplain_inundation_thresholds/butte_inundated.rds'),
  read_rds('data-raw/floodplain_inundation_thresholds/cottonwood_inundated.rds'),
  read_rds('data-raw/floodplain_inundation_thresholds/deer_inundated.rds'),
  read_rds('data-raw/floodplain_inundation_thresholds/bear_river_inundated.rds'),
  read_rds('data-raw/floodplain_inundation_thresholds/feather_river_inundated.rds'),
  read_rds('data-raw/floodplain_inundation_thresholds/american_river_inundated.rds'),
  read_rds('data-raw/floodplain_inundation_thresholds/calaveras_river_inundated.rds'),
  read_rds('data-raw/floodplain_inundation_thresholds/merced_river_inundated.rds'),
  read_rds('data-raw/floodplain_inundation_thresholds/stanislaus_river_inundated.rds'))

devtools::use_data(weeks_inundated, overwrite = TRUE)
