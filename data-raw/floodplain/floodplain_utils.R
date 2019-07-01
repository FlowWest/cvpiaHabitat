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
