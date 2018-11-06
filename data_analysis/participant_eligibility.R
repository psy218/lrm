# ---- exclusion criteria -----
# 1. attention checks 
#' @param attn_check_1 must not choose anything
#' @param attn_check_2 must choose "2"
#' @param attn_check_3 must choose "strongly agree" (i.e., "7")

# Attention check Q1:
#' adding the columns to ensure there was no response (i.e., correct response)
#' "0" = correct response (did not choose anything); "1" = incorrect

df %>%
  dplyr::select(starts_with("attn_check_1")) %>%
  sapply(function(x) as.numeric(x)) %>%
  rowSums(na.rm = T) -> df$attn_check_1

# Participant exclusion based on the 3 criteria above
#' TODO: look into attn_check_3 why it's recorded as 10

df <- df %>%
  mutate(
    attn_check = case_when(
      attn_check_1 == 0 & 
        attn_check_2 == 2 & 
        attn_check_3 == 10 ~ "pass", 
      TRUE ~ "fail")) 

# 2. Variance in responses
# create a new variable to examine how much variance there is in 
# a participant's response (for RFQ_M items)

df %>%
  dplyr::select(starts_with("RFQ_M_"), contains("fit_"), contains("strategy_")) %>%
  apply(., 1, var) -> df$var_response

# Check if variance corresponds to the pattern seen in the responses 
# head(df[1:5, c(paste("RFQ_M", 1:15, sep="_"), "var_response")]) 

# code using the cut-off line at variance below 0.5
df <- df %>%
  mutate(var_low = case_when(
    var_response <= 0.1 ~ "low",
    TRUE ~ "acceptable"
  ))
