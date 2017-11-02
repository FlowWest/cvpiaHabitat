#' set floodplain area based on a watershed, species and a flow
#' @description based on watershed, species and flow return a WUA
#'
#' @param watershed a watershed defined for the SIT model
#' @param species one of 'fr' (Fall Run), 'sr' (Spring Run), or 'st' (Steelhead).
#' @param flow a flow value in cubic feet per second.
#' @examples
#' # floodplain habitat value in square meters for Fall Run in the American River
#' set_floodplain_habitat("American River", "fr", 34652)
#'
#' # floodplain habitat value in square meters for Steelhead in the American River
#' set_floodplain_habitat("American River", "st", 34652)
#' @return floodplain habitat value in square meters
#' @export
set_floodplain_habitat <- function(watershed, species, flow) {
  if (is.null(watershed_to_floodplain_methods[watershed][[1]]))
    stop(paste0("no function associated with watershed '", watershed, "' was found"))

  f <- watershed_to_floodplain_methods[watershed][[1]](species)

  # floodplain is in acres, returned value needs to be in square meters
  f(flow)/0.000247105

}

#' function creates the approx function for fall run
#' @param relationship_df dataframe from cvpiaHabitat with a flow to wua relationship
#' @param modeling_lookup modeling lookup dataframe from cvpiaHabitat
FR_floodplain_approx <- function(relationship_df, modeling_lookup){
  if (is.na(dplyr::pull(modeling_lookup, FR_floodplain))) {
    # no spawning in this watershed
    return(NA)
  } else {
    # case when modeling exists
    FR_approx <- approxfun(relationship_df$flow_cfs,
                           relationship_df$FR_floodplain_acres, rule = 2)
  }

  return(FR_approx)
}

#' function creates the approx function for spring run
#' @param relationship_df dataframe from cvpiaHabitat with a flow to wua relationship
#' @param modeling_lookup modeling lookup dataframe from cvpiaHabitat
SR_floodplain_approx <- function(relationship_df, modeling_lookup){
  if (is.na(dplyr::pull(modeling_lookup, SR_floodplain))) {
    # no spring run floodplain habitat in this watershed
    return(NA)
  } else if (dplyr::pull(modeling_lookup, SR_floodplain)){
    # case when modeling exists
    SR_approx <- approxfun(relationship_df$flow_cfs, relationship_df$SR_floodplain_acres, rule=2)
  } else {
    # assume fall run relationship can be used
    SR_approx <- FR_floodplain_approx(relationship_df, modeling_lookup)
  }

  return(SR_approx)
}

#' function creates the approx function for steelhead
#' @param relationship_df dataframe from cvpiaHabitat with a flow to wua relationship
#' @param modeling_lookup modeling lookup dataframe from cvpiaHabitat
ST_floodplain_approx <- function(relationship_df, modeling_lookup){
  if (is.na(dplyr::pull(modeling_lookup, ST_floodplain))) {
    # no steelhead floodplain habitat in this watershed
    return(NA)
  } else if (dplyr::pull(modeling_lookup, ST_floodplain)){
    # case when modeling exists
    ST_approx <- approxfun(relationship_df$flow_cfs, relationship_df$ST_floodplain_acres, rule=2)
  } else {
    # else assume fall run relationship can be used
    ST_approx <- FR_floodplain_approx(relationship_df, modeling_lookup)
  }

  return(ST_approx)
}

#' function uses an existing relationship to return a linear interpolated approx function
#' @param watershed name of the watershed to compute approx function on
#' @param species one of 'fr' (Fall Run), 'sr' (Spring Run), or 'st' (Steelhead)
#' @return an approx function obtained from calling \code{\link[stats]{approxfun}}
floodplain_approx <- function(watershed, species = "fr") {

  # format watershed name to load wua relationship in the package
  watershed_name <- tolower(gsub(pattern = " ", replacement = "_", x = watershed))
  watershed_rda_name <- paste(watershed_name, "floodplain", sep = "_")
  df <- do.call(`::`, list(pkg = "cvpiaHabitat", name = watershed_rda_name))

  # used to grab correct columns for approx functions
  modeling_lookup <- dplyr::filter(cvpiaHabitat::modeling_exist, Watershed == watershed)

  switch(species,
         "fr" = {FR_floodplain_approx(df, modeling_lookup)},
         "sr" = {SR_floodplain_approx(df, modeling_lookup)},
         "st" = {ST_floodplain_approx(df, modeling_lookup)}
  )
}



