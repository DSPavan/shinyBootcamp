
library("survival")
library("survminer")

data("lung")
head(lung)
View(lung)


fit <- survfit(Surv(time, status) ~ ph.ecog, data = lung)
print(fit)

# confidenc eiNtervel 95%
summary(fit)

# Access to the sort summary table
summary(fit)


d <- data.frame(time = fit$time,
                n.risk = fit$n.risk,
                n.event = fit$n.event,
                n.censor = fit$n.censor,
                surv = fit$surv,
                upper = fit$upper,
                lower = fit$lower
)
head(d)


# Change color, linetype by strata, risk.table color by strata
ggsurvplot(fit)

# Change color, linetype by strata, risk.table color by strata
ggsurvplot(fit,
           pval = TRUE, conf.int = TRUE,
           #cumcensor = TRUE,
           #cumevents = TRUE,
           #risk.table = TRUE, # Add risk table
           #risk.table.col = "strata", # Change risk table color by groups
           linetype = "strata", # Change line type by groups
           surv.median.line = "hv", # Specify median survival
           ggtheme = theme_bw(), # Change ggplot2 theme
           palette = c("red", "blue" ,"orange","black"))


#cumulative
ggsurvplot(fit,
           conf.int = TRUE,
           risk.table.col = "strata", # Change risk table color by groups
           ggtheme = theme_bw(), # Change ggplot2 theme
           palette = c("#E7B800", "#2E9FDF"),
           fun = "event")


#res.sum <- surv_summary(fit)
#res.sum

# Log-Rank test comparing survival curves: survdiff()
# fit <- survfit(Surv(time, status) ~ sex, data = lung)
surv_diff <- survdiff(Surv(time, status) ~ sex, data = lung)
surv_diff


# Cox Proportional-Hazards Model
res.cox <- coxph(Surv(time, status) ~ sex, data = lung)
res.cox
summary(res.cox)

# exp(coef) 

# multi variate
res.cox <- coxph(Surv(time, status) ~ ph.karno + sex + ph.ecog, data =  lung)
summary(res.cox)

#factor(lung$ph.ecog)

# summarize analysis
covariates <- c("age", "sex",  "ph.karno", "ph.ecog", "wt.loss")

univ_formulas <- sapply(covariates,
                        function(x) as.formula(paste('Surv(time, status)~', x)))


univ_models <- lapply( univ_formulas, function(x){coxph(x, data = lung)})
#print(univ_models)
# Extract data 
univ_results <- lapply(univ_models,
                       function(x){ 
                         x <- summary(x)
                         p.value<-signif(x$wald["pvalue"], digits=2)
                         wald.test<-signif(x$wald["test"], digits=2)
                         beta<-signif(x$coef[1], digits=2);#coeficient beta
                         HR <-signif(x$coef[2], digits=2);#exp(beta)
                         HR.confint.lower <- signif(x$conf.int[,"lower .95"], 2)
                         HR.confint.upper <- signif(x$conf.int[,"upper .95"],2)
                         HR <- paste0(HR, " (", 
                                      HR.confint.lower, "-", HR.confint.upper, ")")
                         res<-c(beta, HR, wald.test, p.value)
                         names(res)<-c("beta", "HR (95% CI for HR)", "wald.test", 
                                       "p.value")
                         return(res)
                         #return(exp(cbind(coef(x),confint(x))))
                       })
res <- t(as.data.frame(univ_results, check.names = FALSE))
as.data.frame(res)







