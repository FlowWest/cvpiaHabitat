#' Habitat Data
#' @description Datasets used to calculate spawning, instream, and floodplain
#' rearing habitat areas for Chinook Salmon and Steelhead
#' @format NULL
#'
#' @section Instream:
#' Datasets containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second for Fall Run (FR), Spring Run (SR),
#' Winter Run (WR), and Steelhead (ST) depending on species occurance and modeling availability.
#'
#' Typical data structure for streams:
#' \itemize{
#'   \item{\strong{flow_cfs} - flow value in cubic feet per second}
#'   \item{\strong{FR_spawn_wua} - Spawning WUA in square feet per 1000 feet}
#'   \item{\strong{FR_fry_wua} - Fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{\strong{FR_juv_wua} - Juvenile WUA in square feet per 1000 feet}
#'   \item{\strong{watershed} - Name of watershed}
#' }
#'
#' @section Floodplain:
#' Datasets containing the total inuncated area in acres as a function of flow in cubic
#' feet per second for Fall Run (FR), Spring Run (SR), Winter Run (WR), and
#' Steelhead (ST) depending on species occurance and modeling availability.
#'
#' Typical data structure for streams:
#' \itemize{
#'   \item{\strong{flow_cfs} - Flow value in cubic feet per second}
#'   \item{\strong{FR_floodplain_acres} - Total inundated area in acres for Fall Run}
#'   \item{\strong{SR_floodplain_acres} - Total inundated area in acres for Spring Run}
#'   \item{\strong{ST_floodplain_acres} - Total inundated area in acres for Steelhead}
#'   \item{\strong{watershed} - Name of watershed}
#' }
#'
#' @section Modeling Details for Streams:
#' \itemize{
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/american_river.html}{American River}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/antelope_creek.html}{Antelope Creek}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/battle_creek.html}{Battle Creek}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/bear_creek.html}{Bear Creek}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/bear_river.html}{Bear River}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/big_chico_creek.html}{Big Chico Creek}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/butte_creek.html}{Butte Creek}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/calaveras_river.html}{Calaveras River}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/clear_creek.html}{Clear Creek}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/cosumnes_river.html}{Cosumnes River}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/cottonwood_creek.html}{Cottonwood Creek}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/cow_creek.html}{Cow Creek}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/deer_creek.html}{Deer Creek}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/elder_creek.html}{Elder Creek}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/feather_river.html}{Feather River}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/merced_river.html}{Merced River}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/mill_creek.html}{Mill Creek}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/mokelumne_river.html}{Mokelumne River}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/paynes_creek.html}{Paynes Creek}
#'   \item \link[=upper_sac_ACID_boards_in]{Sacramento River}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/san_joaquin_river.html}{San Joaquin River}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/stanislaus_river.html}{Stanislaus River}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/stony_creek.html}{Stony Creek}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/thomes_creek.html}{Thomes Creek}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/tuolumne_river.html}{Tuolumne River}
#'   \item \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/yuba_river.html}{Yuba River}
#' }
#'
#' @section Bypasses:
#' \itemize{
#'   \item \link[=bypass]{Sutter and Yolo Bypasses}
#' }
#'
#' @section Delta:
#' \itemize{
#'   \item \link[=delta_habitat]{North and South Delta}
#' }
#' @name habitat_data
NULL

# STREAMS ----
# in alphabetical order

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"american_river_instream"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"american_river_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"antelope_creek_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"battle_creek_instream"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"battle_creek_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"bear_creek_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"bear_river_instream"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"bear_river_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"big_chico_creek_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"butte_creek_instream"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"butte_creek_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"calaveras_river_instream"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"calaveras_river_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"clear_creek_instream"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"clear_creek_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"cosumnes_river_instream"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"cosumnes_river_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"cottonwood_creek_instream"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"cottonwood_creek_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"cow_creek_instream"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"cow_creek_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"deer_creek_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"elder_creek_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"feather_river_instream"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"feather_river_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"merced_river_instream"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"merced_river_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"mill_creek_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"mokelumne_river_instream"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"mokelumne_river_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"paynes_creek_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"san_joaquin_river_instream"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"san_joaquin_river_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"stanislaus_river_instream"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"stanislaus_river_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"stony_creek_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"thomes_creek_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"tuolumne_river_instream"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"tuolumne_river_floodplain"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"yuba_river_instream"

#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"yuba_river_floodplain"

# REGIONAL ----
#' @rdname habitat_data
#' @format NULL
#' @usage NULL
"upper_mid_sac_region_instream"

# SACRAMENTO ----
#' Mainstem Sacramento River Habitat Data
#' @description Datasets used to calculate spawning, instream, and floodplain
#' rearing habitat areas for Chinook Salmon and Steelhead
#'
#' @format NULL
#'
#' @usage NULL
#'
#' @section Spawning:
#' Datasets containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second for Fall Run (FR), Late-fall Run (LFR),
#' Winter Run (WR), and Steelhead (ST).
#'
#' \itemize{
#'   \item \code{upper_sac_ACID_boards_in}
#'   \item \code{upper_sac_ACID_boards_out}
#' }
#'
#' Data Format:
#' \itemize{
#'   \item{\strong{flow_cfs} - flow value in cubic feet per second}
#'   \item{\strong{FR_spawn_wua} - Spawning WUA in square feet per 1000 feet (Fall Run)}
#'   \item{\strong{LFR_spawn_wua} - Spawning WUA in square feet per 1000 feet (Late-Fall Run)}
#'   \item{\strong{ST_spawn_wua} - Spawning WUA in square feet per 1000 feet (Steelhead)}
#'   \item{\strong{WR_spawn_wua} - Spawning WUA in square feet per 1000 feet (Winter Run)}
#'   \item{\strong{watershed} - Name of watershed}
#' }
#'
#' @section Instream:
#' Datasets containing the instream rearing habitat area in square meters as a
#' function of flow in cubic feet per second.
#'
#' \itemize{
#'   \item \code{upper_sacramento_river_instream}
#'   \item \code{upper_mid_sacramento_river_instream}
#'   \item \code{lower_mid_sacramento_river_instream}
#'   \item \code{lower_sacramento_river_instream}
#' }
#'
#' Data Format:
#' \itemize{
#'   \item{\strong{flow_cfs} - Flow value in cubic feet per second}
#'   \item{\strong{rearing_sq_meters} - Suitable rearing area in square meteres}
#'   \item{\strong{watershed} - Name of watershed}
#' }
#'
#' @section Floodplain:
#' Datasets containing the floodplain habitat area in square meters as a function
#' of flow in cubic feet per second.
#'
#' \itemize{
#'   \item \code{upper_sacramento_river_floodplain}
#'   \item \code{upper_mid_sacramento_river_floodplain}
#'   \item \code{lower_mid_sacramento_river_floodplain}
#'   \item \code{lower_sacramento_river_floodplain}
#' }
#'
#' Data Format:
#' \itemize{
#'   \item{\strong{flow_cfs} - Flow value in cubic feet per second}
#'   \item{\strong{floodplain_sq_meters} - Suitable rearing area in square meteres}
#'   \item{\strong{watershed} - Name of watershed}
#' }
#'
#' @source
#' \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/sacramento_river.html}{Sacramento River Modeling Details}
#'
#' @name sacramento_habitat
NULL

#' @rdname sacramento_habitat
#' @format NULL
#' @usage NULL
"upper_sac_ACID_boards_in"

#' @rdname sacramento_habitat
#' @format NULL
#' @usage NULL
"upper_sac_ACID_boards_out"

#' @rdname sacramento_habitat
#' @format NULL
#' @usage NULL
"upper_sacramento_river_instream"

#' @rdname sacramento_habitat
#' @format NULL
#' @usage NULL
"upper_sacramento_river_floodplain"

#' @rdname sacramento_habitat
#' @format NULL
#' @usage NULL
"upper_mid_sacramento_river_instream"

#' @rdname sacramento_habitat
#' @format NULL
#' @usage NULL
"upper_mid_sacramento_river_floodplain"

#' @rdname sacramento_habitat
#' @format NULL
#' @usage NULL
"lower_mid_sacramento_river_instream"

#' @rdname sacramento_habitat
#' @format NULL
#' @usage NULL
"lower_mid_sacramento_river_floodplain"

#' @rdname sacramento_habitat
#' @format NULL
#' @usage NULL
"lower_sacramento_river_instream"

#' @rdname sacramento_habitat
#' @format NULL
#' @usage NULL
"lower_sacramento_river_floodplain"

# BYPASS ----
#' Bypass Flow to Habitat Area Relationships
#'
#' @description A dataset containing the suitable habitat area in square meters as a
#' function of flow in cubic feet per second.
#'
#' @format NULL
#'
#' @section Yolo Bypass:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{Yolo Bypass 1}{suitable rearing area in square meters in the Yolo Bypass, Fremont Weir to Sacramento Weir}
#'   \item{Yolo Bypass 2}{suitable rearing area in square meters in the Yolo Bypass below Sacramento Weir}
#' }
#'
#' @section Sutter Bypass:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{Sutter Bypass 1}{suitable rearing area in square meters in the Sutter Bypass, to Moulton Weir}
#'   \item{Sutter Bypass 2}{suitable rearing area in square meters in the Sutter Bypass, to Colusa Weir}
#'   \item{Sutter Bypass 3}{suitable rearing area in square meters in the Sutter Bypass, to Tisdale Weir}
#'   \item{Sutter Bypass 4}{suitable rearing area in square meters in the Sutter Bypass below Tisdale Weir}
#' }
#'
#'
#' @examples
#' yolo_bypass_floodplain
#'
#' @source \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/bypasses.html}{Sutter and Yolo Bypass Modeling Details}
#' @name bypass
#' @aliases NULL
NULL

#' @rdname bypass
#' @format NULL
'yolo_bypass_habitat'

#' @rdname bypass
#' @format NULL
'sutter_bypass_habitat'

# DELTA ----
#' Delta Habitat Area
#'
#' @description A dataset containing the area of highly suitable habitat within the
#' North and South Deltas
#'
#' @format dataframe with 372 rows and 3 variables
#' \describe{
#'   \item{date}{modeled results for 1980-2010}
#'   \item{North Delta}{high quality habitat area in square meters}
#'   \item{South Delta}{high quality habitat area in square meters}
#' }
#'
#'
#' @source
#' \href{http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/delta.html}{North and South Delta Modeling Details}
#'
#' \itemize{
#'   \item Modeling Output: Correigh Green \email{correigh.greene@@noaa.gov}
#'   \item Delta Node Selection: Mark Tompkins \email{mtompkins@@flowwest.com}
#'   \item Data Wrangling: Sadie Gill \email{sgill@@flowwest.com}
#' }
'delta_habitat'

# OTHER-------------
#' Habitat Extent Lengths
#' @description A dataset containing the length of rearing and spawning extent within each CVPIA watershed for different species.
#'
#' @format dataframe with 57 rows and 7 variables
#' \describe{
#' \item{order}{integer value representing watershed order in SIT model}
#' \item{watershed}{name of watershed}
#' \item{lifestage}{habitat type by lifestage, 'spawing' or 'rearing'}
#' \item{miles}{length in miles}
#' \item{feet}{length in feet}
#' \item{source}{Expert who delineated habitat extents}
#' \item{species}{species of habitat extent}
#' }
#'
#' @examples
#' watershed_lengths
#'
#' @details Information comes from expert outreach undertaken in 2017.
#'
#' @source FlowWest, add url to shp file when mapping is complete
'watershed_lengths'

#' Habitat Modeling Status
#' @description This table summaries modeling availability based on species and
#' lifestage combinations for each watershed
#'
#' @format dataframe with 32 rows and 23 variables
#' \describe{
#' \item{Order}{integer value representing watershed order in SIT model}
#' \item{Watershed}{name of watershed}
#' \item{FR_spawn}{TRUE if spawning habitat modeling exists for Fall Run}
#' \item{FR_fry}{TRUE if fry rearing habitat modeling exists for Fall Run}
#' \item{FR_juv}{TRUE if juvenile rearing habitat modeling exists for Fall Run}
#' \item{FR_floodplain}{TRUE if floodplain rearing modeling exists for Fall Run}
#' \item{SR_spawn}{TRUE if spawning habitat modeling exists for Spring Run}
#' \item{SR_fry}{TRUE if fry rearing habitat modeling exists for Spring Run}
#' \item{SR_juv}{TRUE if juvenile rearing habitat modeling exists for Spring Run}
#' \item{SR_floodplain}{TRUE if floodplain rearing modeling exists for Spring Run}
#' \item{ST_spawn}{TRUE if spawning habitat modeling exists for Steelhead}
#' \item{ST_fry}{TRUE if fry rearing habitat modeling exists for Steelhead}
#' \item{ST_juv}{TRUE if juvenile rearing habitat modeling exists for Steelhead}
#' \item{ST_floodplain}{TRUE if floodplain rearing modeling exists for Steelhead}
#' \item{ST_adult}{TRUE if adult rearing habitat modeling exists for Steelhead}
#' \item{LFR_spawn}{TRUE if spawning habitat modeling exists for Late-fall Run}
#' \item{LFR_fry}{TRUE if fry rearing habitat modeling exists for Late-fall Run}
#' \item{LFR_juv}{TRUE if juvenile rearing habitat modeling exists for Late-fall Run}
#' \item{LFR_floodplain}{TRUE if floodplain rearing modeling exists for Late-fall Run}
#' \item{WR_spawn}{TRUE if spawning habitat modeling exists for Winter Run}
#' \item{WR_fry}{TRUE if fry rearing habitat modeling exists for Winter Run}
#' \item{WR_juv}{TRUE if juvenile rearing habitat modeling exists for Winter Run}
#' \item{WR_floodplain}{TRUE if floodplain rearing modeling exists for Winter Run}
#' }
#'
#' @examples
#' modeling_exist
#'
#' @source Sadie Gill \email{sgill@@flowwest.com}
'modeling_exist'

#' Flow Thresholds for Number of Weeks Inundated
#' @description Estimated relationship between duration of inundation and monthly mean flow
#' @format dataframe with rows and 3 variables
#' \describe{
#' \item{watershed}{name of CVPIA watershed}
#' \item{weeks_inundated}{integer value between 0 and 4 to represent weeks of floodplain inundation}
#' \item{flow_threshold}{flow threshold in cubic feet per second associated with number of weeks inundated}
#' }
#'
#' @examples
#' weeks_inundated
#'
#' @details
#' Visual inspection of measured flow and professional judgement were used to define relationships
#' between number of days inundated and the mean monthly flow.
#'
#'
#' \strong{Relationship Modeled:} \cr
#' \itemize{
#'   \item Sacramento River
#'   \item Big Chico Creek
#'   \item Butte Creek
#'   \item Cottonwood Creek
#'   \item Deer Creek
#'   \item Elder Creek
#'   \item Sutter Bypass
#'   \item Bear River
#'   \item Feather River
#'   \item Yuba River
#'   \item Yolo Bypass
#'   \item American River
#'   \item Calaveras River
#'   \item Merced River
#'   \item Stanislaus River
#'   \item Tuolumne River
#'   \item San Joaquin River
#' }
#'
#'
#' All other watersheds are assumed to have a two week inundation.
#'
#' @source Sadie Gill  \email{sgill@@flowwest.com}
'weeks_inundated'

#' Pool Area
#'
#' @description A dataset containing estimated area of pools within a watershed
#'
#' @format dataframe with 31 rows and 3 variables
#' \describe{
#'   \item{watershed}{CVPIA watershed}
#'   \item{SR_pools_sq_meters}{Spring Run pool area estimate in square meters}
#'   \item{ST_pools_sq_meters}{Steelhead pool area estimate in square meters}
#' }
#'
#' @details
#' Estimates of percent pools were provided by Mark Gard for some watersheds.
#' The mean percent pools, excluding Feather River, is 23.1\%. This value is used for watersheds without an estimate.
#' The total area of pools is then caluculated
#' by multiplying the estimated percent pools by the total channel area. Channel
#' areas were estimated using Google Earth Engine.
#'
#' Watersheds With Estimated Percent Pools:
#' \itemize{
#'   \item Antelope Creek
#'   \item Battle Creek
#'   \item Butte Creek
#'   \item Clear Creek
#'   \item Cottonwood Creek
#'   \item Deer Creek
#'   \item Feather River (*80% percent pools seems high, but was confirmed by Jason Kindopp)
#'   \item Mill Creek
#'   \item Mokelumne River
#'   \item Stanislaus River
#'   \item Tuolumne River
#'   \item Upper Sacramento River
#'   \item Yuba River
#' }
#'
#' \strong{Note:} The area of pools that covers both the Upper Sacramento and
#' Upper-mid Sacramento DSM segments is assigned to the Upper Sacramento River.
#'
#' @source
#' \itemize{
#'   \item Percent Pool Estimates: Mark Gard \email{Mark.Gard@@Wildlife.ca.gov}
#'   \item Channel Area Estimates: Sadie Gill \email{sgill@@flowwest.com}
#'   \item QA/QC: Mark Tompkins \email{mtompkins@@flowwest.com}
#' }
#'
'pools'

# TODO revise now that we have more adult rearing modeling
#' Steelhead Adult Rearing Habitat
#'
#' @description A dataset containing adult rearing habitat quanities in square meters
#'
#'
#' @format array[watersheds, months, years]
#'
#' @details
#' Only 5 of the watersheds have wua relationships:
#' **Adult Trout**
#' 1. Battle Creek
#' 2. Butte Creek
#'
#' **Steelhead**
#' 3. Merced River
#' 4. Tuolumne River
#' 5. Yuba River
#'
#' These watershed's habitat values vary by month.
#'
#' For the other watersheds, we created one habitat value using the calsim mean flows for the years 1980-1999.
#' We used Merced's adult steelhead wua curve and scaled it by the ratio of mean flow December through May
#' between itself and Merced.
#'
#' @source
#' \itemize{
#'   \item Wrangling: Sadie Gill \email{sgill@@flowwest.com}
#'   \item Method: Mark Tompkins \email{mtompkins@@flowwest.com}
#' }
#'
'IChab.adult'
