library(tidyverse)
library(readxl)
library(devtools)

sheets <- readxl::excel_sheets('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx')
sheets
cvpiaHabitat::modeling_exist %>% View
.metadata <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx', sheet = 'MetaData',
                       col_types = c('text', 'text', 'text', 'text',
                                     rep('numeric', 17), 'text', 'numeric', 'text'), na = 'na')
glimpse(.metadata)

View(select(.metadata, -model_reference, -model_name))
ws = 'Deer Creek'

.metadata %>%
  select(watershed, ST_high_gradient_length_mi, SR_high_gradient_length_mi)

# function for partially modeled watersheds---------------------------------
# ws = watershed
# df = flow to area relationship dataframe for watershed
scale_fp_flow_area_partial_model <- function(ws, df) {

  spring_run_present <- !is.na(pull(filter(cvpiaHabitat::modeling_exist, Watershed == ws), SR_juv))

  watershed_metadata <- filter(.metadata, watershed == ws)

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
      FR_floodplain_area = fp_area_FR,
      SR_floodplain_area = fp_area_SR,
      ST_floodplain_area = fp_area_ST,
      watershed = ws
    ))
  }

  return(
    data.frame(
    flow_cfs = df$flow_cfs,
    FR_floodplain_area = fp_area_FR,
    ST_floodplain_area = fp_area_ST,
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
         SR_floodplain_area = modeled_floodplain_area_acres,
         ST_floodplain_area = modeled_floodplain_area_acres) %>%
  select(flow_cfs,
         FR_floodplain_area = modeled_floodplain_area_acres,
         SR_floodplain_area, ST_floodplain_area,
         watershed)

use_data(tuolumne_river_floodplain, overwrite = TRUE)


# NO modeling exists method for creating flow to fp area-------------
scale_fp_flow_area <- function(watershed) {

  # lookup for proxy
  scaling_dic <- c('scaled_dc' = "Deer Creek", 'scaled_tr' = "Tuolumne River", 'scaled_cc' = "Cottonwood Creek")
  # first divide floodplain area by watershed length of proxy watershed
  # to get area/mile
  df <- filter(df, watershed) # appropriate proxy from watershed, df has flow to area curve

  scaled_flow <- (flow_watershed/flow_scale_watershed) * (flow_scale_watershed)

  area_per_mile <- (floodplain_area/scaling_watershed_length)*watershed_length

  scaled_area_per_mile <- area_per_mile * scaled_flow

  # high gradient low gradient
  area <- (scaled_area_per_mile * low_grad_len) + (scaled_area_per_mile * high_grad_len * 0.1) #.1 is downscaling for high gradient

  return(data.frame(flow = scaled_flow, fp_ara = area))
}


