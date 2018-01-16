-----
<img src="cvpia_logo2.png" align="right" width="40%"/>

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

2D and 1D  
blah  
Mark Gard  

When no modeling exists method...   



<style>.logo{margin-top: 40px;}</style>
<div class = 'logo'>Data Assembled and Maintained by <a href = "http://www.flowwest.com/" target = "_blank"> <img src="TransLogoTreb.png" width="150px"/></div>

