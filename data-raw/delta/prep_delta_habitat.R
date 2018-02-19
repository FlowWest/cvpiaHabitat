library(tidyverse)
library(lubridate)
library(readxl)

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

south_delta %>%
  separate(col = X__1, into = c('year', 'month'), sep = ' ') %>%
  mutate(date = mdy(paste0(month, ' 1, ', year)))

#details Habitat estimates from Correigh Greene's Winter Run Life Cycle Model
# High quality defined by:
# Channel type: mainstem, distributaries, or open water
# Depth: > 0.2 m and <= 1.5 m
# Cover Vegetated edge
