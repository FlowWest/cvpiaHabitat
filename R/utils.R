#' WUA to Area in Square Meters
#' @description Function converts a Weighted Usable Area (WUA) to an
#' area in square meters by multiplying the WUA by the stream's length used by the species.
#' The lengths were obtained through expert outreach in 2017 and are available here \code{\link{cvpiaHabitat::watershed_lengths}}
#' @param wua WUA in square feet per 1000 feet
#' @param watershed watershed
#' @param species species
#' @param life_stage life stage
wua_to_area <- function(wua, watershed_name,  life_stage) {
  length <- dplyr::pull(dplyr::filter(cvpiaHabitat::watershed_lengths,
                                    watershed == watershed_name,
                                    #species == species_name,
                                    lifestage == life_stage), feet)

  ((length/1000) * wua)/10.7639
}


#' Square Meters to Acres
#' @description Function converts area in square meters to area in acres
#' @param sq_meters area in square meters
#' @examples
#' hab_sq_meters <- set_instream_habitat('Merced River', 'fr', 'fry', 425)
#' square_meters_to_acres(hab_sq_meters)
#'
#' @export
square_meters_to_acres <- function(sq_meters) {
  sq_meters * 0.000247105
}

#' Acres to Square Meters
#' @description Function converts area in acres to area in square meters
#' @param acres area in square meters
#' @export
acres_to_square_meters <- function(acres) {
  acres / 0.000247105
}
