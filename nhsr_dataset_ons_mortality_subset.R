

# Subset ONS deaths data from NHS-R datasets, for demo interactive RMarkdown document
# Hugo Cosh, 20211020

# https://nhsrcommunity.com/blog/nhs-r-community-datasets-package-released/


# Load packages
library(NHSRdatasets)
library(tidyverse)

# Load ONS mortality dataset from NHSR datasets package
data(ons_mortality)

# For reference:  is the ONS weekly deaths publication that the 
# NHS-R ons_mortality dataset it taken from:
# https://www.ons.gov.uk/file?uri=/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/weeklyprovisionalfiguresondeathsregisteredinenglandandwales/2020/previous/v14/referencetablesweek14202013042020165839.xlsx
# This ONS weekly deaths publication was downloaded from here:
# https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/datasets/weeklyprovisionalfiguresondeathsregisteredinenglandandwales/2020


# Subset the data and re-code category 1 and 2 to make it easier to use the 
# data in the interative RMarkdown document

ons_mortality_subset <- ons_mortality %>%
  
  filter(
    date >= "2020-01-01"
    , category_1 %in% c(
      "Total deaths", "Persons", "Males", "Females", "Region"
      , "Deaths where COVID-19 was mentioned on the death certificate (ICD-10 U07.1 and U07.2)")) %>% 
  
  mutate(
    category_1_recoded = case_when(
      category_1 == "Total deaths" ~ "Total deaths, all persons"
      , category_1 == "Persons" ~ "Total deaths, all persons, by age"
      , category_1 == "Males" ~ "Total deaths, males, by age"
      , category_1 == "Females" ~ "Total deaths, females, by age"
      , category_1 == "Region" ~ "Total deaths, all persons, all ages, by region"
      , category_1 == "Deaths where COVID-19 was mentioned on the death certificate (ICD-10 U07.1 and U07.2)" ~ 
        "Deaths involving Covid-19, all persons"
      , TRUE ~ category_1)
    , category_2_recoded = ifelse(is.na(category_2), "all ages", category_2)
  ) 

# Save the subset in .rds format for subsquent loading into the interative 
# RMarkdown document
saveRDS(ons_mortality_subset, "nhs-r_ons_mortality_subset.rds")




