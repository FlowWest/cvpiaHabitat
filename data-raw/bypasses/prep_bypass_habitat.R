library(tidyverse)
library(lubridate)
library(readxl)

# read in data--------------------------------
sutter1 <- read_excel('data-raw/correigh_greene_data/River Rearing_Habitat vs flow.xls', sheet = 2) %>%
  select(flow_cfs = Flow_cfs,
         inchannel_sqft = Sutter_Bypass_1_Pref11_ChanArea_Sq_ft,
         floodplain_sqft = Sutter_Bypass_1_Pref11_BankArea_Sq_ft) %>%
  mutate(watershed = 'Sutter Bypass 1')

sutter2 <- read_excel('data-raw/correigh_greene_data/River Rearing_Habitat vs flow.xls', sheet = 3) %>%
  select(flow_cfs = Flow_cfs,
         inchannel_sqft = Sutter_Bypass_2_Pref11_ChanArea_Sq_ft,
         floodplain_sqft = Sutter_Bypass_2_Pref11_BankArea_Sq_ft) %>%
  mutate(watershed = 'Sutter Bypass 2')

sutter3 <- read_excel('data-raw/correigh_greene_data/River Rearing_Habitat vs flow.xls', sheet = 4) %>%
  select(flow_cfs = Flow_cfs,
         inchannel_sqft = Sutter_Bypass_3_Pref11_ChanArea_Sq_ft,
         floodplain_sqft = Sutter_Bypass_3_Pref11_BankArea_Sq_ft) %>%
  mutate(watershed = 'Sutter Bypass 3')

sutter4 <- read_excel('data-raw/correigh_greene_data/River Rearing_Habitat vs flow.xls', sheet = 5) %>%
  select(flow_cfs = Flow_cfs,
         inchannel_sqft = Sutter_Bypass_4_Pref11_ChanArea_Sq_ft,
         floodplain_sqft = Sutter_Bypass_4_Pref11_BankArea_Sq_ft) %>%
  mutate(watershed = 'Sutter Bypass 4')

yolo1 <- read_excel('data-raw/correigh_greene_data/River Rearing_Habitat vs flow.xls', sheet = 6) %>%
  select(flow_cfs = Flow_cfs,
         inchannel_sqft = Yolo_Bypass_1_Pref11_ChanArea_Sq_ft,
         floodplain_sqft = Yolo_Bypass_1_Pref11_BankArea_Sq_ft) %>%
  mutate(watershed = 'Yolo Bypass 1')

yolo2 <- read_excel('data-raw/correigh_greene_data/River Rearing_Habitat vs flow.xls', sheet = 7) %>%
  select(flow_cfs = Flow_cfs,
         inchannel_sqft = Yolo_Bypass_2_Pref11_ChanArea_Sq_ft,
         floodplain_sqft = Yolo_Bypass_2_Pref11_BankArea_Sq_ft) %>%
  mutate(watershed = 'Yolo Bypass 2')


# floodplain--------------------------
# 1 sqft = 2.29568e-5 acres

yolo_bypass_floodplain <- bind_rows(yolo1, yolo2) %>%
  select(-inchannel_sqft) %>%
  mutate(floodplain_acres = floodplain_sqft * 2.29568e-5) %>%
  select(flow_cfs, floodplain_acres, watershed) %>%
  spread(watershed, floodplain_acres) %>%
  tail(2)
# no floodplain in yolo2

devtools::use_data(yolo_bypass_floodplain, overwrite = TRUE)


sutter_bypass_floodplain <- bind_rows(sutter1, sutter2, sutter3, sutter4) %>%
  select(-inchannel_sqft) %>%
  mutate(floodplain_acres = floodplain_sqft * 2.29568e-5) %>%
  select(flow_cfs, floodplain_acres, watershed) %>%
  spread(watershed, floodplain_acres)

devtools::use_data(sutter_bypass_floodplain, overwrite = TRUE)

# inchannel-----------------------------------
yolo_bypass_instream <- bind_rows(yolo1, yolo2) %>%
  select(-floodplain_sqft) %>%
  rename(juv_wua = inchannel_sqft) %>%
  spread(watershed, juv_wua)

devtools::use_data(yolo_bypass_instream, overwrite = TRUE)

sutter_bypass_instream <- bind_rows(sutter1, sutter2, sutter3, sutter4) %>%
  select(-floodplain_sqft) %>%
  rename(juv_wua = inchannel_sqft) %>%
  spread(watershed, juv_wua)

devtools::use_data(sutter_bypass_instream, overwrite = TRUE)
