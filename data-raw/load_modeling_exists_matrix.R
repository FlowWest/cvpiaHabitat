library(tidyverse)
library(readxl)

# create catalogue of modeling
modeling_exist <- read_csv('data-raw/modeling_exists.csv')

devtools::use_data(modeling_exist, overwrite = TRUE)


modeling_exist %>% View
