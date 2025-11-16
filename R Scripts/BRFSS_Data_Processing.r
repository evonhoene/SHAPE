### CDC NHIS 2024 Data Processing and Regression Analysis ###

## Load required libraries
library(readxl)
library(readr)
library(writexl)
library(dplyr)
library(pscl) 
library(writexl)
library(car)

## Read in survey dataset (not the original -- the version for editing)
data <- read_csv("BRFSS_2022.csv")

##################################################################################################

###########################################################################################################################
### Demographics: Gender, Age, Race, Education, Household Income
###########################################################################################################################

## GENDER ##
data <- data %>%
  mutate(
    male = ifelse(SEXVAR == 1, 1, 0),
    female = ifelse(SEXVAR == 2, 1, 0)
  )


## EDUCATION ##
data <- data %>%
  filter(!is.na(EDUCA), EDUCA != 9) %>%
  mutate(
    bach = ifelse(EDUCA == 6, 1, 0),
    n_bach = ifelse(EDUCA %in% 1:5, 1, 0)
  )


## RACE ##
# Adding new columns representing binary for each gender
data <- data %>%
  filter(`_IMPRACE` %in% 1:6) %>%  
  mutate(
    race1 = ifelse(`_IMPRACE` == 1, 1, 0),
    race2 = ifelse(`_IMPRACE` == 2, 1, 0),
    race3 = ifelse(`_IMPRACE` == 5, 1, 0),
    race4 = ifelse(`_IMPRACE` %in% c(3, 4, 6), 1, 0)
  )



## AGE ##
## Adding new binary fields that represent age groups
data <- data %>%
  mutate(age1 = ifelse(`_AGE80`  >= 18 & `_AGE80` <= 29, 1, 0),
         age2 = ifelse(`_AGE80` >= 30 & `_AGE80` <= 49, 1, 0),
         age3 = ifelse(`_AGE80` >= 50 & `_AGE80` <= 64, 1, 0),
         age4 = ifelse(`_AGE80` >= 65, 1, 0))

## INCOME ##
## Adding new binary fields that represent income groups
data <- data %>%
  filter(!is.na(INCOME3), !INCOME3 %in% c(77, 99)) %>%  
  mutate(
    income1 = ifelse(INCOME3 %in% c(1, 2, 3, 4), 1, 0), #<25K
    income2 = ifelse(INCOME3 %in% c(5, 6), 1, 0),       #25-50K
    income3 = ifelse(INCOME3 %in% c(7,8), 1, 0),       #50-100K
    income4 = ifelse(INCOME3 %in% c(9,10,11), 1, 0)         #100K+
  )

## URBAN ##
data <- data %>%
  filter(!is.na(`_URBSTAT`)) %>%           
  mutate(
    urban = ifelse(`_URBSTAT` == 1, 1, 0)  
  )

data <- data %>%
  mutate(n_urban = ifelse(urban == 0, 1, 0))

## INSURANCE ##
data <- data %>%
  filter(!is.na(`_HLTHPLN`), `_HLTHPLN` != 9) %>%
  mutate(
    insured = ifelse(`_HLTHPLN` == 1, 1, 0)
  )
data <- data %>%
  mutate(n_insured = ifelse(insured == 0, 1, 0))

###########################################################################################################################
### HEALTH RISK BEHAVIORS
###########################################################################################################################
## Binge drinking ##
data <- data %>%
  filter(`_RFBING6` != 9) %>%           
  mutate(
    binge_drinking = ifelse(`_RFBING6` == 2, 0, 1)  
  )

data <- data %>%
  mutate(n_binge_drinking = ifelse(binge_drinking == 0, 1, 0))

## Smoking ##
data <- data %>%
  filter(`_SMOKER3` != 9) %>%  
  mutate(
    smoker = ifelse(`_SMOKER3` %in% c(1, 2), 1, 0)  
  )

data <- data %>%
  mutate(n_smoker = ifelse(smoker == 0, 1, 0))

## Leisure time ##
data <- data %>%
  filter(`_TOTINDA` != 9) %>%  
  mutate(
    leisure_time = ifelse(`_TOTINDA` == 1, 1, 0)  
  )

data <- data %>%
  mutate(n_leisure_time = ifelse(leisure_time == 0, 1, 0))


###########################################################################################################################
### HEALTH OUTCOMES
###########################################################################################################################
## Arthritis ##
data <- data %>%
  filter(!is.na(HAVARTH4), !HAVARTH4 %in% c(7, 9)) %>% 
  mutate(
    arthritis = ifelse(HAVARTH4  == 1, 1, 0))

data <- data %>%
  mutate(
    n_arthritis = ifelse(arthritis == 0, 1, 0))

## Asthma ##
data <- data %>%
  filter(`_CASTHM1` != 9) %>% 
  mutate(
    asthma = ifelse(`_CASTHM1`  == 1, 0, 1))

data <- data %>%
  mutate(n_asthma = ifelse(asthma == 0, 1, 0))

## cancer ##
data <- data %>%
  filter(!is.na(CHCSCNC1), !is.na(CHCOCNC1), !CHCSCNC1 %in% c(7, 9), !CHCOCNC1 %in% c(7, 9)) %>% 
  mutate(
    cancer = ifelse(CHCOCNC1 == 1 & CHCSCNC1 == 2, 1, 0))

data <- data %>%
  mutate(n_cancer = ifelse(cancer == 0, 1, 0))

## high cholesterol ## ### not included iin 2024,22!
data <- data %>%
  filter(!is.na(TOLDHI3), !TOLDHI3 %in% c(7, 9)) %>% 
  mutate(
    high_cholesterol = ifelse(TOLDHI3  == 1, 1, 0))

data <- data %>%
  mutate(
    n_high_cholesterol = ifelse(high_cholesterol == 0, 1, 0))

## high bp ##  ### not included iin 2024,22!
data <- data %>%
  filter(!is.na(BPHIGH6), !BPHIGH6 %in% c(7, 9)) %>% 
  mutate(
    high_bp = ifelse(BPHIGH6  == 1, 1, 0))

data <- data %>%
  mutate(
    n_high_bp = ifelse(high_bp == 0, 1, 0))

## kidney disease ##
data <- data %>%
  filter(!is.na(CHCKDNY2), !CHCKDNY2 %in% c(7, 9)) %>% 
  mutate(
    kidney_disease = ifelse(CHCKDNY2  == 1, 1, 0))

data <- data %>%
  mutate(
    n_kidney_disease = ifelse(kidney_disease == 0, 1, 0))

## copd ##
data <- data %>%
  filter(!is.na(CHCCOPD3), !CHCCOPD3 %in% c(7, 9)) %>% 
  mutate(
    copd = ifelse(CHCCOPD3  == 1, 1, 0))

data <- data %>%
  mutate(
    n_copd = ifelse(copd == 0, 1, 0))

## heart disease ##
data <- data %>%
  filter(!is.na(CVDCRHD4), !CVDCRHD4 %in% c(7, 9)) %>% 
  mutate(
    heart_disease = ifelse(CVDCRHD4  == 1, 1, 0))

data <- data %>%
  mutate(
    n_heart_disease = ifelse(heart_disease == 0, 1, 0))

## depression ##
data <- data %>%
  filter(!is.na(ADDEPEV3), !ADDEPEV3 %in% c(7, 9)) %>% 
  mutate(
    depression = ifelse(ADDEPEV3  == 1, 1, 0))

data <- data %>%
  mutate(
    n_depression = ifelse(depression == 0, 1, 0))

## diabetes ##
data <- data %>%
  filter(!is.na(DIABETE4), !DIABETE4 %in% c(7, 9)) %>% 
  mutate(
    diabetes = ifelse(DIABETE4  == 1, 1, 0))

data <- data %>%
  mutate(
    n_diabetes = ifelse(diabetes == 0, 1, 0))

## obesity ##
data <- data %>%
  filter(!is.na(`_BMI5CAT`)) %>%
  mutate(
    obesity = ifelse(`_BMI5CAT`  == 4, 1, 0))

data <- data %>%
  mutate(n_obesity = ifelse(obesity == 0, 1, 0))

## stroke ##
data <- data %>%
  filter(!is.na(CVDSTRK3), !CVDSTRK3 %in% c(7, 9)) %>% 
  mutate(
    stroke = ifelse(CVDSTRK3  == 1, 1, 0))

data <- data %>%
  mutate(
    n_stroke = ifelse(stroke == 0, 1, 0))

###########################################################################################################################
### ID
###########################################################################################################################
data <- data %>%
  mutate(ID = row_number())

###########################################################################################################################
### save processed data
###########################################################################################################################
#all outcomes
new_df <- data %>%
  select(ID, `_STATE`, age1, age2, age3, age4, race1, race2, race3, race4, bach, n_bach, male, female, income1, income2, income3, income4, insured, n_insured, urban, n_urban,
         binge_drinking, n_binge_drinking, smoker, n_smoker, leisure_time, n_leisure_time,
         arthritis, asthma, cancer, high_cholesterol, high_bp, kidney_disease, copd, heart_disease, depression, diabetes, obesity, n_obesity, stroke)

#without high chol. and bp.
new_df <- data %>%
  select(ID, `_STATE`, age1, age2, age3, age4, race1, race2, race3, race4, bach, n_bach, male, female, income1, income2, income3, income4, insured, n_insured, urban, n_urban,
       binge_drinking, n_binge_drinking, smoker, n_smoker, leisure_time, n_leisure_time,
       arthritis, asthma, cancer, kidney_disease, copd, heart_disease, depression, diabetes, obesity, n_obesity, stroke)

anyNA(new_df)

write.csv(new_df, "brfss_2022_PROCESSED_CLEANED.csv")

# strat <- read.csv("BRFSS_23_sampled_stratified.csv")
# 
# joined <- left_join(strat, new_df, by= "ID")
# 
# write.csv(joined, "BRFSS_23_sampled_stratified.csv")

###########################################################################################################################
### regression analysis
###########################################################################################################################
nrow(data)
table(data$cancer)

#DEMOGRAPHICS AND VACCINE
#log_model1 <- glm(copd ~ male + race2 + bach + income1 + age4, data = data, family = binomial)
log_model1 <- glm(copd ~ male + race2 + bach + income1 + age4 + smoker + obesity + insured + urban, data = data, family = binomial)

summary(log_model1)

pR2(log_model1)

vif_values <- vif(log_model1)
print(vif_values)

#odds_ratios <- exp(coef(log_model1))
#print(odds_ratios)






