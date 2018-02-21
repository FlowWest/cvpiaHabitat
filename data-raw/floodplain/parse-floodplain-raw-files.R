# This script reads in floodplain area raw files in data-raw/floodplain dir for use in package
# there are special cases not parsed here that are done so in clean_floodplain.R

# UPDATE: new version of flow to floodplain curves were added on 2018-02-19 -emanuel
# updates to the documentation also added

library(readr)
library(dplyr)
library(magrittr)

# american river
american_river <- read_csv("data-raw/floodplain/american_river_floodplain.csv")
american_river_floodplain <- american_river
devtools::use_data(american_river_floodplain, overwrite = TRUE)

# bear river
bear_river <- read_csv("data-raw/floodplain/bear_river_floodplain.csv")
bear_river_floodplain <- bear_river
devtools::use_data(bear_river_floodplain, overwrite = TRUE)

# big chico
big_chico <- read_csv("data-raw/floodplain/big_chico_creek_floodplain.csv")
big_chico_creek_floodplain <- big_chico
devtools::use_data(big_chico_creek_floodplain, overwrite = TRUE)

# butte creek
butte_creek <- read_csv("data-raw/floodplain/butte_creek_floodplain.csv")
butte_creek_floodplain <- butte_creek
devtools::use_data(butte_creek_floodplain, overwrite = TRUE)

# calaveras
calaveras_river <- read_csv("data-raw/floodplain/calaveras_river_floodplain.csv")
calaveras_river_floodplain <- calaveras_river
devtools::use_data(calaveras_river_floodplain, overwrite = TRUE)

# consumnes river
cosumnes_river <- read_csv("data-raw/floodplain/cosumnes_river_floodplain.csv")

cosumnes_river_floodplain <- cosumnes_river %>%
  filter(species == "Fall Run") %>%
  select(flow_cfs,
         FR_floodplain_acres = floodplain_acres,
         watershed)

devtools::use_data(cosumnes_river_floodplain, overwrite = TRUE)

# cottonwood creek
cottonwood_creek <- read_csv("data-raw/floodplain/cottonwood_creek_floodplain.csv")
cottonwood_creek_floodplain <- cottonwood_creek
devtools::use_data(cottonwood_creek_floodplain, overwrite = TRUE)

# deer creek
deer_creek <- read_csv("data-raw/floodplain/deer_creek_floodplain.csv")
deer_creek_floodplain <- deer_creek
devtools::use_data(deer_creek_floodplain, overwrite = TRUE)

# elder creek
elder_creek <- read_csv("data-raw/floodplain/elder_creek_floodplain.csv")
elder_creek_floodplain <- elder_creek
devtools::use_data(elder_creek_floodplain, overwrite = TRUE)

# feather river
feather_river <- read_csv("data-raw/floodplain/feather_river_floodplain.csv")
feather_river_floodplain <- feather_river
devtools::use_data(feather_river_floodplain, overwrite = TRUE)

# merced river
merced_river <- read_csv("data-raw/floodplain/merced_river_floodplain.csv")
merced_river_floodplain <- merced_river
devtools::use_data(merced_river_floodplain, overwrite = TRUE)

# moke
mokelumne_river <- read_csv("data-raw/floodplain/mokelumne_river_floodplain.csv")
mokelumne_river_floodplain <- mokelumne_river
devtools::use_data(mokelumne_river_floodplain, overwrite = TRUE)

# north delta
north_delta <- read_csv("data-raw/floodplain/north_delta_floodplain.csv")

north_delta_floodplain <- north_delta %>%
  filter(species == "Fall Run") %>%
  select(flow_cfs,
         FR_floodplain_acres = floodplain_acres,
         watershed)

devtools::use_data(north_delta_floodplain, overwrite = TRUE)

# sac river is a special case see clean_floodplain.R

# san joaquin
san_joaquin <- read_csv("data-raw/floodplain/san_joaquin_river_floodplain.csv")
san_joaquin_river_floodplain <- san_joaquin
devtools::use_data(san_joaquin_river_floodplain, overwrite = TRUE)

# stan
stanislaus <- read_csv("data-raw/floodplain/stanislaus_river_floodplain.csv")
stanislaus_river_floodplain <- stanislaus
devtools::use_data(stanislaus_river_floodplain, overwrite = TRUE)

# sutter
sutter <- read_csv("data-raw/floodplain/sutter_bypass_floodplain.csv")

sutter_bypass_floodplain <- sutter %>%
  filter(species == "Fall Run") %>%
  select(flow_cfs,
         FR_floodplain_acres = floodplain_acres,
         watershed)

devtools::use_data(sutter_bypass_floodplain, overwrite = TRUE)

# tuo
tuo <- read_csv("data-raw/floodplain/tuolumne_river_floodplain.csv")
tuolumne_river_floodplain <- tuo
devtools::use_data(tuolumne_river_floodplain, overwrite = TRUE)

# antelope \0/
antelope <- read_csv("data-raw/floodplain/antelope_creek_floodplain.csv")
antelope_creek_floodplain <- antelope
devtools::use_data(antelope_creek_floodplain, overwrite = TRUE)

# battle
battle <- read_csv("data-raw/floodplain/battle_creek_floodplain.csv")
battle_creek_floodplain <- battle
devtools::use_data(battle_creek_floodplain, overwrite = TRUE)

# bear creek
bear <- read_csv("data-raw/floodplain/bear_creek_floodplain.csv")
bear_creek_floodplain <- bear
devtools::use_data(bear_creek_floodplain, overwrite = TRUE)

# cow creek
cow <- read_csv("data-raw/floodplain/cow_creek_floodplain.csv")
cow_creek_floodplain <- cow
devtools::use_data(cow_creek_floodplain, overwrite = TRUE)

# mill creek
mill <- read_csv("data-raw/floodplain/mill_creek_floodplain.csv")
mill_creek_floodplain <- mill
devtools::use_data(mill_creek_floodplain, overwrite = TRUE)

# paynes
paynes <- read_csv("data-raw/floodplain/paynes_creek_floodplain.csv")
paynes_creek_floodplain <- paynes
devtools::use_data(paynes_creek_floodplain, overwrite = TRUE)

# stony creek
stony <- read_csv("data-raw/floodplain/stony_creek_floodplain.csv")
stony_creek_floodplain <- stony
devtools::use_data(stony_creek_floodplain, overwrite = TRUE)

#thomes creek
thomes <- read_csv("data-raw/floodplain/thomes_creek_floodplain.csv")
thomes_creek_floodplain <- thomes
devtools::use_data(thomes_creek_floodplain, overwrite = TRUE)

# yolo
yolo <- read_csv("data-raw/floodplain/yolo_bypass_floodplain.csv")

yolo_bypass_floodplain <- yolo %>%
  filter(species == "Fall Run") %>%
  select(flow_cfs,
         FR_floodplain_acres = floodplain_acres,
         watershed)

devtools::use_data(yolo_bypass_floodplain, overwrite = TRUE)

# yuba special case see clean_floodplain.R

yuba_river <- read_csv("data-raw/floodplain/yuba_river_floodplain.csv")
yuba_river_floodplain <- yuba_river
devtools::use_data(yuba_river_floodplain, overwrite = TRUE)


# clear creek
clear_creek <- read_csv("data-raw/floodplain/clear_creek_floodplain.csv")
clear_creek_floodplain <- clear_creek
devtools::use_data(clear_creek_floodplain, overwrite = TRUE)
























