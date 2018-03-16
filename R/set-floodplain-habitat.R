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
#' @details The function relies on a dataframe called
#' \code{\link{modeling_exist}} that contains data on whether the species is present in a watershed.
#' If a model for the watershed does exist, the function looks up the flow to floodplain area relationship
#' (e.g. \code{\link{merced_river_floodplain}}) and selects the correct area for the
#' given flow and species.
#' When additional species modeling is not available, the fall run floodplain area
#' values were scaled to the different species' extents.
#'
#'
#' \strong{Regional Approximation:}
#' When a watershed has no associated floodplain modeling, an approximation is made.
#' [insert method description]
#'
#'
#' @export
set_floodplain_habitat <- function(watershed, species, flow) {

  if (species == 'sr' &
      is.na(cvpiaHabitat::modeling_exist[cvpiaHabitat::modeling_exist$Watershed == watershed, 'SR_floodplain'])) {
    warning("no spring run in this watershed")
    return(NA)
  }

  acres <- floodplain_approx(watershed, species)(flow)

  return(acres_to_square_meters(acres))

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
#' @export
apply_suitability <- function(fp_hab_sq_meters, suitable_factor = .27) {
  return(fp_hab_sq_meters * suitable_factor)
}
