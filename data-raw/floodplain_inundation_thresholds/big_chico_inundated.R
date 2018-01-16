library(tidyverse)
library(lubridate)
library(CDECRetrieve)
library(dataRetrieval)
library(cvpiaHabitat)

cvpiaHabitat::apply_suitability(
  cvpiaHabitat::square_meters_to_acres(
    cvpiaHabitat::set_floodplain_habitat(watershed = 'Big Chico Creek', species = 'fr', flow = 500)))

# BIG CHICO CREEK NEAR CHICO-------------------
big_chico <- CDECRetrieve::cdec_query(stations = 'BIC', sensor_num = '20', dur_code = 'H',
                                      start_date = '1997-08-01', end_date = '2012-01-31')

big_chico %>%
  mutate(date = as_date(datetime)) %>%
  filter(parameter_value > 0) %>%
  group_by(date) %>%
  summarise(daily_mean_flow = mean(parameter_value, na.rm = TRUE)) %>%
  ggplot(aes(x = date, y = daily_mean_flow)) +
  geom_col()

fp_threshold_flow <- cvpiaHabitat::big_chico_creek_floodplain$flow_cfs[which(cumsum(cvpiaHabitat::big_chico_creek_floodplain$FR_floodplain_acres != 0) == 1) - 1]

days_inundated <- big_chico %>%
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
      cvpiaHabitat::set_floodplain_habitat(watershed = 'Big Chico Creek', species = 'fr', flow = monthly_mean_flow))))

days_inundated %>%
  # filter(days_inundated > 0) %>%
  filter(monthly_mean_flow > fp_threshold_flow) %>%
  ggplot(aes(x = monthly_mean_flow, y = days_inundated)) +
  geom_jitter(width = .2) +
  # geom_vline(xintercept = fp_threshold_flow) +
  theme_minimal() +
  geom_smooth(method = 'lm', se = FALSE) +
  geom_hline(yintercept = 7) +
  geom_hline(yintercept = 14) +
  geom_hline(yintercept = 21) +
  geom_hline(yintercept = 28)
# linearish
d <- filter(days_inundated, monthly_mean_flow > fp_threshold_flow)
ddd <- lm(days_inundated ~ monthly_mean_flow, d)
summary(ddd)
cor(d$days_inundated, d$monthly_mean_flow)



# if big chico has floodplain inundation it is usually for 2 weeks, above 900 its 4 weeks

data.frame(
  watershed = rep(c('Big Chico Creek'), 5),
  weeks_inundated = 0:4,
  flow_threshhold = c(0, NA, 265, NA, 900)
) %>% write_rds('data-raw/floodplain_inundation_thresholds/big_chico_inundated.rds')
