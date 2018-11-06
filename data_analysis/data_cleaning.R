#---- variable names -----
#' renaming variables to be machine-readable (e.g., removing spaces)
# attention check Q1
df <- df %>%
  rename_at( vars(starts_with("attn_check_1-")), funs(paste("attn_check_1", sep = "_", 1:7)))
  
# ethnicity
df <- df %>%
  rename_at (vars(starts_with("ethnicity-")), 
             funs(paste("ethnicity", sep = "_", 1:11)))

# activity
df <- df %>%
rename_at (vars(starts_with("activity-")), 
           funs(paste("activity", sep = "_", 1:8)))

# ---- removing unnecessary columns ----
df <- df %>%
  dplyr::select(-starts_with("instruction"), # instructions
                -starts_with("Timing"), # time participants stayed on a page
                -starts_with("trait-${e://Field/condition}"), # qualitative text data
                -contains("Location")) # location data
