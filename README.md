# **Exploratory Data Analysis — Presidential Polling and Results**

This repository consists of an exploratory data analysis of US presidential polling and election results, primarily examining the 2012 and 2016 elections. The project explores state-level election results and the extent of polling coverage and accuracy. This exploration identified patterns that further motivated potential research questions.

All analysis in the project was completed in R utilising the tidyverse package, ensuring that all data cleaning/wrangling was reproducible from the raw data sets.

## Project Structure

```         
EDA-Report-TICA/
├── README.md                     <- this file
├── EDA-project.qmd               <- EDA and research questions 
├── EDA-project.pdf               <- rendered EDA report in pdf format
├── .gitignore                    <- specifies files git untracks
├── EDA-Report-TICA.Rproj         
├── data/
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
├── exploratory visualisations/   <- additional visualisations developed during EDA
│   ├── average margin by state-2016 polls.png
│   ├── distribution of margins by state-2016 polls.png
│   ├── Polling margins across sampled populations in 2012.png
│   ├── Undecided voters reaching election day 2012 polls.png
│   ├── Vote share by party overtime (1974-2024).png
│   └── Winning party by state(1974-2024) (2).png
│
└── src/                          <- reproducible data cleaning/wrangling scripts
    ├── clean_2012_polls_visualisations.R
    ├── clean_2016_polls_visualisations.r
    ├── clean_1976-2024_elections_visualisations.R
    ├── clean_2012_polls.R
    ├── clean_2016_polls.r
    └── clean_1976-2024_elections.R
```

## Data

The project explores 3 data sets:

-   state_polls_2012.csv - state-level polling data for election year 2012

-   state_polls_2016.csv - state-level polling data for election year 2016

-   1976-2024-president.csv - state-level US election results spanning from 1976 to 2024

Polling data was retrieved from HuffPost Pollster via the pollstR R package as part of the rOpenGov project. The 1976-2024 election results were retrieved from the MIT Election Data and Science Lab via Harvard Dataverse. For this particular analysis, the 2012 and 2016 election results were utilised in conjunction with the corresponding polling data sets.

## Prerequisites

Ensure the following tools and software are installed before running the project:
- R (v4.0.0+)
- RStudio (v2022.07+)

Run this command in your R console to install the required packages:

`install.packages("tidyverse")`

If TinyTeX has not already been installed, do so in the RStudio Terminal: 

`quarto install tinytex`

## Reproducibility 

To reproduce the project, the below steps must be followed in order:

1.  Run this command to clone the repository:

`git clone https://github.com/TICA-STATX290-2026/EDA-Report-TICA.git`

2. Launch RStudio and open "EDA-Report-TICA.Rproj"

3. Run data cleaning scripts in "src" folder (scripts without "visualisation" as part of their name), to reproduce 3 corresponding cleaned data sets in data/clean/

- In RStudio, open and run each cleaning scripts sequentially in the src/ folder

4. Render the EDA-project.qmd file to generate the updated pdf report:

- In RStudio, open EDA-project.qmd and click the "Render" button. Note that all visualisations displayed in the EDA report are produced directly within EDA-project.qmd, available via the GitHub repository. 

## Exploratory Data Analysis 

The EDA examines patterns in election results and polling in 2012 and 2016 at a state level. It investigates changes in state election margins, the polling coverage across states during the final week before elections, and distinctions in accuracy of polls across the two election years. There is particular focus on competitive states, defined as states that have close election margins. The observations from the EDA raised further questions regarding the associations of polling accuracy with state competitiveness, polling coverage and polling characteristics.
