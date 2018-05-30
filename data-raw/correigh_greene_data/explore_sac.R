library(tidyverse)

cvpiaHabitat::upper_sac_ACID_boards_in




sac_instream <- read_csv(file = 'data-raw/correigh_greene_data/sacramento_instream.csv',
                         col_names = c('flow_cfs', 'kes_bat', 'bat_feat', 'feat_free'), skip = 1)

sac_instream %>%
  gather(reach, sq_ft, -flow_cfs) %>%
  mutate(sq_meters = sq_ft * 0.092903) %>%
  ggplot(aes(x = flow_cfs, y = sq_meters, color = reach)) +
  geom_line()


sac_floodplain <- read_csv(file = 'data-raw/correigh_greene_data/sacramento_floodplain.csv',
                           col_names = c('flow_cfs', 'kes_bat', 'bat_feat', 'feat_free'), skip = 1)

sac_floodplain %>%
  gather(reach, sq_ft, -flow_cfs) %>%
  mutate(sq_meters = sq_ft * 0.092903) %>%
  ggplot(aes(x = flow_cfs, y = sq_meters, color = reach)) +
  geom_line()

tibble(
  flow_cfs = sac_floodplain$flow_cfs,
  sq_meters = cvpiaHabitat::set_instream_habitat('Upper Sacramento River', 'fr', 'fry', sac_floodplain$flow_cfs, month = 1)) %>%
  ggplot(aes(x = flow_cfs, y = sq_meters)) +
  geom_line()


sac_floodplain %>%
  select(flow_cfs, kes_bat) %>%
  mutate(sq_meters = kes_bat * 0.092903,
         model = 'corr') %>%
  select(-kes_bat) %>%
  bind_rows(
    tibble(
      flow_cfs = sac_floodplain$flow_cfs,
      sq_meters = cvpiaHabitat::set_floodplain_habitat('Upper Sacramento River', 'fr', sac_floodplain$flow_cfs),
      model = 'gard')) %>%
  ggplot(aes(x = flow_cfs, y = sq_meters, color = model)) +
  geom_line()
