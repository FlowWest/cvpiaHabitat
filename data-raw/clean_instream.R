library(tidyverse)

# clear creek instream cleaning-----------------------------------
# in units sqft want in units sqft/1000ft
clear_creek <- read_csv('data-raw/clear_creek_instream.csv')
glimpse(clear_creek)
View(clear_creek)

clear_creek_instream <- clear_creek %>%
  gather(species_stage, WUA, -flow_cfs, -Reach:-WUA_units) %>%
  filter(!is.na(WUA)) %>%
  mutate(WUA_ft2_per_1000ft = WUA/Reach_length/5.28) %>%
  group_by(species_stage, flow_cfs) %>%
  summarise(WUA = sum(WUA_ft2_per_1000ft)) %>%
  ungroup() %>%
  spread(species_stage, WUA) %>%
  mutate(watershed = 'Clear Creek')

devtools::use_data(clear_creek_instream)
