library(tidyverse)
library(devtools)
library(scales)
library(readxl)

# clear creek instream cleaning-----------------------------------
# in units sqft want in units sqft/1000ft
clear_creek <- read_csv('data-raw/instream/clear_creek_instream.csv')
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
  mutate(watershed = 'Clear Creek') %>%
  select(flow_cfs,
         FR_fry_wua = FR_fry,
         FR_juv_wua = FR_juv,
         FR_spawn_wua = FR_spawning,
         SR_fry_wua = SR_fry,
         SR_juv_wua = SR_juvenile,
         SR_spawn_wua = SR_spawning,
         ST_fry_wua = ST_fry,
         ST_juv_wua = ST_juvenile,
         ST_spawn_wua = ST_spawning,
         watershed) # add new naming convention to cols

devtools::use_data(clear_creek_instream, overwrite = TRUE)

cottonwood <- read_csv('data-raw/instream/cottonwood_creek_instream.csv', skip = 1)
cottonwood_creek_instream <- cottonwood %>%
  select(flow_cfs,
         FR_spawn_wua = spawn_WUA,
         FR_fry_wua = fry_WUA,
         FR_juv_wua = juv_WUA,
         watershed) %>%
  arrange(flow_cfs)

devtools::use_data(cottonwood_creek_instream, overwrite = TRUE)

stan <- read_csv('data-raw/instream/stanislaus_river_instream.csv', skip = 1)

stanislaus_river_instream <- stan %>%
  gather(species_stage, WUA, -flow_cfs, -watershed) %>%
  filter(!is.na(WUA)) %>%
  spread(species_stage, WUA) %>%
  select(flow_cfs,
         FR_spawn_wua = spawn_WUA,
         FR_fry_wua = fr_fry_WUA,
         FR_juv_wua = fr_juv_WUA,
         ST_fry_wua = st_fry_WUA,
         ST_juv_wua = st_juv_WUA,
         watershed)

devtools::use_data(stanislaus_river_instream, overwrite = TRUE)

#yuba

# fixing the yuba instream based on Mark Gard Input
# according to mark gard, on engle to daguerre segment use 400cfs as the min cfs
# then on the dag to feather use linear interpolation to fill in gaps
yuba <- read_csv("data-raw/instream/yuba_river_instream.csv", skip=1)

engle_to_dag <- yuba %>% filter(segment == "Englebright to Daguerre Segment")
dag_to_feather <- yuba %>% filter(segment == "Daguerre to Feather Segment")

# create approx functions for these
engle_to_dag_FR_fry_area <- approxfun(engle_to_dag$Flow, engle_to_dag$FR_SR_fry, rule = 2)
engle_to_dag_FR_spawn_area <- approxfun(engle_to_dag$Flow, engle_to_dag$FR_Spawn, rule = 2)
engle_to_dag_FR_juv_area <- approxfun(engle_to_dag$Flow, engle_to_dag$FR_SR_juv, rule = 2)
engle_to_dag_SR_spawn_area <- approxfun(engle_to_dag$Flow, engle_to_dag$SR_Spawn, rule = 2)
engle_to_dag_ST_fry_area <- approxfun(engle_to_dag$Flow, engle_to_dag$ST_fry, rule = 2)
engle_to_dag_ST_spawn_area <- approxfun(engle_to_dag$Flow, engle_to_dag$ST_Spawn, rule = 2)
engle_to_dag_ST_juv_area <- approxfun(engle_to_dag$Flow, engle_to_dag$ST_juv, rule = 2)


dag_to_feather_FR_fry_area <- approxfun(dag_to_feather$Flow, dag_to_feather$FR_SR_fry)
dag_to_feather_FR_spawn_area <- approxfun(dag_to_feather$Flow, dag_to_feather$FR_Spawn)
dag_to_feather_FR_juv_area <- approxfun(dag_to_feather$Flow, dag_to_feather$FR_SR_juv)
dag_to_feather_SR_spawn_area <- approxfun(dag_to_feather$Flow, dag_to_feather$SR_Spawn)
dag_to_feather_ST_fry_area <- approxfun(dag_to_feather$Flow, dag_to_feather$ST_fry)
dag_to_feather_ST_spawn_area <- approxfun(dag_to_feather$Flow, dag_to_feather$ST_Spawn)
dag_to_feather_ST_juv_area <- approxfun(dag_to_feather$Flow, dag_to_feather$ST_juv)

# yuba proportion that cover yuba based on dag location
yuba_miles <- yuba %>% select(miles) %>% unique() %>% pull()
yuba_miles_proportions <- yuba_miles/sum(yuba_miles)
yuba_prop_above_dag <- yuba_miles_proportions[1]
yuba_prop_below_dag <- yuba_miles_proportions[2]

# Spawn Columns ---
yuba_SR_spawn <- yuba %>%
  mutate(SR_Spawn = SR_Spawn/miles/5.28) %>%
  select(Flow, SR_Spawn, segment) %>%
  spread(segment, SR_Spawn) %>%
  mutate(
    `Englebright to Daguerre Segment` = case_when(
      is.na(`Englebright to Daguerre Segment`) ~ engle_to_dag_SR_spawn_area(Flow),
      TRUE ~ `Englebright to Daguerre Segment`
    ),
    `Daguerre to Feather Segment` = case_when(
      is.na(`Daguerre to Feather Segment`) ~ dag_to_feather_SR_spawn_area(Flow),
      TRUE ~ `Daguerre to Feather Segment`
    ),
    SR_spawn_wua =
      yuba_prop_above_dag * `Englebright to Daguerre Segment` +
      yuba_prop_below_dag *`Daguerre to Feather Segment`,
    watershed = 'Yuba River') %>%
  select(flow_cfs = Flow, SR_spawn_wua)

yuba_FR_spawn <- yuba %>%
  mutate(FR_Spawn = FR_Spawn/miles/5.28) %>%
  select(Flow, FR_Spawn, segment) %>%
  spread(segment, FR_Spawn) %>%
  mutate(
    `Englebright to Daguerre Segment` = case_when(
      is.na(`Englebright to Daguerre Segment`) ~ engle_to_dag_FR_spawn_area(Flow),
      TRUE ~ `Englebright to Daguerre Segment`
    ),
    `Daguerre to Feather Segment` = case_when(
      is.na(`Daguerre to Feather Segment`) ~ dag_to_feather_FR_spawn_area(Flow),
      TRUE ~ `Daguerre to Feather Segment`
    ),
    FR_spawn_wua =
      yuba_prop_above_dag * `Englebright to Daguerre Segment` +
      yuba_prop_below_dag *`Daguerre to Feather Segment`,
    watershed = 'Yuba River') %>%
  select(flow_cfs = Flow, FR_spawn_wua)

yuba_ST_spawn <- yuba %>%
  mutate(ST_Spawn = ST_Spawn/miles/5.28) %>%
  select(Flow, ST_Spawn, segment) %>%
  spread(segment, ST_Spawn) %>%
  mutate(
    `Englebright to Daguerre Segment` = case_when(
      is.na(`Englebright to Daguerre Segment`) ~ engle_to_dag_ST_spawn_area(Flow),
      TRUE ~ `Englebright to Daguerre Segment`
    ),
    `Daguerre to Feather Segment` = case_when(
      is.na(`Daguerre to Feather Segment`) ~ dag_to_feather_ST_spawn_area(Flow),
      TRUE ~ `Daguerre to Feather Segment`
    ),
    ST_spawn_wua =
      yuba_prop_above_dag * `Englebright to Daguerre Segment` +
      yuba_prop_below_dag *`Daguerre to Feather Segment`,
    watershed = 'Yuba River') %>%
  select(flow_cfs = Flow, ST_spawn_wua)

yuba_spawn <- bind_cols(yuba_FR_spawn,
                        yuba_SR_spawn,
                        yuba_ST_spawn) %>% select(flow_cfs, contains("spawn_wua"))


# Fry Columns --- note here we remove any case of SR since the habitat package
#                 correctly falls back on to Fall Run
yuba_FR_SR_fry <- yuba %>%
  mutate(FR_SR_fry = FR_SR_fry/miles/5.28) %>%
  select(Flow, FR_SR_fry, segment) %>%
  spread(segment, FR_SR_fry) %>%
  mutate(
    `Englebright to Daguerre Segment` = case_when(
      is.na(`Englebright to Daguerre Segment`) ~ engle_to_dag_FR_fry_area(Flow),
      TRUE ~ `Englebright to Daguerre Segment`
    ),
    `Daguerre to Feather Segment` = case_when(
      is.na(`Daguerre to Feather Segment`) ~ dag_to_feather_FR_fry_area(Flow),
      TRUE ~ `Daguerre to Feather Segment`
    ),
    FR_fry_wua =
      yuba_prop_above_dag * `Englebright to Daguerre Segment` +
      yuba_prop_below_dag *`Daguerre to Feather Segment`,
    watershed = 'Yuba River') %>%
  select(flow_cfs = Flow, FR_fry_wua)

yuba_ST_fry <- yuba %>%
  mutate(ST_fry = ST_fry/miles/5.28) %>%
  select(Flow, ST_fry, segment) %>%
  spread(segment, ST_fry) %>%
  mutate(
    `Englebright to Daguerre Segment` = case_when(
      is.na(`Englebright to Daguerre Segment`) ~ engle_to_dag_ST_fry_area(Flow),
      TRUE ~ `Englebright to Daguerre Segment`
    ),
    `Daguerre to Feather Segment` = case_when(
      is.na(`Daguerre to Feather Segment`) ~ dag_to_feather_ST_fry_area(Flow),
      TRUE ~ `Daguerre to Feather Segment`
    ),
    ST_fry_wua =
      yuba_prop_above_dag * `Englebright to Daguerre Segment` +
      yuba_prop_below_dag *`Daguerre to Feather Segment`,
    watershed = 'Yuba River') %>%
  select(flow_cfs = Flow, ST_fry_wua)

yuba_fry <- bind_cols(yuba_FR_SR_fry,
                      yuba_ST_fry) %>% select(flow_cfs, contains("fry_wua"))

# juv columns ---
yuba_FR_SR_juv <- yuba %>%
  mutate(FR_SR_juv = FR_SR_juv/miles/5.28) %>%
  select(Flow, FR_SR_juv, segment) %>%
  spread(segment, FR_SR_juv) %>%
  mutate(
    `Englebright to Daguerre Segment` = case_when(
      is.na(`Englebright to Daguerre Segment`) ~ engle_to_dag_FR_juv_area(Flow),
      TRUE ~ `Englebright to Daguerre Segment`
    ),
    `Daguerre to Feather Segment` = case_when(
      is.na(`Daguerre to Feather Segment`) ~ dag_to_feather_FR_juv_area(Flow),
      TRUE ~ `Daguerre to Feather Segment`
    ),
    FR_juv_wua =
      yuba_prop_above_dag * `Englebright to Daguerre Segment` +
      yuba_prop_below_dag *`Daguerre to Feather Segment`,
    watershed = 'Yuba River') %>%
  select(flow_cfs = Flow, FR_juv_wua)

yuba_ST_juv <- yuba %>%
  mutate(ST_juv = ST_juv/miles/5.28) %>%
  select(Flow, ST_juv, segment) %>%
  spread(segment, ST_juv) %>%
  mutate(
    `Englebright to Daguerre Segment` = case_when(
      is.na(`Englebright to Daguerre Segment`) ~ engle_to_dag_ST_juv_area(Flow),
      TRUE ~ `Englebright to Daguerre Segment`
    ),
    `Daguerre to Feather Segment` = case_when(
      is.na(`Daguerre to Feather Segment`) ~ dag_to_feather_ST_juv_area(Flow),
      TRUE ~ `Daguerre to Feather Segment`
    ),
    ST_juv_wua =
      yuba_prop_above_dag * `Englebright to Daguerre Segment` +
      yuba_prop_below_dag *`Daguerre to Feather Segment`,
    watershed = 'Yuba River') %>%
  select(flow_cfs = Flow, ST_juv_wua)

yuba_juv <- bind_cols(yuba_FR_SR_juv,
                      yuba_ST_juv) %>% select(flow_cfs, contains("juv_wua"))

yuba_river_instream <- bind_cols(
  yuba_spawn,
  yuba_fry,
  yuba_juv
) %>% select(flow_cfs, contains("wua")) %>% mutate(watershed = "Yuba River")


devtools::use_data(yuba_river_instream, overwrite = TRUE)


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



# American River see 'data-raw/instream/american'


# this portion cleans up the naming conventions -------------------------------------
# naming convention: SPECIES_LIFESTAGE_UNITS for each column

# battle creek
battle_creek <- read_csv("data-raw/instream/battle_creek_instream.csv", skip=2)
battle_creek_instream <- battle_creek %>%
  select(flow_cfs,
         FR_spawn_wua = spawn_WUA,
         FR_fry_wua = fry_WUA,
         FR_juv_wua = juv_WUA,
         adult_trout_wua = adult_trout_WUA,
         watershed)

devtools::use_data(battle_creek_instream, overwrite = TRUE)

# bear river
bear_river <- read_csv("data-raw/instream/bear_river_instream.csv", skip = 2)
bear_river_instream <- bear_river %>%
  select(flow_cfs,
         FR_spawn_wua = spawn_WUA,
         FR_juv_wua = juv_WUA,
         watershed)

devtools::use_data(bear_river_instream, overwrite = TRUE)


# butte creek
butte_creek <- read_csv("data-raw/instream/butte_creek_instream.csv", skip=1)
butte_creek_instream <- butte_creek %>%
  select(flow_cfs,
         FR_spawn_wua = spawn_WUA,
         FR_fry_wua = fry_WUA,
         FR_juv_wua = juv_WUA,
         adult_trout_WUA,
         watershed)

devtools::use_data(butte_creek_instream, overwrite = TRUE)

# calaveras river
calaveras_river <- read_csv("data-raw/instream/calaveras_river_instream.csv", skip=2)
calaveras_river_instream <- calaveras_river %>%
  select(flow_cfs,
         FR_spawn_wua = spawn_WUA,
         FR_fry_wua = fry_WUA,
         FR_juv_wua = juv_WUA,
         watershed)

devtools::use_data(calaveras_river_instream, overwrite = TRUE)

# clear creek cleaned above

# cottonwood creek done above

# cow creek
cow_creek <- read_csv("data-raw/instream/cow_creek_instream.csv", skip=1)
cow_creek_instream <- cow_creek %>%
  select(flow_cfs,
         FR_fry_wua = fry_WUA,
         FR_juv_wua = juv_WUA,
         watershed)

devtools::use_data(cow_creek_instream, overwrite = TRUE)

# feather river
feather_river <- read_csv("data-raw/instream/feather_river_instream.csv", skip = 1) %>%
  select(-spawn_WUA)
feather_river_spawn <- read_csv('data-raw/feather/feather_river_spawning.csv')

feather_river_instream <- feather_river_spawn %>%
  left_join(feather_river) %>%
  mutate(watershed = 'Feather River') %>%
  select(flow_cfs,
         FR_spawn_wua,
         FR_fry_wua = fry_WUA,
         FR_juv_wua = juv_WUA,
         watershed)

devtools::use_data(feather_river_instream, overwrite = TRUE)

# merced
merced_river <- read_csv("data-raw/instream/merced_river_instream.csv", skip = 1)
merced_river_instream <- merced_river  %>%
  select(flow_cfs,
         FR_spawn_wua = spawn_WUA,
         FR_fry_wua = fry_WUA,
         FR_juv_wua = juv_WUA,
         adult_steelhead_WUA,
         watershed)

devtools::use_data(merced_river_instream, overwrite = TRUE)

# moke
# 24.7 reach length
robin_rearing <- readxl::read_excel('data-raw/mark_gard_data/Mokelumne CS fry and juvenile WUA Results.xlsx', sheet = 1, skip = 16) %>%
  select(flow_cfs = Flow, `Fall-run fry (ft2)`, `Fall-run juvenile (ft2)`) %>%
  mutate(FR_fry_wua = `Fall-run fry (ft2)` / (24.7 * 5280 / 1000),
         FR_juv_wua = `Fall-run juvenile (ft2)` / (24.7 * 5280 / 1000)) %>%
  select(flow_cfs, FR_fry_wua, FR_juv_wua)

# modified the mark gard data, he created the wua curve using the areas provided by EBMUD
# and dividing by the entire reach length instead of just the spawning area
# i took the ebmud data and divided by our spawning extent length so our areas would match
# ebmud's

mokelumne_river <- read_csv("data-raw/instream/mokelumne_river_instream.csv", skip = 1)
mokelumne_river_instream <- mokelumne_river %>%
  select(flow_cfs,
         FR_spawn_wua = spawn_WUA) %>%
  filter(!is.na(FR_spawn_wua)) %>%
  full_join(robin_rearing) %>%
  mutate(watershed = 'Mokelumne River')

devtools::use_data(mokelumne_river_instream, overwrite = TRUE)

# stanislaus done above

# tuo
tuolumne_river <- read_csv("data-raw/instream/tuolumne_river_instream.csv", skip = 1)

tuolumne_river_instream <- tuolumne_river %>%
  select(flow_cfs,
         FR_spawn_wua = spawn_WUA,
         FR_fry_wua = fry_WUA,
         FR_juv_wua = juv_WUA,
         ST_spawn_wua = ST_spawn_WUA,
         ST_fry_wua = ST_fry_WUA,
         ST_juv_wua = ST_juv_WUA,
         adult_ST_WUA,
         watershed)

devtools::use_data(tuolumne_river_instream, overwrite = TRUE)

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
