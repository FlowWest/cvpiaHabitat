# FLOODPLAIN -------------------------------------------------------------------------------

#' Upper Sacramento River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 240 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @examples
#' upper_sacramento_river_floodplain
#'
#' @details The habitat area was derived from a HEC-RAS 1D model, Hendrix 2017.
#' The CVPIA Upper Sacramento River extends from Keswick to Red Bluff (59.2 mi).
#' This reach overlaps with two of the study's, Keswick to Battle Creek (55.5 mi) and Battle Creek to
#' the confluence with the Feather River (189.1 mi). To scale the study's results to CVPIA's extents,
#' the floodplain acerage at a given flow is the weighted average of the floodplain
#' area per river mile within each study.
#'
#' @source \href{https://www.google.com}{missing}
"upper_sacramento_river_floodplain"

#' Upper-mid Sacramento River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 240 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @examples
#' upper_mid_sacramento_river_floodplain
#'
#' @details The habitat area was derived from HEC-RAS 1D model, Hendrix 2017.
#' The study's extent is from Battle Creek to the confluence with the Feather River (189.1 mi).
#' The CVPIA Upper-mid Sacramento River extends from Red Blurr to Wilkins Slough (122.45 mi).
#' The study results are scaled to the CVPIA extent.
#'
#' @source \href{https://www.google.com}{NMFS Life Cycle Model, Hendrix 2017 [missing url]}
"upper_mid_sacramento_river_floodplain"

#' Lower-mid Sacramento River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 240 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The habitat area was derived from a HEC-RAS 1D model. The CVPIA Lower-mid Sacramento River extends
#' from Wilkins Slough to the American River (58.0 mi). This reach overlaps with two of the study's, Battle Creek to
#' the confluence with the Feather River (189.1 mi) and the confluence with the Feather River to Freeport (33.4 mi).
#' To scale the study's results to CVPIA's extents, we calculate the proportion of the Lower-mid Sacramento River
#' above (34\%) and below (66\%) the Feather River. The floodplain acerage at a given flow is the weighted average
#' of the floodplain area per river mile within each study.
#'
#' @examples
#' lower_mid_sacramento_river_floodplain
#'
#' @source \href{https://www.google.com}{missing}
"lower_mid_sacramento_river_floodplain"

#' Lower Sacramento River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 240 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The habitat area was derived from a HEC-RAS 1D model. The study's extent is
#' from the confluence with the Feather River to Freeport (33.4 mi). The CVPIA Lower
#' Sacramento River extends from the confluence with the American River to Freeport (13.7 mi).
#' The study results are scaled to the CVPIA extent.
#'
#' @examples
#' lower_sacramento_river_floodplain
#'
#' @source \href{https://www.google.com}{missing}
"lower_sacramento_river_floodplain"

#' Merced River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#'   function of flow in cubic feet per second
#'
#' @format dataframe with 22 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage (use for Steelhead when required)}
#'   \item{watershed}{name of watershed} }
#'
#' @details The habitat area was derived from the CVFPP 2012 HEC-RAS 1D model.
#'   The study only represents the lower 25.5 miles of the Merced River. The modeled results were scaled up to
#'   represent the whole rearing region. We calculate area per river mile from modeled reach and assign the product of the
#'   river mile distance and floodplain area per river mile for each reach defined as either in the Valley Lowland area,
#'   in a higher gradient / laterally confined area between Valley Lowland areas, or in the dredge tailing area.
#'   The study area is defined in the
#'   \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/Memo_Fish_30_August_2017.pdf}{CV Habitat Exchange}
#'   as being within the Valley Lowland, all other reaches with that same category are given the full area rate.
#'   River miles outside the Valley Lowland category recieve some proportion of the area rate, detailed below:
#'   \itemize{
#'     \item RM 0 - 25.5 use areas defined by study
#'     \item RM 25.5 - 31.2 "Valley Lowland" use 1X area/RM from modeled reach.
#'     \item RM 31.2 - 43.6 not "Valley Lowland", use 0.5X area/RM relationship from modeled reach.
#'     \item RM 43.6 - 47.0 "Valley Lowland", use 1X area/RM from modeled reach.
#'     \item RM 47.0 - 52.0 not "Valley Lowland" and in dredge tailings, use 0.1X area/RM from modeled reach.
#'   }
#'
#' @source Modeling: \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/CVFPP2012_Att8_June.pdf}{CVFPP2012}
#'
#' @examples
#' merced_river_floodplain
#'
#' Scaling Criteria developed by Mark Tompkins \email{mtompkins@@flowwest.com}
"merced_river_floodplain"

#' Yuba River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 20 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The habitat area was derived from the SRH2D model, Pasternack 2012.
#'
#' @examples
#' yuba_river_floodplain
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/Pasternack2012_LYR+Landforms+Report+(5-9-2012).pdf}{SRH2D}
"yuba_river_floodplain"

#' Tuolumne River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 37 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage (use for Spring Run and Steelhead when required)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details Model extent was from the confluence of the San Joaquin River upstream to LaGrange Dam.
#'
#' @examples
#' tuolumne_river_floodplain
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/Tuolumne_W-AR_21__Study+Report.pdf}{TUFLOW hydraulic model with 1D channel and 2D overbank components}
"tuolumne_river_floodplain"

#' Antelope Creek Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing total inundated floodplain area in acres as a function of flow in cubic feet per second.
#'
#' @format dataframe with 22 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage (use for Spring Run and Steelhead when required)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details HEC-RAS model runs to generate Deer Creek CVPIA DSM inputs conducted by Mark Gard (mark_gard@fws.gov) in 2017. An Antelope scaling factor of 47\% was calculated as the average ratio of Antelope Creek monthly mean flow to Deer Creek monthly mean flow between December and June. This scaling factor was applied to Deer Creek flows and corresponding floodplain area per river mile values, which were then multiplied by the 10.5 mile low gradient and 21.1 mile high gradient mapped rearing extent in Antelope Creek. Remote sensing analysis of aerial photography was used to confirm differentiation between instream (active channel area of 199 acres) and floodplain inundation area.
#'
#' @examples
#' antelope_creek_floodplain
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/DRAFT+Deer+Creek+Hydraulic+Models+Tech+Memo+6-08-07.pdf}{Scaled from a Deer Creek flow to floodplain area relationship generated with a 1D HEC-RAS hydraulic model}
"antelope_creek_floodplain"

#' Battle Creek Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing total inundated floodplain area in acres as a function of flow in cubic feet per second.
#'
#' @format dataframe with 22 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage (use for Spring Run and Steelhead when required)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details HEC-RAS model runs to generate Deer Creek CVPIA DSM inputs conducted by Mark Gard (mark_gard@fws.gov) in 2017. A Battle Creek scaling factor of 147\% was calculated as the average ratio of Battle Creek monthly mean flow to Deer Creek monthly mean flow between December and June. This scaling factor was applied to Deer Creek flows and corresponding floodplain area per river mile values, which were then multiplied by the 5.87 mile low gradient mapped rearing extent in Battle Creek. Remote sensing analysis of aerial photography was used to confirm differentiation between instream (active channel area of 52.4 acres) and floodplain inundation area.
#'
#' @examples
#' battle_creek_floodplain
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/DRAFT+Deer+Creek+Hydraulic+Models+Tech+Memo+6-08-07.pdf}{Scaled from a Deer Creek flow to floodplain area relationship generated with a 1D HEC-RAS hydraulic model}
"battle_creek_floodplain"

#' Bear Creek Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing total inundated floodplain area in acres as a function of flow in cubic feet per second.
#'
#' @format dataframe with 22 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage (use for Spring Run and Steelhead when required)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details HEC-RAS model runs to generate Deer Creek CVPIA DSM inputs conducted by Mark Gard (mark_gard@fws.gov) in 2017. A Bear Creek scaling factor of 25\% was calculated as the average ratio of Bear Creek monthly mean flow to Deer Creek monthly mean flow between December and June. This scaling factor was applied to Deer Creek flows and corresponding floodplain area per river mile values, which were then multiplied by the 4.3 mile low gradient and 13.0 miles of high gradient mapped rearing extent in Bear Creek. Remote sensing analysis of aerial photography was used to confirm differentiation between instream (active channel area of 29.6 acres) and floodplain inundation area.
#'
#' @examples
#' bear_creek_floodplain
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/DRAFT+Deer+Creek+Hydraulic+Models+Tech+Memo+6-08-07.pdf}{Scaled from a Deer Creek flow to floodplain area relationship generated with a 1D HEC-RAS hydraulic model}
"bear_creek_floodplain"

#' Cow Creek Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing total inundated floodplain area in acres as a function of flow in cubic feet per second.
#'
#' @format dataframe with 22 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage (use for Spring Run and Steelhead when required)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details HEC-RAS model runs to generate Deer Creek CVPIA DSM inputs conducted by Mark Gard (mark_gard@fws.gov) in 2017. A Cow Creek scaling factor of 216\% was calculated as the average ratio of Cow Creek monthly mean flow to Deer Creek monthly mean flow between December and June. This scaling factor was applied to Deer Creek flows and corresponding floodplain area per river mile values, which were then multiplied by the 8.6 mile low gradient and 55.6 miles of high gradient mapped rearing extent in Cow Creek. Remote sensing analysis of aerial photography was used to confirm differentiation between instream (active channel area of 217.5 acres) and floodplain inundation area.
#'
#' @examples
#' cow_creek_floodplain
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/DRAFT+Deer+Creek+Hydraulic+Models+Tech+Memo+6-08-07.pdf}{Scaled from a Deer Creek flow to floodplain area relationship generated with a 1D HEC-RAS hydraulic model}
"cow_creek_floodplain"

#' Mill Creek Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing total inundated floodplain area in acres as a function of flow in cubic feet per second.
#'
#' @format dataframe with 22 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage (use for Spring Run and Steelhead when required)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details HEC-RAS model runs to generate Deer Creek CVPIA DSM inputs conducted by Mark Gard (mark_gard@fws.gov) in 2017. A Mill Creek scaling factor of 98% was calculated as the average ratio of Mill Creek monthly mean flow to Deer Creek monthly mean flow between December and June. This scaling factor was applied to Deer Creek flows and corresponding floodplain area per river mile values, which were then multiplied by the 7.5 mile low gradient and 13.6 miles of high gradient mapped rearing extent in Mill Creek. Remote sensing analysis of aerial photography was used to confirm differentiation between instream (active channel area of 119.9 acres) and floodplain inundation area.
#'
#' @examples
#' mill_creek_floodplain
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/DRAFT+Deer+Creek+Hydraulic+Models+Tech+Memo+6-08-07.pdf}{Scaled from a Deer Creek flow to floodplain area relationship generated with a 1D HEC-RAS hydraulic model}
"mill_creek_floodplain"

#' Paynes Creek Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing total inundated floodplain area in acres as a function of flow in cubic feet per second.
#'
#' @format dataframe with 22 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage (use for Spring Run and Steelhead when required)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details HEC-RAS model runs to generate Deer Creek CVPIA DSM inputs conducted by Mark Gard (mark_gard@fws.gov) in 2017. A Paynes Creek scaling factor of 22\% was calculated as the average ratio of Paynes Creek monthly mean flow to Deer Creek monthly mean flow between December and June. This scaling factor was applied to Deer Creek flows and corresponding floodplain area per river mile values, which were then multiplied by the 2.0 mile low gradient and 9.8 miles of high gradient mapped rearing extent in paynes Creek. Remote sensing analysis of aerial photography was used to confirm differentiation between instream (active channel area of 29.6 acres) and floodplain inundation area.
#'
#' @examples
#' paynes_creek_floodplain
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/DRAFT+Deer+Creek+Hydraulic+Models+Tech+Memo+6-08-07.pdf}{Scaled from a Deer Creek flow to floodplain area relationship generated with a 1D HEC-RAS hydraulic model}
"paynes_creek_floodplain"

#' Stony Creek Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing total inundated floodplain area in acres as a function of flow in cubic feet per second.
#'
#' @format dataframe with 8 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage (use for Spring Run and Steelhead when required)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details HEC-RAS model runs to generate Cottonwood Creek CVPIA DSM inputs conducted by Mark Gard (mark_gard@fws.gov) in 2017. A Stony Creek scaling factor of 59\% was calculated as the average ratio of Stony Creek monthly mean flow to Cottonwood Creek monthly mean flow between December and June. This scaling factor was applied to Cottonwood Creek flows and corresponding floodplain area per river mile values, which were then multiplied by the 26 mile mapped rearing extent in Stony Creek. Remote sensing analysis of aerial photography was used to confirm differentiation between instream (active channel area of 203.5 acres) and floodplain inundation area.
#'
#' @examples
#' stony_creek_floodplain
#'
#' @source \href{#}{Scaled from a Cottonwood Creek flow to floodplain area relationship generated with a hybrid USFWS / FEMA 1D HEC-RAS hydraulic model}
"stony_creek_floodplain"


#' Thomes Creek Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing total inundated floodplain area in acres as a function of flow in cubic feet per second.
#'
#' @format dataframe with 8 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage (use for Spring Run and Steelhead when required)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details HEC-RAS model runs to generate Cottonwood Creek CVPIA DSM inputs conducted by Mark Gard (mark_gard@fws.gov) in 2017. A Thomes Creek scaling factor of 37% was calculated as the average ratio of Thomes Creek monthly mean flow to Cottonwood Creek monthly mean flow between December and June. This scaling factor was applied to Cottonwood Creek flows and corresponding floodplain area per river mile values, which were then multiplied by the 37.5 mile mapped rearing extent in Thomes Creek. Remote sensing analysis of aerial photography was used to confirm differentiation between instream (active channel area of 192.3 acres) and floodplain inundation area.
#'
#' @examples
#' thomes_creek_floodplain
#'
#' @source \href{#}{Scaled from a Cottonwood Creek flow to floodplain area relationship generated with a hybrid USFWS / FEMA 1D HEC-RAS hydraulic model}
"thomes_creek_floodplain"



#' Stanislaus River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 15 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage (use for Spring Run and Steelhead when required)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details Model extent was from the confluence of the San Joaquin River upstream to Goodwin Dam.  Active channel area delineated based on geomorphic features to differentiate between instream and floodplain habitat.
#'
#' @examples
#' stanislaus_river_floodplain
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/NewFields+Stanislaus+Model+Documentation.pdf}{SRH-2D hyraulic model developed by NewFields (now FlowWest www.flowwest.com)}
"stanislaus_river_floodplain"


#' San Joaquin River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 29 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage (use for Spring Run and Steelhead when required)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details CVFED HEC-RAS model runs to generate CVPIA DSM inputs conducted by Mark Gard (mark_gard@fws.gov) in 2017. Model extent was from the legal Delta boundary upstream 79 miles. Floodplain area for the 45 mile reach in this mapped rearing extent was calculated by applying 57\% scaling factor to adjust the actual reach length to the modeled reach length. Remote sensing analysis of aerial photography was used to confirm differentiation between instream (active channel area of 534.2 acres) and floodplain inundation area.
#'
#' @examples
#' san_joaquin_river_floodplain
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/CombinedTM_IQAR_Final-FULL-REPORT_20140206.pdf}{Central Valley Floodplain Evaluation and Delineation (CVFED) HEC-RAS hydraulic model}
"san_joaquin_river_floodplain"

#' North Delta Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 73 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage (use for Spring Run and Steelhead when required)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The habitat area was derived from the NMFS life cycle model, Hendirx 2017 HEC-RAS 1D model.
#'
#' @examples
#' north_delta_floodplain
#'
#' @source  \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/HendrixEtAl2014_Winter_Run_Model_Tech_Memo.pdf}{NMFS life cycle model}{Hendirx 2017 HEC-RAS 1D model}
"north_delta_floodplain"


#' Mokelumne River to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 33 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage (use for Spring Run and Steelhead when required)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details TUFLOW model runs to generate Tuolumne River CVPIA DSM inputs conducted by Mark Gard (mark_gard@fws.gov) in 2017. A Mokelumne River scaling factor of 50\% was calculated as the average ratio of Mokelumne River monthly mean flow to Tuolumne River monthly mean flow between December and June. This scaling factor was applied to Tuolumne River flows and corresponding floodplain area per river mile values, which were then multiplied by the 58.4 mile mapped rearing extent in the Mokelumne River. Remote sensing analysis of aerial photography was used to confirm appropriate scale of  instream (active channel area of 241.2 acres) versus floodplain inundation areas.
#'
#'
#' @source  \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/Tuolumne_W-AR_21__Study+Report.pdf}{Scaled from Tuolumne River flow to floodplain area relationship generated with a TUFLOW 2D hydraulic model}
#' @examples
#' mokelumne_river_floodplain
"mokelumne_river_floodplain"

#' Feather River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 39 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage (use for Spring Run and Steelhead when required)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details CVFED HEC-RAS model runs to generate CVPIA DSM inputs conducted by Mark Gard (mark_gard@fws.gov) in 2017. Model extent was from the confluence with the Sacramento River upstream 66 miles (the entire mapped rearing extent). Remote sensing analysis of aerial photography was used to confirm differentiation between instream (active channel area of 2363.2 acres) and floodplain inundation area.
#'
#' @examples
#' feather_river_floodplain
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/CombinedTM_IQAR_Final-FULL-REPORT_20140206.pdf}{Central Valley Floodplain Evaluation and Delineation (CVFED) HEC-RAS hydraulic model}
"feather_river_floodplain"

#' Elder Creek Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 29 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage (use for Steelhead when needed)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details CVFED HEC-RAS model runs to generate CVPIA DSM inputs conducted by Mark Gard (mark_gard@fws.gov) in 2017. Model extent was from the confluence of the Sacramento River upstream 5.4 miles. Floodplain area for the remaining 1.7 miles in the mapped rearing extent was calculated by determing the floodplain area per river mile in the modeled reach and applying this ratio to the unmodeled reach. Remote sensing analysis of aerial photography was used to confirm differentiation between instream (active channel area of 24.3 acres) and floodplain inundation area.
#'
#' @examples
#' elder_creek_floodplain
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/CombinedTM_IQAR_Final-FULL-REPORT_20140206.pdf}{Central Valley Floodplain Evaluation and Delineation (CVFED) HEC-RAS hydraulic model}
"elder_creek_floodplain"

#' Deer Creek Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 30 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage (use for Steelhead when needed)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details HEC-RAS model runs to generate Deer Creek CVPIA DSM inputs conducted by Mark Gard (mark_gard@fws.gov) in 2017. Model extent was from the confluence with the Sacramento River upstream 11.8 miles to the Deer Creek Irrigation District diversion dam. Floodplain area for the remaining 6.6 miles in the mapped rearing extent was calculated by determing the floodplain area per river mile in the modeled reach and applying this ratio to the unmodeled reach with a reduction factor of 10\% to account for the transition from low gradient to high gradient geomorphic conditions in the upper 6.6 miles of rearing extent. Remote sensing analysis of aerial photography was used to confirm differentiation between instream (active channel area of 58.7 acres) and floodplain inundation area.
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/DRAFT+Deer+Creek+Hydraulic+Models+Tech+Memo+6-08-07.pdf}{Deer Creek Watershed Conservancy (DCWC) 1D HEC-RAS model}
#'
#' @examples
#' deer_creek_floodplain
"deer_creek_floodplain"

#' Cottonwood Creek Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 10 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage (use for Steelhead when needed)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The habitat area was derived from the FWS 2017 HEC-RAS 1D model.
#'
#' @examples
#' cottonwood_creek_floodplain
#'
#' @source  \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/FWS2014_CVPIA_Annual_Progress_Report_Fiscal_Year_2013.pdf}{FWS}
"cottonwood_creek_floodplain"

#' Cosumnes River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 36 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage (use for Steelhead when needed)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details NA
#'
#' @source NA
#'
#' @examples
#' cosumnes_river_floodplain
"cosumnes_river_floodplain"

#' Calaveras River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 33 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage (use for Steelhead when needed)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details TUFLOW model runs to generate Tuolumne River CVPIA DSM inputs conducted by Mark Gard (mark_gard@fws.gov) in 2017. A Calaveras River scaling factor of 20\% was calculated as the average ratio of Calaveras River monthly mean flow to Tuolumne River monthly mean flow between December and June. This scaling factor was applied to Tuolumne River flows and corresponding floodplain area per river mile values, which were then multiplied by the 18.5 mile mapped rearing extent in the Calaveras River. Remote sensing analysis of aerial photography was used to confirm appropriate scale of  instream (active channel area of 75 acres) versus floodplain inundation areas.
#'
#' @examples
#' calaveras_river_floodplain
#'
#' @source  \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/Tuolumne_W-AR_21__Study+Report.pdf}{Scaled from Tuolumne River flow to floodplain area relationship generated with a TUFLOW 2D hydraulic model}
"calaveras_river_floodplain"


#' Big Chico Creek Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 7 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage (use for Steelhead when needed)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details CVFED HEC-RAS model runs to generate CVPIA DSM inputs conducted by Mark Gard (mark_gard@fws.gov) in 2017. Model extent was from the confluence of the Sacramento River upstream 8.7 miles. Floodplain area for the remaining 6.3 miles in the mapped rearing extent was calculated by determing the floodplain area per river mile in the modeled reach and applying this ratio to the unmodeled reach. Remote sensing analysis of aerial photography was used to confirm differentiation between instream (active channel area of 89 acres) and floodplain inundation area.
#'
#' @examples
#' big_chico_creek_floodplain
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/CombinedTM_IQAR_Final-FULL-REPORT_20140206.pdf}{Central Valley Floodplain Evaluation and Delineation (CVFED) HEC-RAS hydraulic model}
"big_chico_creek_floodplain"


#' Bear River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 35 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage (use for Steelhead when needed)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details CVFED HEC-RAS model runs to generate CVPIA DSM inputs conducted by Mark Gard (mark_gard@fws.gov) in 2017. Model extent was from the confluence of the Sacramento River upstream 16.4 miles. Floodplain area for the remaining 15.7 miles in the mapped rearing extent was calculated by determing the floodplain area per river mile in the modeled reach and applying this ratio to the unmodeled reach. Remote sensing analysis of aerial photography was used to confirm differentiation between instream (active channel area of 147.8 acres) and floodplain inundation area.
#'
#' @examples
#' bear_river_floodplain
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/CombinedTM_IQAR_Final-FULL-REPORT_20140206.pdf}{Central Valley Floodplain Evaluation and Delineation (CVFED) HEC-RAS hydraulic model}
"bear_river_floodplain"

#' American River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 35 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage (use for Steelhead when needed)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details CVFED HEC-RAS model runs to generate CVPIA DSM inputs conducted by Mark Gard (mark_gard@fws.gov) in 2017. Model extent was from the confluence with the Sacramento River upstream to Nimbus Dam. Remote sensing analysis of aerial photography was used to confirm differentiation between instream (active channel area of 670.2 acres) and floodplain inundation area.
#'
#' @examples
#' american_river_floodplain
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/CombinedTM_IQAR_Final-FULL-REPORT_20140206.pdf}{Central Valley Floodplain Evaluation and Delineation (CVFED) HEC-RAS hydraulic model}
"american_river_floodplain"

#' Butte Creek Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 31 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage (use for Spring Run and Steelhead when required)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details CVFED HEC-RAS model runs to generate CVPIA DSM inputs conducted by Mark Gard (mark_gard@fws.gov) in 2017. Model extent was from the confluence with the Sacramento River upstream 16.8 miles (the entire mapped rearing extent). Remote sensing analysis of aerial photography was used to confirm differentiation between instream (active channel area of 103.4 acres) and floodplain inundation area.
#' @examples
#' butte_creek_floodplain
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/CombinedTM_IQAR_Final-FULL-REPORT_20140206.pdf}{Central Valley Floodplain Evaluation and Delineation (CVFED) HEC-RAS hydraulic model}
"butte_creek_floodplain"


#' Clear Creek Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing total inundated floodplain area in acres as a function of flow in cubic feet per second
#'
#' @format dataframe with 8 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{floodplain_acres}{fall run floodplain acreage (use for Spring Run and Steelhead when required)}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details HEC-RAS model runs to generate Cottonwood Creek CVPIA DSM inputs conducted by Mark Gard (mark_gard@fws.gov) in 2017. A Clear Creek scaling factor of 21\% was calculated as the average ratio of Clear Creek monthly mean flow to Cottonwood Creek monthly mean flow between December and June. This scaling factor was applied to Cottonwood Creek flows and corresponding floodplain area per river mile values, which were then multiplied by the 8 mile mapped rearing extent in Clear Creek. Remote sensing analysis of aerial photography was used to confirm differentiation between instream (active channel area of 57.4 acres) and floodplain inundation area.
#'
#' @examples
#' clear_creek_floodplain
#'
#' @source NA
"clear_creek_floodplain"


# INSTREAMS ----------------------------------------------------------------------------------------


#' Butte Creek Instream Flow to Habitat Area Relationship
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 41 rows and 6 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_spawn_wua}{spawning WUA in square feet per 1000 feet}
#'   \item{FR_fry_wua}{fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{FR_juv_wua}{juvenile WUA in square feet per 1000 feet}
#'   \item{adult_trout_WUA}{adult trout WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning WUA values were derived from a FWS River2D model and the rearing WUA from a PHABSIM
#' model created for the 2008 FERC relicensing of DeSabla. The spawning values are from two river
#' segments, above Centerville Powerhouse (6.5 miles) and below (9 miles).
#' The spawning results are for Spring Run Chinook. The rearing results are for Fall Run Chinook.
#'
#' @examples
#' butte_creek_instream
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/DeSabla2008ButteIFIM.pdf}{FWS and 2008 FERC relicensing of DeSabla}
"butte_creek_instream"

#' Battle Creek Instream Flow to Habitat Area Relationship
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 35 rows and 6 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_spawn_wua}{spawning WUA in square feet per 1000 feet}
#'   \item{FR_fry_wua}{fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{FR_juv_wua}{juvenile WUA in square feet per 1000 feet}
#'   \item{adult_trout_WUA}{adult trout WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning and rearing WUA values were derived from a PHABSIM model. The results are for Fall Run Chinook.
#'
#' @examples
#' battle_creek_instream
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/Payne1995_BattleCreekIFIM.pdf}{Payne 1995}
"battle_creek_instream"

#' Bear River Instream Flow to Habitat Area Relationship
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 4 rows and 4 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_spawn_wua}{spawning WUA in square feet per 1000 feet}
#'   \item{FR_juv_wua}{juvenile (>50 mm) WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning and rearing WUA values were derived from a PHABSIM model. A River2D model is in development.
#' The results are for Fall Run Chinook.
#'
#' @examples
#' bear_river_instream
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/Holton1985_BearRiverIFIM.PDF}{Holten 1985}
"bear_river_instream"

#' Calaveras River Instream Flow to Habitat Area Relationship
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 10 rows and 5 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_spawn_wua}{spawning WUA in square feet per 1000 feet}
#'   \item{FR_fry_wua}{fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{FR_juv_wua}{juvenile WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning and rearing WUA values were derived from a PHABSIM model. The reults are for Steelhead.
#'
#' @examples
#' calaveras_river_instream
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/FishBio_Payne2009_CalaverasInstreamFlowStudy.pdf}{FishBio and Payne 2009}
"calaveras_river_instream"

#' Clear Creek Instream Flow to Habitat Area Relationship
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 23 rows and 11 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_fry_wua}{fall run fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{FR_juv_wua}{fall run juvenile WUA in square feet per 1000 feet}
#'   \item{FR_spawn_wua}{fall run spawning WUA in square feet per 1000 feet}
#'   \item{SR_fry_wua}{spring run fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{SR_juv_wua}{spring run fry juvenile WUA in square feet per 1000 feet}
#'   \item{SR_spawn_wua}{spring run fry spawning WUA in square feet per 1000 feet}
#'   \item{ST_fry_wua}{steelhead fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{ST_juv_wua}{steelhead juvenile WUA in square feet per 1000 feet}
#'   \item{ST_spawn_wua}{steelhead spawning WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning and rearing WUA were derived from a FWS River2D model. The WUA values are from
#' three river segments, Upper Alluvial (2.27 miles), Canyon Segment (7.33 miles), and Lower Alluvial (8.81 miles).
#' Fall Run are only in the Lower Alluvial Segment and there is a segregation weir that prevents the
#' Spring Run from spawning in the Lower Alluvial Segment.
#'
#' @examples
#' clear_creek_instream
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/FWS2007-2013_ClearCreekInstream.pdf}{FWS 2007-2013}
"clear_creek_instream"

#' Cottonwood Creek Instream Flow to Habitat Area Relationship
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 36 rows and 5 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_spawn_wua}{spawning WUA in square feet per 1000 feet}
#'   \item{FR_fry_wua}{fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{FR_juv_wua}{juvenile WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning WUA values were derived from a PHABSIM model. The rearing values are from the FWS 2014
#' River2D model. The results are for Fall Run.
#'
#' @examples
#' cottonwood_creek_instream
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/CDFW1979_CottonwoodSpawningIFIM.PDF}{CDFW 1979 and FWS 2014}
"cottonwood_creek_instream"

#' Feather River Instream Flow to Habitat Area Relationship
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 7 rows and 5 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_spawn_wua}{spawning WUA in square feet per 1000 feet}
#'   \item{FR_fry_wua}{fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{FR_juv_wua}{juvenile WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning and rearing WUA values were derived from a PHABSIM model. The results are for Fall Run.
#'
#' @examples
#' feather_river_instream
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/Payne2002_FeatherRiverIFIM+7-22-02.pdf}{Payne 2002}
"feather_river_instream"

#' Merced River Instream Flow to Habitat Area Relationship
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 30 rows and 6 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_spawn_wua}{spawning WUA in square feet per 1000 feet}
#'   \item{FR_fry_wua}{fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{FR_juv_wua}{juvenile WUA in square feet per 1000 feet}
#'   \item{adult_steelhead_WUA}{adult steelhead WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning WUA values were derived from the FWS 1996 PHABSIM model and the rearing from
#' the MID 2013 PHABSIM.
#'
#' @examples
#' merced_river_instream
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/FWS1996_AmericanRiverSpawningFinalReport.pdf}{FWS 1996 and MID 2013}
"merced_river_instream"

#' Mokelumne River Instream Flow to Habitat Area Relationship
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 14 rows and 5 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_spawn_wua}{spawning WUA in square feet per 1000 feet}
#'   \item{FR_fry_wua}{fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{FR_juv_wua}{juvenile WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning WUA values were derived from the EBMUD 2016 SRH2D model and the rearing from
#' the CDFW 1998 PHABSIM.
#'
#' @examples
#' mokelumne_river_instream
#'
#' @source EBMUD 2016 and CDFW 1998
"mokelumne_river_instream"

#' Cow Creek Instream Flow to Habitat Area Relationship
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 30 rows and 4 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_fry_wua}{fall run fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{FR_juv_wua}{fall run juvenile WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The rearing WUA values are from a River2D model done on South Cow Creek. The values are from two river
#' segments, Valley Floor Reach (5.11 miles) and Boero Reach (1.68 miles).
#'
#' @examples
#' cow_creek_instream
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/FWS2011_SouthCowrpt.pdf}{FWS 2011}
"cow_creek_instream"

#' Stanislaus River Instream Flow to Habitat Area Relationship
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 47 rows and 7 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_spawn_wua}{spawning WUA in square feet per 1000 feet}
#'   \item{FR_fry_wua}{fall run fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{FR_juv_wua}{fall run juvenile WUA in square feet per 1000 feet}
#'   \item{ST_fry_wua}{steelhead fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{ST_juv_wua}{steelhead juvenile WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning WUA was derived from the Aceituno 1993 (FWS) PHABSIM model and the rearing from
#' the FWS River2D model.
#'
#' @examples
#' stanislaus_river_instream
#'
#' @source FWS
"stanislaus_river_instream"

#' Upper Sacramento River Instream Flow to Habitat Area Relationship (A.C.I.D. Boards In)
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second.
#'
#' @format dataframe with 30 rows and 11 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_fry_WUA}{fall run fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{FR_juv_WUA}{fall run juvenile WUA in square feet per 1000 feet}
#'   \item{FR_spawn_WUA}{fall run spawning WUA in square feet per 1000 feet}
#'   \item{LFR_fry_WUA}{late-fall run fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{LFR_juv_WUA}{late-fall run fry juvenile WUA in square feet per 1000 feet}
#'   \item{LFR_spawn_WUA}{late-fall run fry spawning WUA in square feet per 1000 feet}
#'   \item{ST_spawn_WUA}{steelhead spawning WUA in square feet per 1000 feet}
#'   \item{WR_fry_WUA}{winter run fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{WR_juv_WUA}{winter run juvenile WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning WUA were derived from a FWS River2D model. The study is broken into several
#'  segments: Keswick to A.C.I.D. (3.5 mi), A.C.I.D. to Cow Creek (18.5 mi),
#'  Cow Creek to Battle Creek (8.5 mi), Battle Creek to Red Bluff (22.5 mi), and
#'  Red Bluff to Deer Creek (23.5 mi). The Upper Sacramento fall run
#' spawning WUA values include the spawning that occurs in the Upper and Upper-mid Sacramento River
#' (Keswick to Deer Creek). The Late-Fall Run, Winter Run, and Steelhead spawn from Keswick to Battle
#' Creek. The rearing WUA values come from two models, River2D (Keswick to Battle Creek)
#' and HEC-RAS 1D (Battle Creek to Red Bluff). The A.C.I.D. boards are in April 1st - October 31st
#'
#' \tabular{lllllll}{
#'   \strong{Species} \tab \strong{Migration} \tab \strong{Peak Migration} \tab \strong{Spawning} \tab \strong{Peak Spawning} \tab \strong{Juvenile Emergence} \tab \strong{Juvenile Rearing} \cr
#'   Late-Fall Run \tab Oct-Apr \tab Dec \tab Jan-Apr \tab Feb-Mar \tab Apr-Jun \tab 7-13 mths \cr
#'   Winter Run \tab Dec-Jul \tab Mar \tab Apr-Aug \tab May-Jun \tab Jul-Oct \tab 5-10 mths \cr
#'   Spring Run \tab Mar-Sep \tab May-Jun \tab Aug-Oct \tab Mid-Sep \tab Nov-Mar \tab 3-15 mths \cr
#'   Fall Run \tab Jun-Dec \tab Sep-Oct \tab Sep-Dec \tab Oct-Nov \tab Dec-Mar \tab 1-7 mths \cr
#' }
#'
#' \emph{Generalised life history Yoshinyama et al. 1998}
#'
#' Use these values to compute spawning habitat for Winter Run. Use these values to compute rearing habitat
#' for ....
#'
#' @examples
#' upper_sac_ACID_boards_in
#'
#' @source FWS and NMFS Life Cycle Model, Hendrix 2017
"upper_sac_ACID_boards_in"

#' Upper Sacramento River Instream Flow to Habitat Area Relationship (A.C.I.D. Boards Out)
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second.
#'
#' @format dataframe with 30 rows and 11 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_fry_WUA}{fall run fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{FR_juv_WUA}{fall run juvenile WUA in square feet per 1000 feet}
#'   \item{FR_spawn_WUA}{fall run spawning WUA in square feet per 1000 feet}
#'   \item{LFR_fry_WUA}{late-fall run fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{LFR_juv_WUA}{late-fall run fry juvenile WUA in square feet per 1000 feet}
#'   \item{LFR_spawn_WUA}{late-fall run fry spawning WUA in square feet per 1000 feet}
#'   \item{ST_spawn_WUA}{steelhead spawning WUA in square feet per 1000 feet}
#'   \item{WR_fry_WUA}{winter run fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{WR_juv_WUA}{winter run juvenile WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning WUA were derived from a FWS River2D model. The study is broken into several
#'  segments: Keswick to A.C.I.D. (3.5 mi), A.C.I.D. to Cow Creek (18.5 mi),
#'  Cow Creek to Battle Creek (8.5 mi), Battle Creek to Red Bluff (22.5 mi), and
#'  Red Bluff to Deer Creek (23.5 mi). The Upper Sacramento fall run
#' spawning WUA values include the spawning that occurs in the Upper and Upper-mid Sacramento River
#' (Keswick to Deer Creek). The Late-Fall Run, Winter Run, and Steelhead spawn from Keswick to Battle
#' Creek. The rearing WUA values come from two models, River2D (Keswick to Battle Creek)
#' and HEC-RAS 1D (Battle Creek to Red Bluff). The A.C.I.D. boards are in April 1st - October 31st
#'
#' \tabular{lllllll}{
#'   \strong{Species} \tab \strong{Migration} \tab \strong{Peak Migration} \tab \strong{Spawning} \tab \strong{Peak Spawning} \tab \strong{Juvenile Emergence} \tab \strong{Juvenile Rearing} \cr
#'   Late-Fall Run \tab Oct-Apr \tab Dec \tab Jan-Apr \tab Feb-Mar \tab Apr-Jun \tab 7-13 mths \cr
#'   Winter Run \tab Dec-Jul \tab Mar \tab Apr-Aug \tab May-Jun \tab Jul-Oct \tab 5-10 mths \cr
#'   Spring Run \tab Mar-Sep \tab May-Jun \tab Aug-Oct \tab Mid-Sep \tab Nov-Mar \tab 3-15 mths \cr
#'   Fall Run \tab Jun-Dec \tab Sep-Oct \tab Sep-Dec \tab Oct-Nov \tab Dec-Mar \tab 1-7 mths \cr
#' }
#'
#' \emph{Generalised life history Yoshinyama et al. 1998}
#'
#' Use these values to compute spawning habitat for .... Use these values to compute rearing habitat
#' for ....
#'
#' @examples
#' upper_sac_ACID_boards_out
#'
#' @source FWS and NMFS Life Cycle Model, Hendrix 2017
"upper_sac_ACID_boards_out"

#' Upper-Mid Sacramento River Instream Flow to Habitat Area Relationship
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 45 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_juv_wua}{juvenile WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The rearing WUA was derived from a HEC-RAS 1D model. The study's extent is from Battle Creek to
#' the confluence with the Feather River (189.1 mi). The CVPIA Upper-mid Sacramento River extends
#' from Red Blurr to Wilkins Slough (122.45 mi).
#'
#' @examples
#' upper_mid_sacramento_river_instream
#'
#' @source NMFS Life Cycle Model, Hendrix 2017
"upper_mid_sacramento_river_instream"

#' Lower-Mid Sacramento River Instream Flow to Habitat Area Relationship
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 45 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_juv_wua}{juvenile WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The rearing WUA was derived from a HEC-RAS 1D model. The CVPIA Lower-mid Sacramento River extends
#' from Wilkins Slough to the American River (58.0 mi). This reach overlaps with two of the study's, Battle Creek to
#' the confluence with the Feather River (189.1 mi) and the confluence with the Feather River to Freeport (33.4 mi).
#' To scale the study's results to CVPIA's extents, we calculate the proportion of the Lower-mid Sacramento River
#' above (34\%) and below (66\%) the Feather River. Using these values we calculate a weighted average WUA from both of the studies.
#'
#' @examples
#' lower_mid_sacramento_river_instream
#'
#' @source NMFS Life Cycle Model, Hendrix 2017
'lower_mid_sacramento_river_instream'

#' Lower Sacramento River Instream Flow to Habitat Area Relationship
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 45 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_juv_wua}{juvenile WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The rearing WUA was derived from a HEC-RAS 1D model. The study's extent is from
#' the confluence with the Feather River to Freeport (33.4 mi). The CVPIA Lower Sacramento River extends
#' from the confluence with the American River to Freeport (13.7 mi).
#'
#' @examples
#' lower_sacramento_river_instream
#'
#' @source NMFS Life Cycle Model, Hendrix 2017
"lower_sacramento_river_instream"

#' American River Instream Flow to Habitat Area Relationship
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 30 rows and 4 variables:
#' \describe{
#' \item{flow_cfs}{integer flow value in cubic feet per second}
#' \item{FR_spawn_wua}{Fall Run spawning WUA in square feet per 1000 feet}
#' \item{ST_spawn_wua}{Steelhead spawning WUA in square feet per 1000 feet}
#' \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning WUA was derived from a River2D,
#' applied habitat suitability model.
#'
#' @examples
#' american_river_instream
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/FWS2003_AmericanRiverPHABSIM2DFinalReport.pdf}{FWS 2003}
"american_river_instream"

#' Yuba River Instream Flow to Habitat Area Relationship
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 34 rows and 10 variables
#' \describe{
#' \item{flow_cfs}{numeric flow value in cubic feet per second}
#' \item{FR_spawn_wua}{Fall Run spawning WUA in square feet per 1000 feet}
#' \item{FR_SR_fry}{Fall and Spring Run fry WUA in square feet per 1000 feet}
#' \item{FR_SR_juv}{Fall and Spring Run juvenile WUA in square feet per 1000 feet}
#' \item{SR_spawn_wua}{Spring Run spawning WUA in square feet per 1000 feet}
#' \item{ST_fry_wua}{Steelhead fry WUA in square feet per 1000 feet}
#' \item{ST_juv_wua}{Steelhead juvenile WUA in square feet per 1000 feet}
#' \item{ST_spawn_wua}{Steelhead spawning WUA in square feet per 1000 feet}
#' \item{watershed}{name of watershed}
#' }
#'
#' @examples
#' yuba_river_instream
#'
#' @source TODO fix source
"yuba_river_instream"

#' Tuolumne River Instream Flow to Habitat Area Relationship
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 30 rows and 4 variables:
#' \describe{
#' \item{flow_cfs}{integer flow value in cubic feet per second}
#' \item{FR_spawn_wua}{chinook spawning WUA in square feet per 1000 feet}
#' \item{FR_fry_wua}{chinook fry (up to 50 mm) WUA in square feet per 1000 feet}
#' \item{FR_juv_wua}{chinook juvenile WUA in square feet per 1000 feet}
#' \item{ST_spawn_WUA}{steelhead spawning WUA in square feet per 1000 feet}
#' \item{ST_fry_WUA}{steelhead fry (up to 50 mm) WUA in square feet per 1000 feet}
#' \item{ST_juv_WUA}{steelhead juvenile WUA in square feet per 1000 feet}
#' \item{adult_ST_WUA}{adult steelhead WUA in square feet per 1000 feet}
#' \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning and rearing WUAs were derived using a PHABSIM model by Stillwater 2010.
#'
#' @examples
#' tuolumne_river_instream
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/Stillwater2010_Tuolumne_P-2299-075_71_DP_FLA_AttC_StudyRept_IFIM_AppA-H_140428.pdf}{Flo2D model by Stillwater, 2014}
"tuolumne_river_instream"

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
#' @description A table lifestage, species, and watershed
#'
#' @format dataframe with 33 rows and 15 variables
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
#' \item{Region}{Regional grouping of watersheds used for estimating values for watersheds without modeling}
#' }
#'
#' @examples
#' modeling_exist
#'
#' @details This table was compiled from information provided by Mark Gard \email{mark_gard@@fws.gov}.
#' Used as look up table for \code{\link{set_spawning_habitat}},
#' \code{\link{set_instream_habitat}}, and \code{\link{set_floodplain_habitat}}
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

#' Yolo Bypass Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 2 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{Yolo Bypass 1}{floodplain acreage in the Yolo Bypass, Fremont Weir to Sacramento Weir}
#'   \item{Yolo Bypass 2}{floodplain acreage in the Yolo Bypass below Sacramento Weir}
#' }
#'
#' @details Habitat estimates from Correigh Greene's Winter Run Life Cycle Model
#'
#' High quality defined by:
#'
#' Channel depth > 0.2 m and < 1.5 m
#'
#' Velocity <= 0.15 m/s
#'
#' @examples
#' yolo_bypass_floodplain
#'
#' @source \href{https://www.google.com}{TODO}
'yolo_bypass_floodplain'

#' Sutter Bypass Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 41 rows and 5 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{Sutter Bypass 1}{floodplain acreage in the Sutter Bypass, to Moulton Weir}
#'   \item{Sutter Bypass 2}{floodplain acreage in the Sutter Bypass, to Colusa Weir}
#'   \item{Sutter Bypass 3}{floodplain acreage in the Sutter Bypass, to Tisdale Weir}
#'   \item{Sutter Bypass 4}{floodplain acreage in the Sutter Bypass below Tisdale Weir}
#' }
#'
#' @details Habitat estimates from Correigh Greene's Winter Run Life Cycle Model
#'
#' High quality defined by:
#'
#' Channel depth > 0.2 m and < 1.5 m
#'
#' Velocity <= 0.15 m/s
#'
#' @examples
#' sutter_bypass_floodplain
#'
#' @source \href{https://www.google.com}{TODO}
'sutter_bypass_floodplain'

#' Yolo Bypass Instream Flow to Habitat Area Relationship
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 41 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{Yolo Bypass 1}{juvenile rearing habitat WUA in the Yolo Bypass, Fremont Weir to Sacramento Weir}
#'   \item{Yolo Bypass 2}{juvenile rearing habitat WUA in the Yolo Bypass below Sacramento Weir}
#' }
#'
#' @details Habitat estimates from Correigh Greene's Winter Run Life Cycle Model
#'
#' High quality defined by:
#'
#' Channel depth > 0.2 m and < 1.5 m
#'
#' Velocity <= 0.15 m/s
#'
#' @examples
#' yolo_bypass_instream
#'
#' @source \href{https://www.google.com}{TODO}
'yolo_bypass_instream'

#' Sutter Bypass Instream Flow to Habitat Area Relationship
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 41 rows and 5 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{Sutter Bypass 1}{juvenile rearing habitat WUA in the Sutter Bypass, to Moulton Weir}
#'   \item{Sutter Bypass 2}{juvenile rearing habitat WUA in the Sutter Bypass, to Colusa Weir}
#'   \item{Sutter Bypass 3}{juvenile rearing habitat WUA in the Sutter Bypass, to Tisdale Weir}
#'   \item{Sutter Bypass 4}{juvenile rearing habitat WUA in the Sutter Bypass below Tisdale Weir}
#' }
#'
#' @details Habitat estimates from Correigh Greene's Winter Run Life Cycle Model
#'
#' High quality defined by:
#'
#' Channel depth > 0.2 m and < 1.5 m
#'
#' Velocity <= 0.15 m/s
#'
#' @examples
#' sutter_bypass_instream
#'
#' @source \href{https://www.google.com}{TODO}
'sutter_bypass_instream'

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
#' @details
#' Habitat estimates from Correigh Greene's Winter Run Life Cycle Model. The model
#' outputs habitat area estimates for months December-May. Habitat for months
#' June-Novemeber are represented by the yearly average habitat.
#'
#' High quality habitat defined by:
#'
#' Channel type: mainstem, distributaries, or open water
#'
#' Depth: > 0.2 m and <= 1.5 m
#'
#' Cover Vegetated edge
#'
#' @source
#' \itemize{
#'   \item Modeling Output: Correigh Green \email{correigh.greene@@noaa.gov}
#'   \item Delta Node Selection: Mark Tompkins \email{mtompkins@@flowwest.com}
#'   \item Data Wrangling: Sadie Gill \email{sgill@@flowwest.com}
#' }
'delta_habitat'
