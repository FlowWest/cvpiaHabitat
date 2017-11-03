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

  # TODO: refactor when we have scaling and non modeled approach
  if (species == 'sr') {
    sr_blah <- dplyr::pull(dplyr::filter(cvpiaHabitat::modeling_exist,
                                         Watershed == watershed),
                SR_floodplain)
    if (is.na(sr_blah)) {
      return(NA)
    } else {
      needs_scaling = sr_blah
    }
  } else if (species == 'st') {
    needs_scaling = dplyr::pull(dplyr::filter(cvpiaHabitat::modeling_exist,
                                              Watershed == watershed),
                                ST_floodplain)
  } else {
    needs_scaling = FALSE
  }

  watershed_has_modeling <- dplyr::pull(dplyr::filter(cvpiaHabitat::modeling_exist,
                                                      FR_floodplain), Watershed)

  scale = 1 #at some point scale should look up scaling factor based on watershed


  if (watershed %in% watershed_has_modeling) {
    if (needs_scaling) {
      acres <- floodplain_approx(watershed)(flow) * scale
      acres_to_square_meters(acres)
    } else {
      acres <- floodplain_approx(watershed)(flow)
      acres_to_square_meters(acres)
    }
  } else {
    stop('implement other thing')
  }

}

floodplain_approx <- function(watershed) {
  # format watershed name to load flow to area relationship for floodplain
  watershed_name <- tolower(gsub(pattern = " ", replacement = "_", x = watershed))
  watershed_rda_name <- paste(watershed_name, "floodplain", sep = "_")
  df <- do.call(`::`, list(pkg = "cvpiaHabitat", name = watershed_rda_name))

  approxfun(df$flow_cfs, df$FR_floodplain_acres, rule = 2)
}
