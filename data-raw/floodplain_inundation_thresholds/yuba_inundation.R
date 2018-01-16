library(tidyverse)
library(lubridate)
library(CDECRetrieve)
library(dataRetrieval)
library(cvpiaHabitat)

 cvpiaHabitat::apply_suitability(
  cvpiaHabitat::square_meters_to_acres(
    cvpiaHabitat::set_floodplain_habitat(watershed = 'Yuba River', species = 'fr', flow = 2000)))

# yuba near marysville ca-------------------
yuba <- dataRetrieval::readNWISdv(siteNumbers = '11421000', parameterCd = '00060',
                                  startDate = '1984-01-01', endDate = '2003-12-31')

fp_threshold_flow <- cvpiaHabitat::yuba_river_floodplain$flow_cfs[which(cumsum(cvpiaHabitat::yuba_river_floodplain$FR_floodplain_acres != 0) == 1) - 1]

yuba %>%
  select(date = Date, flow_cfs = X_00060_00003) %>%
  ggplot(aes(x = date, y = flow_cfs)) +
  geom_col()

days_inundated <- yuba %>%
  select(date = Date, flow_cfs = X_00060_00003) %>%
  mutate(fp_active = flow_cfs >= fp_threshold_flow) %>%
  group_by(year = year(date), month = month(date)) %>%
  summarise(days_inundated = sum(fp_active),
         monthly_mean_flow = mean(flow_cfs, na.rm = TRUE)) %>%
  mutate(fp_area_acres = cvpiaHabitat::apply_suitability(
    cvpiaHabitat::square_meters_to_acres(
      cvpiaHabitat::set_floodplain_habitat(watershed = 'Yuba River', species = 'fr', flow = monthly_mean_flow))))



days_inundated %>%
  ggplot(aes(y = monthly_mean_flow, x = days_inundated, color = days_inundated > 0)) +
  geom_jitter(pch = 1, alpha = .5, width = .2) +
  geom_hline(yintercept = fp_threshold_flow) +
  geom_hline(yintercept = 5000) +
  theme_minimal() +
  scale_color_manual(values = c('#666666', '#FF0000'))
# non linear

days_inundated %>%
  ungroup() %>%
  filter(monthly_mean_flow >= 800) %>%
  pull(days_inundated) %>% summary()

# if yuba has floodplain inundation it is usually for 4 weeks

data.frame(
  watershed = rep(c('Yuba River'), 5),
  weeks_inundated = 0:4,
  flow_threshhold = c(0, NA, NA, NA, 800)
) %>% write_rds('data-raw/floodplain_inundation_thresholds/yuba_inundated.rds')

