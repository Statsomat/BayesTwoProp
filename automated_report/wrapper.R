# Import libraries
library(rmarkdown)
library(data.table)
library(shiny)
library(coda)


########### CLOSE THE repot.pdf FILE BEFORE RUNNING THE WRAPPER !!!!!  ##################


#########################################################################################
# Simulate the Shiny GUI 
# The user uploads a file or inserts the cell frequencies directly 
# If both file and cell frequencies are nonempty, then the algorithms considers the file 
# Otherwise, the cell frequencies must be nonempty 
#########################################################################################

# Data as a file 
filename <- "datasets/biontech.csv" 
decimal <- "."
data <- fread(filename, header = "auto", sep ="auto", dec = decimal, encoding ="UTF-8", data.table = FALSE, na.strings = "") 
outcome <- "y" # outcome variable 
exposure <- "s" # exposure variable 
presence_outcome <- 1 # presence for the existence of the outcome 
presence_exposure <- "Vaccine" #presence for the existence of the exposure

# Data as cell frequencies 
s1 <- 8 # outcome positive
n1 <- 100 # exposed 
s2 <- 25 # outcome positive  
n2 <- 100 # not-exposed  


# User delivers the priors (are beta distributions with parameters a and b, for each Theta)
a1 <- 2 
b1 <- 2
a2 <- 2
b2 <- 2


# User selection for the function of parameters 
## Possible values: "Theta1-Theta2", "Theta1/Theta2", "1-Theta1/Theta2" 
## Use integers 1,2,3 to represent values from above 
user_selection_function_param <- 3


# Region of practical equivalence (we will learn later about it)
rope_user <- NULL 


##############################################################
# Run parametric, automatic .Rmd file 
##############################################################
rmarkdown::render("report_html.Rmd", params = list(
  filename = filename,
  decimal = decimal,
  data =data,
  data = data,
  outcome = outcome,
  exposure = exposure, 
  presence_outcome = presence_outcome,
  presence_exposure = presence_exposure,
  user_selection_function_param = user_selection_function_param,
  s1=s1,
  n1=n1,
  s2=s2,
  n2=n2,
  a1=a1,
  b1=b1,
  a2=a2,
  b2=b2
))






