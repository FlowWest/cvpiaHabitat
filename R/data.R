#' Butte Creek Instream Flow to Habitat Area Relationship
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 41 rows and 6 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{spawn_WUA}{spawning WUA in square feet per 1000 feet}
#'   \item{fry_WUA}{fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{juv_WUA}{juvenile WUA in square feet per 1000 feet}
#'   \item{adult_trout_WUA}{adult trout WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning WUA was derived from a FWS River2D model and the rearing WUA from a PHABSIM
#' model created for the 2008 FERC relicensing of DeSabla. The spawning values are the summation of two river
#' segments, above Centerville Powerhouse (6.5 miles) and below (9 miles).
#' The spawning results are for Spring Run Chinook. The rearing results are for Fall Run Chinook.
#'
#' @source FWS and 2008 FERC relicensing of DeSabla
"butte_creek_instream"

#' Battle Creek Instream Flow to Habitat Area Relationship
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 35 rows and 6 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{spawn_WUA}{spawning WUA in square feet per 1000 feet}
#'   \item{fry_WUA}{fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{juv_WUA}{juvenile WUA in square feet per 1000 feet}
#'   \item{adult_trout_WUA}{adult trout WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning and rearing WUA values were derived from a PHABSIM model. The results are for Fall Run Chinook.
#'
#' @source Payne 1995
"battle_creek_instream"

#' Bear River Instream Flow to Habitat Area Relationship
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 4 rows and 4 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{spawn_WUA}{spawning WUA in square feet per 1000 feet}
#'   \item{juv_WUA}{juvenile (>50 mm) WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning and rearing WUA values were derived from a PHABSIM model. A River2D model is in development.
#' The results are for Fall Run Chinook.
#'
#' @source Holten 1985
"bear_river_instream"

#' Calaveras River Instream Flow to Habitat Area Relationship
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 10 rows and 5 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{spawn_WUA}{spawning WUA in square feet per 1000 feet}
#'   \item{fry_WUA}{fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{juv_WUA}{juvenile WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning and rearing WUA values were derived from a PHABSIM model. The reults are for Steelhead.
#'
#' @source FishBio and Payne 2009
"calaveras_river_instream"

#' Clear Creek Instream Flow to Habitat Area Relationship
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 23 rows and 11 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_fry}{fall run fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{FR_juv}{fall run juvenile WUA in square feet per 1000 feet}
#'   \item{FR_spawning}{fall run spawning WUA in square feet per 1000 feet}
#'   \item{SR_fry}{spring run fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{SR_juv}{spring run fry juvenile WUA in square feet per 1000 feet}
#'   \item{SR_spawning}{spring run fry spawning WUA in square feet per 1000 feet}
#'   \item{ST_fry}{steelhead fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{ST_juv}{steelhead juvenile WUA in square feet per 1000 feet}
#'   \item{ST_spawning}{steelhead spawning WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning and rearing WUA were derived from a FWS River2D model. The WUA values are the summation
#' of three river segments, Upper Alluvial (2.27 miles), Canyon Segment (7.33 miles), and Lower Alluvial (8.81 miles).
#' Fall Run are only in the Lower Alluvial Segment and there is a segregation weir that prevents the
#' Spring Run from spawning in the Lower Alluvial Segment.
#'
#' @source FWS 2007-2013
"clear_creek_instream"
