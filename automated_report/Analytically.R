# Beta priors, priors independent 

# Data as cell frequencies 
s1 <- 8
n1 <- 18198
s2 <- 162 
n2 <- 18325 


# Likelihood


# Prior 
alpha1 <- 2 # Flat prior
beta1 <- 2 # Flat prior
alpha2 <- 2 # Flat prior
beta2 <- 2 # Flat prior


# Product independent beta distributions  
product_beta <- function(x){
  density <- dbeta(x,s1+alpha1,(n1-s1)+beta1)*dbeta(x,s1+alpha1,(n1-s1)+beta1)
  return(density)
}


product_beta(2)


# Draw page 167


# Simulate from posterior
posterior_theta1 <- rbeta(10000,s1+alpha1,(n1-s1)+beta1)
posterior_theta2 <- rbeta(10000,s2+alpha2,(n2-s2)+beta2)


# Describe posterior estimate of the function of parameters of interest
VE <- 1-posterior_theta1/posterior_theta2
bayestestR::describe_posterior(VE, ci = 0.95)
plot(bayestestR::hdi(VE, ci = c(.89, .95, .99)))
plot(bayestestR::eti(VE))
plot(bayestestR::point_estimate(VE))