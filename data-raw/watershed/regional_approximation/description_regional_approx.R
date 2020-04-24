library(tidyverse)
library(readxl)
library(glue)

print_regional_approx <- function(watershed_name) {

  return(
    glue( ' No watershed specific instream spawning or rearing habitat data was',
          ' available for {watershed_name}. Instream spawning and rearing data for',
          ' {watershed_name} to use in the DSM was developed using a [regional',
          ' approximation](http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/Regional_Approximation.html) for similar watersheds in the Upper-mid Sacramento River',
          ' Region with habitat modeling.' )
    )
}



