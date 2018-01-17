library(tidyverse)
library(lubridate)
library(CDECRetrieve)
library(dataRetrieval)
library(cvpiaHabitat)

cvpiaHabitat::apply_suitability(
  cvpiaHabitat::square_meters_to_acres(
    cvpiaHabitat::set_floodplain_habitat(watershed = 'Elder Creek', species = 'fr', flow = 2000)))

# ELDER C NR PASKENTA CA-------------------
elder <- dataRetrieval::readNWISdv(siteNumbers = '11379500', parameterCd = '00060',
                                   startDate = '1984-01-01', endDate = '2003-12-31')

fp_threshold_flow <- cvpiaHabitat::elder_creek_floodplain$flow_cfs[which(cumsum(cvpiaHabitat::elder_creek_floodplain$FR_floodplain_acres != 0) == 1) - 1]


elder %>%
  select(date = Date, flow_cfs = X_00060_00003) %>%
  # group_by(year = year(date)) %>%
  # summarise(n())
  # arrange(desc(flow_cfs))
  ggplot(aes(x = date, y = flow_cfs)) +
  geom_line()

days_inundated <- elder %>%
  select(date = Date, flow_cfs = X_00060_00003) %>%
  mutate(fp_active = flow_cfs >= fp_threshold_flow) %>%
  group_by(year = year(date), month = month(date)) %>%
  summarise(days_inundated = sum(fp_active),
            monthly_mean_flow = mean(flow_cfs, na.rm = TRUE)) %>%
  mutate(fp_area_acres = cvpiaHabitat::apply_suitability(
    cvpiaHabitat::square_meters_to_acres(
      cvpiaHabitat::set_floodplain_habitat(watershed = 'Elder Creek', species = 'fr', flow = monthly_mean_flow))))


days_inundated %>%
  filter(monthly_mean_flow > fp_threshold_flow) %>%
  # filter(days_inundated > 0) %>%
  ggplot(aes(x = monthly_mean_flow, y = days_inundated)) +
  geom_jitter(pch = 1, width = .2) +
  geom_vline(xintercept = fp_threshold_flow) +
  theme_minimal() +
  geom_hline(yintercept = 7) +
  geom_hline(yintercept = 14) +
  geom_hline(yintercept = 21) +
  geom_hline(yintercept = 28)
  # geom_smooth(method = 'lm', se = FALSE)
# non linear
cor(days_inundated$days_inundated, days_inundated$monthly_mean_flow)

days_inundated %>%
  ungroup() %>%
  filter(days_inundated > 0) %>%
  # filter(monthly_mean_flow >= fp_threshold_flow) %>%
  pull(days_inundated) %>% summary()


data.frame(
  watershed = rep(c('Elder Creek'), 5),
  weeks_inundated = 0:4,
  flow_threshhold = c(0, NA, 130, NA, 250)
) %>% write_rds('data-raw/floodplain_inundation_thresholds/elder_inundated.rds')
