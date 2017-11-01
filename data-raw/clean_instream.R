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
         watershed) # add new naming convention

devtools::use_data(clear_creek_instream, overwrite = TRUE)

cottonwood <- read_csv('data-raw/cottonwood_creek_instream.csv', skip = 1)
cottonwood_creek_instream <- cottonwood %>%
  select(flow_cfs,
         FR_spawn_wua = spawn_WUA,
         FR_fry_wua = fry_WUA,
         FR_juv_wua = juv_WUA,
         watershed) %>%
  arrange(flow_cfs)

devtools::use_data(cottonwood_creek_instream, overwrite = TRUE)

stan <- read_csv('data-raw/stanislaus_river_instream.csv', skip = 1)

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
  select(flow_cfs,
         FR_juv_wua = juv_WUA,
         watershed)

devtools::use_data(upper_mid_sacramento_instream, overwrite = TRUE)

lower_sacramento_instream <- sacramento_instream %>%
  mutate(juv_WUA = juv_WUA/miles/5.28, watershed = 'Lower Sacramento River') %>%
  filter(reach == 'Feather River to Freeport') %>%
  select(flow_cfs, juv_WUA, watershed)

use_data(lower_sacramento_instream)

#yuba


# fixing the yuba instream based on Mark Gard Input
yuba <- read_csv("data-raw/yuba_river_instream.csv", skip=1)

# conflicts of flow ranges between segments
yuba %>%
  group_by(segment) %>%
  summarise(
    min_flow = min(Flow, na.rm = TRUE),
    max_flow = max(Flow, na.rm = TRUE),
    total = n()
  )

# for later comparison
dag_to_feather <- yuba %>% filter(segment == "Daguerre to Feather Segment")
engle_to_dag <- yuba %>% filter(segment == "Englebright to Daguerre Segment")

# what do these look like next to each other
# flow distriubtion
yuba %>% ggplot(aes(Flow, color=segment)) + geom_density() # <- basically the same...
# flow to other cols
plot_ly() %>%
  add_trace(data=dag_to_feather, x=~Flow, y=~ST_Spawn, type='scatter', mode='lines+markers') %>%
  add_trace(data=engle_to_dag, x=~Flow, y=~ST_Spawn, type='scatter', mode='lines+markers')

# here we interpolate and add additional values for low cfs on segment between Englebright to Daguerre Segment
# which values are these?
dag_to_feather %>% filter(Flow < 400)
addins_to_engle_to_dag <- engle_to_dag %>% filter(Flow == 400)

engle_to_dag_below_400 <- dag_to_feather %>% filter(Flow < 400) %>%
  mutate(SR_Spawn=addins_to_engle_to_dag$SR_Spawn,
         FR_Spawn=addins_to_engle_to_dag$FR_Spawn,
         ST_Spawn=addins_to_engle_to_dag$ST_Spawn,
         FR_SR_fry=addins_to_engle_to_dag$FR_SR_fry,
         ST_fry=addins_to_engle_to_dag$ST_fry,
         FR_SR_juv=addins_to_engle_to_dag$FR_SR_juv,
         ST_juv=addins_to_engle_to_dag$ST_juv,
         miles=addins_to_engle_to_dag$miles,
         segment=addins_to_engle_to_dag$segment)

yuba_with_additional_engle_to_dag <- bind_rows(
  yuba,
  engle_to_dag_below_400
)

# the zig-zag stuff at the end can be collpsed by just interpolation
# here we use the values over 3100 to interpolate linearly ()
approx_dag_to_feather <- function(df, col, value) {
  x = df$Flow
  y = df[col] %>% dplyr::pull()
  f <- approxfun(x, y)
  f(value)
}

dag_to_feather_tail <- tail(dag_to_feather, 5)
values_to_interpolate <- c(3100, 3500, 3900,4300)

sr_spawn <- approx_dag_to_feather(dag_to_feather_tail, "SR_Spawn", values_to_interpolate)
fr_spawn <- approx_dag_to_feather(dag_to_feather_tail, "FR_Spawn", values_to_interpolate)
st_spawn <- approx_dag_to_feather(dag_to_feather_tail, "ST_Spawn", values_to_interpolate)
fr_sr_fry <- approx_dag_to_feather(dag_to_feather_tail, "FR_SR_fry", values_to_interpolate)
st_fry <- approx_dag_to_feather(dag_to_feather_tail, "ST_fry", values_to_interpolate)
fr_sr_juv <- approx_dag_to_feather(dag_to_feather_tail, "FR_SR_juv", values_to_interpolate)
st_juv <- approx_dag_to_feather(dag_to_feather_tail, "ST_juv", values_to_interpolate)

dag_to_feather_interpolated <- tibble(
  "Flow" =values_to_interpolate,
  "SR_Spawn" = sr_spawn,
  "FR_Spawn" = fr_spawn,
  "ST_Spawn" = st_spawn,
  "FR_SR_fry" = fr_sr_fry,
  "ST_fry" = st_fry,
  "FR_SR_juv" = fr_sr_juv,
  "ST_juv" = st_juv,
  "miles" = 11.4
)

yuba_witn_interpolated <- bind_rows(
  yuba_with_additional_engle_to_dag,
  dag_to_feather_interpolated
)

yuba_river_instream <- yuba_witn_interpolated %>%
  gather(species_stage, WUA, -Flow, -miles, -segment) %>%
  rename(flow_cfs = Flow) %>%
  filter(!is.na(WUA)) %>%
  group_by(species_stage, flow_cfs) %>%
  mutate(total_reach_length = sum(miles)) %>%
  summarise(WUA = sum(WUA) / max(total_reach_length) / 5.28) %>%
  ungroup() %>%
  spread(species_stage, WUA) %>%
  mutate(watershed = 'Yuba River') %>%
  rename(
    FR_spawning = FR_Spawn,
    SR_spawning = SR_Spawn,
    ST_spawning = ST_Spawn
  )

devtools::use_data(yuba_river_instream, overwrite = TRUE)


# delta
delta <- read_csv('data-raw/north_delta_instream.csv', skip = 1)

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


american <- read_csv("data-raw/american_river_instream.csv", skip =1)

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
battle_creek_instream <- battle_creek_instream %>%
  select(flow_cfs,
         FR_spawn_wua = spawn_WUA,
         FR_fry_wua = fry_WUA,
         FR_juv_wua = juv_WUA,
         adult_trout_wua = adult_trout_WUA,
         watershed)

devtools::use_data(battle_creek_instream, overwrite = TRUE)

# bear river
bear_river_instream <- bear_river_instream %>%
  select(flow_cfs,
         FR_spawn_wua = spawn_WUA,
         FR_juv_wua = juv_WUA,
         watershed)

devtools::use_data(bear_river_instream, overwrite = TRUE)


# butte creek
butte_creek_instream <- butte_creek_instream %>%
  select(flow_cfs,
         FR_spawn_wua = spawn_WUA,
         FR_fry_wua = fry_WUA,
         FR_juv_wua = juv_WUA,
         adult_trout_WUA,
         watershed)

devtools::use_data(butte_creek_instream, overwrite = TRUE)

# calaveras river
calaveras_river_instream <- calaveras_river_instream %>%
  select(flow_cfs,
         FR_spawn_wua = spawn_WUA,
         FR_fry_wua = fry_WUA,
         FR_juv_wua = juv_WUA,
         watershed)

devtools::use_data(calaveras_river_instream, overwrite = TRUE)

# clear creek
clear_creek_instream

# cottonwood creek
cottonwood_creek_instream

# cow creek
cow_creek_instream <- cow_creek_instream %>%
  select(flow_cfs,
         FR_fry_wua = fry_WUA,
         FR_juv_wua = juv_WUA,
         watershed)

devtools::use_data(cow_creek_instream, overwrite = TRUE)

# feather river
feather_river_instream <- feather_river_instream %>%
  select(flow_cfs,
         FR_spawn_wua = spawn_WUA,
         FR_fry_wua = fry_WUA,
         FR_juv_wua = juv_WUA,
         watershed)

devtools::use_data(feather_river_instream, overwrite = TRUE)

# lower sac
lower_sacramento_instream <- lower_sacramento_instream %>%
  select(flow_cfs,
         FR_juv_wua = juv_WUA,
         watershed)

devtools::use_data(lower_sacramento_instream, overwrite = TRUE)

# merced
merced_river_instream <- merced_river_instream  %>%
  select(flow_cfs,
         FR_spawn_wua = spawn_WUA,
         FR_fry_wua = fry_WUA,
         FR_juv_wua = juv_WUA,
         adult_steelhead_WUA,
         watershed)

devtools::use_data(merced_river_instream, overwrite = TRUE)

# moke
mokelumne_river_instream <- mokelumne_river_instream %>%
  select(flow_cfs,
         FR_spawn_wua = spawn_WUA,
         FR_fry_wua = fry_WUA,
         FR_juv_wua = juv_WUA,
         watershed)

devtools::use_data(mokelumne_river_instream, overwrite = TRUE)

# stan
stanislaus_river_instream

# tuo
tuolumne_river_instream <- tuolumne_river_instream %>%
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

# upper mid
upper_mid_sacramento_instream















