#---- variable names -----
#' renaming variables to be machine-readable (e.g., removing spaces)
# ethnicity
df <- df %>%
  rename_at (vars(starts_with("ethnicity-")), 
             funs(paste("ethnicity", sep = "_", 1:11)))


# ---- removing unnecessary columns ----
# df <- df %>%
#   dplyr::select(-starts_with("instruction"), # instructions
#                 -starts_with("Timing"), # time participants stayed on a page
#                 -contains("Location")) # location data

# ---- recoding manually inputted answers ----
# gender
df %>%
  filter(gender==2) %>%
  select(gender, `gender-TEXT`)

# ethnicity
df %>%
  mutate(ethnicity_11 = tolower(ethnicity_11)) %>%
  filter(ethnicity_10==1) %>%
  select(ethnicity_10, ethnicity_11)

## text answers to lower cases
df <- df %>%
  mutate_at(vars(ethnicity_11), tolower)

## recode as Caucasian those who said "white" but indicated their ethnicity to be other
df$ethnicity_1[df$ethnicity_11=="white"] <- 1

