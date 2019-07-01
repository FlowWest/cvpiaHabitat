library(tidyverse)
library(readxl)

# TODO check that metadata sheet is up to date
.metadata <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx', sheet = 'MetaData',
                        col_types = c('text', 'text', 'text', 'text',
                                      rep('numeric', 17), 'text', 'numeric', 'text'), na = 'na')

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

# function for non-modeled watersheds---------------------------------
# ws = watershed

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

# modeling details------------------------------------
print_model_details <- function(ws, species) {

  watershed_doc_vars <- filter(.metadata, watershed == ws)

  if (species == 'sr' & is.na(watershed_doc_vars$SR_length_modeled_mi)) {
    warning(sprintf('There are no spring run in %s.', ws))
    return(NULL)
  }

  watershed_method <- watershed_doc_vars$method

  switch(species,
         'fr' = switch(watershed_method,
                       'full_model_t' = "The entire mapped rearing extent of 54.33 miles was modeled by TID and MID using a TUFLOW hydraulic model with 1D channel and 2D overbank components. This approach directly modeled  inundated floodplain area.",
                       'full_model_nmfs' = sprintf('The entire mapped rearing extent of %.2f miles was modeled using %s. The high quality depth and high quality velocity ("Pref11") "BankArea" result was used as floodplain area. High quality velocities were assumed to be less than or equal to 0.15 meters per second, and high quality depths were assumed to be between 0.2 meters and 1.5 meters.',
                                                   watershed_doc_vars$FR_rearing_length_mi,
                                                   watershed_doc_vars$model_name),
                       'full_model' = sprintf("The entire mapped rearing extent of %.2f miles was modeled using %s. Active channel area of %.2f acres estimated through remote sensing analysis was subtracted from total inundated area to get inundated floodplain area.",
                                              watershed_doc_vars$FR_rearing_length_mi,
                                              watershed_doc_vars$model_name,
                                              watershed_doc_vars$FR_channel_area_of_length_modeled_acres),
                       'scaled_dc' = sprintf('No site-specific hydraulic modeling was available for this watershed. A flow to floodplain area relationship was generated for this watershed by scaling the flow to floodplain area relationship for Deer Creek based on hydrologic and geomorphic analyses. Flows and corresponding floodplain areas per unit length were calculated for this watershed as %i%% of Deer Creek values based on the ratio of mean flow from December to June between this watershed and Deer Creek. Of the entire mapped %.2f mile rearing extent in this watershed, %.2f miles were classified as low gradient and %.2f miles were classified as high gradient based on a geomorphic analysis. A scaling factor of %.1f was applied to the area per unit length for the high gradient extent. No scaling factor was applied to the low gradient extent.',
                                             round(watershed_doc_vars$dec_jun_mean_flow_scaling * 100),
                                             watershed_doc_vars$FR_rearing_length_mi,
                                             watershed_doc_vars$FR_low_gradient_length_mi,
                                             watershed_doc_vars$FR_high_gradient_length_mi,
                                             watershed_doc_vars$high_gradient_floodplain_reduction_factor),
                       'part_model' = sprintf('A %.2f mile portion of the entire mapped rearing extent of %.2f miles was modeled using %s. Of the entire mapped rearing extent, %.2f miles were classified as low gradient and %.2f miles were classified as high gradient based on a geomorphic analysis. Floodplain area per unit length was determined for the modeled extent and applied to determine areas for the non-modeled extent. A scaling factor of %.1f was applied to the area per unit length for the high gradient extent. No scaling factor was applied to the low gradient extent.',
                                              watershed_doc_vars$FR_length_modeled_mi,
                                              watershed_doc_vars$FR_rearing_length_mi,
                                              watershed_doc_vars$model_name,
                                              watershed_doc_vars$FR_low_gradient_length_mi,
                                              watershed_doc_vars$FR_high_gradient_length_mi,
                                              watershed_doc_vars$high_gradient_floodplain_reduction_factor),
                       'scaled_tr' = sprintf('No site-specific hydraulic modeling was available for this watershed. A flow to floodplain area relationship was generated for this watershed by scaling the flow to floodplain area relationship for the Tuolumne River based on hydrologic and geomorphic analyses. Flows and corresponding floodplain areas per unit length were calculated for this watershed as %.2f percent of the Tuolumne River values based on the ratio of mean flow from December to June between this watershed and the Tuolumne River. Of the entire mapped %.2f mile rearing extent in this watershed, %.2f miles were classifiedas low gradient and %.2f miles were classified as high gradient based on a geomorphic analysis. A scaling factor of %.1f was applied to the area per unit length for the high gradient extent. No scaling factor was applied to the low gradient extent.',
                                             watershed_doc_vars$dec_jun_mean_flow_scaling,
                                             watershed_doc_vars$FR_rearing_length_mi,
                                             watershed_doc_vars$FR_low_gradient_length_mi,
                                             watershed_doc_vars$FR_high_gradient_length_mi,
                                             watershed_doc_vars$high_gradient_floodplain_reduction_factor),
                       'scaled_cc' = sprintf('No site-specific hydraulic modeling was available for this watershed. A flow to floodplain area relationship was generated for this watershed by scaling the flow to floodplain area relationship for Cottonwood Creek  based on hydrologic and geomorphic analyses. Flows and corresponding floodplain areas per unit length were calculated for this watershed as %.2f percent of Cottonwood Creek values based on the ratio of mean flow from December to June between this watershed and Cottonwood Creek. Of the entire mapped %.2f mile rearing extent in this watershed, %.2f miles were classified as low gradient and %.2f miles were classified as high gradient based on a geomorphic analysis. A scaling factor of %.1f was  applied to the area per unit length for the high gradient extent. No scaling factor was applied to the low gradient extent.',
                                             watershed_doc_vars$dec_jun_mean_flow_scaling,
                                             watershed_doc_vars$FR_rearing_length_mi,
                                             watershed_doc_vars$FR_low_gradient_length_mi,
                                             watershed_doc_vars$FR_high_gradient_length_mi,
                                             watershed_doc_vars$high_gradient_floodplain_reduction_factor)),
         'sr' = switch(watershed_method,
                       'full_model_nmfs' = sprintf('The entire mapped rearing extent of %.2f miles was modeled using %s. The high quality depth and high quality velocity ("Pref11") "BankArea" result was used as floodplain area. High quality velocities were assumed to be less than or equal to 0.15 meters per second, and high quality depths were assumed to be between 0.2 meters and 1.5 meters.',
                                                   watershed_doc_vars$SR_rearing_length_mi,
                                                   watershed_doc_vars$model_name),
                       'full_model' = sprintf("The entire mapped rearing extent of %.2f miles was modeled using %s. Active channel area of %.2f acres estimated through remote sensing analysis was subtracted from total inundated area to get inundated floodplain area.",
                                              watershed_doc_vars$SR_rearing_length_mi,
                                              watershed_doc_vars$model_name,
                                              watershed_doc_vars$SR_channel_area_of_length_modeled_acres),
                       'scaled_dc' = sprintf('No site-specific hydraulic modeling was available for this watershed. A flow to floodplain area relationship was generated for this watershed by scaling the flow to floodplain area relationship for Deer Creek based onhydrologic and geomorphic analyses. Flows and corresponding floodplain areas per unit length were calculated for this watershed as %.2f percent of DeerCreek values based on the ratio of mean flow from December to June between this watershed and Deer Creek. Of the entire mapped %.2f mile rearing extent in this watershed, %.2f miles were classified as low gradient and %.2f miles were classified as high gradient based on a geomorphic analysis. A scaling factor of %.1f was applied to the area per unit length for the high gradient extent. No scaling factor was applied to the low gradient extent.',
                                             watershed_doc_vars$dec_jun_mean_flow_scaling,
                                             watershed_doc_vars$SR_rearing_length_mi,
                                             watershed_doc_vars$SR_low_gradient_length_mi,
                                             watershed_doc_vars$SR_high_gradient_length_mi,
                                             watershed_doc_vars$high_gradient_floodplain_reduction_factor),
                       'part_model' = sprintf('A %.2f mile portion of the entire mapped rearing extent of %.2f miles was modeled using %s. Of the entire mapped rearing extent, %.2f miles were classified as low gradient and %.2f miles were classified as high gradient based on a geomorphic analysis. Floodplain area per unit length was determined for the modeled extent and applied to determine areas for the non-modeled extent. A scaling factor of %.1f was applied to the area per unit length for the high gradient extent. No scaling factor was applied to the low gradient extent.',
                                              watershed_doc_vars$SR_length_modeled_mi,
                                              watershed_doc_vars$SR_rearing_length_mi,
                                              watershed_doc_vars$model_name,
                                              watershed_doc_vars$SR_low_gradient_length_mi,
                                              watershed_doc_vars$SR_high_gradient_length_mi,
                                              watershed_doc_vars$high_gradient_floodplain_reduction_factor),
                       'scaled_tr' = sprintf('No site-specific hydraulic modeling was available for this watershed. A flow to floodplain area relationship was generated for this watershed by scaling the flow to floodplain area relationship for the Tuolumne River based on hydrologic and geomorphic analyses. Flows and corresponding floodplain areas per unit length were calculated for this watershed as %.2f percent of the Tuolumne River values based on the ratio of mean flow from December to June between this watershed and the Tuolumne River. Of the entire mapped %.2f mile rearing extent in this watershed, %.2f miles were classifiedas low gradient and %.2f miles were classified as high gradient based on a geomorphic analysis. A scaling factor of %.1f was applied to the area per unit length for the high gradient extent. No scaling factor was applied to the low gradient extent.',
                                             watershed_doc_vars$dec_jun_mean_flow_scaling,
                                             watershed_doc_vars$SR_rearing_length_mi,
                                             watershed_doc_vars$SR_low_gradient_length_mi,
                                             watershed_doc_vars$SR_high_gradient_length_mi,
                                             watershed_doc_vars$high_gradient_floodplain_reduction_factor),
                       'scaled_cc' = sprintf('No site-specific hydraulic modeling was available for this watershed. A flow to floodplain area relationship was generated for this watershed by scaling the flow to floodplain area relationship for Cottonwood Creek  based on hydrologic and geomorphic analyses. Flows and corresponding floodplain areas per unit length were calculated for this watershed as %.2f percent of Cottonwood Creek values based on the ratio of mean flow from December to June between this watershed and Cottonwood Creek. Of the entire mapped %.2f mile rearing extent in this watershed, %.2f miles were classified as low gradient and %.2f miles were classified as high gradient based on a geomorphic analysis. A scaling factor of %.1f was  applied to the area per unit length for the high gradient extent. No scaling factor was applied to the low gradient extent.',
                                             watershed_doc_vars$dec_jun_mean_flow_scaling,
                                             watershed_doc_vars$SR_rearing_length_mi,
                                             watershed_doc_vars$SR_low_gradient_length_mi,
                                             watershed_doc_vars$SR_high_gradient_length_mi,
                                             watershed_doc_vars$high_gradient_floodplain_reduction_factor)),
         'st' = switch(watershed_method,
                       'full_model_nmfs' = sprintf('The entire mapped rearing extent of %.2f miles was modeled using %s. The high quality depth and high quality velocity ("Pref11") "BankArea" result was used as floodplain area. High quality velocities were assumed to be less than or equal to 0.15 meters per second, and high quality depths were assumed to be between 0.2 meters and 1.5 meters.',
                                                   watershed_doc_vars$ST_rearing_length_mi,
                                                   watershed_doc_vars$model_name),
                       'full_model' = sprintf("The entire mapped rearing extent of %.2f miles was modeled using %s. Active channel area of %.2f acres estimated through remote sensing analysis was subtracted from total inundated area to get inundated floodplain area.",
                                              watershed_doc_vars$ST_rearing_length_mi,
                                              watershed_doc_vars$model_name,
                                              watershed_doc_vars$FR_channel_area_of_length_modeled_acres),
                       'scaled_dc' = sprintf('No site-specific hydraulic modeling was available for this watershed. A flow to floodplain area relationship was generated for this watershed by scaling the flow to floodplain area relationship for Deer Creek based onhydrologic and geomorphic analyses. Flows and corresponding floodplain areas per unit length were calculated for this watershed as %.2f percent of DeerCreek values based on the ratio of mean flow from December to June between this watershed and Deer Creek. Of the entire mapped %.2f mile rearing extent in this watershed, %.2f miles were classified as low gradient and %.2f miles were classified as high gradient based on a geomorphic analysis. A scaling factor of %.1f was applied to the area per unit length for the high gradient extent. No scaling factor was applied to the low gradient extent.',
                                             watershed_doc_vars$dec_jun_mean_flow_scaling,
                                             watershed_doc_vars$ST_rearing_length_mi,
                                             watershed_doc_vars$ST_low_gradient_length_mi,
                                             watershed_doc_vars$ST_high_gradient_length_mi,
                                             watershed_doc_vars$high_gradient_floodplain_reduction_factor),
                       'part_model' = sprintf('A %.2f mile portion of the entire mapped rearing extent of %.2f miles was modeled using %s. Of the entire mapped rearing extent, %.2f miles were classified as low gradient and %.2f miles were classified as high gradient based on a geomorphic analysis. Floodplain area per unit length was determined for the modeled extent and applied to determine areas for the non-modeled extent. A scaling factor of %.1f was applied to the area per unit length for the high gradient extent. No scaling factor was applied to the low gradient extent.',
                                              watershed_doc_vars$ST_length_modeled_mi,
                                              watershed_doc_vars$ST_rearing_length_mi,
                                              watershed_doc_vars$model_name,
                                              watershed_doc_vars$ST_low_gradient_length_mi,
                                              watershed_doc_vars$ST_high_gradient_length_mi,
                                              watershed_doc_vars$high_gradient_floodplain_reduction_factor),
                       'scaled_tr' = sprintf('No site-specific hydraulic modeling was available for this watershed. A flow to floodplain area relationship was generated for this watershed by scaling the flow to floodplain area relationship for the Tuolumne River based on hydrologic and geomorphic analyses. Flows and corresponding floodplain areas per unit length were calculated for this watershed as %.2f percent of the Tuolumne River values based on the ratio of mean flow from December to June between this watershed and the Tuolumne River. Of the entire mapped %.2f mile rearing extent in this watershed, %.2f miles were classifiedas low gradient and %.2f miles were classified as high gradient based on a geomorphic analysis. A scaling factor of %.1f was applied to the area per unit length for the high gradient extent. No scaling factor was applied to the low gradient extent.',
                                             watershed_doc_vars$dec_jun_mean_flow_scaling,
                                             watershed_doc_vars$ST_rearing_length_mi,
                                             watershed_doc_vars$ST_low_gradient_length_mi,
                                             watershed_doc_vars$ST_high_gradient_length_mi,
                                             watershed_doc_vars$high_gradient_floodplain_reduction_factor),
                       'scaled_cc' = sprintf('No site-specific hydraulic modeling was available for this watershed. A flow to floodplain area relationship was generated for this watershed by scaling the flow to floodplain area relationship for Cottonwood Creek  based on hydrologic and geomorphic analyses. Flows and corresponding floodplain areas per unit length were calculated for this watershed as %.2f percent of Cottonwood Creek values based on the ratio of mean flow from December to June between this watershed and Cottonwood Creek. Of the entire mapped %.2f mile rearing extent in this watershed, %.2f miles were classified as low gradient and %.2f miles were classified as high gradient based on a geomorphic analysis. A scaling factor of %.1f was  applied to the area per unit length for the high gradient extent. No scaling factor was applied to the low gradient extent.',
                                             watershed_doc_vars$dec_jun_mean_flow_scaling,
                                             watershed_doc_vars$ST_rearing_length_mi,
                                             watershed_doc_vars$ST_low_gradient_length_mi,
                                             watershed_doc_vars$ST_high_gradient_length_mi,
                                             watershed_doc_vars$high_gradient_floodplain_reduction_factor)))

}
