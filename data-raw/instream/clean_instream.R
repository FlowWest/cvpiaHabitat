library(tidyverse)
library(devtools)
library(scales)
library(readxl)

# American River see 'data-raw/instream/american'
# Stanislaus River see 'data-raw/instream/stanislaus'
# Feather River see 'data-raw/instream/feather'
# Mokelumne River see 'data-raw/instream/mokelumne'
# Yuba River see 'data-raw/instream/yuba'
# Clear Creek see 'data-raw/instream/clear'
# Cottonwood Creek see 'data-raw/instream/cottonwood'
# Battle Creek see 'data-raw/instream/battle'
# Bear River see 'data-raw/instream/bear_river'
# Butte Creek see 'data-raw/instream/butte'
# Calaveras River see 'data-raw/instream/calaveras'
# Cow Creek see 'data-raw/instream/cow'
# Merced River see 'data-raw/instream/merced'
# Tuolumne River see 'data-raw/instream/tuolumne'

# delta
delta <- read_csv('data-raw/instream/north_delta_instream.csv', skip = 1)

# simple aggregation to remove 'duplicate' flow values
north_delta_instream <- delta %>%
  select(flow_cfs, area_acres) %>%
  mutate(flow_cfs = signif(flow_cfs, 2)) %>%
  group_by(flow_cfs) %>%
  summarise(area_acres = mean(area_acres)) %>%
  mutate(watershed = 'North Delta')

north_delta_instream %>%
  ggplot(aes(x = flow_cfs, y = area_acres)) +
  geom_point() +
  scale_x_continuous(label = comma) +
  theme_minimal() +
  geom_smooth(method = 'glm', formula = y~log(x))

use_data(north_delta_instream)

# south delta, use average % suitatbility from north delta applied to south delta area for habitat value
south_delta_percent_suitability <- delta %>%
  summarise(mean_percent_suitability = mean(percent_suitable)) %>%
  pull(mean_percent_suitability)

use_data(south_delta_percent_suitability)

# rearing pools-----------
lengths_table <- read_excel('data-raw/floodplain/CVPIA_FloodplainAreas.xlsx',
                            sheet = 'MetaData',
                            col_types = c('text', 'text', 'text', 'text', rep('numeric', 17),
                                          'text', 'numeric', 'text'),
                            na = 'na')

pools_perc <- read_csv('data-raw/instream/pools.csv', col_types = 'cnc') %>%
  select(-FW_QAQC)

mean_pools_perc <- filter(pools_perc, watershed != 'Feather River') %>%
  pull(percent_pools) %>% mean(na.rm = TRUE)

pools_perc
wss <- cvpiaData::watershed_ordering$watershed

pools <- lengths_table %>%
  filter(watershed %in% wss) %>%
  mutate(SR_prop_length = SR_rearing_length_mi/FR_rearing_length_mi,
         ST_prop_length = ST_rearing_length_mi/FR_rearing_length_mi,
         FR_channel_area = FR_channel_area_of_length_modeled_acres,
         SR_channel_area = FR_channel_area * SR_prop_length,
         ST_channel_area = FR_channel_area * ST_prop_length) %>%
  select(watershed, FR_channel_area, SR_channel_area, ST_channel_area) %>%
  left_join(pools_perc) %>%
  mutate(percent_pools = replace(percent_pools, is.na(percent_pools), mean_pools_perc),
         SR_pools_sq_meters = SR_channel_area * percent_pools/100 * 4046.86,
         ST_pools_sq_meters = ST_channel_area * percent_pools/100 * 4046.86) %>%
  select(watershed, SR_pools_sq_meters, ST_pools_sq_meters) %>%
  left_join(cvpiaData::watershed_ordering) %>%
  arrange(order) %>%
  select(-order)

# put combinded values of upper sac + upper mid sac in upper sac
# upper sac + upper mid sac 6174 acres, from mark gard

pools_upper_sac <- 6174 * 7.2/100 * 4046.86

pools[pools$watershed == 'Upper Sacramento River', c('SR_pools_sq_meters', 'ST_pools_sq_meters')] <- c(pools_upper_sac, pools_upper_sac)

use_data(pools, overwrite = TRUE)
View(pools)
