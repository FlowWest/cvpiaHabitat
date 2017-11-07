library(tidyverse)
library(devtools)

sac <- read_csv('data-raw/floodplain/sacramento_river_floodplain.csv')

# cvpia sac rearing segments ----
# Upper Sacramento River: Keswick-Red Bluff 59.2 mi (keswick to battle and battle to feather studies)
# Upper-mid Sacramento River: red-bluff to wilkins slough 122.45 mi (battle to feather study)
# Lower-mid Sacramento River: wilkins slough to American 58.0 mi (battle to feather 38.2 miles and feather to freeport 58-38.2)
# Lower Sacramento River: American to freeport 13.7 mi

# hec-ras 1d sac segments ---
# keswick to battle 55.5 mi
# battle to feather 189.1 mi
# feather to freeport 33.4 mi


# linear interpolation functions for each study reach --------------
kes_bat <- sac %>%
  filter(reach == 'Keswick to Battle Creek')

bat_feat <- sac %>%
  filter(reach == 'Battle Creek to Feather River')

feat_free <- sac %>%
  filter(reach == 'Feather River to Freeport')

kes_area <- approxfun(x = kes_bat$flow_cfs, y = kes_bat$floodplain_acres, yleft = 0, rule = 2)
bat_area <- approxfun(x = bat_feat$flow_cfs, y = bat_feat$floodplain_acres, yleft = 0, rule = 2)
feat_area <- approxfun(x = feat_free$flow_cfs, y = feat_free$floodplain_acres, yleft = 0, rule = 2)


# look up vector for converting study reach areas into area per miles--------------
sac_reach_lengths <- sac %>%
  select(reach, miles) %>%
  unique()

miles <- pull(sac_reach_lengths, miles)
names(miles) <- pull(sac_reach_lengths, reach)
miles

# table with floodplain area at each flow value for each study reach-----------
fp <- sac %>%
  select(flow_cfs, floodplain_acres, reach) %>%
  spread(reach, floodplain_acres) %>%
  mutate(`Battle Creek to Feather River` = ifelse(is.na(`Battle Creek to Feather River`),
                                                  bat_area(flow_cfs), `Battle Creek to Feather River`),
         `Feather River to Freeport` = ifelse(is.na(`Feather River to Freeport`),
                                              feat_area(flow_cfs), `Feather River to Freeport`),
         `Keswick to Battle Creek` = ifelse(is.na(`Keswick to Battle Creek`),
                                            kes_area(flow_cfs), `Keswick to Battle Creek`))
         # floodplain_acres =
         #   (`Battle Creek to Feather River`/miles['Battle Creek to Feather River']) +
         #   (`Feather River to Freeport`/miles['Feather River to Freeport']) +
         #   (`Keswick to Battle Creek`/miles['Keswick to Battle Creek']))

# upper sacramento river-------------------------------------------
# upper sac is 59.2 miles, 55.5 of those miles are in the study's first reach
# and the rest are in the second reach. to calculate a combo, use flow
# increments from study reach in which the majority of the cvpia reach lies to
# extrapolate values from the other reach. convert these values to floodplain
# per mile and sum the miles in each study times there respective floodplain
# rates
upper_sac_above_battle <- 55.5/59.2
upper_sac_below_battle <- 1 - upper_sac_above_battle

upper_sacramento_river_floodplain <- fp %>%
  mutate(FR_floodplain_acres =
           (`Keswick to Battle Creek`/miles['Keswick to Battle Creek'] * upper_sac_above_battle) +
           (`Battle Creek to Feather River`/miles['Battle Creek to Feather River'] * upper_sac_below_battle),
         watershed = 'Upper Sacramento River') %>%
  select(flow_cfs, FR_floodplain_acres, watershed)

use_data(upper_sacramento_river_floodplain, overwrite = TRUE)


# Upper-mid Sacramento River ------------------------------------
# red-bluff to wilkins slough 122.45 mi (battle to feather study)
# battle to feather requires no more processing:
upper_mid_within_bat_feat <- 122.45

upper_mid_sacramento_river_floodplain <- fp %>%
  mutate(FR_floodplain_acres =
           (`Battle Creek to Feather River`/miles['Battle Creek to Feather River'] * upper_mid_within_bat_feat),
         watershed = "Upper-mid Sacramento River") %>%
  select(flow_cfs, FR_floodplain_acres, watershed)

use_data(upper_mid_sacramento_river_floodplain, overwrite = TRUE)


# cvpia sac rearing segments ----
# Lower-mid Sacramento River: wilkins slough to American 58.0 mi (battle to feather 38.2 miles and feather to freeport 58-38.2)

# hec-ras 1d sac segments ---
# keswick to battle 55.5 mi
# battle to feather 189.1 mi
# feather to freeport 33.4 mi

sac %>%
  group_by(reach) %>%
  summarise(min = min(flow_cfs, na.rm =TRUE), max = max(flow_cfs, na.rm =TRUE), count = n()) %>%
  arrange(count)

# Emanuel: reference for myself
# create new frame with instances where flow values between battle and feather
# are over the max flow between keswick to battle, assign these instances the
# max value from kes_bat and determine the area by using the kes_area() functions
xtra_flow_feat_free <- bat_feat %>%
  filter(flow_cfs < 4355.361) %>%
  mutate(floodplain_acres = feat_area(4355.361),
         reach = "Feather River to Freeport", miles = 33.4)


feat_free_with_extra_flow <- bind_rows(
  feat_free,
  xtra_flow_feat_free
)

# case when we add rows to feather to freeport
lower_mid_sacramento_river_floodplain <- feat_free_with_extra_flow %>%
  mutate(fp_per_mile_feat_free = floodplain_acres/miles,
         fp_per_mile_bat_feat = bat_area(flow_cfs)/189.1,
         floodplain_acres = (38.2 * fp_per_mile_bat_feat) + (19.8 * fp_per_mile_feat_free),
         watershed = 'Lower-mid Sacramento River') %>%
  select(flow_cfs, floodplain_acres, watershed) %>%
  filter(flow_cfs > 0)

devtools::use_data(lower_mid_sacramento_river_floodplain, overwrite = TRUE)

# cvpia sac rearing segments ----
# Lower Sacramento River: American to freeport 13.7 mi

# hec-ras 1d sac segments ---
# keswick to battle 55.5 mi
# battle to feather 189.1 mi
# feather to freeport 33.4 mi

lower_sacramento_river_floodplain <- feat_free %>%
  mutate(fp_per_mile_feat_free = floodplain_acres/miles,
         floodplain_acres = 13.7 * fp_per_mile_feat_free,
         watershed = "Lower Sacramento River") %>%
  select(flow_cfs, floodplain_acres, watershed)
devtools::use_data(lower_sacramento_river_floodplain, overwrite = TRUE)
