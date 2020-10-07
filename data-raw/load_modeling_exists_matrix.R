library(tidyverse)

# create catalogue of modeling
modeling_exist <- read_csv('data-raw/modeling_exists.csv')

usethis::use_data(modeling_exist, overwrite = TRUE)

modeling_exist %>% glimpse

# make san joaquin spawn false, no spawning in model
# modeling_exist %>%
#   mutate(spawn = ifelse(is.na(FR_spawn), FALSE, TRUE),
#          fr = TRUE,
#          sr = ifelse(is.na(SR_spawn), FALSE, TRUE),
#          st = ifelse(is.na(ST_spawn), FALSE, TRUE),
#          use_mid_sac_spawn_proxy = UseSpawnRegionApprox & Region == "Upper-mid Sacramento River",
#          use_mid_sac_rear_proxy = UseRearRegionApprox & Region == "Upper-mid Sacramento River") %>%
#   select(watershed = Watershed, order = Order, spawn, fr, sr, st, use_mid_sac_spawn_proxy, use_mid_sac_rear_proxy) %>%
#   write_csv("data-raw/watershed_metadata.csv")

watershed_metadata <- read_csv('data-raw/watershed_metadata.csv')
usethis::use_data(watershed_metadata, overwrite = TRUE)
