#' <<<<<<< HEAD
#' #' Upper Sacramento River Flow to Floodplain Habitat Area Relationship
#' #'
#' #' @description A dataset containing the floodplain habitat area in acres as a
#' #' function of flow in cubic feet per second
#' #'
#' #' @format dataframe with 75 rows
#' =======

  #' Merced River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#'   function of flow in cubic feet per second
#'
#' @format dataframe with 23 rows and 3 variables: \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage}
#'   \item{watershed}{name of watershed} }
#'
#' @details The habitat area was derived from the CVFPP 2012 HEC-RAS 1D model.
#'   The study only represents the lower half of Merced, scale up to
#'   represent the whole rearing region.
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/CVFPP2012_Att8_June.pdf}{CVFPP2012}
"merced_river_floodplain"

#' Yuba River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 28 rows and 5 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage}
#'   \item{SR_floodplain_acres}{spring run floodplain acreage}
#'   \item{ST_floodplain_acres}{steelhead floodplain acreage}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The habitat area was derived from the SRH2D model, Pasternack 2012.
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/Pasternack2012_LYR+Landforms+Report+(5-9-2012).pdf}{SRH2D}
"yuba_river_floodplain"

#' Yolo Bypass Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 62 rows and 5 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage}
#'   \item{SR_floodplain_acres}{spring run floodplain acreage}
#'   \item{ST_floodplain_acres}{steelhead floodplain acreage}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The habitat area was derived from the NMFS life cycle model, Hendirx 2017 HEC-RAS 1D model.
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/HendrixEtAl2014_Winter_Run_Model_Tech_Memo.pdf}{NMFS life cycle model}
"yolo_bypass_floodplain"

#' Tuolumne River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 37 rows and 5 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage}
#'   \item{SR_floodplain_acres}{spring run floodplain acreage}
#'   \item{ST_floodplain_acres}{steelhead floodplain acreage}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The habitat area was derived from the Flo2D model by Stillwater, 2014.
#'
#' @source
"tuolumne_river_floodplain"


#' Stanislaus River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 16 rows and 5 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage}
#'   \item{SR_floodplain_acres}{spring run floodplain acreage}
#'   \item{ST_floodplain_acres}{steelhead floodplain acreage}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The habitat area was derived from the SRH2D model from Newfields 2013.
#'
#' @source TODO fix source
"stanislaus_river_floodplain"


#' San Joaquin River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 32 rows and 5 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage}
#'   \item{SR_floodplain_acres}{spring run floodplain acreage}
#'   \item{ST_floodplain_acres}{steelhead floodplain acreage}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The habitat area was derived from the CVFPP 2012 HEC-RAS 1D model.
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/CVFPP2012_Att8_June.pdf}{CVFPP 2012}
"san_joaquin_river_floodplain"

#' North Delta Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 73 rows and 5 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage}
#'   \item{SR_floodplain_acres}{spring run floodplain acreage}
#'   \item{ST_floodplain_acres}{steelhead floodplain acreage}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The habitat area was derived from the NMFS life cycle model, Hendirx 2017 HEC-RAS 1D model.
#'
#' @source  \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/HendrixEtAl2014_Winter_Run_Model_Tech_Memo.pdf}{NMFS life cycle model}{Hendirx 2017 HEC-RAS 1D model}
"north_delta_floodplain"


#' Mokelumne River to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 31 rows and 5 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage}
#'   \item{SR_floodplain_acres}{spring run floodplain acreage}
#'   \item{ST_floodplain_acres}{steelhead floodplain acreage}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details NA
#'
#' @source NA
"mokelumne_river_floodplain"

#' Feather River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 40 rows and 5 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage}
#'   \item{SR_floodplain_acres}{spring run floodplain acreage}
#'   \item{ST_floodplain_acres}{steelhead floodplain acreage}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The habitat area was derived from the CVFPP 2012 HEC-RAS 1D model.
#'
#' @source  \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/CVFPP2012_Att8_June.pdf}{CVFPP 2012}
"feather_river_floodplain"

#' Elder Creek Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 31 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The habitat area was derived from the CVFPP 2012 HEC-RAS 1D model.
#'
#' @source  \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/CVFPP2012_Att8_June.pdf}{CVFPP 2012}
"elder_creek_floodplain"

#' Deer Creek Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 30 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The habitat area was derived from the Deer Creek Watershed Conservancy HEC-RAS 1D 2011 model.
#'
#' @source TODO
"deer_creek_floodplain"

#' Cottonwood Creek Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 32 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The habitat area was derived from the FWS 2017 HEC-RAS 1D model.
#'
#' @source  \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/FWS2014_CVPIA_Annual_Progress_Report_Fiscal_Year_2013.pdf}{FWS}
"cottonwood_creek_floodplain"

#' Cosumnes River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 36 rows and 4 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage}
#'   \item{ST_floodplain_acres}{steelhead floodplain acreage}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details NA
#'
#' @source NA
"cosumnes_river_floodplain"

#' Calaveras River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 37 rows and 4 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage}
#'   \item{ST_floodplain_acres}{steelhead floodplain acreage}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The habitat area was derived from the CVFPP 2012 HEC-RAS 1D model.
#'
#' @source  \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/CVFPP2012_Att8_June.pdf}{CVFPP 2012}
"calaveras_river_floodplain"


#' Big Chico Creek Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 32 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The habitat area was derived from the CVFPP 2012 HEC-RAS 1D model.
#'
#' @source  \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/CVFPP2012_Att8_June.pdf}{CVFPP 2012}
"big_chico_creek_floodplain"


#' Bear River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 37 rows and 4 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage}
#'   \item{ST_floodplain_acres}{steelhead floodplain acreage}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The habitat area was derived from the CVFPP 2012 HEC-RAS 1D model.
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/CVFPP2012_Att8_June.pdf}{CVFPP 2012}
"bear_river_floodplain"

#' American River Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 35 rows and 4 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage}
#'   \item{ST_floodplain_acres}{steelhead floodplain acreage}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The habitat area was derived from the CVFPP 2012 HEC-RAS 1D model.
#'
#' @source  \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/CVFPP2012_Att8_June.pdf}{CVFPP 2012}
"american_river_floodplain"

#' Butte Creek Flow to Floodplain Habitat Area Relationship
#'
#' @description A dataset containing the floodplain habitat area in acres as a
#' function of flow in cubic feet per second
#'
#' @format dataframe with 31 rows and 5 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{FR_floodplain_acres}{fall run floodplain acreage}
#'   \item{SR_floodplain_acres}{spring run floodplain acreage}
#'   \item{ST_floodplain_acres}{steelhead floodplain acreage}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The habitat area was derived from the CVFPP 2012 HEC-RAS 1D model.
#' The total area * suitability (25\%)
#'
#' @source \href{https://s3-us-west-2.amazonaws.com/cvpiahabitat-r-package/cvpia-sit-model-inputs/CVFPP2012_Att8_June.pdf}{CVFPP 2012}
"butte_creek_floodplain"

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
#' @details The spawning WUA values were derived from a FWS River2D model and the rearing WUA from a PHABSIM
#' model created for the 2008 FERC relicensing of DeSabla. The spawning values are from two river
#' segments, above Centerville Powerhouse (6.5 miles) and below (9 miles).
#' The spawning results are for Spring Run Chinook. The rearing results are for Fall Run Chinook.
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
#'   \item{spawn_WUA}{spawning WUA in square feet per 1000 feet}
#'   \item{fry_WUA}{fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{juv_WUA}{juvenile WUA in square feet per 1000 feet}
#'   \item{adult_trout_WUA}{adult trout WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning and rearing WUA values were derived from a PHABSIM model. The results are for Fall Run Chinook.
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
#'   \item{spawn_WUA}{spawning WUA in square feet per 1000 feet}
#'   \item{juv_WUA}{juvenile (>50 mm) WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning and rearing WUA values were derived from a PHABSIM model. A River2D model is in development.
#' The results are for Fall Run Chinook.
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
#'   \item{spawn_WUA}{spawning WUA in square feet per 1000 feet}
#'   \item{fry_WUA}{fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{juv_WUA}{juvenile WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning and rearing WUA values were derived from a PHABSIM model. The reults are for Steelhead.
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
#' @details The spawning and rearing WUA were derived from a FWS River2D model. The WUA values are from
#' three river segments, Upper Alluvial (2.27 miles), Canyon Segment (7.33 miles), and Lower Alluvial (8.81 miles).
#' Fall Run are only in the Lower Alluvial Segment and there is a segregation weir that prevents the
#' Spring Run from spawning in the Lower Alluvial Segment.
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
#'   \item{spawn_WUA}{spawning WUA in square feet per 1000 feet}
#'   \item{fry_WUA}{fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{juv_WUA}{juvenile WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning WUA values were derived from a PHABSIM model. The rearing values are from the FWS 2014
#' River2D model. The results are for Fall Run.
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
#'   \item{spawn_WUA}{spawning WUA in square feet per 1000 feet}
#'   \item{fry_WUA}{fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{juv_WUA}{juvenile WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning and rearing WUA values were derived from a PHABSIM model. The results are for Fall Run.
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
#'   \item{spawn_WUA}{spawning WUA in square feet per 1000 feet}
#'   \item{fry_WUA}{fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{juv_WUA}{juvenile WUA in square feet per 1000 feet}
#'   \item{adult_steelhead_WUA}{adult steelhead WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning WUA values were derived from the FWS 1996 PHABSIM model and the rearing from
#' the MID 2013 PHABSIM.
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
#'   \item{spawn_WUA}{spawning WUA in square feet per 1000 feet}
#'   \item{fry_WUA}{fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{juv_WUA}{juvenile WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning WUA values were derived from the EBMUD 2016 SRH2D model and the rearing from
#' the CDFW 1998 PHABSIM.
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
#'   \item{fry_WUA}{fall run fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{juv_WUA}{fall run juvenile WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The rearing WUA values are from a River2D model done on South Cow Creek. The values are from two river
#' segments, Valley Floor Reach (5.11 miles) and Boero Reach (1.68 miles).
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
#'   \item{spawn_WUA}{spawning WUA in square feet per 1000 feet}
#'   \item{FR_fry}{fall run fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{FR_juv}{fall run juvenile WUA in square feet per 1000 feet}
#'   \item{ST_fry}{steelhead fry (up to 50 mm) WUA in square feet per 1000 feet}
#'   \item{ST_juv}{steelhead juvenile WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning WUA was derived from the Aceituno 1993 (FWS) PHABSIM model and the rearing from
#' the FWS River2D model.
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
#'   \item{juv_WUA}{juvenile WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The rearing WUA was derived from a HEC-RAS 1D model. The study's extent is from Battle Creek to
#' the confluence with the Feather River (189.1 mi). The CVPIA Upper-mid Sacramento River extends
#' from Red Blurr to Wilkins Slough (122.45 mi).
#'
#' \strong{NOTE:} The CVPIA Lower-mid Sacramento River segment is from Wilkins Slough to the
#' American River (58.0 mi). To calculate the available habitat, use a proportional combination of
#' the WUA from the Upper-mid (38.3 mi, 2/3) and Lower (19.7 mi, 1/3) Sacramento instream values.
#'
#' @source NMFS Life Cycle Model, Hendrix 2017
"upper_mid_sacramento_instream"

#' Lower Sacramento River Instream Flow to Habitat Area Relationship
#'
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 45 rows and 3 variables:
#' \describe{
#'   \item{flow_cfs}{integer flow value in cubic feet per second}
#'   \item{juv_WUA}{juvenile WUA in square feet per 1000 feet}
#'   \item{watershed}{name of watershed}
#' }
#'
#' @details The rearing WUA was derived from a HEC-RAS 1D model. The study's extent is from
#' the confluence with the Feather River to Freeport (33.4 mi). The CVPIA Lower Sacramento River extends
#' from the confluence with the American River to Freeport (13.7 mi).
#'
#' \strong{NOTE:} The CVPIA Lower-mid Sacramento River segment is from Wilkins Slough to the
#' American River (58.0 mi). To calculate the available habitat, use a proportional combination of
#' the WUA from the Upper-mid (38.3 mi, 2/3) and Lower (19.7 mi, 1/3) Sacramento instream values.
#'
#' @source NMFS Life Cycle Model, Hendrix 2017
"lower_sacramento_instream"

#' American River Instream Flow to Habitat Area Relationship
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 30 rows and 4 variables:
#' \describe{
#' \item{flow_cfs}{integer flow value in cubic feet per second}
#' \item{FR_spawning}{Fall Run spawning WUA in square feet per 1000 feet}
#' \item{ST_spawning}{Steelhead spawning WUA in square feet per 1000 feet}
#' \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning WUA was derived from a River2D,
#' applied habitat suitability model.
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
#' \item{FR_spawning}{Fall Run spawning WUA in square feet per 1000 feet}
#' \item{FR_SR_fry}{Fall and Spring Run fry WUA in square feet per 1000 feet}
#' \item{FR_SR_juv}{Fall and Spring Run juvenile WUA in square feet per 1000 feet}
#' \item{SR_spawning}{Spring Run spawning WUA in square feet per 1000 feet}
#' \item{ST_fry}{Steelhead fry WUA in square feet per 1000 feet}
#' \item{ST_juv}{Steelhead juvenile WUA in square feet per 1000 feet}
#' \item{ST_spawning}{Steelhead spawning WUA in square feet per 1000 feet}
#' \item{watershed}{name of watershed}
#' }
#'
#' @source
"yuba_river_instream"

#' Tuolumne River Instream Flow to Habitat Area Relationship
#' @description A dataset containing the Weighted Usable Area (WUA) in square feet per 1000 feet
#' as a function of flow in cubic feet per second
#'
#' @format dataframe with 30 rows and 4 variables:
#' \describe{
#' \item{flow_cfs}{integer flow value in cubic feet per second}
#' \item{spawn_WUA}{chinook spawning WUA in square feet per 1000 feet}
#' \item{fry_WUA}{chinook fry (up to 50 mm) WUA in square feet per 1000 feet}
#' \item{juv_WUA}{chinook juvenile WUA in square feet per 1000 feet}
#' \item{ST_spawn_WUA}{steelhead spawning WUA in square feet per 1000 feet}
#' \item{ST_fry_WUA}{steelhead fry (up to 50 mm) WUA in square feet per 1000 feet}
#' \item{ST_juv_WUA}{steelhead juvenile WUA in square feet per 1000 feet}
#' \item{adult_ST_WUA}{adult steelhead WUA in square feet per 1000 feet}
#' \item{watershed}{name of watershed}
#' }
#'
#' @details The spawning and rearing WUAs were derived using a PHABSIM model by Stillwater 2010.
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
#' @details Information comes from mapping effort undertaken in the Summer and Fall of 2017. Fall Run completed, Spring Run and Steelhead mappings in progress.
#'
#' @source FlowWest, add url to shp file when mapping is complete
'watershed_lengths'
