# SHAPE: Spatial Health and Population Estimator  
***A Spatial Microsimulation Framework for Public Health Synthetic Population Generation and Small-Area Estimation (SAE)***  
**Programming Language:** R  
**SHAPE GIS Web App:** *Interactively explore SHAPE’s estimates, and visualize health outcomes and behaviors across space and time* - https://tinyurl.com/SHAPE-GIS
**OSF Data Repository:** https://doi.org/10.17605/OSF.IO/XN4G8 

**Contact:** Emma Von Hoene (evonhoen@gmu.edu) and Taylor Anderson (tander6@gmu.edu); Department of Geography and Geoinformation Science, George Mason University

## Overview  

Public health decision-making—such as identifying health inequalities or targeting interventions—requires population health data at fine geographic scales. However, such *ground truth* data are often unavailable.  

**SHAPE (Spatial Health and Population Estimator)** introduces an open-source, reproducible, and transparent framework that relies on publicly available data  for **spatial microsimulation-based synthetic populations and small-area estimation (SAE)**. Implemented entirely in R, SHAPE uses a hierarchical **Iterative Proportional Fitting (IPF)** process to integrate individual-level health surveys with spatially aggregated census data. The result is a synthetic population that preserves joint distributions of individual characteristics, enabling spatial aggregation to obtain SAEs. This data allows for fine-scale health analysis and  supports downstream applications, such as Agent-Based Modeling, for further exploring disease dynamics or testing policy scenarios.

### **Methods Summary**
SHAPE uses a **two-level hierarchical IPF framework**:
1. **Level 1:** Fits BRFSS survey data to ACS demographic marginals to generate synthetic local populations and estimate smoking and obesity prevalence.  
2. **Level 2:** Incorporates Level 1 estimates to model eleven health outcomes, producing fine-scale prevalence estimates.

## **Health Variables Generated with SHAPE**
- **Health Behaviors:** Smoking, Obesity  
- **Health Outcomes:** Cancer, Asthma, High Blood Pressure, Diabetes, COPD, Arthritis, High Cholesterol, Kidney Disease, Heart Disease, Depression, and Stroke  

## Repository Structure and Data Organization

This GitHub repository contains materials from **two distinct SHAPE studies**, organized into separate folders to support transparency, reproducibility, and reuse. A third folder is also included, which holds several **R scripts** for pre-processing the input data, generating  synthetic populations with SHAPE's Level 1 and 2 framework, and post-processing the synthetic populations.

### **1. SHAPE Evaluation Study**
This study systematically evaluated SHAPE-generated SAEs across multiple health behaviors/outcomes, spatial and temporal settings, and spatial scales by comparing them to benchmark datasets (CDC PLACES and BRFSS direct estimates).

- **Folder:** `SHAPE_Evaluation/`
- **Contents:**
  - All **input datasets** used (BRFSS - Surveys from 2019 and 2021, and ACS - Spatially Aggregated Sociodemographics from 2017-2021 Five Year Estimates)
  - All **SHAPE-generated SAE outputs** used in the evaluation (Florida - 2019, and New York - 2021- at both county and census tract scales)
  - All **evaluation datasets** (CDC PLACES - 2019 and 2021 releases at county and census tract levels, and BRFSS direct estimates - county level from New York Department of Health BRFSS 2021, and Florida Health Charts BRFSS 2019)

This folder fully supports the analyses presented in the following SHAPE evaluation manuscript.  
**Citation:** Von Hoene, E., Gupta, A., Kavak, H., Roess, A., & Anderson, T. (2025). Evaluation of A Spatial Microsimulation Framework for Small-Area Estimation of Population Health Outcomes Using the Behavioral Risk Factor Surveillance System. arXiv preprint arXiv:2510.22080.
**Link**: https://arxiv.org/abs/2510.22080. 

### **2. SHAPE Data Release (2023–2024)**
SHAPE was also used to generate **national synthetic populations and small-area estimates (SAEs)** for recent years, intended as a reusable public data product.

- **Folder:** `SHAPE_Data_Release/`
- **Years Covered:** 2023 and 2024
- **Contents:**
  - **Input data** used to generate national synthetic populations (BRFSS - Surveys from 2023 and 2024, and ACS - Spatially Aggregated Sociodemographics from 2019-2023 Five Year Estimates)
  - **Output datasets**, including:
    - National synthetic populations (individuals aged 18+)*
    - SAEs (county and census tract scale)

These datasets are provided as a standalone data release for downstream research and policy applications. 
* Due to large file sizes, both the 2023 and 2024 synthetic population dataset is provided at: https://doi.org/10.17605/OSF.IO/XN4G8. 

### **3. SHAPE R Scripts and Computational Framework**

This folder contains all **core R scripts** used to implement SHAPE, process input data, generate synthetic populations, produce small-area estimates, and perform validation or post-processing analyses. These scripts support both the SHAPE evaluation study and the national SHAPE data releases.
- **Folder:** `R Scripts/`

*SHAPE development was supported by the National Science Foundation Award No. 2109647 and 2302970.*



