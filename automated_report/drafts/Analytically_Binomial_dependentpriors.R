# Howard Prior, variable dependent 

library(LearnBayes)

sigma <- c(2,1,0.5,0.25)
plo <- 0.0001 
phi <- 0.9999
par(mfrow=c(2,2))

# Prior 
for (i in 1:4){
  mycontour(howardprior, c(plo,phi,plo,phi), c(1,1,1,1,sigma[i]),
            main = paste("sigma=",as.character(sigma[i])), xlab="p1", ylab="p2")
}


# Likelihood 



# Posterior, data goes in 
s1 <- 162
n1 <- 18325
s2 <- 8
n2 <- 18198
for (i in 1:4){
  mycontour(howardprior, c(plo,phi,plo,phi), c(1+s1,1+(n1-s1),1+s2,1+(n2-s2),sigma[i]),
            main = paste("sigma=",as.character(sigma[i])),xlab="p1",ylab="p2", lines(c(0,1),c(0,1)))
}


# Simulate 1000 values from posterior on a grid, sigma = 2
s <- simcontour(howardprior, c(plo,phi,plo,phi), c(1+s1,1+(n1-s1),1+s2,1+(n2-s2),2), 10000) 


# Estimate relative risk 
VE <- 1-s$y/s$x
bayestestR::describe_posterior(VE, ci = 0.95)
plot(bayestestR::point_estimate(VE))
plot(bayestestR::hdi(VE, ci = c(.89, .95, .99)))
plot(bayestestR::eti(VE))


