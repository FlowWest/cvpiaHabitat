#' Set Floodplain Habitat Area
#' @description This function returns an estimated floodplain area based on watershed, species and flow.
#'
#' @param watershed a watershed defined for the SIT model
#' @param species one of 'fr' (Fall Run), 'sr' (Spring Run), or 'st' (Steelhead)
#' @param flow a flow value in cubic feet per second
#' @examples
#' # floodplain habitat value in square meters for Fall Run in the American River
#' set_floodplain_habitat("American River", "fr", 34652)
#'
#' # floodplain habitat value in square meters for Steelhead in the American River
#' set_floodplain_habitat("American River", "st", 34652)
#' @return floodplain habitat value in square meters
#'
#' @section Lower-mid Sacramento River:
#' The Lower-mid Sacramento River has two nodes, one above Fremont Weir (C134) and one below (C160).
#' When calculating habitat for the Lower-Mid Sacramento river, calculate the habitat at
#' each flow node and sum them proportion to the length of stream above and below the weir:
#'
#' 35.6/58 * (habitat at C134) + 22.4/58 * (habitat at C160)
#'
#'
#' \strong{Regional Approximation:}
#' When a watershed has no associated floodplain modeling, an approximation is made.
#' [insert method description]
#'
#'
#' @export
set_floodplain_habitat <- function(watershed, species, flow, flow2 = NULL) {

  if (species == 'sr' &
      is.na(cvpiaHabitat::modeling_exist[cvpiaHabitat::modeling_exist$Watershed == watershed, 'SR_floodplain'])) {
    warning("no spring run in this watershed")
    return(NA)
  }

  if (watershed %in% c('Upper Sacramento River', 'Upper-mid Sacramento River',
                       'Lower-mid Sacramento River', 'Lower Sacramento River')) {
    watershed_name <- tolower(gsub(pattern = " |-", replacement = "_", x = watershed))
    watershed_rda_name <- paste(watershed_name, "floodplain", sep = "_")

    df <- do.call(`::`, list(pkg = "cvpiaHabitat", name = watershed_rda_name))
    fp_approx <- approxfun(df$flow_cfs, df$floodplain_sq_meters, yleft = 0, yright = max(df$floodplain_sq_meters))

    if (watershed == 'Lower-mid Sacramento River') {
      if (is.null(flow2)) {
        warning('For CVPIA purposes: Lower-mid Sacramento River requires two flow values, one above and below Fremont Weir. Running with one flow value...')
        return(fp_approx(flow))
      } else {
        return(35.6/58 * fp_approx(flow) + 22.4/58 * fp_approx(flow2))
        }
    } else {
      return(fp_approx(flow))
    }

  } else {
    acres <- floodplain_approx(watershed, species)(flow)

    return(acres_to_square_meters(acres))}

}


floodplain_approx <- function(watershed, species) {
  # format watershed name to load flow to area relationship for floodplain
  watershed_name <- tolower(gsub(pattern = " |-", replacement = "_", x = watershed))
  watershed_rda_name <- paste(watershed_name, "floodplain", sep = "_")

  df <- do.call(`::`, list(pkg = "cvpiaHabitat", name = watershed_rda_name))


  switch(species,
         'fr' = approxfun(df$flow_cfs, df$FR_floodplain_acres, yleft = 0, yright = max(df$FR_floodplain_acres)),
         'sr' = approxfun(df$flow_cfs, df$SR_floodplain_acres, yleft = 0, yright = max(df$SR_floodplain_acres)),
         'st' = approxfun(df$flow_cfs, df$ST_floodplain_acres, yleft = 0, yright = max(df$ST_floodplain_acres)))

}


#' Apply Suitability Factor
#'
#' @description The modeled flow to floodplain area relationships within the package are for total innundated area.
#' This function applys a suitability factor to the total area in order to estimate total suitable floodplain area
#' available at a given flow.
#'
#' @param fp_hab_sq_meters Total floodplain area in square meters
#' @param suitable_factor Habitat suitability factor, default value of .27 from
#' U.S. Fish and Wildlife Services San Joaquin River Restoration Program
#' \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/20121127_MinimumRearingHabitat.pdf}{2012 report.}
#'
#' @return Total suitable floodplain area in square meters
#'
#' @details
#' Do not apply a suitability factory to the floodplain areas of the
#' Sacramento Reaches, the Sutter and Yolo Bypasses, and the North and South Deltas.
#'
#' @export
apply_suitability <- function(fp_hab_sq_meters, suitable_factor = .27) {
  return(fp_hab_sq_meters * suitable_factor)
}
