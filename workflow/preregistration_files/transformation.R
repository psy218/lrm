#### variable coding ####
#' @param condition profile browsing conditions
#' @param promotion 
#' @param prevention

df$condition <- dplyr::recode_factor(df$condition, "undesirable" = -1, "desirable" = 1)

