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

