library(tidyverse)
library(lubridate)
library(CDECRetrieve)
library(dataRetrieval)
library(cvpiaHabitat)

cvpiaHabitat::apply_suitability(
  cvpiaHabitat::square_meters_to_acres(
    cvpiaHabitat::set_floodplain_habitat(watershed = 'Cottonwood Creek', species = 'fr', flow = 2000)))

# COTTONWOOD C NR COTTONWOOD CA-------------------
cottonwood <- dataRetrieval::readNWISdv(siteNumbers = '11376000', parameterCd = '00060',
                                  startDate = '1984-01-01', endDate = '2003-12-31')

fp_threshold_flow <- cvpiaHabitat::cottonwood_creek_floodplain$flow_cfs[which(cumsum(cvpiaHabitat::cottonwood_creek_floodplain$FR_floodplain_acres != 0) == 1)]


cottonwood %>%
  select(date = Date, flow_cfs = X_00060_00003) %>%
  # group_by(year = year(date)) %>%
  # summarise(n())
  # arrange(desc(flow_cfs))
  ggplot(aes(x = date, y = flow_cfs)) +
  geom_line()

days_inundated <- cottonwood %>%
  select(date = Date, flow_cfs = X_00060_00003) %>%
  mutate(fp_active = flow_cfs >= fp_threshold_flow) %>%
  group_by(year = year(date), month = month(date)) %>%
  summarise(days_inundated = sum(fp_active),
            monthly_mean_flow = mean(flow_cfs, na.rm = TRUE)) %>%
  mutate(fp_area_acres = cvpiaHabitat::apply_suitability(
    cvpiaHabitat::square_meters_to_acres(
      cvpiaHabitat::set_floodplain_habitat(watershed = 'Cottonwood Creek', species = 'fr', flow = monthly_mean_flow))))


days_inundated %>%
  filter(monthly_mean_flow > fp_threshold_flow) %>%
  ggplot(aes(x = monthly_mean_flow, y = days_inundated)) +
  geom_jitter(pch = 1, width = .2) +
  # geom_vline(xintercept = fp_threshold_flow) +
  theme_minimal() +
  geom_hline(yintercept = 7) +
  geom_hline(yintercept = 14) +
  geom_hline(yintercept = 21) +
  geom_hline(yintercept = 28)
# non linear
# cor(days_inundated$days_inundated, days_inundated$monthly_mean_flow)

days_inundated %>%
  ungroup() %>%
  filter(monthly_mean_flow >= 800) %>%
  pull(days_inundated) %>% summary()

# if cottonwood has floodplain inundation it is usually for 4 weeks

data.frame(
  watershed = rep(c('Cottonwood Creek'), 5),
  weeks_inundated = 0:4,
  flow_threshhold = c(0, NA, NA, NA, 400)
) %>% write_rds('data-raw/floodplain_inundation_thresholds/cottonwood_inundated.rds')
