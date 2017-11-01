#' Set spawning habitat area based on watershed, species, life stage and flow.
#'
#' @param watershed one of the watersheds defined for the SIT model
#' @param species one of 'fr' (Fall Run), 'sr' (Spring Run), or 'st' (Steelhead)
#' @param flow a flow value in cubic feet per second used to determine habitat area
#' @return habitat area in square meters
#' @export
set_spawning_habitat <- function(watershed, species, flow) {

  watershed_to_skip <- dplyr::pull(dplyr::filter(cvpiaHabitat::modeling_exist,
                                                 !FR_spawn), Watershed)

  # check if watershed has no modeling, if so use regional approx
  if (watershed %in% watershed_to_skip) {
    region <- dplyr::pull(dplyr::filter(cvpiaHabitat::modeling_exist,
                                        Watershed == watershed), Region)

    approx_functions <- region_spawn_approx(region, species)
    wuas <- purrr::map_dbl(approx_functions, function(f) {
      f(flow)
    })
    wua <- mean(wuas)
    habitat_area <- wua_to_area(wua = wua, watershed = watershed,
                                life_stage = "spawning")
    return(habitat_area)
  } else {
    wua <- spawning_approx(watershed, species)(flow)
    habitat_area <- wua_to_area(wua = wua, watershed = watershed,
                                life_stage = "spawning")
    return(habitat_area)
  }

}


FR_spawn_approx <- function(waterhsed, df, modeling_lookup){
  if (is.na(dplyr::pull(modeling_lookup, FR_spawn))) {
    # no spawning in this watershed
    return(NA)
  } else {
    # case when modeling exists
    FR_approx <- approxfun(df$flow_cfs, df$FR_spawn_wua, rule = 2)
  }

  return(FR_approx)
}

SR_spawn_approx <- function(watershed, df, modeling_lookup){
  if (is.na(dplyr::pull(modeling_lookup, SR_spawn))){
    # no spawning in this watershed
    return(NA)
  } else if (dplyr::pull(modeling_lookup, SR_spawn)) {
    # case when modeling exists
    SR_approx <- approxfun(df$flow_cfs, df$SR_spawn_wua, rule = 2)
  } else {
    # case when no spring run modeling but fall run modeling is used
    SR_approx <- FR_spawn_approx(watershed, df, modeling_lookup)
  }

  return(SR_approx)
}

ST_spawn_approx <- function(watershed, df, modeling_lookup){
  if (is.na(dplyr::pull(modeling_lookup, ST_spawn))){
    # no spawning in this watershed
    return(NA)
  } else if (dplyr::pull(modeling_lookup, ST_spawn)) {
    # case when modeling exists
    ST_approx <- approxfun(df$flow_cfs, df$ST_spawn_wua, rule = 2)
  } else {
    # case when no steelhead modeling but fall run modeling is used
    ST_approx <- FR_spawn_approx(watershed, df, modeling_lookup)
  }

  return(ST_approx)
}


region_spawn_approx <- function(region, species) {
  # list of watersheds within the specified region with modeling
  watersheds_with_modeling <- dplyr::pull(dplyr::filter(cvpiaHabitat::modeling_exist,
                                                        Region == region,
                                                        FR_spawn), Watershed)

  # return list of approx function for the watersheds in region with modeling
  purrr::map(watersheds_with_modeling, ~spawning_approx(., species = species))
}


spawning_approx <- function(watershed, species = "fr") {

  # format watershed name to load wua relationship in the package
  watershed_name <- tolower(gsub(pattern = " ", replacement = "_", x = watershed))
  watershed_rda_name <- paste(watershed_name, "instream", sep = "_")
  df <- do.call(`::`, list(pkg = "cvpiaHabitat", name = watershed_rda_name))

  # used to grab correct columns for approx functions
  modeling_lookup <- dplyr::filter(cvpiaHabitat::modeling_exist, Watershed == watershed)

  switch(species,
         "fr" = {FR_spawn_approx(watershed, df, modeling_lookup)},
         "sr" = {SR_spawn_approx(watershed, df, modeling_lookup)},
         "st" = {ST_spawn_approx(watershed, df, modeling_lookup)}
  )
}

