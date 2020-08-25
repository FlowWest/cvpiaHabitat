library(tidyverse)
library(readxl)
library(glue)

# TODO check that metadata sheet is up to date
metadata <- read_excel('data-raw/watershed/CVPIA_FloodplainAreas.xlsx', sheet = 'MetaData',
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
    temp_df <- read_excel('data-raw/watershed/CVPIA_FloodplainAreas.xlsx', sheet = 'DeerCreek')
    proxy_watershed_metadata <- filter(metadata, watershed == 'Deer Creek')
  }

  if (proxy_watershed == 'cottonwood_creek') {
    temp_df <- read_excel('data-raw/watershed/CVPIA_FloodplainAreas.xlsx', sheet = 'CottonwoodCreek')
    proxy_watershed_metadata <- filter(metadata, watershed == 'Cottonwood Creek')
  }

  if (proxy_watershed == 'tuolumne_river') {
    temp_df <- read_excel('data-raw/watershed/CVPIA_FloodplainAreas.xlsx', sheet = 'TuolumneRiver')
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
  watershed_name <- ws

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
      glue('The entire mapped rearing extent of {rearing_length} miles was modeled
            using {model_name}. The high quality depth and high quality velocity
            ("Pref11") "BankArea" result was used as the floodplain area. High quality
            velocities were assumed to be less than or equal to 0.15 meters per second,
            and high quality depths were assumed to be between 0.2 meters and 1.5 meters.')
    )
  }

  if (watershed_method == 'full_model') {
    return(
      glue("The entire mapped rearing extent of {rearing_length} miles was modeled using {model_name}.
           An active channel area of {channel_area_modeled} acres, estimated through remote
           sensing analysis, was subtracted from total inundated area to obtain inundated floodplain area.")
    )
  }

  if (watershed_method == 'part_model') {
    return(
      glue('A {modeled_length} mile portion of the entire mapped rearing extent of {rearing_length}
            miles was modeled using {model_name}. Of the entire mapped rearing extent,
            {low_grad} miles were classified as low gradient and {high_grad} miles were classified
            as high gradient based on a geomorphic analysis of long profile slopes and valley widths.
            The floodplain area per unit length was determined for the modeled extent and used to
            approximate areas for the non-modeled extent. The area per unit length was scaled by a
            factor of {high_grad_factor} for the high gradient extent.
            There was no scaling factor applied to the low gradient extent.')
    )
  }

  if (str_detect(watershed_method, 'scaled')) {
    proxies <- c('Deer Creek', 'Cottonwood Creek', 'Tuolumne River')
    names(proxies) <- c('dc', 'cc', 'tr')

    proxy_ws <- proxies[str_remove(watershed_method, 'scaled_')]

    return(
      glue(' There was no watershed specific hydraulic modeling available for {watershed_name}.
            A flow to inundated floodplain area relationship was generated for {watershed_name}
            by scaling the flow to inundated floodplain area relationship for {proxy_ws}.
            This scaling used the ratio of mean flow from December to June between the modeled
            and unmodeled watershed. Flows and corresponding inundated floodplain areas per unit length
            were calculated for {watershed_name} as {flow_scale}% of {proxy_ws}.
            Of the entire mapped {rearing_length} miles rearing
            extent in {watershed_name}, {low_grad} miles were classified as low gradient and
            {high_grad} miles were classified as high gradient based on a geomorphic analysis
            of long profile slopes and valley widths. The area per unit length was scaled by a
            factor of {high_grad_factor} for the high gradient extent.
            There was no scaling factor applied to the low gradient extent.')
    )
  }

}

