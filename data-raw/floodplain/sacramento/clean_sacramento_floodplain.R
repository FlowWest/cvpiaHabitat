library(tidyverse)
library(devtools)

sac <- read_csv('data-raw/floodplain/sacramento_river_floodplain.csv')

sac_floodplain <- read_csv(file = 'data-raw/floodplain/sacramento_floodplain.csv',
                           col_names = c('flow_cfs', 'kes_bat', 'bat_feat', 'feat_free'), skip = 1) %>%
  gather(reach, sq_ft, -flow_cfs) %>%
  mutate(sq_meters = sq_ft * 0.092903)

295.92 - 267 #keswick to battle
267 - 80.5 # battle to feather
80.5 - 46.6 # feather to freeport

# cvpia sac rearing segments ----
# Upper Sacramento River: Keswick-Red Bluff 59.28 mi (keswick to battle and battle to feather studies)
# Upper-mid Sacramento River: red-bluff to wilkins slough 122.25 mi (battle to feather study)
# Lower-mid Sacramento River: wilkins slough to American 57.96 mi (battle to feather 38.2 miles and feather to freeport 58-38.2)
# Lower Sacramento River: American to freeport 13.70 mi

# linear interpolation functions for each study reach --------------
kes_bat <- sac_floodplain %>%
  filter(reach == 'kes_bat')

bat_feat <- sac_floodplain %>%
  filter(reach == 'bat_feat')

feat_free <- sac_floodplain %>%
  filter(reach == 'feat_free')

# look up vector for converting study reach areas into area per miles--------------
reach_miles <- c(295.92 - 267, 267 - 80.5, 80.5 - 46.6)
sum(reach_miles)
59.28 + 122.25 + 57.96 + 13.7
names(reach_miles) <- c('kes_bat', 'bat_feat', 'feat_free')
reach_miles

# upper sacramento river-------------------------------------------
# upper sac is 59.28 miles, 28.92 of those miles are in the study's first reach
# and the rest are in the second reach. Sum propotion of area by length in second reach to total in first.
# areas are already suitable, don't scale down
upper_sac_above_battle <- 28.92
upper_sac_below_battle <- 59.28 - upper_sac_above_battle

prop_bat_rbdd <- upper_sac_below_battle / reach_miles['bat_feat']

upper_sacramento_river_floodplain <- bat_feat %>%
  mutate(sq_meter_scaled = sq_meters * prop_bat_rbdd) %>%
  bind_cols(kes_bat) %>%
  mutate(floodplain_sq_meters = sq_meter_scaled + sq_meters1,
         watershed = 'Upper Sacramento River') %>%
  select(flow_cfs, floodplain_sq_meters, watershed)

upper_sacramento_river_floodplain %>%
  ggplot(aes(x = flow_cfs, y = floodplain_sq_meters)) +
  geom_line()

devtools::use_data(upper_sacramento_river_floodplain, overwrite = TRUE)

# Upper-mid Sacramento River ------------------------------------
# red-bluff to wilkins slough 122.25 mi (battle to feather study)
rbdd_wilk_mi <- 122.25
prop_rbdd_wilkins <- rbdd_wilk_mi / reach_miles['bat_feat']

upper_mid_sacramento_river_floodplain <- bat_feat %>%
  mutate(floodplain_sq_meters = sq_meters * prop_rbdd_wilkins,
         watershed = 'Upper-mid Sacramento River') %>%
  select(flow_cfs, floodplain_sq_meters, watershed)

upper_mid_sacramento_river_floodplain %>%
  ggplot(aes(x = flow_cfs, y = floodplain_sq_meters)) +
  geom_line()

devtools::use_data(upper_mid_sacramento_river_floodplain, overwrite = TRUE)

# Lower-mid Sacramento River ------------
# wilkins slough to American 57.96 mi (battle to feather 33.89 miles and feather to freeport 57.96 - 33.89)
wilk_amer_mi <- 57.96
wilk_feather_mi <- reach_miles['bat_feat'] - rbdd_wilk_mi - upper_sac_below_battle
prop_wilkins_feather <- wilk_feather_mi / reach_miles['bat_feat']
feat_amer_mi <- wilk_amer_mi - wilk_feather_mi
prop_feat_amer <- feat_amer_mi/reach_miles['feat_free']

lower_mid_sacramento_river_floodplain <- bat_feat %>%
  bind_cols(feat_free) %>%
  mutate(sq_meter_scaled1 = sq_meters * prop_wilkins_feather,
         sq_meter_scaled2 = sq_meters1 * prop_feat_amer) %>%
  mutate(floodplain_sq_meters = sq_meter_scaled1 + sq_meter_scaled2,
         watershed = 'Lower-mid Sacramento River') %>%
  select(flow_cfs, floodplain_sq_meters, watershed)

lower_mid_sacramento_river_floodplain %>%
  ggplot(aes(x = flow_cfs, y = floodplain_sq_meters)) +
  geom_line()

devtools::use_data(lower_mid_sacramento_river_floodplain, overwrite = TRUE)

# Lower Sacramento River ----
amer_free_mi <- reach_miles['feat_free'] - feat_amer_mi
prop_amer_free <- amer_free_mi / reach_miles['feat_free']

lower_sacramento_river_floodplain <- feat_free %>%
  mutate(floodplain_sq_meters = sq_meters * prop_amer_free,
         watershed = 'Lower Sacramento River') %>%
  select(flow_cfs, floodplain_sq_meters, watershed)

lower_sacramento_river_floodplain %>%
  ggplot(aes(x = flow_cfs, y = floodplain_sq_meters)) +
  geom_line()

devtools::use_data(lower_sacramento_river_floodplain, overwrite = TRUE)


