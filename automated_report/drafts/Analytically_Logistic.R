library(LearnBayes)


# Dataset 
s1 <- 162
n1 <- 18325
s2 <- 8
n2 <- 18198

x = c(0, 1)
n = c(n1, n2)
y = c(s1, s2)
data = cbind(x, n, y)

# Search for rectangle to plot the posterior
response = cbind(y, n - y)
glm(response ~ x, family = binomial)

# Define prior 
beta.select(list(p=.5, x=.3), list(p=.9, x=.5))
beta.select(list(p=.5, x=.8), list(p=.9, x=.98))
prior <- rbind(c(1, 3.26+7.19, 3.26), c(0, 2.10, 2.10+0.74))
data.new <- rbind(data, prior)


# Plot posterior 
mycontour(logisticpost, c(-5,-3,-4,-2), data.new, xlab="beta0", ylab="beta1")

# Simulate from bivariate density on a grid
s <- simcontour(logisticpost, c(-5,-3,-4,-2), data.new, 10000)

# Add points 
points(s)

# Describe posterior estimate of the function of parameters of interest
VE <- 1-exp(s$y)
bayestestR::describe_posterior(VE, ci = 0.95)
plot(bayestestR::hdi(VE, ci = c(.89, .95, .99)))
plot(bayestestR::eti(VE))
plot(bayestestR::point_estimate(VE, centrality="Median"))

