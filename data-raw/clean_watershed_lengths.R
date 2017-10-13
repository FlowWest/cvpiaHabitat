library(tidyverse)
library(devtools)

watershed_lengths <- read_csv('data-raw/FR_chinook_habitat_extents.csv', skip = 1) %>%
  arrange(Id) %>%
  mutate(species = "Fall Run Chinook") %>%
  rename(order = Id, watershed = River, lifestage = Habitat, source = Source)

use_data(watershed_lengths)
