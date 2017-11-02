#' Set instream habitat area based on watershed, species, life stage and flow
#'
#' @param watershed one of the watersheds defined for the SIT model
#' @param species one of 'fr', 'sr', or 'st'
#' @param life_stage life stage of fish, one of 'juv', 'adult' or 'fry'
#' @param flow value used to determine habitat area
#' @export
set_instream_habitat <- function(watershed, species, life_stage, flow) {
  f <- watershed_to_instream_methods[watershed][[1]](species, life_stage)

  wua_value <- f(flow)
  area_value <- wua_to_area(wua = wua_value,
                            ws = watershed,
                            sp = "Fall Run Chinook",
                            ls = "rearing") # ask sadie if rearing is ok here

  return(area_value)
}

# INTERNALS

rearing_approx <- function(watershed, species = "fr", life_stage) {
  w <- paste(tolower(gsub(pattern = " ", replacement = "_", x = watershed)), "instream", sep = "_")
  df <- do.call(`::`, list(pkg="cvpiaHabitat", name=w))

}

