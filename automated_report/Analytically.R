library(plotly)

# Data as cell frequencies 
s1 <- 8
n1 <- 18198
s2 <- 162 
n2 <- 18325 


# Prior 
a1 <- 1/2 
b1 <- 1/2 
a2 <- 1/2 
b2 <- 1/2 


# Points for plotting
Theta1 = seq(0.001, 0.999, by=0.001) 
Theta2 = seq(0.001, 0.999, by=0.001) 


# Prior for plotting
pTheta1 = dbeta(Theta1,a1,b1)
pTheta2 = dbeta(Theta2,a2,b2) 


# Posterior for plotting
pTheta1Theta2GivenData <- matrix(data=NA, nrow=length(Theta1), ncol=length(Theta2))
for (i in 1:length(Theta1)){
  for (j in 1:length(Theta2)){
    pTheta1Theta2GivenData[i,j]<- dbeta(Theta1[i], a1+s1, b1+n1-s1)*dbeta(Theta2[j], a2+s2, b2+n2-s2)   
  }
} 

# Define likelihood for plotting


# Draw page 167
fig <- plot_ly(x = Theta1, y = Theta2, z = pTheta1Theta2GivenData) 
add_surface(fig)


# Simulate from posterior
posterior_Theta1 <- rbeta(10000,s1+a1,(n1-s1)+b1)
posterior_Theta2 <- rbeta(10000,s2+a2,(n2-s2)+b2)


# Describe posterior estimate of the function of parameters of interest
VE <- 1-posterior_Theta1/posterior_Theta2
bayestestR::describe_posterior(VE, ci = 0.95)
plot(bayestestR::hdi(VE, ci = c(.89, .95, .99)))
plot(bayestestR::eti(VE))
plot(bayestestR::point_estimate(VE))



