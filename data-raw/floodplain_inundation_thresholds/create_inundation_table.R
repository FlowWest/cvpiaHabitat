library(tidyverse)

weeks_inundated <- bind_rows(
  read_rds('data-raw/floodplain_inundation_thresholds/yuba_inundated.rds'),
  read_rds('data-raw/floodplain_inundation_thresholds/big_chico_inundated.rds'),
  read_rds('data-raw/floodplain_inundation_thresholds/butte_inundated.rds'),
  read_rds('data-raw/floodplain_inundation_thresholds/cottonwood_inundated.rds'))

use_data(weeks_inundated, overwrite = TRUE)
