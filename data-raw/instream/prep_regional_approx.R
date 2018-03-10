library(tidyverse)
library(purrr)
library(lubridate)

cvpiaHabitat::modeling_exist %>%
  group_by(Region) %>%
  summarise(n())

# create cache for Upper-mid Sacramento River --------
watersheds_with_modeling <- dplyr::pull(dplyr::filter(cvpiaHabitat::modeling_exist,
                                                      Region == 'Upper-mid Sacramento River',
                                                      FR_fry, Watershed != 'Cottonwood Creek',
                                                      Watershed != 'Upper-mid Sacramento River'), Watershed)

watersheds_without_modeling <- dplyr::pull(dplyr::filter(cvpiaHabitat::modeling_exist,
                                                         Region == 'Upper-mid Sacramento River',
                                                         !FR_fry), Watershed)

# explore flow range of modeling
model_flow_summary <- function(df) {summary(pull(df, flow_cfs))}

model_flow_summary(cvpiaHabitat::battle_creek_instream)
model_flow_summary(cvpiaHabitat::butte_creek_instream)
model_flow_summary(cvpiaHabitat::clear_creek_instream)
model_flow_summary(cvpiaHabitat::cow_creek_instream)


# create list of wua (sq ft/1000 ft) approximators for each watershed in region
get_approx_fry <- function(df) {approxfun(df$flow_cfs, df$FR_fry_wua, rule = 2)}
get_approx_juv <- function(df) {approxfun(df$flow_cfs, df$FR_juv_wua, rule = 2)}

upmidsac_juv <- list(get_approx_juv(cvpiaHabitat::battle_creek_instream),
     get_approx_juv(cvpiaHabitat::butte_creek_instream),
     get_approx_juv(cvpiaHabitat::clear_creek_instream),
     get_approx_juv(cvpiaHabitat::cow_creek_instream))

upmidsac_fry <- list(get_approx_fry(cvpiaHabitat::battle_creek_instream),
                     get_approx_fry(cvpiaHabitat::butte_creek_instream),
                     get_approx_fry(cvpiaHabitat::clear_creek_instream),
                     get_approx_fry(cvpiaHabitat::cow_creek_instream))

# get mean wua for region at 100 cfs


cvpiaFlow::flows_cfs %>%
  gather(watershed, flow, -date) %>%
  filter(watershed %in% watersheds_without_modeling, month(date) %in% 1:8) %>%
  group_by(watershed) %>%
  summarise(min = min(flow), median = median(flow), mean = mean(flow),
            q90 = quantile(flow, .9), max = max(flow))

cvpiaFlow::flows_cfs %>%
  gather(watershed, flow, -date) %>%
  filter(watershed %in% watersheds_with_modeling, month(date) %in% 1:8) %>%
  group_by(watershed) %>%
  summarise(min = min(flow), median = median(flow), mean = mean(flow),
            q90 = quantile(flow, .9), max = max(flow))

flows <- cvpiaHabitat::clear_creek_instream$flow_cfs

upper_mid_sac_region_instream <- purrr::map_df(flows, function(flow) {
  wua_fry <- mean(purrr::map_dbl(1:length(upmidsac_fry), function(i){upmidsac_fry[[i]](flow)}))
  wua_juv <- mean(purrr::map_dbl(1:length(upmidsac_juv), function(i){upmidsac_juv[[i]](flow)}))
  tibble(flow_cfs = flow, FR_fry_wua = wua_fry, FR_juv_wua = wua_juv, watershed = 'Upper-mid Sacramento River Region')
})

ggplot(upper_mid_sac_region_instream, aes(x = flow, y = mean_wua)) +
  geom_line()

bind_rows(cvpiaHabitat::battle_creek_instream,
     cvpiaHabitat::butte_creek_instream,
     cvpiaHabitat::clear_creek_instream,
     cvpiaHabitat::cow_creek_instream,
     upper_mid_sac_region_instream) %>%
  ggplot(aes(x = flow_cfs, y= FR_fry_wua, color = watershed)) +
  geom_line() +
  theme_minimal()

# TODO
# the rest-----------
watersheds_without_modeling <- dplyr::pull(dplyr::filter(cvpiaHabitat::modeling_exist,
                                                         Region != 'Upper-mid Sacramento River',
                                                         !FR_juv), Watershed)

cvpiaHabitat::modeling_exist %>%
  filter(Watershed %in% watersheds_without_modeling) %>%
  select(Watershed, Region, FR_fry, FR_juv)

# american ----
cvpiaHabitat::modeling_exist %>%
  filter(Region == 'Lower Sacramento River') %>%
  select(Watershed, Region, FR_fry, FR_juv)

# cosumnes -----
cvpiaHabitat::modeling_exist %>%
  filter(Region == 'South Delta') %>%
  select(Watershed, Region, FR_fry, FR_juv)

cvpiaHabitat::calaveras_river_floodplain
