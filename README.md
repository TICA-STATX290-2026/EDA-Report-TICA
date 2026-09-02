# **Exploratory Data Analysis — Presidential Polling and Results**

This repository consists of an exploratory data analysis of US presidential polling and election results, primarily examining the 2012 and 2016 elections. The project explores state-level election results and the extent of polling coverage and accuracy. This exploration identified patterns that further motivated potential research questions.

All analysis in the project was completed in R utilising the tidyverse package, ensuring that all data cleaning/wrangling was reproducible from the raw data sets.

## Project Structure

```         
EDA-Report-TICA/
├── README.md                     <- this file
├── EDA-project.qmd               <- EDA and research questions 
├── EDA-project.html              <- rendered EDA report 
├── EDA-Report-TICA.Rproj         
└── data/
│   ├── raw/                      <- original data sets 
│   │   ├── state_polls_2012.csv
│   │   ├── state_polls_2016.csv
│   |   └── 1976-2024-president.csv
│   │ 
│   └── clean/                    <- cleaned data created using cleaning scripts  
│       ├── state_polls_2012_clean.csv
│       ├── state_polls_2016_clean.csv
│       └── 1976-2024-president-clean.csv
│
└── src/                          <- reproducible data cleaning/wrangling scripts  
    ├── clean_2012_polls.R
    ├── clean_2016_polls.R
    └── clean_1976-2024_elections.R
```

## Data 

The project explores 3 data sets:

-   state_polls_2012.csv - state-level polling data for election year 2012

-   state_polls_2016.csv - state-level polling data for election year 2016

-   1976-2024-president.csv - state-level US election results spanning from 1976 to 2024

Polling data was retrieved from HuffPost Pollster via the pollstR R package as part of the rOpenGov project. The 1976-2024 election results were retrieved from the MIT Election Data and Science Lab via Harvard Dataverse. For this particular analysis, the 2012 and 2016 election results were utilised in conjunction with the corresponding polling data sets.

## Reproducibility 

The 3 original data sets in data/raw/ are unchanged. The cleaning and wrangling process is implemented via the R scripts that can be found in src/, and generates the corresponding cleaned data sets found in data/clean/.

To reproduce the project, the below steps must be followed in order:

1.  Clone/download repository
2.  Open the project EDA-Report-TICA.Rproj in RStudio
3.  Run the 3 scripts located in src/ folder to reproduce 3 corresponding cleaned data sets in data/clean/
4.  Render EDA-project.qmd to reproduce the EDA report.

## Exploratory Data Analysis 

The EDA examines patterns in election results and polling in 2012 and 2016 at a state level. It investigates changes in state election margins, the polling coverage across states during the final week before elections, and distinctions in accuracy of polls across the two election years. There is particular focus on competitive states, defined as states that have close election margins. The observations from the EDA raised further questions regarding the associations of polling accuracy with state competitiveness, polling coverage and polling characteristics.
