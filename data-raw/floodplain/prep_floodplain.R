library(tidyverse)
library(readxl)
library(devtools)


# butte creek----------------
butte_fp <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx', sheet = 'ButteCreek') %>%
  mutate(watershed = 'Butte Creek')

butte_creek_floodplain <- scale_fp_flow_area_partial_model(ws = 'Butte Creek', df = butte_fp)

use_data(butte_creek_floodplain, overwrite = TRUE)

# bear river----------------
bear_fp <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx', sheet = 'BearRiver') %>%
  mutate(watershed = 'Bear River')

bear_river_floodplain <- scale_fp_flow_area_partial_model(ws = 'Bear River', df = bear_fp) %>%
  mutate(ST_floodplain_acres = FR_floodplain_acres)

use_data(bear_river_floodplain, overwrite = TRUE)

# merced river----------------
merced_fp <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx', sheet = 'MercedRiver') %>%
  mutate(watershed = 'Merced River')

merced_river_floodplain <- scale_fp_flow_area_partial_model(ws = 'Merced River', df = merced_fp)

use_data(merced_river_floodplain, overwrite = TRUE)

# proxy watersheds for non-modeled watersheds----------------
# Deer Creek-------------------------------------
filter(.metadata, watershed == 'Deer Creek') %>% glimpse

deer_fp <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx', sheet = 'DeerCreek') %>%
  mutate(watershed = 'Deer Creek')

deer_creek_floodplain <- scale_fp_flow_area_partial_model(ws = 'Deer Creek', df = deer_fp)

use_data(deer_creek_floodplain, overwrite = TRUE)

# Cottonwood Creek -------------
filter(.metadata, watershed == 'Cottonwood Creek') %>% glimpse

cotton_fp <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx', sheet = 'CottonwoodCreek') %>%
  mutate(watershed = 'Cottonwood Creek')

cottonwood_creek_floodplain <- scale_fp_flow_area_partial_model(ws = 'Cottonwood Creek', df = cotton_fp)

use_data(cottonwood_creek_floodplain, overwrite = TRUE)

# no modeling exists method for creating flow to fp area-------------


# NO MODELING, use proxy------------
filter(.metadata, stringr::str_detect(method, "scaled_")) %>% pull(watershed)

# TODO Ask mark about the difference in outcome from his sheet
# Antelope Creek-------------------------------------
antelope_creek_floodplain <- scale_fp_flow_area('Antelope Creek')

use_data(antelope_creek_floodplain, overwrite = TRUE)

# Battle Creek-------------------------------------
battle_creek_floodplain <- scale_fp_flow_area('Battle Creek')

use_data(battle_creek_floodplain, overwrite = TRUE)

# Bear Creek-------------------------------------
bear_creek_floodplain <- scale_fp_flow_area('Bear Creek')

use_data(bear_creek_floodplain, overwrite = TRUE)

# Calaveras River -------------------------------------
calaveras_river_floodplain <- scale_fp_flow_area('Calaveras River')

use_data(calaveras_river_floodplain, overwrite = TRUE)

# Clear Creek-------------------------------------
clear_creek_floodplain <- scale_fp_flow_area('Clear Creek')

use_data(clear_creek_floodplain, overwrite = TRUE)

# Cosumnes River -------------------------------------
cosumnes_river_floodplain <- scale_fp_flow_area('Cosumnes River')

use_data(cosumnes_river_floodplain, overwrite = TRUE)

# Cow Creek-------------------------------------
cow_creek_floodplain <- scale_fp_flow_area('Cow Creek')

use_data(cow_creek_floodplain, overwrite = TRUE)

# Mill Creek-------------------------------------
mill_creek_floodplain <- scale_fp_flow_area('Mill Creek')

use_data(mill_creek_floodplain, overwrite = TRUE)

# Mokelumne River -------------------------------------
# see data-raw/instream/mokelumne/mokelumne_river.Rmd

# Paynes Creek-------------------------------------
paynes_creek_floodplain <- scale_fp_flow_area('Paynes Creek')

use_data(paynes_creek_floodplain, overwrite = TRUE)

# Stony Creek-------------------------------------
stony_creek_floodplain <- scale_fp_flow_area('Stony Creek')

use_data(stony_creek_floodplain, overwrite = TRUE)

# Thomes Creek-------------------------------------
thomes_creek_floodplain <- scale_fp_flow_area('Thomes Creek')

use_data(thomes_creek_floodplain, overwrite = TRUE)


# FULLY MODELED ----------
filter(.metadata, method == 'full_model') %>% pull(watershed)









