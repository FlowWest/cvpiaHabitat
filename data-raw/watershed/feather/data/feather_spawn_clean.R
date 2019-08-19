library(tidyverse)

# digitized from FERC 2004 report https://automeris.io/WebPlotDigitizer/
upper <- read_csv('data-raw/instream/feather/alt_upper_feather_spawn_wua_rsi.csv') %>%
  mutate(location = 'upper')

lower <- read_csv('data-raw/instream/feather/alt_lower_feather_spawn_wua_rsi.csv') %>%
  mutate(location = 'lower')

upper_approx <- approxfun(upper$flow, upper$wua_rsi, rule = 2)
lower_approx <- approxfun(lower$flow, lower$wua_rsi, rule = 2)
min(upper$flow)
min(lower$flow)
max(upper$flow)
max(lower$flow)
length(lower$flow)
length(upper$flow)

# modeled lengths
upper_length <- 8.25 * 5280
lower_length <- 15 * 5280
((upper_approx(med_spawn_flow) * upper_length/1000) + (lower_approx(med_spawn_flow) * lower_length/1000))/43560

tibble(
  flow_cfs = c(200, 500, 750, 1000, 1250, 1500, 1750, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 5500, 6000, 6500, 7000),
  upper_wua = upper_approx(flow_cfs),
  lower_wua = lower_approx(flow_cfs)) %>%
  mutate(FR_spawn_wua = upper_wua * (9.75/18) + lower_wua * (8.25/18)) %>%
  select(flow_cfs, FR_spawn_wua) %>%
  write_csv('data-raw/instream/feather/feather_river_spawning.csv')

cvpiaHabitat::watershed_lengths %>%
  filter(watershed == 'Feather River')

# 18 miles for our mapped spawning
(8.25 + 15) - 18
18 - 8.25
med_spawn_flow <- 2241.379

((upper_approx(med_spawn_flow) * 8.5*5280/1000) + (lower_approx(med_spawn_flow) * 9.75*5280/1000))/43560
wua_lower <- 32796.83
wua_upper <- 7277.629
(wua_lower * (8.25/18) + wua_upper * (9.75/18))* 18*5280/1000/43560

