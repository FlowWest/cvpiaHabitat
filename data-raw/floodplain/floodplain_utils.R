library(tidyverse)
library(readxl)
library(glue)

# TODO check that metadata sheet is up to date
metadata <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx', sheet = 'MetaData',
                       col_types = c('text', 'text', 'text', 'text',
                                     rep('numeric', 17), 'text', 'numeric', 'text'), na = 'na')

# function for partially modeled watersheds---------------------------------
# ws = watershed
# df = flow to area relationship dataframe for watershed
scale_fp_flow_area_partial_model <- function(ws, df) {

  watershed_metadata <- filter(metadata, watershed == ws)
  spring_run_present <- !is.na(watershed_metadata$SR_rearing_length_mi)
  steelhead_present <- !is.na(watershed_metadata$ST_rearing_length_mi)

  fp_area <- df$modeled_floodplain_area_acres

  fp_area_per_mile_modeled <- fp_area/watershed_metadata$FR_length_modeled_mi

  # fall run floodplain area
  low_grad_len_FR <- watershed_metadata$FR_low_gradient_length_mi
  high_grad_len_FR <- watershed_metadata$FR_high_gradient_length_mi

  #.1 is downscaling for high gradient
  fp_area_FR <- (fp_area_per_mile_modeled * low_grad_len_FR) +
    (fp_area_per_mile_modeled * high_grad_len_FR * 0.1)

  result <- data.frame(
    flow_cfs = df$flow_cfs,
    FR_floodplain_acres = fp_area_FR
  )

  if (spring_run_present) {
    # spring run floodplain area
    low_grad_len_SR <- watershed_metadata$SR_low_gradient_length_mi
    high_grad_len_SR <- watershed_metadata$SR_high_gradient_length_mi

    fp_area_SR <- (fp_area_per_mile_modeled * low_grad_len_SR) +
      (fp_area_per_mile_modeled * high_grad_len_SR * 0.1)

    result <- bind_cols(result, SR_floodplain_acres = fp_area_SR)
  }

  # steel head floodplain area
  if (steelhead_present) {
    low_grad_len_ST <- watershed_metadata$ST_low_gradient_length_mi
    high_grad_len_ST <- watershed_metadata$ST_high_gradient_length_mi

    fp_area_ST <- (fp_area_per_mile_modeled * low_grad_len_ST) +
      (fp_area_per_mile_modeled * high_grad_len_ST * 0.1)

    result <- bind_cols(result, ST_floodplain_acres = fp_area_ST)
  }

  return(
    mutate(result, watershed = ws)
  )

}

# function for non-modeled watersheds---------------------------------
# ws = watershed

scale_fp_flow_area <- function(ws) {

  watershed_metadata <- filter(metadata, watershed == ws)
  spring_run_present <- !is.na(watershed_metadata$SR_rearing_length_mi)
  steelhead_present <- !is.na(watershed_metadata$ST_rearing_length_mi)

  # appropriate proxy from watershed, df has flow to area curve
  proxy_watershed <- watershed_metadata$scaling_watershed

  if (proxy_watershed == 'deer_creek') {
    temp_df <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx', sheet = 'DeerCreek')
    proxy_watershed_metadata <- filter(metadata, watershed == 'Deer Creek')
  }

  if (proxy_watershed == 'cottonwood_creek') {
    temp_df <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx', sheet = 'CottonwoodCreek')
    proxy_watershed_metadata <- filter(metadata, watershed == 'Cottonwood Creek')
  }

  if (proxy_watershed == 'tuolumne_river') {
    temp_df <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx', sheet = 'TuolumneRiver')
    proxy_watershed_metadata <- filter(metadata, watershed == 'Tuolumne River')
  }

  bank_full_flow <- temp_df %>%
    filter(modeled_floodplain_area_acres == 0) %>%
    summarise(max = max(flow_cfs)) %>%
    pull(max)

  df <- temp_df %>%
    filter(flow_cfs >=  bank_full_flow)

  # scale flow
  scaled_flow <- df$flow_cfs * watershed_metadata$dec_jun_mean_flow_scaling

  # fall run area
  # divide floodplain area by watershed length of proxy watershed to get area/mile, scale to hydrology
  scaled_area_per_mile_FR <- (df$modeled_floodplain_area_acres / proxy_watershed_metadata$FR_length_modeled_mi) *
    watershed_metadata$dec_jun_mean_flow_scaling

  # apportion area by high gradient/low gradient, .1 is downscaling for high gradient
  fp_area_FR <- (scaled_area_per_mile_FR * watershed_metadata$FR_low_gradient_length_mi) +
    (scaled_area_per_mile_FR * watershed_metadata$FR_high_gradient_length_mi * 0.1)

  result <- data.frame(
    flow_cfs = scaled_flow,
    FR_floodplain_acres = fp_area_FR
  )

  if (spring_run_present) {
    # spring run floodplain area
    scaled_area_per_mile_SR <- (df$modeled_floodplain_area_acres / proxy_watershed_metadata$SR_length_modeled_mi) *
      watershed_metadata$dec_jun_mean_flow_scaling

    fp_area_SR <- (scaled_area_per_mile_SR * watershed_metadata$SR_low_gradient_length_mi) +
      (scaled_area_per_mile_SR * watershed_metadata$SR_high_gradient_length_mi * 0.1)

    result <- bind_cols(result, SR_floodplain_acres = fp_area_SR)
  }

  if (steelhead_present) {
    scaled_area_per_mile_ST <- (df$modeled_floodplain_area_acres / proxy_watershed_metadata$ST_length_modeled_mi) *
      watershed_metadata$dec_jun_mean_flow_scaling

    fp_area_ST <- (scaled_area_per_mile_ST * watershed_metadata$ST_low_gradient_length_mi) +
      (scaled_area_per_mile_ST * watershed_metadata$ST_high_gradient_length_mi * 0.1)

    result <- bind_cols(result, ST_floodplain_acres = fp_area_ST)
  }

  return(
    mutate(result, watershed = ws)
  )

}

# modeling details------------------------------------
print_model_details <- function(ws, species) {

  watershed_doc_vars <- filter(metadata, watershed == ws)

  if (species == 'sr' & is.na(watershed_doc_vars$SR_length_modeled_mi)) {
    warning(sprintf('There are no spring run in %s.', ws))
    return(NULL)
  }

  watershed_method <- watershed_doc_vars$method
  model_name <- watershed_doc_vars$model_name
  flow_scale <- round(watershed_doc_vars$dec_jun_mean_flow_scaling * 100)
  high_grad_factor <- watershed_doc_vars$high_gradient_floodplain_reduction_factor

  if (species == 'fr') {
    rearing_length <- round(watershed_doc_vars$FR_rearing_length_mi, 1)
    channel_area_modeled <- watershed_doc_vars$FR_channel_area_of_length_modeled_acres
    low_grad <- round(watershed_doc_vars$FR_low_gradient_length_mi, 1)
    high_grad <- round(watershed_doc_vars$FR_high_gradient_length_mi, 1)
    modeled_length <- round(watershed_doc_vars$FR_length_modeled_mi, 1)
  }

  if (species == 'sr') {
    rearing_length <- round(watershed_doc_vars$SR_rearing_length_mi, 1)
    channel_area_modeled <- watershed_doc_vars$SR_channel_area_of_length_modeled_acres
    low_grad <- round(watershed_doc_vars$SR_low_gradient_length_mi, 1)
    high_grad <- round(watershed_doc_vars$SR_high_gradient_length_mi, 1)
    modeled_length <- round(watershed_doc_vars$SR_length_modeled_mi, 1)
  }

  if (species == 'st') {
    rearing_length <- round(watershed_doc_vars$ST_rearing_length_mi, 1)
    channel_area_modeled <- watershed_doc_vars$ST_channel_area_of_length_modeled_acres
    low_grad <- round(watershed_doc_vars$ST_low_gradient_length_mi, 1)
    high_grad <- round(watershed_doc_vars$ST_high_gradient_length_mi, 1)
    modeled_length <- round(watershed_doc_vars$ST_length_modeled_mi, 1)
  }

  if (watershed_method == 'full_model_nmfs') {

    return(
      glue('The entire mapped rearing extent of {rearing_length} miles was modeled',
           ' using {model_name}. The high quality depth and high quality velocity',
           ' ("Pref11") "BankArea" result was used as floodplain area. High quality',
           ' velocities were assumed to be less than or equal to 0.15 meters per second,',
           ' and high quality depths were assumed to be between 0.2 meters and 1.5 meters.')
    )
  }

  if (watershed_method == 'full_model') {
    return(
      glue("The entire mapped rearing extent of {rearing_length} miles was modeled using {model_name}.",
           " Active channel area of {channel_area_modeled} acres estimated through remote",
           " sensing analysis was subtracted from total inundated area to get inundated floodplain area.")
    )
  }

  if (watershed_method == 'part_model') {
    return(
      glue('A {modeled_length} mile portion of the entire mapped rearing extent of {rearing_length}',
           ' miles was modeled using {model_name}. Of the entire mapped rearing extent,',
           ' {low_grad} miles were classified as low gradient and {high_grad} miles were classified',
           ' as high gradient based on a geomorphic analysis. Floodplain area per',
           ' unit length was determined for the modeled extent and applied to',
           ' determine areas for the non-modeled extent. A scaling factor of {high_grad_factor} was',
           ' applied to the area per unit length for the high gradient extent. No',
           ' scaling factor was applied to the low gradient extent.')
    )
  }

  if (str_detect(watershed_method, 'scaled')) {
    proxies <- c('Deer Creek', 'Cottonwood Creek', 'Tuolumne River')
    names(proxies) <- c('dc', 'cc', 'tr')

    proxy_ws <- proxies[str_remove(watershed_method, 'scaled_')]

    return(
      glue("No site-specific hydraulic modeling was available for this watershed.",
           " A flow to floodplain area relationship was generated for this watershed",
           " by scaling the flow to floodplain area relationship for {proxy_ws} based",
           " on hydrologic and geomorphic analyses. Flows and corresponding floodplain",
           " areas per unit length were calculated for this watershed as {flow_scale}% of",
           " {proxy_ws} values based on the ratio of mean flow from December to June between",
           " this watershed and {proxy_ws}. Of the entire mapped {rearing_length} mile rearing",
           " extent in this watershed, {low_grad} miles were classified as low gradient and",
           " {high_grad} miles were classified as high gradient based on a geomorphic analysis.",
           " A scaling factor of {high_grad_factor} was applied to the area per unit length for the",
           " high gradient extent. No scaling factor was applied to the low gradient extent.")
    )
  }

}
