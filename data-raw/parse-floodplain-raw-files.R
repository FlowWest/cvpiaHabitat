# This script reads in floodplain area raw files in data-raw dir for use in package

library(readr)
library(dplyr)
library(magrittr)

# american river
american_river <- read_csv("data-raw/american_river_floodplain.csv")

american_river_floodplain <- american_river %>%
  select(flow_cfs,
         FR_floodplain_acres = floodplain_acres,
         watershed)

devtools::use_data(american_river_floodplain, overwrite = TRUE)

# bear river
bear_river <- read_csv("data-raw/bear_river_floodplain.csv")

bear_river_floodplain <- bear_river %>%
  select(flow_cfs,
         FR_floodplain_acres = floodplain_acres,
         watershed)

devtools::use_data(bear_river_floodplain, overwrite = TRUE)

# big chico
big_chico <- read_csv("data-raw/big_chico_creek_floodplain.csv")

big_chico_creek_floodplain <- big_chico %>%
  select(flow_cfs,
         FR_floodplain_acres = floodplain_acres,
         watershed)

devtools::use_data(big_chico_creek_floodplain, overwrite = TRUE)

# butte creek
butte_creek <- read_csv("data-raw/butte_creek_floodplain.csv")

butte_creek_floodplain <- butte_creek %>%
  select(flow_cfs,
         FR_floodplain_acres = floodplain_acres,
         watershed)

devtools::use_data(butte_creek_floodplain, overwrite = TRUE)

# calaveras
calaveras_river <- read_csv("data-raw/calaveras_river_floodplain.csv")

calaveras_river_floodplain <- calaveras_river %>%
  select(flow_cfs,
         FR_floodplain_acres = floodplain_acres,
         watershed)

devtools::use_data(calaveras_river_floodplain, overwrite = TRUE)

# consumnes river
cosumnes_river <- read_csv("data-raw/cosumnes_river_floodplain.csv")

cosumnes_river_floodplain <- cosumnes_river %>%
  select(flow_cfs,
         FR_floodplain_acres = floodplain_acres,
         watershed)

devtools::use_data(cosumnes_river_floodplain, overwrite = TRUE)

# cottonwood creek
cottonwood_creek <- read_csv("data-raw/cottonwood_creek_floodplain.csv")

cottonwood_creek_floodplain <- cottonwood_creek %>%
  select(flow_cfs,
         FR_floodplain_acres = floodplain_acres,
         watershed)

devtools::use_data(cottonwood_creek_floodplain, overwrite = TRUE)

# deer creek
deer_creek <- read_csv("data-raw/deer_creek_floodplain.csv")

deer_creek_floodplain <- deer_creek %>%
  select(flow_cfs,
         FR_floodplain_acres = floodplain_acres,
         watershed)

devtools::use_data(deer_creek_floodplain, overwrite = TRUE)

# elder creek
elder_creek <- read_csv("data-raw/elder_creek_floodplain.csv")

elder_creek_floodplain <- elder_creek %>%
  select(flow_cfs,
         FR_floodplain_acres = floodplain_acres,
         watershed)

devtools::use_data(elder_creek_floodplain, overwrite = TRUE)

# feather river
feather_river <- read_csv("data-raw/feather_river_floodplain.csv")

feather_river_floodplain <- feather_river %>%
  select(flow_cfs,
         FR_floodplain_acres = floodplain_acres,
         watershed)

devtools::use_data(feather_river_floodplain, overwrite = TRUE)

# merced river
merced_river <- read_csv("data-raw/merced_river_floodplain.csv")

merced_river_floodplain <- merced_river %>%
  select(flow_cfs,
         FR_floodplain_acres = floodplain_acres,
         watershed)

devtools::use_data(merced_river_floodplain, overwrite = TRUE)

# moke
mokelumne_river <- read_csv("data-raw/mokelumne_river_floodplain.csv")

mokelumne_river_floodplain <- mokelumne_river %>%
  select(flow_cfs,
         FR_floodplain_acres = floodplain_acres,
         watershed)

devtools::use_data(mokelumne_river_floodplain, overwrite = TRUE)

# north delta
north_delta <- read_csv("data-raw/north_delta_floodplain.csv")

north_delta_floodplain <- north_delta %>%
  select(flow_cfs,
         FR_floodplain_acres = floodplain_acres,
         watershed)

devtools::use_data(north_delta_floodplain, overwrite = TRUE)

# sac river is a special case see clean_floodplain.R

# san joaquin
san_joaquin <- read_csv("data-raw/san_joaquin_river_floodplain.csv")

san_joaquin_river_floodplain <- san_joaquin %>%
  select(flow_cfs,
         FR_floodplain_acres = floodplain_acres,
         watershed)

devtools::use_data(san_joaquin_river_floodplain, overwrite = TRUE)

# stan
stanislaus <- read_csv("data-raw/stanislaus_river_floodplain.csv")

stanislaus_river_floodplain <- stanislaus %>%
  select(flow_cfs,
         FR_floodplain_acres = floodplain_acres,
         watershed)

devtools::use_data(stanislaus_river_floodplain, overwrite = TRUE)

# sutter
sutter <- read_csv("data-raw/sutter_bypass_floodplain.csv")

sutter_bypass_floodplain <- sutter %>%
  select(flow_cfs,
         FR_floodplain_acres = floodplain_acres,
         watershed)

devtools::use_data(sutter_bypass_floodplain, overwrite = TRUE)

# tuo
tuo <- read_csv("data-raw/tuolumne_river_floodplain.csv")

tuolumne_river_floodplain <- tuo %>%
  select(flow_cfs,
         FR_floodplain_acres = floodplain_acres,
         watershed)

devtools::use_data(tuolumne_river_floodplain, overwrite = TRUE)

# yolo
yolo <- read_csv("data-raw/yolo_bypass_floodplain.csv")

yolo_bypass_floodplain <- yolo %>%
  select(flow_cfs,
         FR_floodplain_acres = floodplain_acres,
         watershed)

devtools::use_data(yolo_bypass_floodplain, overwrite = TRUE)

# yuba special case see clean_floodplain.R





