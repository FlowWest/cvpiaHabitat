library(tidyverse)
library(zoo)

battle_wr_raw <- read_csv("data-raw/watershed/battle/data/winter-run-weighted-composite-battle.csv")

# subreach lenghts (from report)
subreach_lens <- tribble(
  ~reach, ~length_miles,
  "wildcat", 2.5,
  "eagle_creek", 3,
  "north_battle_feeder", 4,
  "mainstem", 9
) %>%
  mutate(
    prop_of_creek = length_miles/sum(length_miles)
  )


battle_wr <- battle_wr_raw %>%
  left_join(subreach_lens, by = c("subreach" = "reach"))


# rearing ----------------
wr_juv <- battle_wr %>%
  select(flow, SR_juv, subreach) %>%
  spread(subreach, SR_juv)

# need to fill in the in between values for some of these
eagle_creek_approx_juv <- approxfun(wr_juv$flow, wr_juv$eagle_creek)
mainstem_approx_juv <- approxfun(wr_juv$flow, wr_juv$mainstem)
feeder_approx_juv <- approxfun(wr_juv$flow, wr_juv$north_battle_feeder)
wildcat_approx_juv <- approxfun(wr_juv$flow, wr_juv$wildcat)

wr_juv_imputed <- battle_wr %>%
  select(flow, SR_juv, subreach) %>%
  pivot_wider(names_from = subreach, values_from = SR_juv) %>%
  mutate(
    eagle_creek = eagle_creek_approx_juv(flow),
    mainstem = mainstem_approx_juv(flow),
    north_battle_feeder = feeder_approx_juv(flow),
    wildcat = wildcat_approx_juv(flow)
  ) %>%
  filter(across(everything(), ~ !is.na(.x))) %>%
  pivot_longer(names_to = "reach", values_to = "wua", cols = wildcat:mainstem) %>%
  left_join(subreach_lens) %>%
  mutate(wua = wua * prop_of_creek) %>%
  group_by(flow) %>%
  summarise(
    wua = sum(wua)
  )

wr_fry <- battle_wr %>%
  select(flow, SR_fry, subreach) %>%
  spread(subreach, SR_fry)

# need to fill in the in between values for some of these
eagle_creek_approx_fry <- approxfun(wr_fry$flow, wr_fry$eagle_creek)
mainstem_approx_fry <- approxfun(wr_fry$flow, wr_fry$mainstem)
feeder_approx_fry <- approxfun(wr_fry$flow, wr_fry$north_battle_feeder)
wildcat_approx_fry <- approxfun(wr_fry$flow, wr_fry$wildcat)

wr_fry_imputed <- battle_wr %>%
  select(flow, SR_fry, subreach) %>%
  spread(subreach, SR_fry) %>%
  mutate(
    eagle_creek = eagle_creek_approx_fry(flow),
    mainstem = mainstem_approx_fry(flow),
    north_battle_feeder = feeder_approx_fry(flow),
    wildcat = wildcat_approx_fry(flow)
  )


# spawning ---------------
