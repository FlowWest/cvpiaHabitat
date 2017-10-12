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
  "FR_SR_Spawn" = fr_sr_fry,
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
  mutate(watershed = 'Yuba River')

devtools::use_data(yuba_river_instream)

# how do the two methods compare?
plot_ly() %>%
  add_trace(data=yuba_method1, x=~flow_cfs, y=~FR_Spawn, type='scatter', mode='lines+markers') %>%
  add_trace(data=yuba_method2, x=~flow_cfs, y=~FR_Spawn, type='scatter', mode='lines+markers') %>%
  add_trace(data=yuba_river_instream, x=~flow_cfs, y=~FR_Spawn, type='scatter', mode='lines+markers')



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
  select(flow_cfs, FR_spawning, ST_spawning, watershed)


devtools::use_data(american_river_instream, overwrite = TRUE)

# plot qa/qc

plot_ly() %>%
  add_trace(data=american_river_instream, x=~flow_cfs,
            y=~FR_spawning, type='scatter', mode='lines+markers', name="1") %>%
  add_trace(data=american_river_instream, x=~flow_cfs,
            y=~ST_spawning, type='scatter', mode='lines+markers', name="2") %>%
  add_trace(data=american, type='scatter', mode='lines+markers', color=~species,
            name='american', x=~Flow, y=~wua)

american_river_instream %>% ggplot(aes(flow_cfs, FR_spawning)) + geom_line() +
  geom_line(aes(x=flow_cfs, y=ST_spawning))

american %>%
  ggplot(aes(Flow, wua, color=species)) + geom_line()
