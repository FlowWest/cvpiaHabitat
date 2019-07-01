library(tidyverse)
library(readxl)
library(devtools)

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

# no modeling exists method for creating flow to fp area-------------


# NO MODELING, use proxy------------
filter(.metadata, stringr::str_detect(method, "scaled_")) %>% pull(watershed)

# Calaveras River -------------------------------------
calaveras_river_floodplain <- scale_fp_flow_area('Calaveras River')

use_data(calaveras_river_floodplain, overwrite = TRUE)

# Cosumnes River -------------------------------------
cosumnes_river_floodplain <- scale_fp_flow_area('Cosumnes River')

use_data(cosumnes_river_floodplain, overwrite = TRUE)

# Mokelumne River -------------------------------------
# see data-raw/instream/mokelumne/mokelumne_river.Rmd

# Thomes Creek-------------------------------------
thomes_creek_floodplain <- scale_fp_flow_area('Thomes Creek')

use_data(thomes_creek_floodplain, overwrite = TRUE)


# FULLY MODELED ----------
filter(.metadata, method == 'full_model') %>% pull(watershed)









