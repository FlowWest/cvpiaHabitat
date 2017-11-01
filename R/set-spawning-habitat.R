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

FR_spawn_approx <- function(waterhsed, df, modeling_lookup){
  if (is.na(dplyr::pull(modeling_lookup, FR_spawn))) {
    # no spawning in this watershed
    return(NA)
  } else if (dplyr::pull(modeling_lookup, FR_spawn)){
    # case when modeling exists
    FR_approx <- approxfun(df$flow_cfs, df$FR_spawn_wua, rule = 2)
  } else {
    # case when no modeling avaiable, use regional approx
    #FR_approx <- region_spawn_approx(watershed, species = "fr")
    stop("regional approach was attempted")
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
  } else if(dplyr::pull(modeling_lookup, FR_spawn)) {
    # case when no spring run modeling but fall run modeling is used
    SR_approx <- FR_spawn_approx(watershed, df, modeling_lookup)
  } else {
    # case when no modeling avaiable, use regional approx
    stop("regional approach was attempted")
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
  } else if(dplyr::pull(modeling_lookup, FR_spawn)) {
    # case when no steelhead modeling but fall run modeling is used
    ST_approx <- FR_spawn_approx(watershed, df, modeling_lookup)
  } else {
    # case when no modeling avaiable, use regional approx
    #ST_approx <- SR_approx <- region_spawn_approx(watershed, species = "st")
    stop("regional approach was attempted")
  }

  return(ST_approx)
}

region_spawn_approx <- function(region, species) {
  watersheds_with_modeling <- dplyr::pull(dplyr::filter(cvpiaHabitat::modeling_exist,
                                                        Region == region,
                                                        FR_spawn), Watershed)

  purrr::map(watersheds_with_modeling, ~spawning_approx(., species = species))
}


spawning_approx <- function(watershed, species = "fr") {

  watershed_to_skip <- dplyr::pull(dplyr::filter(cvpiaHabitat::modeling_exist,
                                     !FR_spawn), Watershed)

  # check if watershed has no modeling, if so use regional approx
  if (watershed %in% watershed_to_skip) {
    region <- dplyr::pull(dplyr::filter(cvpiaHabitat::modeling_exist,
                                        Watershed == watershed), Region)
    return(region_spawn_approx(region, species))
  }

  # format watershed name to load wua relationship in the package
  watershed_name <- tolower(gsub(pattern = " ", replacement = "_", x = watershed))
  watershed_rda_name <- paste(watershed_name, "instream", sep = "_")
  df <- do.call(`::`, list(pkg = "cvpiaHabitat", name = watershed_rda_name))

  modeling_lookup <- dplyr::filter(cvpiaHabitat::modeling_exist, Watershed == watershed)


  switch(species,
         "fr" = {FR_spawn_approx(watershed, df, modeling_lookup)},
         "sr" = {SR_spawn_approx(watershed, df, modeling_lookup)},
         "st" = {ST_spawn_approx(watershed, df, modeling_lookup)}
  )
}

