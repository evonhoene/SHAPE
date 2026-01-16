#### READING IN SYNTHETIC POPULATIONS AS PARQUET FILES ####
#* IMPORTANT NOTE! Leading zeros from STATE_FIPS, COUNTY_FIPS and TRACT_FIPS are not included since the data type is INTEGER! (e.g., FIPS Code, will be 9)
#* This is ONLY the case for US States with FIPS Codes between 1-9 
  #01       ALABAMA
  #02        ALASKA
  #04        ARIZONA
  #05        ARKANSAS
  #06        CALIFORNIA
  #08        COLORADO
  #09        CONNECTICUT

## Loading neccessary librarys (remember to install them if you have not already)
library(arrow)
library(dplyr)

# Open the dataset (does NOT load data yet)
ds <- open_dataset("C:INSERT REST OF PATH HERE/SHAPE_national_synthetic_population_parquet_2023")

# Load synthetic population for single state (e.g., California = 06)
# Remember that leading zeros are not included since FIPS are integer data types
ca <- ds |>
  filter(STATE_FIPS==6) |>
  collect()

# Load Synthetic population for a specific county (e.g., San Francisco County)
# Remember that leading zeros are not included since FIPS are integer data types (e.g., FIPS code of 06075 will be 6075)
ca_sf <- ds %>%
  filter(STATE_FIPS == 6) %>%  # note: must include state filter since parquet is partitioned accordingly
  collect() %>%
  filter(COUNTY_FIPS ==6075)

# Load Synthetic population for multiple specific counties 
# Remember that leading zeros are not included since FIPS are integer data types
ca_counties <- ds %>%
  filter(STATE_FIPS == 6) %>%  # note: must include state filter since parquet is partitioned accordingly
  collect() %>%
  filter(COUNTY_FIPS %in% c(6075, 6037))

# Load Synthetic population for a specific census tract (e.g., census tract in Alameda county, CA)
# Remember that leading zeros are not included since FIPS are integer data types (e.g., FIPS code of 06037700100 will be 6037700100)
ca_tract <- ds %>%
  filter(STATE_FIPS == 6) %>%  # note: must include state filter since parquet is partitioned accordingly
  collect() %>%
  filter(TRACT_FIPS ==6001400100)

# Convert extracted synthetic population to a .csv file (if needed)
write.csv(ca_tract, "C:/INSERT PATH HERE!.csv")