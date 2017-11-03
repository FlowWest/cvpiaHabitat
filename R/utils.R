#' Function converts a weighted usable area (WUA) to area in square meters
#' @param wua weighted usable area
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


#' Function converts area in square meters to area in acres
#' @param sq_meters area in square meters
square_meters_to_acres <- function(sq_meters) {
  sq_meters * 0.000247105
}

#' Function converts area in acres to area in square meters
#' @param acres area in square meters
acres_to_square_meters <- function(acres) {
  acres / 0.000247105
}
