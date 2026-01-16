#### CALCULATING JOINT DISTRIBUTION ESTIMATES FROM SYNTHETIC POPULATIONS ####
#This script can be used to calculate joint distributions (e.g., percentage of population with cancer AND no health insurance AND are aged 65+) in small geographic areas (counties or census tracts)

# Load necessary libraries (remember to install if you have not already)
library(purrr)
library(rlang)
library(arrow)
library(dplyr)
library(writexl)

# Open the synthetic population dataset (does NOT load data yet)
ds <- open_dataset("C:INSERT YOUR FILE PATH HERE!/SHAPE_national_synthetic_population_parquet_2023")

## Calculate joint distributions by CENSUS TRACT (original scale of synthetic population)
# This example shows joint distributions calculated between diagnosed cancer and health disparity groups
summary_data_census_tract <- ds %>%
  group_by(GEOID) %>%
  summarise(
    # Marginal totals
    total_population = n(),
    total_cancer = sum(cancer, na.rm = TRUE),
    # Joint distributions: cancer × sociodemographics
    total_cancer_male        = sum(cancer == 1 & male == 1, na.rm = TRUE),
    total_cancer_income1    = sum(cancer == 1 & income1 == 1, na.rm = TRUE),
    total_cancer_race3      = sum(cancer == 1 & race3 == 1, na.rm = TRUE), # Hispanic
    total_cancer_race2      = sum(cancer == 1 & race2 == 1, na.rm = TRUE), # Black
    total_cancer_age4       = sum(cancer == 1 & age4 == 1, na.rm = TRUE),  # Aged 65+
    total_cancer_uninsured  = sum(cancer == 1 & n_insured == 1, na.rm = TRUE),
    total_cancer_rural      = sum(cancer == 1 & n_urban == 1, na.rm = TRUE),
    total_cancer_nobach     = sum(cancer == 1 & n_bach == 1, na.rm = TRUE)
  ) %>%
  mutate(
    # Joint percentages
    perc_cancer_male       = 100 * total_cancer_male / total_population,
    perc_cancer_income1   = 100 * total_cancer_income1 / total_population,
    perc_cancer_race3     = 100 * total_cancer_race3 / total_population,
    perc_cancer_race2     = 100 * total_cancer_race2 / total_population,
    perc_cancer_age4      = 100 * total_cancer_age4 / total_population,
    perc_cancer_uninsured = 100 * total_cancer_uninsured / total_population,
    perc_cancer_rural     = 100 * total_cancer_rural / total_population,
    perc_cancer_nobach    = 100 * total_cancer_nobach / total_population
  )

# Collecting data from parquet (converting to dataframe)
summary_data_census_tract <- summary_data_census_tract %>% collect()

# Saving joint distribution estimates to an excel sheet 
write_xlsx(summary_data_census_tract, "Insert file path here!.xlsx")

## Calculate joint distributions by COUNTY 
# This example shows joint distributions calculated between arthritis and health disparity groups
# Remember that leading 0s are not included for county FIPS code (e.g., county FIPS code for 01001 will be 1001)
summary_data_county <- ds %>%
  group_by(COUNTY_FIPS) %>%
  summarise(
    # Marginal totals
    total_population = n(),
    total_arthritis = sum(arthritis, na.rm = TRUE),
    
    # Joint distributions: arthritis × sociodemographics
    total_arthritis_male        = sum(arthritis == 1 & male == 1, na.rm = TRUE),
    total_arthritis_income1    = sum(arthritis == 1 & income1 == 1, na.rm = TRUE),
    total_arthritis_race3      = sum(arthritis == 1 & race3 == 1, na.rm = TRUE), # Hispanic
    total_arthritis_race2      = sum(arthritis == 1 & race2 == 1, na.rm = TRUE), # Black
    total_arthritis_age4       = sum(arthritis == 1 & age4 == 1, na.rm = TRUE),  # 65+
    total_arthritis_uninsured  = sum(arthritis == 1 & n_insured == 1, na.rm = TRUE),
    total_arthritis_rural      = sum(arthritis == 1 & n_urban == 1, na.rm = TRUE),
    total_arthritis_nobach     = sum(arthritis == 1 & n_bach == 1, na.rm = TRUE)
  ) %>%
  mutate(
    # Joint percentages
    perc_arthritis_male       = 100 * total_arthritis_male / total_population,
    perc_arthritis_income1   = 100 * total_arthritis_income1 / total_population,
    perc_arthritis_race3     = 100 * total_arthritis_race3 / total_population,
    perc_arthritis_race2     = 100 * total_arthritis_race2 / total_population,
    perc_arthritis_age4      = 100 * total_arthritis_age4 / total_population,
    perc_arthritis_uninsured = 100 * total_arthritis_uninsured / total_population,
    perc_arthritis_rural     = 100 * total_arthritis_rural / total_population,
    perc_arthritis_nobach    = 100 * total_arthritis_nobach / total_population
  )

# Collecting data from parquet (converting to dataframe)
summary_data_county <- summary_data_county %>% collect()

# Saving joint distribution estimates to an excel sheet 
write_xlsx(summary_data_county, "Insert file path here!.xlsx")