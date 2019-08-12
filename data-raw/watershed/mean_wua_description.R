library(tidyverse)
library(readxl)
library(glue)

mean_wua_area <- read.csv('data-raw/watershed/mean_wua_values.csv', skip = 1)


mean_wua_details <- mean_wua_area %>%
  select(watershed, channel_area_sqm, watershed_area_sqkm) %>%
  left_join(cvpiaHabitat::watershed_lengths) %>%
  filter(species == 'fr', lifestage == 'rearing') %>%
  mutate(meters = miles * 1609.34, width = channel_area_sqm/meters) %>%
  select(watershed, watershed_area_sqkm, width) %>%
  unique()

print_mean_wua_details <- function(ws) {
  watershed_doc_vars <- filter(mean_wua_details, watershed == ws)

  area <- watershed_doc_vars$watershed_area_sqkm
  channel_width <- round(watershed_doc_vars$width, digits = 1)
  name <- ws
  return(
    glue("No watershed specific salmonid habitat data was available for {name}.",
         " A regional weighted usable area (WUA) relationship with flow",
         " was derived for {name} by averaging the WUA values on Battle Creek,",
         " Butte Creek, Clear Creek, Cottonwood Creek and Cow Creek. The ",
         "geomorphic and hydrologic conditions in {name} (watershed area =",
         " {area} sqkm, active channel width = {channel_width} meters)",
         " are similar to those on ",
         "Battle Creek (watershed area = 957 sqkm; active channel width = 22.5 m",
         "), Butte Creek (watershed area = 2123 sqkm; active channel width = 15.2 m",
         "), Clear Creek (watershed area = 645 sqkm; active channel ",
         "width = 18 m), Cottonwood Creek (watershed area = 2444 sqkm;",
         " active channel width = 28.25 m), and Cow Creek (watershed",
         " area = 1107 sqkm; active channel width = 8.5 m). The regional WUA",
         " relationships for {name} were multiplied by the length of spawning",
         " and rearing extents mapped by the Science Integration Team (SIT)."
    )
  )
}

