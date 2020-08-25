#' Set Instream Habitat Area
#' @description This function returns an estimated instream habitat area based on watershed, species, life stage, and flow.
#'
#' @param watershed one of the watersheds defined for the SIT model
#' @param species one of 'fr' (Fall Run), 'sr' (Spring Run), or 'st' (Steelhead)
#' @param life_stage life stage of fish, one of 'juv', 'adult' or 'fry'
#' @param flow value used to determine habitat area
#' @return habitat area in square meters
#'
#' @details The function relies on a dataframe called
#' \code{\link{modeling_exist}} that contains data on whether the species is present in a watershed
#' and whether habitat modeling exists.
#' If a model for the watershed does exist, the function looks up the flow to weighted usable area (WUA) relationship
#' (e.g. \code{\link{battle_creek_instream}}) and selects the correct WUA for the
#' given flow, species, and life stage. This WUA is then multiplied by the watershed's
#' typical rearing habitat extent length (stored in \code{\link{watershed_lengths}}),
#' to return an estimate of suitable rearing habitat within the watershed.
#' When additional species modeling is not available, the fall run WUA
#' values are used (lengths are modified if the habitat extent varies across species).
#' Also, if there is no modeling specifically for fry, then the juvenile value is used.
#'
#' @section Lower-mid Sacramento River:
#' The Lower-mid Sacramento River has two nodes, one above Fremont Weir (C134) and one below (C160).
#' When calculating habitat for the Lower-Mid Sacramento river, calculate the habitat at
#' each flow node and sum them proportion to the length of stream above and below the weir:
#'
#' 35.6/58 * (habitat at C134) + 22.4/58 * (habitat at C160)
#'
#'
#' \strong{Regional Approximation:}
#' When a watershed has no associated flow to WUA reltionship, a regional approximation is made.
#' First, the mean WUA at the given flow value from a set of similar modeled watersheds nearby is calculated.
#' Then the mean WUA is multiplied by the river length of the watershed of interest.
#'
#' Below are the regions (defined by the downstream watershed) that contain
#' watersheds with unmodeled spawning relationships. The modeled watersheds
#' used to approximate spawning area for the unmodeled watersheds
#' are marked with an asterisk.
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
#'   \item Cow Creek*
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
#' @examples
#' # Fry rearing habitat value in square meters for Fall Run in the Merced River at 425 cfs.
#' set_instream_habitat('Merced River', 'fr', 'fry', 425) # habitat modeling exists
#' # Juvenile rearing habitat value in square meters for Fall Run in Elder Creek at 300 cfs.
#' set_instream_habitat('Elder Creek', 'fr', 'juv', 300) # no habitat modeling exists, composite used
#' @export
set_instream_habitat <- function(watershed, species, life_stage, flow, ...) {

  if (species == 'sr') {
    spring_run_exists <- !is.na(dplyr::pull(
      dplyr::filter(cvpiaHabitat::modeling_exist,
                    Watershed == watershed), SR_juv))
    if (!spring_run_exists){
      return(NA)
    }
  }

  if (watershed %in% c('Upper Sacramento River', 'Upper-mid Sacramento River',
                       'Lower-mid Sacramento River', 'Lower Sacramento River')) {
    return(set_sac_habitat(watershed, flow, ...))
  }

  # identify watersheds within upper mid that need to use region approx curve
  upper_mid_region <- dplyr::pull(
    dplyr::filter(cvpiaHabitat::modeling_exist,
                  UseRearRegionApprox,
                  Region == "Upper-mid Sacramento River"), Watershed)

  # create approx functions
  if (watershed %in% upper_mid_region) {
    wua_func <- rearing_approx("Upper Mid Sac Region", species, life_stage)
  } else {
    wua_func <- rearing_approx(watershed, species, life_stage)
  }

  wua <- wua_func(flow)
  habitat_area <- wua_to_area(wua = wua, watershed = watershed,
                              life_stage = "rearing", species_name = species)
  return(habitat_area)
}


#' Fall Run rearing habitat flow to area approximator
#' @description function creates the approx function for fall run
#' @param relationship_df dataframe from cvpiaHabitat with a flow to wua relationship
#' @param modeling_lookup modeling lookup dataframe from cvpiaHabitat
#' @param life_stage one of 'spawn', 'juv' or 'fry'
FR_rearing_approx <- function(relationship_df, modeling_lookup, life_stage){
  # check if fr floodplain has modeling
  FR_has_modeling <- dplyr::pull(modeling_lookup, FR_juv)

  if (FR_has_modeling) {
    # check to see if lifestage is fry
    if (life_stage == "fry") {
      fry_has_modeling <- dplyr::pull(modeling_lookup, FR_fry)
      if (fry_has_modeling) {
        # if modeling exists for fry use
        FR_approx <- approxfun(relationship_df$flow_cfs, relationship_df$FR_fry_wua, rule = 2)
      } else {
        # no fry modeling use juv modeling
        FR_approx <- approxfun(relationship_df$flow_cfs, relationship_df$FR_juv_wua, rule = 2)
      }
    } else {
      # for juvs use juv modeling
      FR_approx <- approxfun(relationship_df$flow_cfs, relationship_df$FR_juv_wua, rule = 2)
    }

  } else {
    # for calaveras
    FR_approx <- ST_rearing_approx(relationship_df, modeling_lookup, life_stage)
  }
    return(FR_approx)
}

#' Spring Run rearing habitat flow to area approximator
#' @description function creates the approx function for spring run
#' @param relationship_df dataframe from cvpiaHabitat with a flow to wua relationship
#' @param modeling_lookup modeling lookup dataframe from cvpiaHabitat
#' @param life_stage one of 'spawn', 'juv' or 'fry'
SR_rearing_approx <- function(relationship_df, modeling_lookup, life_stage) {
  # check if sr floodplain has modeling
  SR_has_modeling <- dplyr::pull(modeling_lookup, SR_juv)
  FR_has_modeling <- dplyr::pull(modeling_lookup, FR_juv)

  if (SR_has_modeling){
    if (life_stage == 'fry') {
      # life stage fry modeling
      SR_approx <- approxfun(relationship_df$flow_cfs, relationship_df$SR_fry_wua, rule = 2)
    } else {
      # life stage juv modeling
      SR_approx <- approxfun(relationship_df$flow_cfs, relationship_df$SR_juv_wua, rule = 2)
    }
  } else if (FR_has_modeling) {
    # no modeling use fall run modeling
    SR_approx <- FR_rearing_approx(relationship_df, modeling_lookup, life_stage)
  } else {
    SR_approx <- ST_rearing_approx(relationship_df, modeling_lookup, life_stage)
  }

  return(SR_approx)
}

#' Steelhead rearing habitat flow to area approximator
#' @description function creates the approx function for spring run
#' @param relationship_df dataframe from cvpiaHabitat with a flow to wua relationship
#' @param modeling_lookup modeling lookup dataframe from cvpiaHabitat
#' @param life_stage one of 'spawn', 'juv' or 'fry'
ST_rearing_approx <- function(relationship_df, modeling_lookup, life_stage) {
  # check if sr floodplain has modeling
  ST_has_modeling <- dplyr::pull(modeling_lookup, ST_juv)

  if (ST_has_modeling){
    if (life_stage == 'fry') {
      # life stage fry modeling
      ST_approx <- approxfun(relationship_df$flow_cfs, relationship_df$ST_fry_wua, rule = 2)
    } else {
      # life stage juv modeling
      ST_approx <- approxfun(relationship_df$flow_cfs, relationship_df$ST_juv_wua, rule = 2)
    }
  } else {
    # no modeling use fall run modeling
    ST_approx <- FR_rearing_approx(relationship_df, modeling_lookup, life_stage)
  }

  return(ST_approx)
}

#' function uses an existing relationship to return a linear interpolated approx function
#' @param watershed name of the watershed to compute approx function on
#' @param species one of 'fr' (Fall Run), 'sr' (Spring Run), or 'st' (Steelhead)
#' @return an approx function obtained from calling \code{\link[stats]{approxfun}}
rearing_approx <- function(watershed, species, life_stage) {

  # format watershed name to load wua relationship in the package
  watershed_name <- tolower(gsub(pattern = "-| ", replacement = "_", x = watershed))
  watershed_rda_name <- paste(watershed_name, "instream", sep = "_")
  df <- do.call(`::`, list(pkg = "cvpiaHabitat", name = watershed_rda_name))

  # used to grab correct columns for approx functions
  modeling_lookup <- dplyr::filter(cvpiaHabitat::modeling_exist, Watershed == watershed)

  switch(species,
         "fr" = {FR_rearing_approx(df, modeling_lookup, life_stage)},
         "sr" = {SR_rearing_approx(df, modeling_lookup, life_stage)},
         "st" = {ST_rearing_approx(df, modeling_lookup, life_stage)}
  )
}

set_sac_habitat <- function(watershed, flow, flow2 = NULL) {

  watershed_name <- tolower(gsub(pattern = "-| ", replacement = "_", x = watershed))
  watershed_rda_name <- paste(watershed_name, "instream", sep = "_")
  df <- do.call(`::`, list(pkg = "cvpiaHabitat", name = watershed_rda_name))

  rear_approx <- approxfun(df$flow_cfs, df$rearing_sq_meters, rule = 2)

  if (watershed == 'Lower-mid Sacramento River') {
    if (is.null(flow2)) {
      warning('For CVPIA purposes: Lower-mid Sacramento River requires two flow values, one above and below Fremont Weir. Running with one flow value...')
      return(fp_approx(flow))
      } else {
        return(35.6/58 * rear_approx(flow) + 22.4/58 * rear_approx(flow2))
      }
  } else {
    return(rear_approx(flow))
  }

}

