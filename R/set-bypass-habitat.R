#' Set Bypass Instream Habitat Area
#' @description This function returns an estimated suitable instream habitat area based on bypass and flow.
#'
#' @param bypass one section of the bypasses ('yolo1', 'yolo2', 'sutter1', 'sutter2', 'sutter3', or 'sutter4')
#' @param flow value used to determine habitat area
#' @return habitat area in square meters
#'
#' @examples
#' # habitat area in square meters for section 1 of the yolo bypass at 200 cfs
#' set_bypass_instream_habitat('yolo1', 200)
#' @export
set_bypass_instream_habitat <- function(bypass, flow) {

  col_name <- switch(bypass,
                     'yolo1' = 'Yolo Bypass 1',
                     'yolo2' = 'Yolo Bypass 2',
                     'sutter1' = 'Sutter Bypass 1',
                     'sutter2' = 'Sutter Bypass 2',
                     'sutter3' = 'Sutter Bypass 3',
                     'sutter4' = 'Sutter Bypass 4')

  if (grepl('yolo', bypass)) {
    df <- as.data.frame(cvpiaHabitat::yolo_bypass_instream[, c('flow_cfs', col_name)])
  } else {
    df <- as.data.frame(cvpiaHabitat::sutter_bypass_instream[, c('flow_cfs', col_name)])
  }
  instream_approx <- approxfun(df[, 1], df[, 2], yleft = 0, yright = max(df[, 2], na.rm = TRUE))
  return(instream_approx(flow))

}

#' Set Bypass Floodplain Habitat Area
#' @description This function returns an estimated total of suitable floodplain habitat area based on bypass and flow.
#'
#' @param bypass one section of the bypasses ('yolo1', 'yolo2', 'sutter1', 'sutter2', 'sutter3', or 'sutter4')
#' @param flow value used to determine habitat area
#' @return habitat area in square meters
#'
#' @examples
#' # habitat area in square meters for section 1 of the yolo bypass at 200 cfs
#' set_bypass_floodplain_habitat('yolo1', 200000)
#' @export
set_bypass_floodplain_habitat <- function(bypass, flow) {

  col_name <- switch(bypass,
                     'yolo1' = 'Yolo Bypass 1',
                     'yolo2' = 'Yolo Bypass 2',
                     'sutter1' = 'Sutter Bypass 1',
                     'sutter2' = 'Sutter Bypass 2',
                     'sutter3' = 'Sutter Bypass 3',
                     'sutter4' = 'Sutter Bypass 4')

  if (grepl('yolo', bypass)) {
    df <- as.data.frame(cvpiaHabitat::yolo_bypass_floodplain[, c('flow_cfs', col_name)])
  } else {
    df <- as.data.frame(cvpiaHabitat::sutter_bypass_floodplain[, c('flow_cfs', col_name)])
  }
  floodplain_approx <- approxfun(df[, 1], df[, 2], yleft = 0, yright = max(df[, 2], na.rm = TRUE))
  return(floodplain_approx(flow))

}


