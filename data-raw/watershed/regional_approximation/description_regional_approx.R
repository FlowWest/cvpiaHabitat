library(tidyverse)
library(readxl)
library(glue)

print_regional_approx <- function(watershed_name) {

  return(
    glue( ' No watershed specific instream spawning or rearing habitat data was
          available for {watershed_name}. Instream spawning and rearing data
          were developed using similar watersheds in the Upper-mid Sacramento River Region to create a [regional
          approximation](http://cvpia-habitat-docs-markdown.s3-website-us-west-2.amazonaws.com/watershed/Regional_Approximation.html).')
  )
}



