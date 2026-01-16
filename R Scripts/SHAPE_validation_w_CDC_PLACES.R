### VALIDATING SHAPE SMALL AREA ESTIMATES AGAINST CDC PLACES MODEL-BASED ESTIMATES ###

# Load necessary packages (remember to install them if needed)
library(readxl)
library(dplyr)
library(Metrics)
library(purrr)
library(writexl)


#### LEVEL ONE - SMOKING AND OBESITY ###
# Read Excel files
shape <- read_excel("Insert SHAPE estimates file path here.xlsx")
cdc <- read_excel("Insert CDC PLACES estimates file path here.xlsx")

# Parse GEOID column if needed
shape$TractFIPS <- substr(shape$GEOID, nchar(shape$GEOID) - 10, nchar(shape$GEOID))

# Convert unique ID columns to character so join works properly
shape$TractFIPS <- as.character(shape$TractFIPS)
cdc$TractFIPS <- as.character(cdc$TractFIPS)

# Join SHAPE estimates and CDC PLACES datasets
data <- shape %>%
  left_join(cdc, by = "TractFIPS")


# drop any NAs so that calculation of metrics work properly
data <- data %>%
  filter(!is.na(CSMOKING_CrudePrev),
         !is.na(OBESITY_CrudePrev))


# Calculate r, R², and MAE by state for obesity and smoking
obesity_results <- data %>%
  group_by(StateDesc) %>%
  summarise(
    r = cor(perc_sim_obesity, OBESITY_CrudePrev, use = "complete.obs"),
    R2 = r^2,
    MAE = mae(OBESITY_CrudePrev, perc_sim_obesity)
  )

smoking_results <- data %>%
  group_by(StateDesc) %>%
  summarise(
    r = cor(perc_sim_smoker, CSMOKING_CrudePrev, use = "complete.obs"),
    R2 = r^2,
    MAE = mae(CSMOKING_CrudePrev, perc_sim_smoker)
  )

# Calculate metrics for whole dataset for smoking and obesity
obesity_results_all <- data %>%
  summarise(
    r = cor(perc_sim_obesity, OBESITY_CrudePrev, use = "complete.obs"),
    R2 = r^2,
    MAE = mae(OBESITY_CrudePrev, perc_sim_obesity)
  )

# Smoking (whole dataset)
smoking_results_all <- data %>%
  summarise(
    r = cor(perc_sim_smoker, CSMOKING_CrudePrev, use = "complete.obs"),
    R2 = r^2,
    MAE = mae(CSMOKING_CrudePrev, perc_sim_smoker)
  )

#### LEVEL TWO - HEALTH OUTCOMES ###

# Read Excel files
shape <- read_excel("Insert SHAPE estimates file path here .xlsx")
cdc <- read_excel("Insert CDC PLACES estimates file path here.xlsx")

# Parse GEOID column if needed
shape$TractFIPS <- substr(shape$GEOID, nchar(shape$GEOID) - 10, nchar(shape$GEOID))

# Convert unique ID columns to character so join works properly
shape$TractFIPS <- as.character(shape$TractFIPS)
cdc$TractFIPS <- as.character(cdc$TractFIPS)

# Join CDC PLACES and SHAPE estimates datasets
data1 <- shape %>%
  left_join(cdc, by = "TractFIPS")

## FOR EACH HEALTH OUTCOME: filter out any NAs and calculate metrics by state
data <- data1 %>%
  filter(!is.na(BPHIGH_CrudePrev))

# High BP
high_bp_results <- data %>%
  group_by(StateDesc) %>%
  summarise(
    r = cor(perc_sim_high_bp, BPHIGH_CrudePrev, use = "complete.obs"),
    R2 = r^2,
    MAE = mae(BPHIGH_CrudePrev, perc_sim_high_bp)
  )

data <- data1 %>%
  filter(!is.na(HIGHCHOL_CrudePrev))

# High cholestrol
high_chol_results <- data %>%
  group_by(StateDesc) %>%
  summarise(
    r = cor(perc_sim_high_cholesterol, HIGHCHOL_CrudePrev, use = "complete.obs"),
    R2 = r^2,
    MAE = mae(HIGHCHOL_CrudePrev, perc_sim_high_cholesterol)
  )


data <- data1 %>%
  filter(!is.na(ARTHRITIS_CrudePrev))

# Calculate r, R², and MAE by state
arthritis_results <- data %>%
  group_by(StateDesc) %>%
  summarise(
    r = cor(perc_sim_arthritis, ARTHRITIS_CrudePrev, use = "complete.obs"),
    R2 = r^2,
    MAE = mae(ARTHRITIS_CrudePrev, perc_sim_arthritis)
  )

data <- data1 %>%
  filter(!is.na(CASTHMA_CrudePrev))

asthma_results <- data %>%
  group_by(StateDesc) %>%
  summarise(
    r = cor(perc_sim_asthma, CASTHMA_CrudePrev, use = "complete.obs"),
    R2 = r^2,
    MAE = mae(CASTHMA_CrudePrev, perc_sim_asthma)
  )


data <- data1 %>%
  filter(!is.na(CANCER_CrudePrev))

cancer_results <- data %>%
  group_by(StateDesc) %>%
  summarise(
    r = cor(perc_sim_cancer, CANCER_CrudePrev, use = "complete.obs"),
    R2 = r^2,
    MAE = mae(CANCER_CrudePrev, perc_sim_cancer)
  )

data <- data1 %>%
  filter(!is.na(COPD_CrudePrev))

COPD_results <- data %>%
  group_by(StateDesc) %>%
  summarise(
    r = cor(perc_sim_copd, COPD_CrudePrev , use = "complete.obs"),
    R2 = r^2,
    MAE = mae(COPD_CrudePrev, perc_sim_copd)
  )

data <- data1 %>%
  filter(!is.na(CHD_CrudePrev))

heart_results <- data %>%
  group_by(StateDesc) %>%
  summarise(
    r = cor(perc_sim_heart_disease, CHD_CrudePrev , use = "complete.obs"),
    R2 = r^2,
    MAE = mae(CHD_CrudePrev, perc_sim_heart_disease)
  )

data <- data1 %>%
  filter(!is.na(DEPRESSION_CrudePrev))

depress_results <- data %>%
  group_by(StateDesc) %>%
  summarise(
    r = cor(perc_sim_depression, DEPRESSION_CrudePrev , use = "complete.obs"),
    R2 = r^2,
    MAE = mae(DEPRESSION_CrudePrev, perc_sim_depression)
  )

data <- data1 %>%
  filter(!is.na(DIABETES_CrudePrev))

diabetes_results <- data %>%
  group_by(StateDesc) %>%
  summarise(
    r = cor(perc_sim_diabetes, DIABETES_CrudePrev , use = "complete.obs"),
    R2 = r^2,
    MAE = mae(DIABETES_CrudePrev, perc_sim_diabetes)
  )

data <- data1 %>%
  filter(!is.na(STROKE_CrudePrev))

stroke_results <- data %>%
  group_by(StateDesc) %>%
  summarise(
    r = cor(perc_sim_stroke, STROKE_CrudePrev , use = "complete.obs"),
    R2 = r^2,
    MAE = mae(STROKE_CrudePrev, perc_sim_stroke)
  )

## Now calculate the same Metrics, but for all data (instead of by state)

data <- data1 %>%
  filter(!is.na(ARTHRITIS_CrudePrev))

# Arthritis
arthritis_results_all <- data %>%
  summarise(
    r = cor(perc_sim_arthritis, ARTHRITIS_CrudePrev, use = "complete.obs"),
    R2 = r^2,
    MAE = mae(ARTHRITIS_CrudePrev, perc_sim_arthritis)
  )

data <- data1 %>%
  filter(!is.na(CASTHMA_CrudePrev))

# Asthma
asthma_results_all <- data %>%
  summarise(
    r = cor(perc_sim_asthma, CASTHMA_CrudePrev, use = "complete.obs"),
    R2 = r^2,
    MAE = mae(CASTHMA_CrudePrev, perc_sim_asthma)
  )

data <- data1 %>%
  filter(!is.na(CANCER_CrudePrev))

# Cancer
cancer_results_all <- data %>%
  summarise(
    r = cor(perc_sim_cancer, CANCER_CrudePrev, use = "complete.obs"),
    R2 = r^2,
    MAE = mae(CANCER_CrudePrev, perc_sim_cancer)
  )

data <- data1 %>%
  filter(!is.na(COPD_CrudePrev))

# COPD
COPD_results_all <- data %>%
  summarise(
    r = cor(perc_sim_copd, COPD_CrudePrev, use = "complete.obs"),
    R2 = r^2,
    MAE = mae(COPD_CrudePrev, perc_sim_copd)
  )

data <- data1 %>%
  filter(!is.na(CHD_CrudePrev))

# Heart disease
heart_results_all <- data %>%
  summarise(
    r = cor(perc_sim_heart_disease, CHD_CrudePrev, use = "complete.obs"),
    R2 = r^2,
    MAE = mae(CHD_CrudePrev, perc_sim_heart_disease)
  )

data <- data1 %>%
  filter(!is.na(DEPRESSION_CrudePrev))

# Depression
depress_results_all <- data %>%
  summarise(
    r = cor(perc_sim_depression, DEPRESSION_CrudePrev, use = "complete.obs"),
    R2 = r^2,
    MAE = mae(DEPRESSION_CrudePrev, perc_sim_depression)
  )

data <- data1 %>%
  filter(!is.na(DIABETES_CrudePrev))

# Diabetes
diabetes_results_all <- data %>%
  summarise(
    r = cor(perc_sim_diabetes, DIABETES_CrudePrev, use = "complete.obs"),
    R2 = r^2,
    MAE = mae(DIABETES_CrudePrev, perc_sim_diabetes)
  )

data <- data1 %>%
  filter(!is.na(STROKE_CrudePrev))

# Stroke
stroke_results_all <- data %>%
  summarise(
    r = cor(perc_sim_stroke, STROKE_CrudePrev, use = "complete.obs"),
    R2 = r^2,
    MAE = mae(STROKE_CrudePrev, perc_sim_stroke)
  )


# High Cholestrol
data <- data1 %>%
  filter(!is.na(HIGHCHOL_CrudePrev))

high_cholestrol_results_all <- data %>%
  summarise(
    r = cor(perc_sim_high_cholesterol, HIGHCHOL_CrudePrev, use = "complete.obs"),
    R2 = r^2,
    MAE = mae(HIGHCHOL_CrudePrev, perc_sim_high_cholesterol)
  )

# High BP
data <- data1 %>%
  filter(!is.na(BPHIGH_CrudePrev))

high_bp_results_all <- data %>%
  summarise(
    r = cor(perc_sim_high_bp, BPHIGH_CrudePrev, use = "complete.obs"),
    R2 = r^2,
    MAE = mae(BPHIGH_CrudePrev, perc_sim_high_bp)
  )

####### MERGING STATE RESULTS:
# Add a suffix to identify metrics by outcome
smoking_results  <- smoking_results  %>% rename_with(~ paste0("smoking_", .), -StateDesc)
obesity_results  <- obesity_results  %>% rename_with(~ paste0("obesity_", .), -StateDesc)
arthritis_results  <- arthritis_results  %>% rename_with(~ paste0("arthritis_", .), -StateDesc)
asthma_results     <- asthma_results     %>% rename_with(~ paste0("asthma_", .), -StateDesc)
cancer_results     <- cancer_results     %>% rename_with(~ paste0("cancer_", .), -StateDesc)
COPD_results       <- COPD_results       %>% rename_with(~ paste0("copd_", .), -StateDesc)
heart_results      <- heart_results      %>% rename_with(~ paste0("heart_", .), -StateDesc)
depress_results    <- depress_results    %>% rename_with(~ paste0("depress_", .), -StateDesc)
diabetes_results   <- diabetes_results   %>% rename_with(~ paste0("diab_", .), -StateDesc)
stroke_results     <- stroke_results     %>% rename_with(~ paste0("stroke_", .), -StateDesc)
high_bp_results     <- high_bp_results     %>% rename_with(~ paste0("high_bp_", .), -StateDesc)
high_chol_results     <- high_chol_results     %>% rename_with(~ paste0("high_chol_", .), -StateDesc)

# Combine all data frames into a list
all_results <- list(
  smoking_results, 
  obesity_results,
  arthritis_results,
  asthma_results,
  cancer_results,
  COPD_results,
  heart_results,
  depress_results,
  diabetes_results,
  stroke_results,
  high_bp_results,
  high_chol_results
)

# Merge them all by StateDesc
merged_results <- reduce(all_results, full_join, by = "StateDesc")

# Saving validation results (by state) to an excel sheet
write_xlsx(merged_results, "Insert file path here.xlsx")


####### MERGING ALL RESULTS:
overall_results <- bind_rows(
  smoking_results_all%>% mutate(outcome = "Smoking"),
  obesity_results_all%>% mutate(outcome = "Obesity"),
  arthritis_results_all %>% mutate(outcome = "Arthritis"),
  asthma_results_all %>% mutate(outcome = "Asthma"),
  cancer_results_all %>% mutate(outcome = "Cancer"),
  COPD_results_all %>% mutate(outcome = "COPD"),
  heart_results_all %>% mutate(outcome = "Heart Disease"),
  depress_results_all %>% mutate(outcome = "Depression"),
  diabetes_results_all %>% mutate(outcome = "Diabetes"),
  stroke_results_all %>% mutate(outcome = "Stroke"),
  high_cholestrol_results_all %>% mutate(outcome = "High Cholestrol"),
  high_bp_results_all %>% mutate(outcome = "High BP")
) %>%
  select(outcome, everything())

# Saving validation results to an excel sheet
write_xlsx(overall_results, "Insert file path here.xlsx")
