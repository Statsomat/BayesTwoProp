library(plotly)
library(bayestestR)

#############################################################################
#### User Input from Shiny GUI###############################################
#############################################################################


# Data as cell frequencies 
s1 <- 21
n1 <- 938812
s2 <- 6 
n2 <- 938812 


# Priors are beta distributions with parameters a and b (for each Theta)
a1 <- 1/2 
b1 <- 1/2 
a2 <- 1/2 
b2 <- 1/2 


# User selection for the function of parameters 
## Possible values: "Theta1-Theta2", "Theta1/Theta2", "1-Theta1/Theta2" 
## Use integers to represent values from above 
user_selection_function_param <- 1  


# Region of practical equivalence 
rope_user <- NULL 

#############################################################################
#############################################################################
#############################################################################




# Draw page 167 
## Range for plotting
Theta1 = seq(0.001, 0.999, by=0.001) 
Theta2 = seq(0.001, 0.999, by=0.001) 


## Priors for plotting 
pTheta1 = dbeta(Theta1,a1,b1)
pTheta2 = dbeta(Theta2,a2,b2) 


## Posterior for plotting
pTheta1Theta2GivenData <- matrix(data=NA, nrow=length(Theta1), ncol=length(Theta2))
for (i in 1:length(Theta1)){
  for (j in 1:length(Theta2)){
    pTheta1Theta2GivenData[i,j]<- dbeta(Theta1[i], a1+s1, b1+n1-s1)*dbeta(Theta2[j], a2+s2, b2+n2-s2)   
  }
} 

## Define likelihood for plotting


## Generate and include the plot as a png 
fig <- plot_ly(x = Theta1, y = Theta2, z = pTheta1Theta2GivenData, type = "surface") 



# Posterior 
## Simulate from posterior
posterior_Theta1 <- rbeta(10000,s1+a1,(n1-s1)+b1)
posterior_Theta2 <- rbeta(10000,s2+a2,(n2-s2)+b2)


## Function of parameters of interest
if (user_selection_function_param == 3) {
  estimate <- 1-posterior_Theta1/posterior_Theta2
} else if (user_selection_function_param == 2){
  estimate <- posterior_Theta1/posterior_Theta2  
} else {
  estimate <- posterior_Theta1-posterior_Theta2  
}


## Describe posterior in a table 
if (is.null(rope_user)==TRUE){
  describe_posterior(estimate, ci = 0.95, centrality="all", dispersion=TRUE, test=NULL)
} else {
  describe_posterior(estimate, ci = 0.95, centrality="all", dispersion=TRUE, test="rope", rope_range = rope_user)
}



## Display graphical posterior information
### Use bayestestR package 
plot(hdi(estimate, ci = c(.89, .95, .99)))
plot(eti(estimate))


## Use the plotPost function (page 205 Kruschke)



# Plot both in percent
Theta1pct <- posterior_Theta1*100
Theta2pct <- posterior_Theta2*100
results <- data.frame(Theta1pct,Theta2pct)
results %>%
  tidyr::pivot_longer(everything(), names_to = "group") %>%
  ggplot(aes(x = value, fill = group)) +
  ggdist::stat_halfeye(.width = c(0.89, 0.95),
                       alpha = .8,
                       slab_colour = "black",
                       slab_size = .5) +
  ggtitle("xxx") +
  xlab("xlael") +
  scale_x_continuous(labels = scales::label_percent(scale = 1),
                     breaks = seq.int(0, 1, .1)) +
  theme(axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank())

