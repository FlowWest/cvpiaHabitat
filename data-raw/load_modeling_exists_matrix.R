library(tidyverse)

# create catalogue of modeling
modeling_exist <- read_csv('data-raw/modeling_exists.csv')

usethis::use_data(modeling_exist, overwrite = TRUE)

modeling_exist %>% glimpse
