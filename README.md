<img src="man/figures/cvpia_logo.jpg" align="right" width="40%"/>

### Modeled Habitat Areas
*This package is for estimating spawning and rearing (instream and floodplain) habitat within the Sacramento and San Joaquin river systems for use with the CVPIA salmon life cycle model.*

#### Installation   

``` r
# install.packages("devtools")
devtools::install_github("FlowWest/cvpiaHabitat")
```

#### Usage    

This package provides habitat related datasets to the [`cvpiaData`](https://flowwest.github.io/cvpiaData/) package.

``` r
# determine the spawning habitat area at Cottonwood Creek for Fall Run Chinook at 1567 cfs
set_spawning_habitat("Cottonwood Creek", "fr", 1567)

# determine the juvenile rearing habitat area at Cottonwood Creek for Fall Run Chinook at 1567 cfs
set_instream_habitat("Cottonwood Creek", "fr", "juv", 1567)

# determine the floodplain habitat area at Cottonwood Creek for Fall Run Chinook at 6000 cfs
fp <- set_floodplain_habitat("Cottonwood Creek", "fr", 6000) # total area
apply_suitability(fp) # total suitable area

# explore Cottonwood Creek modeling metadata
?cvpiaHabitat::cottonwood_creek_instream
?cvpiaHabitat::cottonwood_creek_floodplain

```

#### About the Models    

This data package includes flow to suitable habitat area relationships for salmonid (Fall Run, Spring Run - pending, and steelhead - pending) spawning, instream rearing, and floodplain rearing habitat.   

Where available, results from Instream Flow Incremental Methodology (IFIM) studies were used to generate instream spawning and rearing flow to suitable area relationships. For watersheds without IFIM (or comparable) studies, suitable instream areas were scaled from nearby, geomorphically similar watersheds.    

Similarly, where available, results from floodplain hydraulic modeling studies were used to generate floodplain flow to suitable area relationships. Where no modeling studies were available, suitable floodplain area were scaled from nearby, geomorphically similar watersheds. Specific methods and supporting documents for instream and floodplain habitat inputs in every watershed are provided on the reference tab. 


<div style="margin-top: 40px;">Data Assembled and Maintained by <a href = "http://www.flowwest.com/" target = "_blank"> <img src="man/figures/TransLogoTreb.png" width="150px"/></div>

