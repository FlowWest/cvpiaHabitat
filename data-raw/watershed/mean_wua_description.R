mean_wua_details <- read.csv('data-raw/watershed/mean_wua_values .csv', skip = 1)

print_mean_wua_details <- function(ws) {
  watershed_doc_vars <- filter(mean_wua_details, watershed == ws)

  watershed_area <- mean_wua_details$watershed_area
  watershed_channel_width <- mean_wua_details$channel_width
  watershed_name <- ws

  return(
    glue("No watershed specific salmonid habitat data was available for {watershed_name}.",
         "A regional weighted usable area (WUA) relationship with flow",
         "was derived for {watershed_name} by averaging the WUA values on Battle Creek,",
         "Butte Creek, Clear Creek, Cottonwood Creek and Cow Creek. The ",
         "geomorphic and hydrologic conditions in {watershed_name} (watershed area =",
         " {watershed_area} sqkm, active channel width = {watershed_channel_width})",
         "are similar to those on ",
         "Battle Creek (watershed area = 957; active channel width = Y;",
         "= Z), Butte Creek (watershed area = 2123; active channel width = Y;",
         "); Clear Creek (watershed area = 645; active channel ",
         "width = Y), Cottonwood Creek (watershed area = 2444 sqkm;",
         "active channel width = Y), and Cow Creek (watershed",
         "area = 1107 sqkm; active channel width = Y). The regional WUA",
         "relationships for Bear Creek were multiplied by the length of spawning",
         "and rearing extents mapped by the Science Integration Team (SIT)."
    )
  )
}

print_mean_wua_details('Mokelumne River')

