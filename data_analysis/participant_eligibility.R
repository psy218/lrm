# ---- exclusion criteria -----
# 1. attention checks 
#' @param attn_check_2 must choose "2"

df <- df %>%
  mutate(
    attn_check = case_when(
      attn_check_2 == 2 ~ "pass", 
      TRUE ~ "fail")) 

# 2. Variance in responses
# create a new variable to examine how much variance there is in 
# a participant's response (for RFQ_M items)

df %>%
  dplyr::select(starts_with("RFQ_M_")) %>%
  apply(., 1, var) -> df$var_response

# Check if variance corresponds to the pattern seen in the responses 
# head(df[1:5, c(paste("RFQ_M", 1:15, sep="_"), "var_response")]) 

# code using the cut-off line at variance below 0.5
df <- df %>%
  mutate(var_low = case_when(
    var_response <= 0.1 ~ "low",
    TRUE ~ "acceptable"
  ))
