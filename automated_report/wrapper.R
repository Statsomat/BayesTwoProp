# Import libraries
library(rmarkdown)
library(data.table)
library(shiny)


##############################################################
# Simulate the Shiny GUI 
##############################################################
filename <- "datasets/testfile.csv"
decimal <- "."
data <- fread(filename, header = "auto", sep ="auto", dec = decimal, 
              encoding ="UTF-8", data.table = FALSE, na.strings = "")
outcome <- "y"
level <- 1

 

##############################################################
# Run parametric, automatic .Rmd file 
##############################################################
rmarkdown::render("report.Rmd", params = list(
  filename = filename,
  decimal = decimal,
  data = data,
  level = level,
  outcome = outcome
))

############################################## end of program ########################################################################





