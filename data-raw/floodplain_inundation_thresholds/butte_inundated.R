library(tidyverse)
library(lubridate)
library(CDECRetrieve)
library(dataRetrieval)
library(cvpiaHabitat)

cvpiaHabitat::apply_suitability(
  cvpiaHabitat::square_meters_to_acres(
    cvpiaHabitat::set_floodplain_habitat(watershed = 'Butte Creek', species = 'fr', flow = 500)))

# BUTTE CREEK NR DURHAM-------------------
butte <- CDECRetrieve::cdec_query(stations = 'BCD', sensor_num = '20', dur_code = 'H',
                                      start_date = '1998-01-01', end_date = '2011-12-31')

butte %>%
  mutate(date = as_date(datetime)) %>%
  filter(parameter_value > 0) %>%
  group_by(date) %>%
  summarise(daily_mean_flow = mean(parameter_value, na.rm = TRUE)) %>%
  mutate(fp_active = daily_mean_flow >= fp_threshold_flow) %>%
  group_by(year = year(date)) %>%
  summarise(n())

butte %>%
  mutate(date = as_date(datetime)) %>%
  filter(parameter_value > 0) %>%
  group_by(date) %>%
  summarise(daily_mean_flow = mean(parameter_value, na.rm = TRUE)) %>%
  ggplot(aes(x = date, y = daily_mean_flow)) +
  geom_col()

fp_threshold_flow <- cvpiaHabitat::butte_creek_floodplain$flow_cfs[which(cumsum(cvpiaHabitat::butte_creek_floodplain$FR_floodplain_acres != 0) == 1) - 1]

days_inundated <- butte %>%
  mutate(date = as_date(datetime)) %>%
  filter(parameter_value > 0) %>%
  group_by(date) %>%
  summarise(daily_mean_flow = mean(parameter_value, na.rm = TRUE)) %>%
  mutate(fp_active = daily_mean_flow >= fp_threshold_flow) %>%
  group_by(year = year(date), month = month(date)) %>%
  summarise(days_inundated = sum(fp_active),
            monthly_mean_flow = mean(daily_mean_flow, na.rm = TRUE)) %>%
  mutate(fp_area_acres = cvpiaHabitat::apply_suitability(
    cvpiaHabitat::square_meters_to_acres(
      cvpiaHabitat::set_floodplain_habitat(watershed = 'Butte Creek', species = 'fr', flow = monthly_mean_flow))))

days_inundated %>%
  filter(days_inundated > 0, monthly_mean_flow > fp_threshold_flow) %>%
  ggplot(aes(x = monthly_mean_flow, y = days_inundated)) +
  geom_jitter( width = .2) +
  # geom_vline(xintercept = fp_threshold_flow) +
  theme_minimal() +
  geom_hline(yintercept = 7) +
  geom_hline(yintercept = 14) +
  geom_hline(yintercept = 21) +
  geom_hline(yintercept = 28)
# non linear

dd <- days_inundated %>%
  filter(days_inundated > 0)
ddd <- lm(days_inundated ~ monthly_mean_flow, dd)
summary(ddd)

# if butte has floodplain inundation it is usually for 2 weeks, above 900 its 4 weeks

data.frame(
  watershed = rep(c('Butte Creek'), 5),
  weeks_inundated = 0:4,
  flow_threshhold = c(0, NA, 310, NA, NA)
) %>% write_rds('data-raw/floodplain_inundation_thresholds/butte_inundated.rds')
