library(rmarkdown)
library(stringr)
library(scales)
library(ggforce)
library(forcats)
library(stringr)
library(ggrepel)
library(tidyverse)
library(knitr)
library(kableExtra)
library(urbnthemes)

table1 <- read.csv(file="Tables/StateFactSheetData_521.csv", header=TRUE, sep=",")
table1[2:53, 2:84]  <- as.numeric(table1[2:53, 2:84])
datdict <- read.csv(file="Tables/State Uninsurance WRA Data Dictionary_227.csv", header=TRUE, sep=",")

index <- as.character(table1[['statename']])
#index <- as.character("Wisconsin")

# create a data frame with parameters and output file names
runs <- tibble(
  filename = str_c(index, ".pdf"),             # creates a string with output file names in the form <index>.pdf
  params = map(index, ~list(parameter1 = .)))  # creates a nest list of parameters for each object in the index

# iterate render() along the tibble of parameters and file names
runs %>%
  select(output_file = filename, params) %>%
  pwalk(rmarkdown::render, input = "simple-factsheet-working.Rmd", output_dir = "factsheets")

