
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


# gender
df$gender <- factor(df$gender, 
                    levels = 0:2,
                    labels = c("female", "male", "other"))

# condition
# 0 = undesirable; 1 = desirable
df <- df %>% 
  mutate_at("condition", funs(recode(., `-1` = 0, `1` = 1)))
