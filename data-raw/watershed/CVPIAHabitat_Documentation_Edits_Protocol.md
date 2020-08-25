---
title: "CVPIA Habitat Documentation Edits Protocol"
subtitle: "Instructions for updating Rmd files"
author: "[Isabelle Kavanagh](mailto:isabellekavanagh@berkeley.edu)"
date: "July 17, 2020"
output: html_document
---

## General Workflow

1. Navigate to the cvpiaHabitat repo in terminal 
2. Create a new branch off of master called "updates/[watershed_name]"
3. Make all edits on this branch 
4. Commit each individual edit with a detailed description of what was changed 
5. Once finished, create a pull request for this branch to Sadie or Emanuel 

## General Tips 

1. Write new descriptions in third person (no we) 
2. Check for the grammar mistake of “data are” instead of “data is” 
3. Check that acronyms are defined upon their first mention in the document (ex: SIT = Science Integration Team, WUA = weighted         usable area, DSM = Decision Support Model) 
4. If the data improvements specified in the “Future Data Improvements” section are completed, delete the relevant bullet points 

## Modeling_exists Spreadsheet Specifications 

**Spreadsheet location:** cvpiaHabitat > data-raw > modeling_exists.csv 

**Spreadsheet description:** This spreadsheet indicates if modeling exists for each species and each life stage in every watershed. The columns are broken into Fall Run (FR), Spring Run (SR), and Steelhead (ST), and then broken into spawning, fry, juvenile, and for Steelhead, adult (ST_adult). There are also 3 columns that specify whether or not rearing, spawning, or floodplain regional approximations were used in the absence of modeling data. **It is important to update this spreadsheet if new modeling becomes available**. 

* **NA:** the species is not present in the watershed
* **FALSE:** the species is present, but habitat modeling does not exist for the stream – typically estimated using a proxy species or scaling method 
* **TRUE:** the species is present and habitat modeling exists


## Instructions for when the data *source* is changed or updated 
For example, the CVPIA Annual Progress Report is updated annually, and hence the link in the "Data Source" section of the Rmd file must be updated. 

1. Upload the data source pdf to AWS in the s3 bucket named [“cvpiahabitat-r-package/cvpia-sit-model-inputs”](https://s3.console.aws.amazon.com/s3/buckets/cvpiahabitat-r-package/cvpia-sit-model-inputs/?region=us-west-2&tab=overview)
2. Click "Next" to set permissions for the document > under "Manage Public Permissions" select "Grant public read access to this        object(s)"
3. Click "Next" to set properties for the document > under "Storage class" select "Standard-IA" for long-lived, infrequently  accessed data  
4. Click "Upload" 
5. Click on the document in AWS and copy paste the link provided into the respective Rmd file under the "Data Source" section (add pages numbers where data are located) **and** within the description underneath if present 
6. Change wording of data source in description if necessary 


## Instructions for when the data *itself* (habitat modeling output) is changed or updated 
For example, if new data are presented for a certain species/life stage or the previous data are edited. 

1. Download new data as a csv file and move file to appropriate location: 
  * if data is from Mark Gard: move file to cvpiaHabitat > data-raw > mark_gard_data
  * otherwise: move file to cvpiaHabitat > data-raw > watershed > [watershed_name] > data 
2. Check data availability & structures (units, columns, organization, column headers, additional scaling calculations, etc.) to make sure appropriate for being read into R 
  * if more information is needed to use the data, reach out to the person/organization who provided the data
  * if there are organizational errors you can fix yourself for R compatibility, do so 
3. Open respective Rmd file: cvpiaHabitat > data-raw > watershed > [watershed_name] > [watershed_name].Rmd 
4. Update path being read into the read.csv function with new file name 
5. Edit code as necessary to accommodate new data format and be able to create a table with appropriate column headers, units, filled in rows, etc. 
6. Check that the column titles in the tables conform to naming conventions (see below), and that all column titles are represented in the "Header Descriptions" section above each table 
7. Build the plots and check that they look accurate: the species names/life stages in the plots are correct, units are correct, axis titles are correct, color coding is correct, data visualization looks reasonable  
6. If the source includes data on a species not previously represented, ensure that the species is added to data tables and plots 
7. Collaborate with Mark Tompkins to update description above the edited data table to reflect the changes: what type of modeling was done, what software was used, how/where/when the data were collected, who collected it, etc. 
8. Update modeling_exists spreadsheet if necessary (see above for details) 

## Naming Conventions
*Fry & Juvenile are two different rearing stages.* 

* flow_cfs: flow in cubic feet per second 
* watershed: section of stream modeled for CVPIA SDM 
* FR_spawn_wua: Fall Run Chinook Spawning WUA
* FR_juv_wua: Fall Run Chinook Juvenile WUA
* FR_fry_wua: Fall Run Chinook Fry WUA
* FR_floodplain_acres: Fall Run Chinook Floodplain Acres
* SR_spawn_wua: Spring Run Chinook Spawning WUA
* SR_juv_wua: Spring Run Chinook Juvenile WUA
* SR_fry_wua: Spring Run Chinook Fry WUA
* SR_floodplain_acres: Spring Run Chinook Floodplain Acres
* ST_spawn_wua: Steelhead Spawning WUA
* ST_juv_wua: Steelhead Juvenile WUA
* ST_fry_wua: Steelhead Fry WUA
* ST_adult_wua: Steelhead Adult WUA 
* ST_floodplain_acres: Steelhead Floodplain Acres 
