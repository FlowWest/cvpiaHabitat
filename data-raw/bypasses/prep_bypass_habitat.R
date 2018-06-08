library(tidyverse)
library(lubridate)
library(readxl)

# read in data--------------------------------
# 1 sq ft = 0.092903 sq meters
sutter1 <- read_excel('data-raw/correigh_greene_data/River Rearing_Habitat vs flow.xls', sheet = 2) %>%
  mutate(flow_cfs = Flow_cfs,
         inchannel_sq_meters = Sutter_Bypass_1_Pref11_ChanArea_Sq_ft * 0.092903,
         floodplain_sq_meters = Sutter_Bypass_1_Pref11_BankArea_Sq_ft * 0.092903,
         watershed = 'Sutter Bypass 1') %>%
  select(flow_cfs:watershed)

sutter2 <- read_excel('data-raw/correigh_greene_data/River Rearing_Habitat vs flow.xls', sheet = 3) %>%
  mutate(flow_cfs = Flow_cfs,
         inchannel_sq_meters = Sutter_Bypass_2_Pref11_ChanArea_Sq_ft * 0.092903,
         floodplain_sq_meters = Sutter_Bypass_2_Pref11_BankArea_Sq_ft * 0.092903,
         watershed = 'Sutter Bypass 2') %>%
  select(flow_cfs:watershed)

sutter3 <- read_excel('data-raw/correigh_greene_data/River Rearing_Habitat vs flow.xls', sheet = 4) %>%
  mutate(flow_cfs = Flow_cfs,
         inchannel_sq_meters = Sutter_Bypass_3_Pref11_ChanArea_Sq_ft * 0.092903,
         floodplain_sq_meters = Sutter_Bypass_3_Pref11_BankArea_Sq_ft * 0.092903,
         watershed = 'Sutter Bypass 3') %>%
  select(flow_cfs:watershed)

sutter4 <- read_excel('data-raw/correigh_greene_data/River Rearing_Habitat vs flow.xls', sheet = 5) %>%
  mutate(flow_cfs = Flow_cfs,
         inchannel_sq_meters = Sutter_Bypass_4_Pref11_ChanArea_Sq_ft * 0.092903,
         floodplain_sq_meters = Sutter_Bypass_4_Pref11_BankArea_Sq_ft * 0.092903,
         watershed = 'Sutter Bypass 4') %>%
  select(flow_cfs:watershed)

yolo1 <- read_excel('data-raw/correigh_greene_data/River Rearing_Habitat vs flow.xls', sheet = 6) %>%
  mutate(flow_cfs = Flow_cfs,
         inchannel_sq_meters = Yolo_Bypass_1_Pref11_ChanArea_Sq_ft * 0.092903,
         floodplain_sq_meters = Yolo_Bypass_1_Pref11_BankArea_Sq_ft * 0.092903,
         watershed = 'Yolo Bypass 1') %>%
  select(flow_cfs:watershed)

yolo2 <- read_excel('data-raw/correigh_greene_data/River Rearing_Habitat vs flow.xls', sheet = 7) %>%
  mutate(flow_cfs = Flow_cfs,
         inchannel_sq_meters = Yolo_Bypass_2_Pref11_ChanArea_Sq_ft * 0.092903,
         floodplain_sq_meters = Yolo_Bypass_2_Pref11_BankArea_Sq_ft * 0.092903,
         watershed = 'Yolo Bypass 2') %>%
  select(flow_cfs:watershed)


# floodplain--------------------------

yolo_bypass_floodplain <- bind_rows(yolo1, yolo2) %>%
  select(-inchannel_sq_meters) %>%
  spread(watershed, floodplain_sq_meters) %>%
  tail(2)
# no floodplain in yolo2

devtools::use_data(yolo_bypass_floodplain, overwrite = TRUE)


sutter_bypass_floodplain <- bind_rows(sutter1, sutter2, sutter3, sutter4) %>%
  select(-inchannel_sq_meters) %>%
  spread(watershed, floodplain_sq_meters)

devtools::use_data(sutter_bypass_floodplain, overwrite = TRUE)

# inchannel-----------------------------------
yolo_bypass_instream <- bind_rows(yolo1, yolo2) %>%
  select(-floodplain_sq_meters) %>%
  spread(watershed, inchannel_sq_meters)

devtools::use_data(yolo_bypass_instream, overwrite = TRUE)

sutter_bypass_instream <- bind_rows(sutter1, sutter2, sutter3, sutter4) %>%
  select(-floodplain_sq_meters) %>%
  spread(watershed, inchannel_sq_meters)

devtools::use_data(sutter_bypass_instream, overwrite = TRUE)
