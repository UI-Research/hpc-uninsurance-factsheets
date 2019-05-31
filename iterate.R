library(rmarkdown)
library(stringr)
library(tidyverse)

table1 <- read.csv(file="Tables/StateFactSheetData_521.csv", header=TRUE, sep=",")
datdict <- read.csv(file="Tables/State Uninsurance WRA Data Dictionary.csv", header=TRUE, sep=",")

table1_smallstate <- table1 %>%
  filter(small==1)

table1_largestate <- table1 %>%
  filter(small==0)
# create an index
# index <- c("Alabama")

index_smallstate <- as.character(table1_smallstate[['statename']])

# create a data frame with parameters and output file names
runs_smallstate <- tibble(
  filename = str_c(index_smallstate, ".pdf"),             # creates a string with output file names in the form <index>.pdf
  params = map(index_smallstate, ~list(parameter1 = .)))  # creates a nest list of parameters for each object in the index

# iterate render() along the tibble of parameters and file names
runs_smallstate %>%
  select(output_file = filename, params) %>%
  pwalk(rmarkdown::render, input = "simple-factsheet-smallstate.Rmd", output_dir = "factsheets")

# create an index
# index <- c("Alabama")
index_largestate <- as.character(table1_largestate[['statename']])

# create a data frame with parameters and output file names
runs_largestate <- tibble(
  filename = str_c(index_largestate, ".pdf"),             # creates a string with output file names in the form <index>.pdf
  params = map(index_largestate, ~list(parameter1 = .)))  # creates a nest list of parameters for each object in the index

# iterate render() along the tibble of parameters and file names
runs_largestate %>%
  select(output_file = filename, params) %>%
  pwalk(rmarkdown::render, input = "simple-factsheet-largestate.Rmd", output_dir = "factsheets")
