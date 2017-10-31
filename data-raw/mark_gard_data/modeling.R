library(tidyverse)
library(readxl)

# create catalogue of modeling
fall_run_fp <- read_excel('data-raw/mark_gard_data/floodplain2017update.xlsx')

fp <- fall_run_fp %>%
  mutate(Floodplain_Modeled = Method != 'redo scaling, length based and then categorize by geography') %>%
  select(Order, Watershed, Floodplain_Modeled)

fall_run_ic <- read_excel('data-raw/mark_gard_data/instream2017update.xlsx', skip = 1)

icr <- fall_run_ic %>%
  filter(`Life Stage` == 'rearing') %>%
  mutate(Instream_Rearing_Modeled = Method != 'Total area * percent suitable') %>%
  select(Watershed, Instream_Rearing_Modeled)

ics <- fall_run_ic %>%
  filter(`Life Stage` == 'spawning') %>%
  mutate(Instream_Spawning_Modeled = Method != 'Total area * percent suitable') %>%
  select(Watershed, Instream_Spawning_Modeled)

icsr <- fall_run_ic %>%
  filter(`Life Stage` == 'spawning and rearing') %>%
  mutate(Instream_SR_Modeled = Method != 'Total area * percent suitable') %>%
  select(Watershed, Instream_SR_Modeled)

modeling_exist <- fp %>%
  left_join(icr) %>%
  left_join(ics) %>%
  left_join(icsr) %>%
  mutate(Instream_Spawning_Modeled = ifelse(is.na(Instream_Spawning_Modeled),
                             Instream_SR_Modeled, Instream_Spawning_Modeled),
         Instream_Rearing_Modeled = ifelse(is.na(Instream_Rearing_Modeled),
                             Instream_SR_Modeled, Instream_Rearing_Modeled)) %>%
  select(Order, Watershed, Spawning = Instream_Spawning_Modeled,
         Rearing = Instream_Rearing_Modeled, Floodplain = Floodplain_Modeled) %>%
  filter(Watershed != 'Bear Creek') %>%
  bind_rows(tibble(Order = 4, Watershed = 'Bear Creek', Spawning = FALSE, Rearing = FALSE, Floodplain = FALSE)) %>%
  mutate(Rearing = replace(Rearing, Watershed == 'South Delta', FALSE)) %>%
  arrange(Order) %>%
  unique()




# ---

watershed_region <- read_csv("data-raw/watershed_by_regions.csv")

modeling_exist <- modeling_exist %>% left_join(watershed_region)



sr_st_modeling_exists <- read_csv("data-raw/mark_gard_data/sr_st_modeling_exists.csv")


modeling_exist <- modeling_exist %>%
  left_join(sr_st_modeling_exists) %>%
  mutate(FR = TRUE, SR = !is.na(`Spring Run`), ST = TRUE) %>%
  select(-`Spring Run`, -Steelhead)

devtools::use_data(modeling_exist, overwrite = TRUE)
