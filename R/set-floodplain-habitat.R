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



