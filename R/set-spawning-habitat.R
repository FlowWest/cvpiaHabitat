#' Set Spawning Habitat Area
#' @description This function returns an estimated spawning area based on watershed, species, and flow.
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
#'
#' @details The function relies on a dataframe called
#' \code{\link{modeling_exist}} that contains data on whether the species is present in a watershed
#' and whether habitat modeling exists.
#' If a model for the watershed does exist, the function looks up the flow to weighted usable area (WUA) relationship
#' (e.g. \code{\link{battle_creek_instream}}) and selects the correct WUA for the
#' given flow and species. This WUA is then multiplied by the watershed's
#' typical spawning habitat extent length (stored in \code{\link{watershed_lengths}}),
#' to return an estimate of suitable spawning habitat within the watershed.
#' When additional species modeling is not available, the fall run WUA
#' values are used (lengths are modified if the habitat extent varies across species).
#'
#'
#' \strong{Regional Approximation:}
#' When a watershed has no associated flow to WUA reltionship, a regional approximation is made.
#' First, the mean WUA at the given flow vale from a set of similar modeled watersheds nearby is calculated.
#' Then the mean WUA is multiplied by the river length of the watershed of interest.
#'
#' Below are the regions (defined by the downstream watershed) that contain
#' watersheds with unmodeled spawning relationships. The modeled watersheds
#' used to approximate spawning area for the unmodeled watersheds
#' are marked with an asterisk.
#'
#'
#'
#' \strong{Upper-mid Sacramento River}
#' \itemize{
#'   \item Battle Creek*
#'   \item Bear Creek
#'   \item Big Chico Creek
#'   \item Butte Creek*
#'   \item Clear Creek*
#'   \item Cottonwood Creek*
#'   \item Cow Creek
#'   \item Deer Creek
#'   \item Elder Creek
#'   \item Mill Creek
#'   \item Paynes Creek
#'   \item Stony Creek
#'   \item Thomes Creek
#' }
#' \strong{South Delta}
#' \itemize{
#'   \item Calaveras River*
#'   \item Cosumnes River
#'   \item Mokelumne River*
#' }
set_spawning_habitat <- function(watershed, species, flow, ...) {

  no_spawning <- dplyr::pull(dplyr::filter(cvpiaHabitat::modeling_exist, is.na(FR_spawn)), Watershed)
  if (watershed %in% no_spawning) {
    return(NA)
  }

  if (species == 'sr') {
    spring_run_exists <- !is.na(dplyr::pull(
      dplyr::filter(cvpiaHabitat::modeling_exist,
                    Watershed == watershed), SR_spawn))
    if (!spring_run_exists) {
      return(NA)
    }
  }


  if (watershed == 'Upper Sacramento River') {
    return(set_upper_sac_spawn_habitat(species, flow, ...))
  }

  # determine the set of watersheds that need to use the region approx curves
  upper_mid_region <- dplyr::pull(
    dplyr::filter(
      cvpiaHabitat::modeling_exist,
      UseSpawnRegionApprox,
      Region == "Upper-mid Sacramento River"
    ),
    Watershed
  )

  # create approx functions
  if (watershed %in% upper_mid_region) {
    wua_func <- spawning_approx("Upper Mid Sac Region", species)
  } else {
    watershed_name <- tolower(gsub(pattern = "-| ", replacement = "_", x = watershed))
    watershed_rda_name <- paste(watershed_name, "instream", sep = "_")
    df <- do.call(`::`, list(pkg = "cvpiaHabitat", name = watershed_rda_name))

    wua_selector <- get_wua_selector(names(df), species, "spawn")
    flows <- df[ , "flow_cfs"][[1]]
    wuas <- df[ , wua_selector][[1]]
    wua_func <- approxfun(flows, wuas , rule = 2)
  }

  wua <- wua_func(flow)
  habitat_area <- wua_to_area(wua = wua, watershed = watershed,
                              life_stage = "spawning", species_name = species)

  return(habitat_area)

}


#' function creates the approx function for fall run
#' @param relationship_df dataframe from cvpiaHabitat with a flow to wua relationship
#' @param modeling_lookup modeling lookup dataframe from cvpiaHabitat
FR_spawn_approx <- function(relationship_df, modeling_lookup){
  if (dplyr::pull(modeling_lookup, FR_spawn)) {
    # case when modeling exists
    FR_approx <- approxfun(relationship_df$flow_cfs,
                           relationship_df$FR_spawn_wua, rule = 2)
  } else {
    #for calaveras
    FR_approx <- approxfun(relationship_df$flow_cfs,
                           relationship_df$ST_spawn_wua, rule = 2)
  }

  return(FR_approx)
}

#' function creates the approx function for spring run
#' @param relationship_df dataframe from cvpiaHabitat with a flow to wua relationship
#' @param modeling_lookup modeling lookup dataframe from cvpiaHabitat
SR_spawn_approx <- function(relationship_df, modeling_lookup){

  if (dplyr::pull(modeling_lookup, SR_spawn)) {
    # case when modeling exists
    SR_approx <- approxfun(relationship_df$flow_cfs, relationship_df$SR_spawn_wua, rule = 2)
  } else {
    # use fall run if availble, defaults to fall if not
    SR_approx <- FR_spawn_approx(relationship_df, modeling_lookup)
  }

  return(SR_approx)
}

#' function creates the approx function for steelhead
#' @param relationship_df dataframe from cvpiaHabitat with a flow to wua relationship
#' @param modeling_lookup modeling lookup dataframe from cvpiaHabitat
ST_spawn_approx <- function(relationship_df, modeling_lookup){

  if (dplyr::pull(modeling_lookup, ST_spawn)) {
    # case when modeling exists
    ST_approx <- approxfun(relationship_df$flow_cfs,
                           relationship_df$ST_spawn_wua, rule = 2)
  } else {
    # case when no steelhead modeling but fall run modeling is used
    ST_approx <- FR_spawn_approx(relationship_df, modeling_lookup)
  }

  return(ST_approx)
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

set_upper_sac_spawn_habitat <- function(species, flow, month) {
  # this is composed of two different curves, the first is the board in and second is boards out
  # board IN months 4-10
  # board OUT months 1-3, 11-12

  # for fall run fry modeling does not exist so we use fall run juv
  if (species == 'wr') {
    # winter run spawning
    upper_sac_IN_approx <- approxfun(cvpiaHabitat::upper_sac_ACID_boards_in$flow_cfs,
                                     cvpiaHabitat::upper_sac_ACID_boards_in$WR_spawn_WUA, rule=2)

    upper_sac_OUT_approx <- approxfun(cvpiaHabitat::upper_sac_ACID_boards_out$flow_cfs,
                                      cvpiaHabitat::upper_sac_ACID_boards_out$WR_spawn_WUA, rule=2)
  } else if (species == 'st') {
    # steelhead spawning
    upper_sac_IN_approx <- approxfun(cvpiaHabitat::upper_sac_ACID_boards_in$flow_cfs,
                                     cvpiaHabitat::upper_sac_ACID_boards_in$ST_spawn_WUA, rule=2)

    upper_sac_OUT_approx <- approxfun(cvpiaHabitat::upper_sac_ACID_boards_out$flow_cfs,
                                      cvpiaHabitat::upper_sac_ACID_boards_out$ST_spawn_WUA, rule=2)
  } else {
    # fall run and spring run spawning
    upper_sac_IN_approx <- approxfun(cvpiaHabitat::upper_sac_ACID_boards_in$flow_cfs,
                                     cvpiaHabitat::upper_sac_ACID_boards_in$FR_spawn_WUA, rule=2)

    upper_sac_OUT_approx <- approxfun(cvpiaHabitat::upper_sac_ACID_boards_out$flow_cfs,
                                      cvpiaHabitat::upper_sac_ACID_boards_out$FR_spawn_WUA, rule=2)
  }


  wua <- if (month < 4 | month > 10) {
    upper_sac_OUT_approx(flow)
  } else {
    upper_sac_IN_approx(flow)
  }

  habitat_area <- wua_to_area(wua = wua, watershed = 'Upper Sacramento River',
                              life_stage = "spawning", species_name = species)

  return(habitat_area)
}
