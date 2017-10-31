library(tidyverse)
library(readxl)

# create catalogue of modeling
watershed_region <- read_csv("data-raw/watershed_by_regions.csv")
fall_run_fp <- read_excel('data-raw/mark_gard_data/floodplain2017update.xlsx')

fp <- fall_run_fp %>%
  mutate(FR_floodplain = Method != 'redo scaling, length based and then categorize by geography') %>%
  select(Order, Watershed, FR_floodplain)

fall_run_ic <- read_excel('data-raw/mark_gard_data/instream2017update.xlsx', skip = 1)

no_fry_modeling <- c('Bear River', 'Upper Sacramento River', 'Upper-mid Sacramento River',
                     'Lower-mid Sacramento River', 'Lower Sacramento River')

icr <- fall_run_ic %>%
  filter(`Life Stage` == 'rearing') %>%
  mutate(FR_juv = Method != 'Total area * percent suitable',
         FR_fry = ifelse(FR_juv & !(Watershed %in% no_fry_modeling), TRUE, FALSE)) %>%
  select(Order, Watershed, FR_fry, FR_juv)

ics <- fall_run_ic %>%
  filter(`Life Stage` == 'spawning') %>%
  mutate(FR_spawn = Method != 'Total area * percent suitable') %>%
  select(Order, Watershed, FR_spawn)

icsr <- fall_run_ic %>%
  filter(`Life Stage` == 'spawning and rearing') %>%
  mutate(FR_spawn = Method != 'Total area * percent suitable',
         FR_fry = ifelse(FR_spawn & !(Watershed %in% no_fry_modeling), TRUE, FALSE),
         FR_juv = FR_spawn) %>%
  select(Order, Watershed, FR_spawn, FR_fry, FR_juv)

FR_modeling <- full_join(ics, icr) %>%
  full_join(icsr) %>%
  full_join(fp) %>%
  unique() %>%
  filter(Watershed != 'Bear Creek') %>%
  bind_rows(data.frame(Order = 4, Watershed = 'Bear Creek', FR_spawn = FALSE,
                       FR_fry = FALSE, FR_juv = FALSE, FR_floodplain = FALSE)) %>%
  arrange(Order)
glimpse(FR_modeling)
View(FR_modeling)

sr_st_modeling_exists <- read_csv("data-raw/mark_gard_data/sr_st_modeling_exists.csv")

sr_st_modeling_exists %>%
  mutate(SR_spawn = case_when())

modeling_exist <- FR_modeling %>%
  left_join(sr_st_modeling_exists) %>%
  mutate(SR_spawn = case_when(
    FR_spawn & `Spring Run` == "same method, different values" ~ TRUE,
    FR_spawn & !is.na(`Spring Run`) ~ FALSE,
    !FR_spawn & !is.na(`Spring Run`) ~ FALSE,
    TRUE ~ NA),
    SR_fry = case_when(
      FR_fry & `Spring Run` == "same method, different values" ~ TRUE,
      !is.na(`Spring Run`) ~ FALSE,
      is.na(`Spring Run`) ~ NA),
    SR_juv = case_when(
      `Spring Run` == "same method, different values" ~ TRUE,
      !is.na(`Spring Run`) ~ FALSE,
      is.na(`Spring Run`) ~ NA),
    SR_floodplain = ifelse(is.na(`Spring Run`), NA, FALSE),
    ST_spawn = case_when(
      FR_spawn & Steelhead == "same method different values (just for spawning)" ~ TRUE,
      FR_spawn & Steelhead == "same method different values" ~ TRUE,
      is.na(FR_spawn) ~ NA,
      TRUE ~ FALSE),
    ST_fry = ifelse(FR_fry & Steelhead == "same method different values", TRUE, FALSE),
    ST_juv = ifelse(FR_juv  & Steelhead == "same method different values", TRUE, FALSE),
    ST_floodplain = FALSE) %>%
  select(-`Spring Run`, -Steelhead) %>%
  left_join(watershed_region)

devtools::use_data(modeling_exist, overwrite = TRUE)

