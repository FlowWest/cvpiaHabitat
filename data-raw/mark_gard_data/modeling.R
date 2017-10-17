library(tidyverse)
library(readxl)

# create catalogue of modeling
fall_run_fp <- read_excel('data-raw/mark_gard_data/floodplain2017update.xlsx')

fp <- fall_run_fp %>%
  mutate(Floodplain_Modeled = Method == 'redo scaling, length based and then categorize by geography') %>%
  select(Order, Watershed, Floodplain_Modeled)

fall_run_ic <- read_excel('data-raw/mark_gard_data/instream2017update.xlsx', skip = 1)

icr <- fall_run_ic %>%
  filter(`Life Stage` == 'rearing') %>%
  mutate(Instream_Rearing_Modeled = Method == 'Total area * percent suitable') %>%
  select(Watershed, Instream_Rearing_Modeled)

ics <- fall_run_ic %>%
  filter(`Life Stage` == 'spawning') %>%
  mutate(Instream_Spawning_Modeled = Method == 'Total area * percent suitable') %>%
  select(Watershed, Instream_Spawning_Modeled)

icsr <- fall_run_ic %>%
  filter(`Life Stage` == 'spawning and rearing') %>%
  mutate(Instream_SR_Modeled = Method == 'Total area * percent suitable') %>%
  select(Watershed, Instream_SR_Modeled)

fp %>%
  left_join(icr) %>%
  left_join(ics) %>%
  left_join(icsr) %>%
  mutate(Instream_S = ifelse(is.na(Instream_Spawning_Modeled), Instream_SR_Modeled, Instream_Spawning_Modeled))

View(fall_run_ic)
