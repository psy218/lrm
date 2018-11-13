#### library ####
library("lavaan")

#### Promotion model ####
prom.model <- '
# covariance
engage ~~ ease

# regressions
engage ~ a11*prom.c + a21*condition + a31*prom_cond
ease ~ a12*prom.c + a22*condition + a32*prom_cond 
success ~ b1*engage + b2*ease + c1*prom.c   

# b1a3
prom.engage := b1 * a31
prom.ease := b2 * a32

## undesirable condition
unde.engage.prom := a11 + a31 * -0.5
unde.ease.prom := a12 + a32 * -0.5

## desirable condition
desi.engage.prom := a11 + a31 * 0.5
desi.ease.prom := a12 + a32 * 0.5

## moderated mediation
prom.engage.unde := a11 * b1 + prom.engage * -0.5
prom.engage.desi := a11 * b1 + prom.engage * 0.5
prom.ease.unde := a12 * b2 + prom.ease * -0.5
prom.ease.desi := a12 * b2 + prom.ease * 0.5
'

summary(prom_model.fit <- sem(prom.model, 
                              data = subset(df, exclusion == "eligible"), 
                              se = "bootstrap", bootstrap=1000),
        standardized = TRUE, fit.measures = TRUE)

lavaan::parameterestimates(prom_model.fit, boot.ci.type = "bca.simple", standardized = T) %>%
  as.tibble() %>%
  filter(op==":=")

#### Prevention model ####
prev.model <- '
  # covariance
engage ~~ ease

# regressions
engage ~ a11*prev.c + a21*condition + a31*prev_cond
ease ~ a12*prev.c + a22*condition + a32*prev_cond
success ~ b1*engage + b2*ease + c1*prev.c   

# b1a3
prev.engage := b1 * a31
prev.ease := b2 * a32

## undesirable condition
unde.engage.prev := a11 + a31 * -0.5
unde.ease.prev := a12 + a32 * -0.5

## desirable condition
desi.engage.prev := a11 + a31 * 0.5
desi.ease.prev := a12 + a32 * 0.5

## moderated mediation
prev.engage.unde := a11 * b1 + prev.engage * -0.5
prev.engage.desi := a11 * b1 + prev.engage * 0.5
prev.ease.unde := a12 * b2 + prev.ease * -0.5
prev.ease.desi := a12 * b2 + prev.ease * 0.5
'

summary(prev_model.fit <- sem(prev.model, 
                              data = subset(df, exclusion=="eligible"), 
                              se = "bootstrap", bootstrap=1000),
        standardized = T, fit.measures = T)

parameterestimates(prev_model.fit, boot.ci.type = "bca.simple", standardized = T) %>%
  as.tibble() %>%
  filter(op==":=")
