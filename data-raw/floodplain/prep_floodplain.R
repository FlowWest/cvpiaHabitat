library(tidyverse)
library(readxl)
library(devtools)

# merced river----------------
merced_fp <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx', sheet = 'MercedRiver') %>%
  mutate(watershed = 'Merced River')

merced_river_floodplain <- scale_fp_flow_area_partial_model(ws = 'Merced River', df = merced_fp)

use_data(merced_river_floodplain, overwrite = TRUE)

# proxy watersheds for non-modeled watersheds----------------

# no modeling exists method for creating flow to fp area-------------


# NO MODELING, use proxy------------
filter(.metadata, stringr::str_detect(method, "scaled_")) %>% pull(watershed)

# Mokelumne River -------------------------------------
# see data-raw/instream/mokelumne/mokelumne_river.Rmd

# FULLY MODELED ----------
filter(.metadata, method == 'full_model') %>% pull(watershed)









