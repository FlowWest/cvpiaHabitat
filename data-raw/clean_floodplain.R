library(tidyverse)
library(devtools)

sac <- read_csv('data-raw/sacramento_river_floodplain.csv')

# cvpia sac rearing segments ----
# Upper Sacramento River: Keswick-Red Bluff 59.2 mi (keswick to battle and battle to feather studies)
# Upper-mid Sacramento River: red-bluff to wilkins slough 122.45 mi (battle to feather study)
# Lower-mid Sacramento River: wilkins slough to American 58.0 mi (battle to feather 38.2 miles and feather to freeport 58-38.2)
# Lower Sacramento River: American to freeport 13.7 mi

# hec-ras 1d sac segments ---
# keswick to battle 55.5 mi
# battle to feather 189.1 mi
# feather to freeport 33.4 mi

# add zeros for extrapolating past lower limit
kes <- sac %>%
  filter(reach == 'Keswick to Battle Creek') %>%
  bind_rows(tibble(flow_cfs = 0, floodplain_acres = 0, reach = 'Keswick to Battle Creek', miles = 55.5))

bat <- sac %>%
  filter(reach == 'Battle Creek to Feather River') %>%
  bind_rows(tibble(flow_cfs = 0, floodplain_acres = 0, reach = 'Battle Creek to Feather River', miles = 189.1))

feat <- sac %>%
  filter(reach == 'Feather River to Freeport') %>%
  bind_rows(tibble(flow_cfs = 0, floodplain_acres = 0, reach = 'Feather River to Freeport', miles = 33.4))

# Emanuel: renaming the above for easier reference for me
# add zeros for extrapolating past lower limit
kes_bat <- sac %>%
  filter(reach == 'Keswick to Battle Creek') %>%
  bind_rows(tibble(flow_cfs = 0, floodplain_acres = 0, reach = 'Keswick to Battle Creek', miles = 55.5))

bat_feat <- sac %>%
  filter(reach == 'Battle Creek to Feather River') %>%
  bind_rows(tibble(flow_cfs = 0, floodplain_acres = 0, reach = 'Battle Creek to Feather River', miles = 189.1))

feat_free <- sac %>%
  filter(reach == 'Feather River to Freeport') %>%
  bind_rows(tibble(flow_cfs = 0, floodplain_acres = 0, reach = 'Feather River to Freeport', miles = 33.4))


bat %>%
  ggplot(aes(flow_cfs, floodplain_acres)) +
  geom_line()

# linear interpolation functions for each study reach
kes_area <- approxfun(x = kes$flow_cfs, y = kes$floodplain_acres)
bat_area <- approxfun(x = bat$flow_cfs, y = bat$floodplain_acres)
feat_area <- approxfun(x = feat$flow_cfs, y = feat$floodplain_acres)

# at 4500 cfs, the floodplain per mile for each study reach
kes_area(4500)/55.5
bat_area(4500)/189.1
feat_area(4500)/33.4

sac %>%
  group_by(reach) %>%
  summarise(min = min(flow_cfs), max = max(flow_cfs), count = n()) %>%
  arrange(count)

# Emanuel: reference for myself
# create new frame with instances where flow values between battle and feather
# are over the max flow between keswick to battle, assign these instances the
# max value from kes_bat and determine the area by using the kes_area() functions
xtra_flow_kes <- bat %>%
  filter(flow_cfs > 62457) %>%
  mutate(floodplain_acres = kes_area(62457),
         reach = 'Keswick to Battle Creek ', miles = 55.5)


#test method
# a weighted average where the weights are determined by how much length
# is covered by each of the studies
55.5 * kes_area(2637.426)/55.5 + (59.2-55.5) * bat_area(2637.426)/189.1

# upper sac is 59.2 miles, 55.5 of those miles are in the study's first reach
# and the rest are in the second reach. to calculate a combo, use flow
# increments from study reach in which the majority of the cvpia reach lies to
# extrapolate values from the other reach. convert these values to floodplain
# per mile and sum the miles in each study times there respective floodplain
# rates

upper_sacramento_river_floodplain <- kes %>%
  bind_rows(xtra_flow_kes) %>%
  mutate(fp_per_mile_kes = floodplain_acres/miles,
         fp_per_mile_bat = bat_area(flow_cfs)/189.1,
         floodplain_acres = miles * fp_per_mile_kes + (59.2 - miles) * fp_per_mile_bat,
         watershed = 'Upper Sacramento River') %>%
  select(flow_cfs, floodplain_acres, watershed) %>%
  filter(flow_cfs > 0)

use_data(upper_sacramento_river_floodplain, overwrite = TRUE)

View(feat)
