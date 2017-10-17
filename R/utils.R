#' Function converts a weighted usable area (WUA) to area in square meters
#' @param wua weighted usable area
#' @param ws watershed
#' @param sp species
#' @param ls life stage
wua_to_area <- function(wua, ws, sp, ls) {
  d <- cvpiaHabitat::watershed_lengths

  watershed_length <- d %>% dplyr::filter(watershed == ws,
                                          species == sp,
                                          lifestage == ls) %>%
    dplyr::pull(feet)

  ((watershed_length/1000) * wua)/10.7639
}
