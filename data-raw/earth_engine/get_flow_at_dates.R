library(tidyverse)
library(lubridate)
library(dataRetrieval)
library(stringr)
library(CDECRetrieve)

img_dates <- read_csv('data-raw/earth_engine/channel_width_imagery_dates.csv')
gage_ids <- read_csv('data-raw/earth_engine/watershed_gage_ids.csv')
glimpse(img_dates)

# cdec gages
gage_ids %>%
  mutate(usgs = str_detect(`Flow Gage ID`, '[0-9]')) %>%
  filter(!usgs)

View(img_dates)

get_dates <- function(watershed) {
  img_dates %>%
    filter(River == watershed) %>%
    pull(Dates) %>%
    str_replace('\\[', '') %>%
    str_replace('\\]', '') %>%
    strsplit(', ') %>%
    flatten_chr() %>%
    ymd_hms() %>%
    as_date() %>%
    sort()
}

get_flow <- function(watershed) {
  dates <- get_dates(watershed)
  id <- pull(filter(gage_ids, Watershed == watershed), `Flow Gage ID`)

  flow <- dataRetrieval::readNWISdv(siteNumbers = id, parameterCd = '00060',
                                    startDate = dates[1], endDate = dates[length(dates)])

  if (nrow(flow) == 0) stop('no data')

  flows <- flow %>%
    filter(Date %in% dates) %>%
    mutate(watershed = watershed) %>%
    select(watershed, date = Date, gage_id = site_no, flows_cfs = X_00060_00003)

  return(flows)
}

get_flow_cdec <- function(watershed) {
  dates <- get_dates(watershed)

  id <- pull(filter(gage_ids, Watershed == watershed), `Flow Gage ID`)

  flow <- CDECRetrieve::cdec_query(stations = id, sensor_num = '20', dur_code = 'H',
                                          start_date = as.character(dates[1]),
                                          end_date = as.character(dates[length(dates)]))

  flows <- flow %>%
    group_by(date = as_date(datetime), gage_id = location_id) %>%
    summarise(flows_cfs = mean(parameter_value, na.rm = TRUE)) %>%
    filter(date %in% dates) %>%
    mutate(watershed = watershed) %>%
    select(watershed, date, gage_id, flows_cfs ) %>%
    ungroup()

  return(flows)
}

# battle creek -----
bc <- get_flow('Battle Creek')

# bear creek NO DATA-----
bec <- get_flow('Bear Creek')

# butte creek -----
buc <- get_flow_cdec('Butte Creek')

# clear creek -------
clc <- get_flow('Clear Creek')

# cottonwood creek -------
coc <- get_flow('Cottonwood Creek')

# cow creek -------
cowc <- get_flow('Cow Creek')

# deer creek -------
dc <- get_flow('Deer Creek')

# elder creek -------
ec <- get_flow('Elder Creek')

# mill creek -------
mc <- get_flow('Mill Creek')

# paynes creek -------
pc <- get_flow('Paynes Creek')

# thomes creek -------
tc <- get_flow('Thomes Creek')

# bear river -------
br <- get_flow('Bear River')

# Yuba river -------
yr <- get_flow_cdec('Yuba River')

# all creeks----------
bc %>%
  bind_rows(buc) %>%
  bind_rows(clc) %>%
  bind_rows(coc) %>%
  bind_rows(cowc) %>%
  bind_rows(dc) %>%
  bind_rows(ec) %>%
  bind_rows(mc) %>%
  bind_rows(br)
