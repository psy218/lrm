
#### RFQ_M ####
# prevention focus
df %>%
  select(as.array(paste("RFQ_M", 1:7, sep="_"))) %>%
  # psych::alpha(check.keys = T) 
  rowMeans(na.rm = T) -> df$prevention

# promotion focus
df %>%
  select(as.array(paste("RFQ_M", 8:15, sep="_"))) %>%
  # psych::alpha(check.keys = T)
  rowMeans(na.rm = T) -> df$promotion

#### Strategy condition ####
df$condition <- dplyr::recode_factor(df$condition, "undesirable" = -1, "desirable" = 1)

#### Regulatory fit outcomes ####
# df %>%
#   ungroup() %>%
#   mutate(overall_engagement_4 = 8 - overall_engagement_4,
#          overall_ease_2 = 8 - overall_ease_2,
#          overall_ease_3 = 8 - overall_ease_3,
#          overall_ease_5 = 8 - overall_ease_5,
#          overall_success_4 = 8 - overall_success_4,
#          overall_success_4 = 8 - overall_success_4) %>%
#   select(starts_with("overall_"), -exclusion) %>%
#   rowMeans(na.rm = T) -> df$overall_measure

# 1a. Engagement while viewing profiles
df %>%
  mutate(overall_engagement_4 = 8 - overall_engagement_4) %>%
  select(starts_with("overall_engagement_")) %>%
  # psych::alpha(check.keys = T)
  rowMeans(na.rm = T) -> df$fit_engage

# 1b. Ease of use
df %>%
  mutate(overall_ease_2 = 8 - overall_ease_2,
         overall_ease_3 = 8 - overall_ease_3,
         overall_ease_5 = 8 - overall_ease_5) %>%
  select(starts_with("overall_ease_")) %>%
  # psych::alpha(check.keys = T)
  rowMeans(., na.rm = T) -> df$fit_ease

# 1c. Perceived success
df %>%
  mutate(overall_success_4 = 8 - overall_success_4) %>%
  select(starts_with("overall_success_")) %>%
  # psych::alpha(check.keys = T)
  rowMeans(., na.rm = T) -> df$fit_success

# 1d. Partner evaluation
df %>%
  select(starts_with("overall_partner_")) %>%
  # psych::describe()
  # psych::alpha(check.keys = T)
  rowMeans(., na.rm = T) -> df$fit_partner

#### Strategy-specific outcomes ####
# NOTE: qualtrics recoded strategy-specific items to range from 4 - 10 as opposed to 1 - 7
df <- df %>%
  mutate_at(vars(starts_with("strategy_")), 
                 funs(recode(., `4` = 1, `5` = 2, `6` = 3, `7` = 4,
                                                  `8` = 5, `9` = 6, `10` = 7))) 

# 
# df %>%
#   ungroup() %>%
#   mutate(strategy_engagement_3 = 8 - strategy_engagement_3,
#          strategy_ease_3 = 8 - strategy_ease_3,
#          strategy_ease_4 = 8 - strategy_ease_4) %>%
#   select(starts_with("strategy_")) %>%
#   rowMeans(na.rm = T) -> df$strategy_measure

# 2a. Strategy engagement
df %>%
  mutate(strategy_engagement_3 = 8 - strategy_engagement_3) %>%
  select(starts_with("strategy_engagement_")) %>%
  # psych::describe()
  # psych::alpha(check.keys = T)
  rowMeans(na.rm = T) -> df$fit_strategy_engage

# 2b. Strategy's ease of use
df %>%
  mutate(strategy_ease_3 = 8 - strategy_ease_3,
         strategy_ease_4 = 8 - strategy_ease_4) %>%
  select(starts_with("strategy_ease_")) %>%
  # psych::describe()
  # psych::alpha(check.keys = T)
  rowMeans(na.rm = T) -> df$fit_strategy_ease

# 2c. Perceived success using the strategy

df %>%
  select(starts_with("strategy_success_")) %>%
  # psych::alpha(check.keys = T)
  # psych::describe()
  rowMeans(na.rm = T) -> df$fit_strategy_success


#### Profile browsing outcomes ####
# the site participants used 
df$site_choice <- factor(df$site_choice,
                         levels = 1:3,
                         labels = c("okc", "pof", "eharm"))

# gender
df$gender <- factor(df$gender, 
                    levels = 0:2,
                    labels = c("female", "male", "other"))

# condition
# 0 = undesirable; 1 = desirable
df <- df %>% 
  mutate_at("condition", funs(recode(., `-1` = 0, `1` = 1)))
