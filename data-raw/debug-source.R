rm(list = ls())
library(cvpiaHabitat)

fry_not_na_index <- which(!is.na(cvpiaHabitat::american_river_instream$FR_fry_wua))[1]
juv_not_na_index <- which(!is.na(cvpiaHabitat::american_river_instream$FR_juv_wua))[1]
spawn_not_na_index <- which(!is.na(cvpiaHabitat::american_river_instream$FR_spawn_wua))[1]

fry_wua <- cvpiaHabitat::american_river_instream$FR_fry_wua[fry_not_na_index]
juv_wua <- cvpiaHabitat::american_river_instream$FR_juv_wua[juv_not_na_index]
spawn_wua <- cvpiaHabitat::american_river_instream$FR_spawn_wua[spawn_not_na_index]

rearing_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                watershed == 'American River' & lifestage == 'rearing'
                                & species == 'fr')$feet
spawning_stream_length <- subset(cvpiaHabitat::watershed_lengths,
                                 watershed == 'American River' & lifestage == 'spawning'
                                 & species == 'fr')$feet

fry_m2 <- (((rearing_stream_length/1000) * fry_wua)/10.7639)
juv_m2 <- (((rearing_stream_length/1000) * juv_wua)/10.7639)
spawn_m2 <- (((spawning_stream_length/1000) * spawn_wua)/10.7639)

fry_flow <- cvpiaHabitat::american_river_instream$flow_cfs[fry_not_na_index]
juv_flow <- cvpiaHabitat::american_river_instream$flow_cfs[juv_not_na_index]
spawn_flow <- cvpiaHabitat::american_river_instream$flow_cfs[spawn_not_na_index]


set_instream_habitat('American River', 'fr', 'fry', fry_flow)


# tibble and dataframe are indexed differently
t <- tibble::tibble(x = 1:10, y = letters[x])
d <- as.data.frame(t)

t[, "y"]
d[, "y"]



