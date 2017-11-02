#' Set spawning habitat area based on watershed, species, life stage and flow.
#'
#' @param watershed one of the watersheds defined for the SIT model
#' @param species one of 'fr' (Fall Run), 'sr' (Spring Run), or 'st' (Steelhead)
#' @param flow a flow value in cubic feet per second used to determine habitat area
#' @return habitat area in square meters
#' @export
#' @examples
#' # determine the spawning habitat area at Cottonwood Creek for Fall Run Chinook at flow 1567
#' set_spawning_habitat("Cottonwood Creek", "fr", 1567)
#'
#' # determine spawning habitat for a watershed with no modeling, uses region approximation
#' set_spawning_habitat("Antelope Creek", "fr", 1597)
#' @section Modeling Existance:
#' The set_spawning_habitat function relies on a dataframe exported by the package called
#' cvpiaHabitat::modeling_exist. This dataframe allows the set_spawning_habitat function to
#' determine whether a given watershed has either no existance of the species, has
#' existance but no model, or whether a model exists. Changes to the dataframe will affect
#' whether an attempt is made to look for the relationship between flow and wua or
#' a region approximation is made to determine habitat area.
#' The process for updating this dataframe requires not only altering the dataframe,
#' but adding a relationship to package in the form of a dataframe using
#' devtools::use_data(watershed_name_instream). For more details see \href{#}{here}
#' @section Region Approximation:
#' When a watershed has no associated flow to wua reltionship a region approximation is made.
#' Simply put, this approach determines a set of related watersheds (defined as a region)
#' for which a model does exists. It then applies set_spawning_habitat for each, takes
#' a mean of them and returns the appropriate area from this calculation.
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
    # create approx functions
    wua_func <- spawning_approx(watershed, species)

    # case when species does not exist in this watershed
    if (!is.function(wua_func) && is.na(wua_func)) {
      return(NA)
    }

    wua <- wua_func(flow)
    habitat_area <- wua_to_area(wua = wua, watershed = watershed,
                                life_stage = "spawning")
    return(habitat_area)
  }

}

#' function creates the approx function for fall run
#' @param relationship_df dataframe from cvpiaHabitat with a flow to wua relationship
#' @param modeling_lookup modeling lookup dataframe from cvpiaHabitat
FR_spawn_approx <- function(relationship_df, modeling_lookup){
  if (is.na(dplyr::pull(modeling_lookup, FR_spawn))) {
    # no spawning in this watershed
    return(NA)
  } else {
    # case when modeling exists
    FR_approx <- approxfun(relationship_df$flow_cfs,
                           relationship_df$FR_spawn_wua, rule = 2)
  }

  return(FR_approx)
}

#' function creates the approx function for spring run
#' @param relationship_df dataframe from cvpiaHabitat with a flow to wua relationship
#' @param modeling_lookup modeling lookup dataframe from cvpiaHabitat
SR_spawn_approx <- function(relationship_df, modeling_lookup){
  if (is.na(dplyr::pull(modeling_lookup, SR_spawn))){
    # no spawning in this watershed
    return(NA)
  } else if (dplyr::pull(modeling_lookup, SR_spawn)) {
    # case when modeling exists
    SR_approx <- approxfun(relationship_df$flow_cfs, relationship_df$SR_spawn_wua, rule = 2)
  } else {
    # case when no spring run modeling but fall run modeling is used
    SR_approx <- FR_spawn_approx(relationship_df, modeling_lookup)
  }

  return(SR_approx)
}

#' function creates the approx function for steelhead
#' @param relationship_df dataframe from cvpiaHabitat with a flow to wua relationship
#' @param modeling_lookup modeling lookup dataframe from cvpiaHabitat
ST_spawn_approx <- function(relationship_df, modeling_lookup){
  if (is.na(dplyr::pull(modeling_lookup, ST_spawn))){
    # no spawning in this watershed
    return(NA)
  } else if (dplyr::pull(modeling_lookup, ST_spawn)) {
    # case when modeling exists
    ST_approx <- approxfun(relationship_df$flow_cfs,
                           relationship_df$ST_spawn_wua, rule = 2)
  } else {
    # case when no steelhead modeling but fall run modeling is used
    ST_approx <- FR_spawn_approx(relationship_df, modeling_lookup)
  }

  return(ST_approx)
}

#' function uses a region to return approx functions for watersheds within it with models
#' @param region Region name, example "Upper-mid Sacramento River"
#' @param species one of 'fr' (Fall Run), 'sr' (Spring Run), or 'st' (Steelhead)
#' @return a list of approx functions obtained from calliong spawning_approx()
region_spawn_approx <- function(region, species) {
  # list of watersheds within the specified region with modeling
  watersheds_with_modeling <- dplyr::pull(dplyr::filter(cvpiaHabitat::modeling_exist,
                                                        Region == region,
                                                        FR_spawn), Watershed)

  # return list of approx function for the watersheds in region with modeling
  purrr::map(watersheds_with_modeling, ~spawning_approx(., species = species))
}

#' function uses an existing relationship to return a linear interpolated approx function
#' @param watershed name of the watershed to compute approx function on
#' @param species one of 'fr' (Fall Run), 'sr' (Spring Run), or 'st' (Steelhead)
#' @return an approx function obtained from calling \code{\link[stats]{approxfun}}
spawning_approx <- function(watershed, species = "fr") {

  # format watershed name to load wua relationship in the package
  watershed_name <- tolower(gsub(pattern = " ", replacement = "_", x = watershed))
  watershed_rda_name <- paste(watershed_name, "instream", sep = "_")
  df <- do.call(`::`, list(pkg = "cvpiaHabitat", name = watershed_rda_name))

  # used to grab correct columns for approx functions
  modeling_lookup <- dplyr::filter(cvpiaHabitat::modeling_exist, Watershed == watershed)

  switch(species,
         "fr" = {FR_spawn_approx(df, modeling_lookup)},
         "sr" = {SR_spawn_approx(df, modeling_lookup)},
         "st" = {ST_spawn_approx(df, modeling_lookup)}
  )
}

