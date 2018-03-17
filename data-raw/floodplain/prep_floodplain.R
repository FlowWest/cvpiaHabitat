library(tidyverse)
library(readxl)
library(devtools)

sheets <- readxl::excel_sheets('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx')
sheets

.metadata <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx', sheet = 'MetaData',
                        col_types = c('text', 'text', 'text', 'text',
                                      rep('numeric', 17), 'text', 'numeric', 'text'), na = 'na')
glimpse(.metadata)


# function for partially modeled watersheds---------------------------------
# ws = watershed
# df = flow to area relationship dataframe for watershed
scale_fp_flow_area_partial_model <- function(ws, df) {

  watershed_metadata <- filter(.metadata, watershed == ws)
  spring_run_present <- !is.na(watershed_metadata$SR_rearing_length_mi)

  # remove channel area from total wetted area to obtain floodplain area
  watershed_channel_area <- watershed_metadata$FR_channel_area_of_length_modeled_acres # get channel area

  if (any(is.na(df$modeled_area_acres))) {
    # if there is no total area modeled use value supplied from Mark Gard
    fp_area <- df$modeled_floodplain_area_acres
  } else {
    # subtract channel area from total wetted area, no values less than 0
    fp_area <- ifelse(df$modeled_area_acres - watershed_channel_area >= 0,
                      df$modeled_area_acres - watershed_channel_area, 0)
  }

  fp_area_per_mile_modeled <- fp_area/watershed_metadata$FR_length_modeled_mi

  # fall run floodplain area
  low_grad_len_FR <- watershed_metadata$FR_low_gradient_length_mi
  high_grad_len_FR <- watershed_metadata$FR_high_gradient_length_mi

  #.1 is downscaling for high gradient
  fp_area_FR <- (fp_area_per_mile_modeled * low_grad_len_FR) +
    (fp_area_per_mile_modeled * high_grad_len_FR * 0.1)

  # steel head floodplain area
  low_grad_len_ST <- watershed_metadata$ST_low_gradient_length_mi
  high_grad_len_ST <- watershed_metadata$ST_high_gradient_length_mi

  fp_area_ST <- (fp_area_per_mile_modeled * low_grad_len_ST) +
    (fp_area_per_mile_modeled * high_grad_len_ST * 0.1)

  if (spring_run_present) {
    # spring run floodplain area
    low_grad_len_SR <- watershed_metadata$SR_low_gradient_length_mi
    high_grad_len_SR <- watershed_metadata$SR_high_gradient_length_mi

    fp_area_SR <- (fp_area_per_mile_modeled * low_grad_len_SR) +
      (fp_area_per_mile_modeled * high_grad_len_SR * 0.1)

    return(data.frame(
      flow_cfs = df$flow_cfs,
      FR_floodplain_acres = fp_area_FR,
      SR_floodplain_acres = fp_area_SR,
      ST_floodplain_acres = fp_area_ST,
      watershed = ws
    ))
  }

  return(
    data.frame(
      flow_cfs = df$flow_cfs,
      FR_floodplain_acres = fp_area_FR,
      ST_floodplain_acres = fp_area_ST,
      watershed = ws
    ))

}

# proxy watersheds for non-modeled watersheds----------------
# Deer Creek-------------------------------------
filter(.metadata, watershed == 'Deer Creek') %>% glimpse

deer_fp <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx', sheet = 'DeerCreek') %>%
  mutate(watershed = 'Deer Creek')

deer_creek_floodplain <- scale_fp_flow_area_partial_model(ws = 'Deer Creek', df = deer_fp)

use_data(deer_creek_floodplain, overwrite = TRUE)

# Cottonwood Creek -------------
filter(.metadata, watershed == 'Cottonwood Creek') %>% glimpse

cotton_fp <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx', sheet = 'CottonwoodCreek') %>%
  mutate(watershed = 'Cottonwood Creek')

cottonwood_creek_floodplain <- scale_fp_flow_area_partial_model(ws = 'Cottonwood Creek', df = cotton_fp)

use_data(cottonwood_creek_floodplain, overwrite = TRUE)

# Tuolumne River -------------
filter(.metadata, watershed == 'Tuolumne River') %>% glimpse
tuolumne_river_floodplain <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx', sheet = 'TuolumneRiver') %>%
  mutate(watershed = 'Tuolumne River',
         SR_floodplain_acres = modeled_floodplain_area_acres,
         ST_floodplain_acres = modeled_floodplain_area_acres) %>%
  select(flow_cfs,
         FR_floodplain_acres = modeled_floodplain_area_acres,
         SR_floodplain_acres, ST_floodplain_acres,
         watershed)

use_data(tuolumne_river_floodplain, overwrite = TRUE)

# no modeling exists method for creating flow to fp area-------------
scale_fp_flow_area <- function(ws) {

  watershed_metadata <- filter(.metadata, watershed == ws)
  spring_run_present <- !is.na(watershed_metadata$SR_rearing_length_mi)

  # appropriate proxy from watershed, df has flow to area curve
  proxy_watershed <- stringr::str_to_title(stringr::str_replace(watershed_metadata$scaling_watershed, '_', ' '))

  if (proxy_watershed == 'Deer Creek') {
    df <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx', sheet = 'DeerCreek') %>%
      mutate(watershed = 'Deer Creek',
             SR_floodplain_acres = modeled_floodplain_area_acres,
             ST_floodplain_acres = modeled_floodplain_area_acres) %>%
      select(flow_cfs,
             FR_floodplain_acres = modeled_floodplain_area_acres,
             SR_floodplain_acres, ST_floodplain_acres,
             watershed)
  } else if (proxy_watershed == 'Cottonwood Creek') {
    df <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx', sheet = 'CottonwoodCreek') %>%
      mutate(watershed = 'Cottonwood Creek',
             SR_floodplain_acres = modeled_floodplain_area_acres,
             ST_floodplain_acres = modeled_floodplain_area_acres) %>%
      select(flow_cfs,
             FR_floodplain_acres = modeled_floodplain_area_acres,
             SR_floodplain_acres, ST_floodplain_acres,
             watershed)
  } else {
    watershed_rda_name <- paste0(watershed_metadata$scaling_watershed, '_floodplain')
    df <- do.call(`::`, list(pkg = "cvpiaHabitat", name = watershed_rda_name))
  }

  proxy_watershed_metadata <- filter(.metadata, watershed == proxy_watershed)

  # scale flow
  scaled_flow <- df$flow_cfs * watershed_metadata$dec_jun_mean_flow_scaling

  # fall run area
  #divide floodplain area by watershed length of proxy watershed to get area/mile, scale to hydrology
  scaled_area_per_mile <- (df$FR_floodplain_acres / proxy_watershed_metadata$FR_length_modeled_mi) *
    watershed_metadata$dec_jun_mean_flow_scaling

  # apportion area by high gradient/low gradient, .1 is downscaling for high gradient
  fp_area_FR <- (scaled_area_per_mile * watershed_metadata$FR_low_gradient_length_mi) +
    (scaled_area_per_mile * watershed_metadata$FR_high_gradient_length_mi * 0.1)

  # steelhead area
  scaled_area_per_mile <- (df$ST_floodplain_acres / proxy_watershed_metadata$FR_length_modeled_mi) *
    watershed_metadata$dec_jun_mean_flow_scaling

  fp_area_ST <- (scaled_area_per_mile * watershed_metadata$ST_low_gradient_length_mi) +
    (scaled_area_per_mile * watershed_metadata$ST_high_gradient_length_mi * 0.1)

  if (spring_run_present) {
    # spring run floodplain area
    scaled_area_per_mile <- (df$SR_floodplain_acres / proxy_watershed_metadata$FR_length_modeled_mi) *
      watershed_metadata$dec_jun_mean_flow_scaling

    fp_area_SR <- (scaled_area_per_mile * watershed_metadata$SR_low_gradient_length_mi) +
      (scaled_area_per_mile * watershed_metadata$SR_high_gradient_length_mi * 0.1)

    return(data.frame(
      flow_cfs = scaled_flow,
      FR_floodplain_acres = fp_area_FR,
      SR_floodplain_acres = fp_area_SR,
      ST_floodplain_acres = fp_area_ST,
      watershed = ws
    ))
  }

  return(data.frame(
    flow_cfs = scaled_flow,
    FR_floodplain_acres = fp_area_FR,
    ST_floodplain_acres = fp_area_ST,
    watershed = ws
  ))
}

# NO MODELING, use proxy------------
filter(.metadata, stringr::str_detect(method, "scaled_")) %>% pull(watershed)

# TODO Ask mark about the difference in outcome from his sheet
# Antelope Creek-------------------------------------
antelope_creek_floodplain <- scale_fp_flow_area('Antelope Creek')

use_data(antelope_creek_floodplain, overwrite = TRUE)

# Battle Creek-------------------------------------
battle_creek_floodplain <- scale_fp_flow_area('Battle Creek')

use_data(battle_creek_floodplain, overwrite = TRUE)

# Bear Creek-------------------------------------
bear_creek_floodplain <- scale_fp_flow_area('Bear Creek')

use_data(bear_creek_floodplain, overwrite = TRUE)

# Calaveras River -------------------------------------
calaveras_river_floodplain <- scale_fp_flow_area('Calaveras River')

use_data(calaveras_river_floodplain, overwrite = TRUE)

# Clear Creek-------------------------------------
clear_creek_floodplain <- scale_fp_flow_area('Clear Creek')

use_data(clear_creek_floodplain, overwrite = TRUE)

# Cosumnes River -------------------------------------
cosumnes_river_floodplain <- scale_fp_flow_area('Cosumnes River')

use_data(cosumnes_river_floodplain, overwrite = TRUE)

# Cow Creek-------------------------------------
cow_creek_floodplain <- scale_fp_flow_area('Cow Creek')

use_data(cow_creek_floodplain, overwrite = TRUE)

# Mill Creek-------------------------------------
mill_creek_floodplain <- scale_fp_flow_area('Mill Creek')

use_data(mill_creek_floodplain, overwrite = TRUE)

# Mokelumne River -------------------------------------
mokelumne_river_floodplain <- scale_fp_flow_area('Mokelumne River')

use_data(mokelumne_river_floodplain, overwrite = TRUE)

# Paynes Creek-------------------------------------
paynes_creek_floodplain <- scale_fp_flow_area('Paynes Creek')

use_data(paynes_creek_floodplain, overwrite = TRUE)

# Stony Creek-------------------------------------
stony_creek_floodplain <- scale_fp_flow_area('Stony Creek')

use_data(stony_creek_floodplain, overwrite = TRUE)

# Thomes Creek-------------------------------------
thomes_creek_floodplain <- scale_fp_flow_area('Thomes Creek')

use_data(thomes_creek_floodplain, overwrite = TRUE)


# FULLY MODELED ----------
filter(.metadata, method == 'full_model') %>% pull(watershed)

# american river -------
american_river_floodplain <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx',
                                        sheet = 'AmericanRiver') %>%
  mutate(watershed = 'American River',
         SR_floodplain_acres = modeled_floodplain_area_acres,
         ST_floodplain_acres = modeled_floodplain_area_acres) %>%
  select(flow_cfs,
         FR_floodplain_acres = modeled_floodplain_area_acres,
         SR_floodplain_acres, ST_floodplain_acres,
         watershed)

use_data(american_river_floodplain, overwrite = TRUE)

# feather river -------
feather_river_floodplain <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx',
                                       sheet = 'FeatherRiver') %>%
  mutate(watershed = 'Feather River',
         SR_floodplain_acres = modeled_floodplain_area_acres,
         ST_floodplain_acres = modeled_floodplain_area_acres) %>%
  select(flow_cfs,
         FR_floodplain_acres = modeled_floodplain_area_acres,
         SR_floodplain_acres, ST_floodplain_acres,
         watershed)

use_data(feather_river_floodplain, overwrite = TRUE)

# san joaquin river -------
san_joaquin_river_floodplain <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx',
                                           sheet = 'SanJoaquinRiver') %>%
  mutate(watershed = 'San Joaquin River',
         SR_floodplain_acres = modeled_floodplain_area_acres,
         ST_floodplain_acres = modeled_floodplain_area_acres) %>%
  select(flow_cfs,
         FR_floodplain_acres = modeled_floodplain_area_acres,
         SR_floodplain_acres, ST_floodplain_acres,
         watershed)

use_data(san_joaquin_river_floodplain, overwrite = TRUE)

# stanislaus river -------
stanislaus_river_floodplain <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx',
                                           sheet = 'StanislausRiver') %>%
  mutate(watershed = 'Stanislaus River',
         SR_floodplain_acres = modeled_floodplain_area_acres,
         ST_floodplain_acres = modeled_floodplain_area_acres) %>%
  select(flow_cfs,
         FR_floodplain_acres = modeled_floodplain_area_acres,
         SR_floodplain_acres, ST_floodplain_acres,
         watershed)

use_data(stanislaus_river_floodplain, overwrite = TRUE)

# yuba river -------
yuba_river_floodplain <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx',
                                          sheet = 'YubaRiver') %>%
  mutate(watershed = 'Yuba River',
         SR_floodplain_acres = modeled_floodplain_area_acres,
         ST_floodplain_acres = modeled_floodplain_area_acres) %>%
  select(flow_cfs,
         FR_floodplain_acres = modeled_floodplain_area_acres,
         SR_floodplain_acres, ST_floodplain_acres,
         watershed)

use_data(yuba_river_floodplain, overwrite = TRUE)
