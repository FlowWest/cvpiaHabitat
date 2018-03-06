library(tidyverse)
library(devtools)

sac <- read_csv('data-raw/floodplain/sacramento_river_floodplain.csv')

# cvpia sac rearing segments ----
# Upper Sacramento River: Keswick-Red Bluff 59.2 mi (keswick to battle and battle to feather studies)
# Upper-mid Sacramento River: red-bluff to wilkins slough 122.45 mi (battle to feather study)
# Lower-mid Sacramento River: wilkins slough to American 58.0 mi (battle to feather 38.2 miles and feather to freeport 58-38.2)
# Lower Sacramento River: American to freeport 13.7 mi

# hec-ras 1d sac segments ------
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

# upper sacramento river-------------------------------------------
# upper sac is 59.2 miles, 55.5 of those miles are in the study's first reach
# and the rest are in the second reach. to calculate a combo, use flow
# increments from study reach in which the majority of the cvpia reach lies to
# extrapolate values from the other reach. convert these values to floodplain
# per mile and sum the miles in each study times there respective floodplain
# rates
upper_sac_above_battle <- 55.5
upper_sac_below_battle <- 59.2 - 55.5

upper_sacramento_river_floodplain <- fp %>%
  mutate(floodplain_acres =
           (`Keswick to Battle Creek`/miles['Keswick to Battle Creek'] * upper_sac_above_battle) +
           (`Battle Creek to Feather River`/miles['Battle Creek to Feather River'] * upper_sac_below_battle),
         watershed = 'Upper Sacramento River') %>%
  select(flow_cfs, floodplain_acres, watershed)

devtools::use_data(upper_sacramento_river_floodplain, overwrite = TRUE)

# Upper-mid Sacramento River ------------------------------------
# red-bluff to wilkins slough 122.45 mi (battle to feather study)
# battle to feather requires no more processing:
upper_mid_within_bat_feat <- 122.45

upper_mid_sacramento_river_floodplain <- fp %>%
  mutate(floodplain_acres =
           (`Battle Creek to Feather River`/miles['Battle Creek to Feather River'] * upper_mid_within_bat_feat),
         watershed = "Upper-mid Sacramento River") %>%
  select(flow_cfs, floodplain_acres, watershed)

devtools::use_data(upper_mid_sacramento_river_floodplain, overwrite = TRUE)

# Lower-mid Sacramento River ------------
# wilkins slough to American 58.0 mi (battle to feather 38.2 miles and feather to freeport 58-38.2)

lower_mid_above_feather <- 38.2
lower_mid_below_feather <- 58 - 38.2

lower_mid_sacramento_river_floodplain <- fp %>%
  mutate(floodplain_acres =
           (`Battle Creek to Feather River`/miles['Battle Creek to Feather River'] * lower_mid_above_feather) +
           (`Feather River to Freeport`/miles['Feather River to Freeport'] * lower_mid_below_feather),
         watershed = 'Lower-mid Sacramento River') %>%
  select(flow_cfs, floodplain_acres, watershed)

devtools::use_data(lower_mid_sacramento_river_floodplain, overwrite = TRUE)

# Lower Sacramento River ----
# American to freeport 13.7 mi
lower_within_feat_free <-  13.7

lower_sacramento_river_floodplain <- fp %>%
  mutate(floodplain_acres =
           (`Feather River to Freeport`/miles['Feather River to Freeport'] * lower_within_feat_free),
         watershed = 'Lower Sacramento River') %>%
  select(flow_cfs, floodplain_acres, watershed)

devtools::use_data(lower_sacramento_river_floodplain, overwrite = TRUE)

# merced river ---------
# only lower 25.5 miles are modeled, need to scale to upper half
# calculate area per RM and assign the product of the river miles and the weighted area rate for each segment
# RM 25.5 - 31.2 in same "Valley Lowland" category (from CV Habitat Exchange) as RM 0 - 25.5, so use 1X area/RM from modeled reach.
# RM 31.2 - 43.6 not in Valley Lowland category, so use 0.5X area/RM relationship from modeled reach.
# RM 43.6 - 47.0 in same Valley Lowland category, so use 1X area/RM from modeled reach.
# RM 47.0 - 52.0 not in Valley Lowland category and in dredge tailings, so use 0.1X area/RM from modeled reach.
merced <- read_csv('data-raw/floodplain/merced_river_floodplain.csv')

merced_river_floodplain <- merced %>%
  filter(flow_cfs != 876) %>% # remove 876 value not modeled
  mutate(area_per_RM = floodplain_acres / 25.5,
         rm0_25 = floodplain_acres,
         rm25_31 = area_per_RM * (31.2 - 25.5),
         rm31_43 = area_per_RM * (43.6 - 31.2) * .5,
         rm43_47 = area_per_RM * (47 - 43.6),
         rm47_52 = area_per_RM * (52 - 47) * .1,
         rm0_52 = rm0_25 + rm25_31 + rm31_43 + rm43_47 + rm47_52) %>%
  select(flow_cfs, floodplain_acres = rm0_52, watershed)

devtools::use_data(merced_river_floodplain, overwrite = TRUE)


cosumnes_river_floodplain <- read_csv('data-raw/floodplain/cosumnes_river_floodplain.csv') %>%
  select(-species)

use_data(cosumnes_river_floodplain, overwrite = TRUE)

tuolumne_river_floodplain <- read_csv('data-raw/floodplain/tuolumne_river_floodplain.csv')

use_data(tuolumne_river_floodplain, overwrite = TRUE)

butte_creek_floodplain <- read_csv('data-raw/floodplain/butte_creek_floodplain.csv')

use_data(butte_creek_floodplain, overwrite = TRUE)
