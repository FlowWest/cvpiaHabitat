library(tidyverse)
library(devtools)

species_lookup <- c('fr', 'sr', 'st')
names(species_lookup) <- c("Fall Run Chinook", "Spring Run Chinook", "Steelhead")

watershed_lengths <- read_csv('data-raw/salmonid_habitat_extents.csv') %>%
  arrange(Species, Id) %>%
  mutate(Species = species_lookup[Species]) %>%
  rename(order = Id, watershed = River, lifestage = Habitat, species = Species, source = Source)

use_data(watershed_lengths, overwrite = TRUE)
