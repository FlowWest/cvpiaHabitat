#' Set spawning habitat area based on watershed, species, life stage and flow.
#'
#' @param watershed one of the watersheds defined for the SIT model
#' @param species one of 'fr' (Fall Run), 'sr' (Spring Run), or 'st' (Steelhead)
#' @param flow a flow value in cubic feet per second used to determine habitat area
#' @return habitat area in square meters
#' @export
set_spawning_habitat <- function(watershed, species, flow) {
  f <- watershed_to_spawning_methods[watershed][[1]](species)

  wua_value <- f(flow)
  area_value <- wua_to_area(wua = wua_value,
                            ws = watershed,
                            sp = "Fall Run Chinook", # this does not change right now
                            ls = "spawning")

  return(area_value)
}

# INTERNALS


spawning_species_error <- function(species) {
  stop(paste0("species '", species,  "' was not found for spawning habitat in this watershed"),
       call. = FALSE)
}

american_river_spawning_approx <- function(species) {
  d <- cvpiaHabitat::american_river_instream

  switch(species,
         "fr" = approxfun(d$flow_cfs, d$FR_spawning, rule = 2),
         "st" = approxfun(d$flow_cfs, d$ST_spawning, rule = 2),
         spawning_species_error(species))
}

battle_creek_spawning_approx <- function(species) {
  d <- cvpiaHabitat::battle_creek_instream

  switch(species,
         "fr" = approxfun(d$flow_cfs, d$spawn_WUA, rule = 2),
         spawning_species_error(species))
}


bear_river_spawning_approx <- function(species) {
  d <- cvpiaHabitat::bear_river_instream

  switch(species,
         "fr" = approxfun(d$flow_cfs, d$spawn_WUA, rule = 2),
         spawning_species_error(species))
}

butte_creek_spawning_approx <- function(species) {
  d <- cvpiaHabitat::butte_creek_instream

  switch(species,
         "fr" = approxfun(d$flow_cfs, d$spawn_WUA, rule = 2),
         spawning_species_error(species))
}

calaveras_river_spawning_approx <- function(species) {
  d <- cvpiaHabitat::calaveras_river_instream

  switch(species,
         "fr" = approxfun(d$flow_cfs, d$spawn_WUA, rule = 2),
         spawning_species_error(species))
}

clear_creek_spawning_approx <- function(species) {
  d <- cvpiaHabitat::clear_creek_instream

  switch(spcies,
         "fr" = approxfun(d$flow_cfs, d$FR_spawning, rule = 2),
         "sr" = approxfun(d$flow_cfs, d$SR_spawning, rule = 2),
         "st" = approxfun(d$flow_cfs, d$ST_spawning, rule = 2),
         spawning_species_error(species))
}

cottonwood_creek_spawning_approx <- function(species) {
  d <- cvpiaHabitat::cottonwood_creek_instream

  switch(species,
         "fr" = approxfun(d$flow_cfs, d$spawn_WUA, rule = 2),
         spawning_species_error(species))
}


feather_river_spawning_approx <- function(species) {
  d <- cvpiaHabitat::feather_river_instream

  switch(species,
         "fr" = approxfun(d$flow_cfs, d$spawn_WUA, rule = 2),
         spawning_species_error(species))
}

lower_sacramneto_spawning_approx <- function(species) {
  # no spawning
}

merced_river_spawning_approx <- function(species) {
  d <- cvpiaHabitat::merced_river_instream

  switch(species,
         "fr" = approxfun(d$flow_cfs, d$spawn_WUA, rule = 2),
         spawning_species_error(species))
}

mokelumne_river_spawning_approx <- function(speices) {
  d <- cvpiaHabitat::mokelumne_river_instream

  switch(species,
         "fr" = approxfun(d$flow_cfs, d$spawn_WUA, rule = 2),
         spawning_species_error(species))
}

north_delta_spawning_approx <- function(species) {
  # no spawning
}

stanislaus_river_spawning_approx <- function(species) {
  d <- cvpiaHabitat::stanislaus_river_instream

  switch(species,
         "fr" = approxfun(d$flow_cfs, d$spawn_WUA, rule =2),
         spawning_species_error(species))
}

tuolumne_river_spawning_approx <- function(species) {
  d <- cvpiaHabitat::tuolumne_river_instream

  switch(species,
         "fr" = approxfun(d$flow_cfs, d$spawn_WUA, rule = 2),
         "sr" = approxfun(d$flow_cfs, d$spawn_WUA, rule = 2),
         "st" = approxfun(d$flow_cfs, d$ST_spawn_WUA, rule = 2),
         spawning_species_error(species))
}

yuba_river_spawning_approx <- function(species) {
  d <- cvpiaHabitat::yuba_river_instream

  switch(species,
         "fr" = approxfun(d$flow_cfs, d$FR_spawning, rule = 2),
         "sr" = approxfun(d$flow_cfs, d$SR_spawning, rule = 2),
         "st" = approxfun(d$flow_cfs, d$ST_spawning, rule = 2),
         spawning_species_error(species))
}

antelope_creek_spawning_approx <- function(species) {
  d <- dplyr::filter(modeling_exist, Spawning, Region == "Upper-mid Sacramento River") %>%
    dplyr::pull(Watershed)

  switch(species,
         "fr" = watershed_to_spawning_methods[d],
         "sr" = watershed_to_spawning_methods[d],
         "st" = watershed_to_spawning_methods[d])

}

bear_creek_spawning_approx <- function(species) {
  d <- dplyr::filter(modeling_exist, Spawning, Region == "Upper-mid Sacramento River") %>%
    dplyr::pull(Watershed)

  switch(species,
         "fr" = watershed_to_spawning_methods[d],
         "st" = watershed_to_spawning_methods[d],
         stop("TODO"))

}

big_chico_creek_spawning_approx <- function(species) {
  d <- dplyr::filter(modeling_exist, Spawning, Region == "Upper-mid Sacramento River") %>%
    dplyr::pull(Watershed)

  switch(species,
         "fr" = watershed_to_spawning_methods[d],
         "st" = watershed_to_spawning_methods[d],
         stop("TODO"))
}

cow_creek_spawning_approx <- function(species) {
  d <- dplyr::filter(modeling_exist, Spawning, Region == "Upper-mid Sacramento River") %>%
    dplyr::pull(Watershed)

  switch(species,
         "fr" = watershed_to_spawning_methods[d],
         "st" = watershed_to_spawning_methods[d],
         stop("TODO"))
}

deer_creek_spawning_approx <- function(species) {
  d <- dplyr::filter(modeling_exist, Spawning, Region == "Upper-mid Sacramento River") %>%
    dplyr::pull(Watershed)

  switch(species,


         "fr" = watershed_to_spawning_methods[d],
         "st" = watershed_to_spawning_methods[d],
         stop("TODO"))
}



spawning_approx <- function(watershed, species = "fr") {
  # format watershed name to load wua relationship in the package
  watershed_name <- tolower(gsub(pattern = " ", replacement = "_", x = watershed))
  watershed_rda_name <- paste(watershed_name, "instream", sep = "_")
  df <- do.call(`::`, list(pkg = "cvpiaHabitat", name = watershed_rda_name))

  modeling_lookup <- dplyr::filter(cvpiaHabitat::modeling_exist, Watershed == watershed)

  # set FR_approx to use as default method for SR and ST if no additional modeling exist
  if (is.na(dplyr::pull(modeling_lookup, FR_spawn))) {
    FR_approx <- NA
  } else if (dplyr::pull(modeling_lookup, FR_spawn)){
    FR_approx <- approxfun(df$flow_cfs, df$FR_spawn_wua, rule = 2)
  } else {
    stop("FIX ME: call other watersheds in this region")
  }

  switch(species,
         "fr" = {FR_approx},
         "sr" = {
           if (is.na(dplyr::pull(modeling_lookup, SR_spawn))){
             return(NA)
           } else if (dplyr::pull(modeling_lookup, SR_spawn)) {
             approxfun(df$flow_cfs, df$SR_spawn_wua, rule = 2)
           } else {
             FR_approx
           }
         },
         "st" = {
           if (is.na(dplyr::pull(modeling_lookup, ST_spawn))){
             return(NA)
           } else if (dplyr::pull(modeling_lookup, ST_spawn)) {
             approxfun(df$flow_cfs, df$ST_spawn_wua, rule = 2)
           } else {
             FR_approx
           }
         }

  )
}

