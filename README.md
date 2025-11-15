# SHAPE: Spatial Health and Population Estimator  
*A Spatial Microsimulation Framework for Public Health Small-Area Estimation (SAE)*  
**Programming Language:** R  
**SHAPE GIS Dashboard:** insert

**Contact:** Emma Von Hoene; Department of Geography and Geoinformation Science, George Mason University; evonhoene@gmu.edu

## Overview  

Public health decision-making—such as identifying health inequalities or targeting interventions—requires population health data at fine geographic scales. However, such *ground truth* data are often unavailable.  

**SHAPE (Spatial Health and Population Estimator)** introduces an open, reproducible, and transparent framework for **spatial microsimulation-based small-area estimation (SAE)**. Implemented entirely in R, SHAPE uses a hierarchical **Iterative Proportional Fitting (IPF)** process to integrate individual-level health surveys with spatially aggregated census data. The result is a synthetic population that preserves joint distributions of individual characteristics, enabling fine-scale health analysis.

## Key Features  

- Implements **hierarchical IPF** for multi-level microsimulation.  
- Generates **synthetic individual-level populations** aligned with sociodemographic constraints.  
- Produces **SAEs for two health behaviors and eleven health outcomes**.  
- Evaluates estimates against **CDC PLACES** and **BRFSS direct estimates**.  
- Fully **open-source, scalable, and timely** for public health applications.

## Evaluation Study Design  
**Citation:** insert

### **Health Variables**
- **Health Behaviors:** Smoking, Obesity  
- **Health Outcomes:** Cancer, Asthma, High Blood Pressure, Diabetes, COPD, Arthritis, High Cholesterol, Kidney Disease, Heart Disease, Depression, and Stroke  

### **Geographic Focus**
- **Florida (2019)** and **New York (2021)**  
- SAEs generated at **county** and **census tract** levels  

### **Methods Summary**
SHAPE uses a **two-level hierarchical IPF framework**:
1. **Level 1:** Fits BRFSS survey data to ACS demographic marginals to generate synthetic local populations and estimate smoking and obesity prevalence.  
2. **Level 2:** Incorporates Level 1 estimates to model eleven health outcomes, producing fine-scale prevalence estimates.  

## Results Summary  

- SHAPE estimates were **moderately consistent** with BRFSS direct estimates (r̄ ≈ 0.5).  
- SHAPE estimates were **highly consistent** with CDC PLACES at county (r̄ ≈ 0.8) and census tract (r̄ ≈ 0.7) levels.  
- Demonstrated flexibility and reproducibility across multiple spatial scales and survey inputs.
  
## Data Description  

All input and evaluation datasets used in SHAPE, as well SHAPE-derived SAEs are publicly available or derived from open-access sources.  

### **1. Survey Data: Behavioral Risk Factor Surveillance System (BRFSS)**  
- **Source:** CDC; 2019 and 2021 
- **Type:** Individual-level health survey data  
- **Use:** Provides individual samples with health behaviors and outcomes, as well as demographics used in the IPF-based microsimulation fitting. 

### **2. Spatially Aggregated Data: American Community Survey (ACS)**  
- **Source:** U.S. Census Bureau, 2017–2021 5-year estimates  
- **Type:** Spatially aggregated demographic data  
- **Use:** Provides marginal population totals (e.g., age, race, education, income) at county and census tract levels used in the IPF algorithm to align the survey data with local sociodemographic distributions.  

### **3. Evaluation Data: CDC PLACES**  
- **Source:** CDC 2021 and 2023 releases; for Florida (2021) and New York (2023) counties and census tracts
- **Type:** Model-based SAE estimates  
- **Use:** Benchmark dataset for evaluating SHAPE estimates at county and census tract levels.

### **4. Evaluation Data: BRFSS Direct Estimates**  
- **Source:** New York Department of Health BRFSS 2021, and Florida Health Charts BRFSS 2019
- **Type:** Direct estimates derivied from respective county-level BRFSS surveys
- **Use:** Benchmark dataset for evaluating SHAPE estimates at county levels.  

### **5. SHAPE-Derived Outputs**  
- **Level 1:** Synthetic populations and prevalence estimates for two health behaviors (e.g., smoking, obesity).  
- **Level 2:** Extended estimates for eleven health outcomes (e.g., diabetes, hypertension, depression).  
- **Format:** Excel outputs containing aggregated prevalence rates for Flordia and New York, both at counties and census tract scales.    






