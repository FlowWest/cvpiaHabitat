library(tidyverse)
library(devtools)
library(scales)

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

up_sac <- read_csv('data-raw/instream/upper_sacramento_river_instream.csv', skip = 1)
View(up_sac)
glimpse(up_sac)

# TODO fix upper sac rearing to include battle to red bluff from the battle to feather model
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
# NOTE: no rearing modeling for reach 3 and 2

# hec-ras 1d sac segments ---
# battle to feather 189.1 mi
# feather to freeport 33.4 mi

# WUA in square feet use miles/5.28 to get to square feet per 1000 feet
sacramento_instream <- read_csv('data-raw/instream/sacramento_river_instream.csv', skip = 1)

upper_mid_sacramento_river_instream <- sacramento_instream %>%
  mutate(juv_WUA = juv_WUA/miles/5.28, watershed = 'Upper-mid Sacramento River') %>%
  filter(reach == 'Battle Creek to Feather River') %>%
  select(flow_cfs,
         FR_juv_wua = juv_WUA,
         watershed)

devtools::use_data(upper_mid_sacramento_river_instream, overwrite = TRUE)


# lower mid sacramento has 201843.335 feet in the battle to feather study area
# and 104198.716079 feet in the feather to freeport study area
# the lower mid sac is 306042.051 feet long
prop_above_feather <- 201843.335/306042.051 #34%
prop_below_feather  <- 104198.716079/306042.051 #66%

# build approx functions to use for filling in missing values at flows from other study area
sacramento_instream %>%
  group_by(reach) %>%
  summarise(min_flow = min(flow_cfs), max_flow = max(flow_cfs))

bat_to_feather <- sacramento_instream %>%
  mutate(juv_WUA = juv_WUA/miles/5.28) %>%
  filter(reach == 'Battle Creek to Feather River')

# add 0 value to extrapolate below min flow value
feather_to_free <-  sacramento_instream %>%
  mutate(juv_WUA = juv_WUA/miles/5.28) %>%
  filter(reach == 'Feather River to Freeport') %>%
  select(flow_cfs, juv_WUA) %>%
  bind_rows(tibble(flow_cfs = 0, juv_WUA = 0))


bat_to_feather_approx <- approxfun(bat_to_feather$flow_cfs, bat_to_feather$juv_WUA, rule = 2)
feather_to_free_approx <- approxfun(feather_to_free$flow_cfs, feather_to_free$juv_WUA, rule = 2)

lower_mid_sacramento_river_instream <- sacramento_instream %>%
  mutate(juv_WUA = juv_WUA/miles/5.28) %>%
  select(flow_cfs, reach, juv_WUA) %>%
  spread(reach, juv_WUA) %>%
  mutate(`Battle Creek to Feather River` = ifelse(is.na(`Battle Creek to Feather River`),
                                                  bat_to_feather_approx(flow_cfs), `Battle Creek to Feather River`),
         `Feather River to Freeport` = ifelse(is.na(`Feather River to Freeport`),
                                              feather_to_free_approx(flow_cfs), `Feather River to Freeport`),
         FR_juv_wua =
           prop_above_feather * `Battle Creek to Feather River` +
           prop_below_feather *`Feather River to Freeport`,
         watershed = 'Lower-mid Sacramento River') %>%
  select(flow_cfs, FR_juv_wua, watershed)

devtools::use_data(lower_mid_sacramento_river_instream)

lower_sacramento_river_instream <- sacramento_instream %>%
  mutate(juv_WUA = juv_WUA/miles/5.28, watershed = 'Lower Sacramento River') %>%
  filter(reach == 'Feather River to Freeport') %>%
  select(flow_cfs, juv_WUA, watershed) %>%
  select(flow_cfs,
         FR_juv_wua = juv_WUA,
         watershed)

devtools::use_data(lower_sacramento_river_instream, overwrite = TRUE)

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
yuba_prop_above_dag <- .5
yuba_prop_below_dag <- .5

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



# American river
# from MG call, all we have to look at are rows 1-32 that specify spawning
# all else is "intermediate" steps.


american <- read_csv("data-raw/instream/american_river_instream.csv", skip =1)

american$miles <- 2.2

american_river_instream <- american %>%
  rename(flow_cfs = Flow, species_stage = species, WUA = wua) %>%
  group_by(species_stage, flow_cfs) %>%
  mutate(WUA = WUA/miles/5.28, watershed = 'American River') %>%
  spread(key = species_stage, value = WUA) %>%
  select(flow_cfs,
         FR_spawn_wua = FR_spawning,
         ST_spawn_wua = ST_spawning,
         watershed)


devtools::use_data(american_river_instream, overwrite = TRUE)

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
feather_river <- read_csv("data-raw/instream/feather_river_instream.csv", skip=1)
feather_river_instream <- feather_river %>%
  select(flow_cfs,
         FR_spawn_wua = spawn_WUA,
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
mokelumne_river <- read_csv("data-raw/instream/mokelumne_river_instream.csv", skip = 1)
mokelumne_river_instream <- mokelumne_river %>%
  select(flow_cfs,
         FR_spawn_wua = spawn_WUA,
         FR_fry_wua = fry_WUA,
         FR_juv_wua = juv_WUA,
         watershed)

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















