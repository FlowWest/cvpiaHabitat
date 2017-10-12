library(tidyverse)
library(devtools)
library(scales)

# clear creek instream cleaning-----------------------------------
# in units sqft want in units sqft/1000ft
clear_creek <- read_csv('data-raw/clear_creek_instream.csv')
glimpse(clear_creek)
View(clear_creek)

clear_creek_instream <- clear_creek %>%
  gather(species_stage, WUA, -flow_cfs, -Reach:-WUA_units) %>%
  filter(!is.na(WUA)) %>%
  group_by(species_stage, flow_cfs) %>%
  mutate(total_reach_length = sum(Reach_length)) %>%
  summarise(WUA = sum(WUA)/ max(total_reach_length) / 5.28) %>%
  ungroup() %>%
  spread(species_stage, WUA) %>%
  mutate(watershed = 'Clear Creek')

devtools::use_data(clear_creek_instream)

cottonwood <- read_csv('data-raw/cottonwood_creek_instream.csv', skip = 1)
cottonwood_creek_instream <- cottonwood %>%
  arrange(flow_cfs)

devtools::use_data(cottonwood_creek_instream)

stan <- read_csv('data-raw/stanislaus_river_instream.csv', skip = 1)

stanislaus_river_instream <- stan %>%
  gather(species_stage, WUA, -flow_cfs, -watershed) %>%
  filter(!is.na(WUA)) %>%
  spread(species_stage, WUA) %>%
  select(flow_cfs, spawn_WUA, FR_fry_WUA = fr_fry_WUA,
         FR_juv_WUA = fr_juv_WUA, ST_fry_WUA = st_fry_WUA,
         ST_juv_WUA = st_juv_WUA, watershed)

devtools::use_data(stanislaus_river_instream)

up_sac <- read_csv('data-raw/upper_sacramento_river_instream.csv', skip = 1)
View(up_sac)
glimpse(up_sac)

#6-2 upper sac spawning, 6-4 upper sac rearing
upper_sac_ACID_boards_out <- up_sac %>%
  gather(species_stage, WUA, -flow_cfs, -Segment:-length_unit) %>%
  filter(Segment != '6 ACID Boards In', !is.na(WUA)) %>%
  group_by(species_stage, flow_cfs) %>%
  mutate(total_length = sum(length)) %>%
  summarise(WUA = sum(WUA)/ max(total_length) / 5.28) %>%
  ungroup() %>%
  spread(species_stage, WUA) %>%
  mutate(watershed = 'Upper Sacramento River')

upper_sac_ACID_boards_in <- up_sac %>%
  gather(species_stage, WUA, -flow_cfs, -Segment:-length_unit) %>%
  filter(Segment != '6 ACID Boards Out', !is.na(WUA)) %>%
  group_by(species_stage, flow_cfs) %>%
  mutate(total_length = sum(length)) %>%
  summarise(WUA = sum(WUA)/ max(total_length) / 5.28) %>%
  ungroup() %>%
  spread(species_stage, WUA) %>%
  mutate(watershed = 'Upper Sacramento River')

use_data(upper_sac_ACID_boards_in, overwrite = T)
use_data(upper_sac_ACID_boards_out, overwrite = T)

# cvpia sac rearing segments ----
# upper sac Keswick-Red Bluff 59.2 mi
# upper-mid sac red-bluff to wilkins slough 122.45 mi
# lower-mid sac wilkins slough to American 58.0 mi
# lower sac American to freeport 13.7 mi

# river 2D segments ----
# Reach 6 – keswick to ACID;
# reach 5 ACID to Cow;
# reach 4 cow to battle
# reach 3 battle to red bluff
# reach 2 red bluff to deer
# NOTE: no rearing for reach 3 and 2

# hec-ras 1d sac segments ---
# battle to feather 189.1 mi
# feather to freeport 33.4 mi

sacramento_instream <- read_csv('data-raw/sacramento_river_instream.csv', skip = 1)

upper_mid_sacramento_instream <- sacramento_instream %>%
  mutate(juv_WUA = juv_WUA/miles/5.28, watershed = 'Upper-mid Sacramento River') %>%
  filter(reach == 'Battle Creek to Feather River') %>%
  select(flow_cfs, juv_WUA, watershed)

use_data(upper_mid_sacramento_instream)

lower_sacramento_instream <- sacramento_instream %>%
  mutate(juv_WUA = juv_WUA/miles/5.28, watershed = 'Lower Sacramento River') %>%
  filter(reach == 'Feather River to Freeport') %>%
  select(flow_cfs, juv_WUA, watershed)

use_data(lower_sacramento_instream)

#yuba


# delta TODO
delta <- read_csv('data-raw/north_delta_instream.csv', skip = 1)

north_delta_instream <- delta %>%
  select(flow_cfs, area_acres) %>%
  arrange(flow_cfs) %>%
  mutate(watershed = 'North Delta')

north_delta_instream %>%
  ggplot(aes(x = flow_cfs, y = area_acres)) +
  geom_point() +
  scale_x_continuous(label = comma) +
  theme_minimal() +
  geom_smooth(method = 'glm', formula = y~log(x))

n_delta_model <- glm(area_acres ~ flow_cfs, 'poisson', north_delta_instream)

tt <- lm(area_acres ~ log(flow_cfs), north_delta_instream)
summary(tt)
predict.lm(tt, data.frame(flow_cfs = 5000))

mm <- broom::augment(tt)
View(mm)

north_delta_instream %>%
  left_join(mm) %>% View()
  ggplot(aes(x = flow_cfs)) +
  geom_point(aes(y = area_acres), pch = 21) +
  geom_point(aes(y = .fitted), alpha = .2)
