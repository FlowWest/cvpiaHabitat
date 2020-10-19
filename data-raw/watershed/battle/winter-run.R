library(tidyverse)
library(zoo)

battle_wr <- read_csv("data-raw/watershed/battle/data/spring-run-WUA-mainstem-and-north-fork.csv")

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

props_lookup <- subreach_lens$prop_of_creek
names(props_lookup) <- subreach_lens$reach

# rearing ----------------
wr_juv <- battle_wr %>%
  select(flow, SR_juv, subreach) %>%
  spread(subreach, SR_juv) %>%
  arrange(flow)

# need to fill in the in between values for some of these
# so that when they spread they all have values on aligned cfs
eagle_creek_approx_juv <- approxfun(wr_juv$flow, wr_juv$eagle_creek)
mainstem_approx_juv <- approxfun(wr_juv$flow, wr_juv$mainstem)
feeder_approx_juv <- approxfun(wr_juv$flow, wr_juv$north_battle_feeder)
wildcat_approx_juv <- approxfun(wr_juv$flow, wr_juv$wildcat)

# TODO use the group by to simplify this code
wr_juv_imputed <- wr_juv %>%
  mutate(
    eagle_creek = eagle_creek_approx_juv(flow) * props_lookup["eagle_creek"],
    mainstem = mainstem_approx_juv(flow) * props_lookup["mainstem"],
    north_battle_feeder = feeder_approx_juv(flow) * props_lookup["north_battle_feeder"],
    wildcat = wildcat_approx_juv(flow) * props_lookup["wildcat"]
  ) %>%
  filter(across(everything(), ~!is.na(.x))) %>% # remove cases where any one creeks is NA
  pivot_longer(names_to = "reach", values_to = "wua", cols = eagle_creek:wildcat) %>%
  group_by(flow) %>%
  summarise(
    wua = sum(wua)
  ) %>%
  rename(flow_cfs = flow,
         WR_juv_wua = wua)

View(wr_juv_imputed)

wr_juv_imputed %>%
  ggplot(aes(flow_cfs, WR_juv_wua)) + geom_point()

# fry --------------------------------------------------------
wr_fry <- battle_wr %>%
  select(flow, SR_fry, subreach) %>%
  spread(subreach, SR_fry) %>%
  arrange(flow)

# need to fill in the in between values for some of these
# so that when they spread they all have values on aligned cfs
eagle_creek_approx_fry <- approxfun(wr_fry$flow, wr_fry$eagle_creek)
mainstem_approx_fry <- approxfun(wr_fry$flow, wr_fry$mainstem)
feeder_approx_fry <- approxfun(wr_fry$flow, wr_fry$north_battle_feeder)
wildcat_approx_fry <- approxfun(wr_fry$flow, wr_fry$wildcat)

# TODO use the group by to simplify this code
wr_fry_imputed <- wr_fry %>%
  mutate(
    eagle_creek = eagle_creek_approx_fry(flow) * props_lookup["eagle_creek"],
    mainstem = mainstem_approx_fry(flow) * props_lookup["mainstem"],
    north_battle_feeder = feeder_approx_fry(flow) * props_lookup["north_battle_feeder"],
    wildcat = wildcat_approx_fry(flow) * props_lookup["wildcat"]
  ) %>%
  filter(across(everything(), ~!is.na(.x))) %>% # remove cases where any one creeks is NA
  pivot_longer(names_to = "reach", values_to = "wua", cols = eagle_creek:wildcat) %>%
  group_by(flow) %>%
  summarise(
    wua = sum(wua)
  ) %>%
  rename(flow_cfs = flow,
         wr_fry_wua = wua)

View(wr_fry_imputed)

wr_fry_imputed %>%
  ggplot(aes(flow_cfs, wr_fry_wua)) + geom_point()


# spawning ---------------
wr_spawn <- battle_wr %>%
  select(flow, SR_spawn, subreach) %>%
  spread(subreach, SR_spawn) %>%
  arrange(flow)

# need to fill in the in between values for some of these
# so that when they spread they all have values on aligned cfs
eagle_creek_approx_spawn <- approxfun(wr_spawn$flow, wr_spawn$eagle_creek)
mainstem_approx_spawn <- approxfun(wr_spawn$flow, wr_spawn$mainstem)
feeder_approx_spawn <- approxfun(wr_spawn$flow, wr_spawn$north_battle_feeder)
wildcat_approx_spawn <- approxfun(wr_spawn$flow, wr_spawn$wildcat)

# TODO use the group by to simplify this code
wr_spawn_imputed <- wr_spawn %>%
  mutate(
    eagle_creek = eagle_creek_approx_spawn(flow) * props_lookup["eagle_creek"],
    mainstem = mainstem_approx_spawn(flow) * props_lookup["mainstem"],
    north_battle_feeder = feeder_approx_spawn(flow) * props_lookup["north_battle_feeder"],
    wildcat = wildcat_approx_spawn(flow) * props_lookup["wildcat"]
  ) %>%
  filter(across(everything(), ~!is.na(.x))) %>% # remove cases where any one creeks is NA
  pivot_longer(names_to = "reach", values_to = "wua", cols = eagle_creek:wildcat) %>%
  group_by(flow) %>%
  summarise(
    wua = sum(wua)
  ) %>%
  rename(flow_cfs = flow,
         wr_spawn_wua = wua)

View(wr_spawn_imputed)

wr_spawn_imputed %>%
  ggplot(aes(flow_cfs, wr_spawn_wua)) + geom_point()
