library(ggplot2)
library(dplyr)
library(tidybayes)
library(bayestestR)

pfizer_data <- 
  data.frame(
    y = c(rep("No", 18198 - 8), 
          rep("Yes", 8),
          rep("No", 18325 - 162),
          rep("Yes", 162)),
    s = c(rep("vaccinated", 18198),
          rep("placebo", 18325))      
  )

table(pfizer_data$s, pfizer_data$y)


modelString <- "
  model {
    
    # likelihood 
    for (i in 1:Ntotal) {
      y[i] ~ dbern(theta[s[i]])
    }
    
    # prior
    for (sIdx in 1:Nsubj) {
      theta[sIdx] ~ dbeta(2,2) 
    }
  }
  " # close quote for modelString


# Specify the data in a list, for later shipment to JAGS:
dataList = list(
  y = ifelse(pfizer_data$y == "No", 0, 1),
  s = as.integer(factor(pfizer_data$s)),
  Ntotal = nrow(pfizer_data),
  Nsubj = nlevels(factor(pfizer_data$s))
)


# JAGS 
pfizer_chains <-
  runjags::run.jags(modelString,
                    sample = 15000,
                    n.chains = 4,
                    method = "parallel",
                    monitor = "theta",
                    data = dataList)



# Results 
pfizer_results <- 
  tidybayes::tidy_draws(pfizer_chains) %>%
  select(`theta[1]`:`theta[2]`) %>%
  rename(placebo = `theta[1]`, vaccinated = `theta[2]`) %>%
  mutate(diff_rate = (placebo - vaccinated) / placebo * 100,
         placebo_pct = placebo * 100,
         vaccinated_pct = vaccinated * 100)

plot(bayestestR::hdi(pfizer_results$placebo_pct))
plot(bayestestR::hdi(pfizer_results$diff_rate, ci = c(.89, .95, .99)))
plot(bayestestR::point_estimate(pfizer_results$diff_rate))
bayestestR::describe_posterior(pfizer_results$diff_rate, ci = 0.95)


## Plot both
pfizer_results %>%
  select(placebo_pct:vaccinated_pct) %>%
  tidyr::pivot_longer(everything(), names_to = "group") %>%
  ggplot(aes(x = value, fill = group)) +
  ggdist::stat_halfeye(.width = c(0.89, 0.95),
                       alpha = .8,
                       slab_colour = "black",
                       slab_size = .5) +
  ggtitle("Infection rates for vaccine and placebo groups (N = 43,538)") +
  xlab("Infection rate") +
  scale_x_continuous(labels = scales::label_percent(scale = 1),
                     breaks = seq.int(0, .6, .1)) +
  theme(axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank())


# MCMC Diagnostics 



# Plot posterior estimate of the function of parameters of interest 
thetaDiff = results$diff
plotPost(thetaDiff, xlab=expression(theta[1]-theta[2]) , compVal=0.0 )
plot(bayestestR::hdi(results$diff))
