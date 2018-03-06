#' Set Bypass Instream Habitat Area
#' @description This function returns an estimated instream habitat area based on bypass and flow.
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

  yb <- as.data.frame(cvpiaHabitat::yolo_bypass_instream)
  sb <- as.data.frame(cvpiaHabitat::sutter_bypass_instream)
  i <- which(c('yolo1', 'yolo2', 'sutter1', 'sutter2', 'sutter3', 'sutter4') == bypass)


  if (bypass == 'yolo1' | bypass == 'yolo2') {
    yolowua <- approxfun(yb$flow_cfs, yb[, i + 1],
                         yleft = 0, yright = max(yb[, i + 1], na.rm = TRUE))

    return(yolowua(flow) * 0.092903)

  } else if (bypass == 'sutter1') {
    sutter1wua <- approxfun(sb$flow_cfs, sb$`Sutter Bypass 1`,
                            yleft = 0, yright = max(sb$`Sutter Bypass 1`, na.rm = TRUE))

    return(sutter1wua(flow) * 0.092903)

  } else {
    #remove small areas after first zero at high flows
    for (bypass in 3:5) {
      zeros <- which(sb[, bypass] == 0)
      sb[zeros[1]:41, bypass] <- 0
    }
    sutterwua <- approxfun(sb$flow_cfs, sb[, i - 1], yleft = 0, yright = 0)
    return(sutterwua(flow) * 0.092903)
  }
}



