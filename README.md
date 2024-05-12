# NMC Synthetic Data Creation & Exploration

# Project Overview
This project is developed by Michelle K Jamieson to demonstrate the process of generating synthetic datasets based on a predefined schema of nursing and midwifery council (NMC) registration data. The synthetic data aims to replicate the variability and characteristics of actual data while ensuring privacy and confidentiality.

# Repository Contents
R Scripts: Contains the scripts for generating synthetic data using the simstudy and tidyverse libraries.
Data Dictionary: Describes each variable included in the synthetic dataset.
Synthetic Datasets: Sample outputs of the synthetic data generation process.
Analysis Examples: Scripts demonstrating how to perform basic data analysis on the synthetic datasets, including survival analysis and time-to-event analysis.

# Key Features
Data Schema Definition: Includes demographic identifiers, registration details, employment information, and more.
Synthetic Data Generation: Utilizes distributions and characteristics defined in the simstudy library to generate data that mimics real-world registration datasets.
Privacy Preservation: Ensures that the synthetic data does not contain any real-world identifiable information, making it suitable for public sharing and analysis.

# Creating the Synthetic Dataframe
The synthetic dataset for this project was created using the simstudy and tidyverse libraries in R. Data definitions were established using defData for attributes like demographic identifiers and registration details, each with specified distribution types to emulate realistic data patterns. The dataset was then generated with the genData function, transforming numerical values into actual dates and setting factor levels for categorical variables to ensure interpretability. This method produced a detailed and realistic synthetic dataset while maintaining privacy and confidentiality.

# The Freetext Postcode Issue
The "Postcode to Output Area" (postcode to OA) linkage is a method used to map postcodes to smaller geographic units called Output Areas (OAs). Output Areas are the smallest geographical unit for which census data is released in the UK, making them crucial for detailed spatial analysis and demographic research.

## Key Features of Postcode to OA Linkage:
Granular Mapping: Links each postcode to a corresponding Output Area, facilitating fine-grained geographic analyses.
Census Integration: Enables the integration of detailed demographic, social, and economic data from the census with any dataset that includes postcode information.
Versatility in Applications: Useful in a wide range of fields including public health, urban planning, marketing, and more, by allowing data to be displayed and analyzed at a small-area geographical level.

## How It Works:
Data Source: The linkage relies on a dataset provided by the UK's Office for National Statistics (ONS), which regularly updates the linkages between postcodes and Output Areas.
Geocoding: Postcodes are geocoded to find their geographical coordinates (latitude and longitude).
Assignment to OAs: Based on these coordinates, each postcode is assigned to an Output Area that spatially contains the postcode's location.

## Usage:
This linkage is particularly useful for researchers and analysts who need to:

Aggregate individual-level data to Output Areas for statistical analysis or reporting.
Analyze spatial patterns and trends at a detailed level without compromising the confidentiality of individual data.
Combine different datasets through a common geographical identifier, enhancing the richness and utility of the data.
The "Postcode to Output Area" linkage is a fundamental tool in geographical and demographic research in the UK, bridging the gap between raw data and actionable geographic intelligence.

# Usage
To generate synthetic data:

Clone this repository.
Run the provided R scripts in an environment with R and the necessary packages installed.
Modify the data generation parameters as needed to customize the output.

# Dependencies
R
tidyverse
simstudy
lubridate

