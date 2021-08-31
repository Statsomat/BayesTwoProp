# Import libraries
library(rmarkdown)
library(data.table)
library(shiny)





##############################################################
# Simulate the Shiny GUI 
# At least the cell frequencies must be nonempty 
# If both file and cell ferquencies are nonempty, then one considers the file 
##############################################################

# Data as a file 
filename <- "datasets/testfile.csv"
decimal <- "."
#data <- fread(filename, header = "auto", sep ="auto", dec = decimal, encoding ="UTF-8", data.table = FALSE, na.strings = "")
outcome <- "y"
exposure <- "s"
level <- 1


# Data as cell frequencies 
s1 <- 21
n1 <- 938812
s2 <- 6 
n2 <- 938812 


# Priors (are beta distributions with parameters a and b, for each Theta)
a1 <- 1/2 
b1 <- 1/2 
a2 <- 1/2 
b2 <- 1/2 


# User selection for the function of parameters 
## Possible values: "Theta1-Theta2", "Theta1/Theta2", "1-Theta1/Theta2" 
## Use integers to represent values from above 
user_selection_function_param <- 2  


# Region of practical equivalence (we will learn later about it)
rope_user <- NULL 





##############################################################
# Run parametric, automatic .Rmd file 
##############################################################
rmarkdown::render("report.Rmd", params = list(
  filename = filename,
  decimal = decimal,
  data = data,
  outcome = outcome,
  exposure = exposure, 
  level = level

))
