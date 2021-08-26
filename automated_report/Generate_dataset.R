# Generate dataset and file biontech.csv
s1 <- 8
n1 <- 18198
s2 <- 162 
n2 <- 18325 
y <- c(rep(1,s1), rep(0,n1-s1), rep(1,s2), rep(0,n2-s2))
s <- c(rep("Vaccine",n1), rep("Placebo",n2))
dataset <- data.frame(y,s)
write.csv(dataset,"biontech.csv")


