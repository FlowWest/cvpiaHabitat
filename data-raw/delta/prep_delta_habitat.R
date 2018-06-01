library(tidyverse)
library(lubridate)
library(readxl)
library(devtools)

# read in data ----------------------
south_yolo <- read_excel('data-raw/correigh_greene_data/delta habitat By Region.xlsx', sheet = 3, skip = 1) %>%
  select(X__1, south_yolo = ppp)

north_delta <- read_excel('data-raw/correigh_greene_data/delta habitat By Region.xlsx', sheet = 4, skip = 1)  %>%
  select(X__1, north_delta = ppp)

south_delta <- read_excel('data-raw/correigh_greene_data/delta habitat By Region.xlsx', sheet = 5, skip = 1) %>%
  select(X__1, south_delta = ppp)

north_delta_habitat <- north_delta %>%
  left_join(south_yolo) %>%
  separate(col = X__1, into = c('year', 'month'), sep = ' ') %>%
  mutate(`North Delta` = north_delta + south_yolo,
         date = mdy(paste0(month, ' 1, ', year))) %>%
  select(date, `North Delta`)


north_delta_habitat %>%
  mutate(acres = `North Delta`* 0.000247105,
         day = lubridate::days_in_month(date)) %>%
  # filter(acres > 10000) %>%
  mutate(date = ymd(paste(year(date), month(date), day))) %>%
  left_join( select(cvpiaFlow::delta_flows, date, n_dlt_inflow_cfs)) %>%
  ggplot(aes(x = acres, y = n_dlt_inflow_cfs, color = factor(month(date), levels = 1:12))) +
  geom_point()
  # ggplot(aes(x = date)) +
  # geom_col(aes(y = acres)) +
  # geom_point(aes(y = n_dlt_inflow_cfs)) +
  # labs(y = 'acres')

# 1 sq meter = 0.000247105 acres
nd_year_means <- north_delta_habitat %>%
  group_by(year = year(date)) %>%
  summarise(mean_area = mean(`North Delta`))

nd_means <- tibble(
  date = seq(as.Date('1980-06-01'), as.Date('2010-11-01'), by = 'month')) %>%
  mutate(year = year(date)) %>%
  filter(between(month(date), 6, 11)) %>%
  left_join(nd_year_means) %>%
  select(date, `North Delta` = mean_area)

nd_hab <- north_delta_habitat %>%
  bind_rows(nd_means) %>%
  arrange(date)

north_delta_habitat %>%
  mutate(acres = `North Delta` * 0.000247105,
         year = year(date)) %>%
  filter(between(year, 1980, 1999)) %>%
  ggplot(aes(x = date, y = acres)) +
  geom_boxplot(aes(group = year)) +
  geom_point(aes(color = month.abb[month(date)])) +
  geom_hline(yintercept = 5623.347)

north_delta_habitat %>%
  mutate(acres = `North Delta` * 0.000247105,
         year = year(date),
         month = factor(month(date), levels = c(12, 1:5), labels = month.abb[c(12, 1:5)])) %>%
  filter(between(year, 1980, 1999)) %>%
  ggplot(aes(x = month, y = acres)) +
  geom_boxplot(aes(group = month)) +
  geom_point(size = .2) +
  geom_hline(yintercept = 5623.347)

south_delta_habitat <- south_delta %>%
  separate(col = X__1, into = c('year', 'month'), sep = ' ') %>%
  mutate(date = mdy(paste0(month, ' 1, ', year))) %>%
  select(date, `South Delta` = south_delta)

south_delta_habitat %>%
  summarise(max(date))

sd_year_means <- south_delta_habitat %>%
  group_by(year = year(date)) %>%
  summarise(mean_area = mean(`South Delta`))

sd_means <- tibble(
  date = seq(as.Date('1980-06-01'), as.Date('2010-11-01'), by = 'month')) %>%
  mutate(year = year(date)) %>%
  filter(between(month(date), 6, 11)) %>%
  left_join(sd_year_means) %>%
  select(date, `South Delta` = mean_area)

sd_hab <- south_delta_habitat %>%
  bind_rows(sd_means) %>%
  arrange(date)

delta_habitat <- left_join(nd_hab, sd_hab)

use_data(delta_habitat, overwrite = TRUE)

delta_habitat %>%
  group_by(month(date)) %>%
  summarise(n())

delta_habitat %>%
  filter(month(date) ==1) %>% View


cvpiaFlow::delta_flows %>%
  select(date, n_dlt_inflow_cfs, s_dlt_inflow_cfs) %>%
  filter(between(year(date), 1980, 1999)) %>%
  gather(delta, flow, -date) %>%
  mutate(year = year(date),
         month = factor(month(date), levels = c(12, 1:11), labels = month.abb[c(12, 1:11)])) %>%
  ggplot(aes(x = month, y = flow)) +
  geom_boxplot(aes(group = month)) +
  geom_point(size = .2) +
  facet_wrap(~delta)
