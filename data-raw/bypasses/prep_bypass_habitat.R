library(tidyverse)
library(lubridate)
library(readxl)

sutter1 <- read_excel('data-raw/correigh_greene_data/River Rearing_Habitat vs flow.xls', sheet = 2) %>%
  select(flow_cfs = Flow_cfs,
         inchannel = Sutter_Bypass_1_Pref11_ChanArea_Sq_ft,
         floodplain = Sutter_Bypass_1_Pref11_BankArea_Sq_ft) %>%
  mutate(watershed = 'Sutter Bypass 1')

sutter2 <- read_excel('data-raw/correigh_greene_data/River Rearing_Habitat vs flow.xls', sheet = 3) %>%
  select(flow_cfs = Flow_cfs,
         inchannel = Sutter_Bypass_2_Pref11_ChanArea_Sq_ft,
         floodplain = Sutter_Bypass_2_Pref11_BankArea_Sq_ft) %>%
  mutate(watershed = 'Sutter Bypass 2')

sutter3 <- read_excel('data-raw/correigh_greene_data/River Rearing_Habitat vs flow.xls', sheet = 4) %>%
  select(flow_cfs = Flow_cfs,
         inchannel = Sutter_Bypass_3_Pref11_ChanArea_Sq_ft,
         floodplain = Sutter_Bypass_3_Pref11_BankArea_Sq_ft) %>%
  mutate(watershed = 'Sutter Bypass 3')

sutter4 <- read_excel('data-raw/correigh_greene_data/River Rearing_Habitat vs flow.xls', sheet = 5) %>%
  select(flow_cfs = Flow_cfs,
         inchannel = Sutter_Bypass_4_Pref11_ChanArea_Sq_ft,
         floodplain = Sutter_Bypass_4_Pref11_BankArea_Sq_ft) %>%
  mutate(watershed = 'Sutter Bypass 4')

yolo1 <- read_excel('data-raw/correigh_greene_data/River Rearing_Habitat vs flow.xls', sheet = 6) %>%
  select(flow_cfs = Flow_cfs,
         inchannel = Yolo_Bypass_1_Pref11_ChanArea_Sq_ft,
         floodplain = Yolo_Bypass_1_Pref11_BankArea_Sq_ft) %>%
  mutate(watershed = 'Yolo Bypass 1')

yolo2 <- read_excel('data-raw/correigh_greene_data/River Rearing_Habitat vs flow.xls', sheet = 7) %>%
  select(flow_cfs = Flow_cfs,
         inchannel = Yolo_Bypass_2_Pref11_ChanArea_Sq_ft,
         floodplain = Yolo_Bypass_2_Pref11_BankArea_Sq_ft) %>%
  mutate(watershed = 'Yolo Bypass 2')

# 1 sqft = 2.29568e-5 acres

yolo_bypass_1_floodplain <- yolo1 %>%
  select(-inchannel) %>%
  tail(2) %>%
  rename(WR_floodplain_acres = floodplain)

devtools::use_data(yolo_bypass_1_floodplain)

# no floodplain in yolo2
yolo2 %>%
  select(-inchannel) %>%
  tail(2)

