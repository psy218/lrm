#### setup ####
library("tidyverse"); library("here")

#### data ####
# uncomment the following lines to create a codebook
# library("QualtricsTools")
# app()

# Note: personal information (MTurkID & IPaddress) is annoymized in the "raw_data.csv"

# 0. Import data ----
df <- readr::read_csv(here("data", "raw_data.csv"), 
                      col_types = list(
                        `gender-TEXT` = col_character(),
                        `ethnicity-Middle Eastern (e.g., Afghanistan, Iran)` = col_integer(),
                        `ethnicity-Southeast Asian (e.g., Vietnam, Cambodia, Malaysia)` = col_integer(),
                        `ethnicity-Native Hawaiian or Pacific Islander` = col_integer()),
                      skip = 1)


# 1. Data cleaning ----
#' Removing unnecessary columns (e.g., instruction pages, timing)
#' Renaming variables to be machine-readable

source(here("data_analysis", "data_cleaning.R"))

# 2. Determining participant eligibility ----
#' eligibility criteria: 
#' 1) Failling 3 attention-check items 
#' 2) Duplicated responses - those who participated more than once in the study
#' 3) Low variance in response - extremely low variance in their responses

source(here("data_analysis", "participant_eligibility.R"))


# 3. Scoring items for the outcome and predicitor measures ----
#' Predictors: 
#' a) RFQ: promotion and prevention focus
#' @param promotion - promotion focus
#' @param prevention - prevention focus
#' b) condition: 2 profile-scanning conditions (i.e., desirable-trait and undesirable-trait scanning strategies)
#' @param condition effects-coded (+1 = desirable-trait condition; -1 undesirable-trait condition)

source(here::here("data_analysis", "item_scoring.R"))
