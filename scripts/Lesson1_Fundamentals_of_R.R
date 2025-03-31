################################################################################
# Script for introducing Fundamentals of R for Lesson 1 with BOPRC
# Author: Whitney Woelmer
# Created: April 2025

################################################################################
# installing packages: packages provide new functions that can help us do specific
# actions in R. these will become increasingly useful as you learn more about R!

install.packages('tidyverse') # typically, R needs things to be in quotes, 
# either '' or "" if it is not a recognized object in the environment
install.packages('readxl')
# once a package in installed, you need to load in each time you open R
library(tidyverse)
library(readxl)

################################################################################
# creating objects
num_participants <- # insert number of people in the room
  
num_instructors <- # insert number of instructors in the room
  
participant_instructor_ratio <- num_participants/num_instructors

################################################################################
# reading in data: you can read in many different file formats into R and each
# will use their own function (e.g., read.csv, read.table, read_)
wq <- read.csv('./data/BoP_WQ_formatted.csv') # HINT: hit 'tab' to see a list of files in this directory

str(WQ)
#### Woah, why didn't that work?? ####
## troubleshoot the code above so that you can look at the structure of the dataframe
  # this shows us that 'date' is listed as a charater, we need to tell R that this is a date, which has a special structure

view(wq) # this opens up the dataframe to view, you can also do this by clicking on 'df' in the Environment at right

# format as date
wq$date <- as.Date(wq$date)

# look at structure again
str(wq)


####### read in the 'Rotlakes_bathymetry.xls' file. 
# what do you need to change from read.csv() for a .xls file? talk to your neighbor, google, or ChatGPT
bathy <- # insert code to read in the bathymetry data
library(readxl)
?read_excel  
# do your columns look funny? this is because it's reading in the first row and putting the column headers in the second row
# look at the help documentation and try using the 'skip' argument to skip the first line in the file

################################################################################
# read in data of your own: select a file on your computer that you want to read in R
# move it to this directory and read it in, naming it something different from the dataframes above

################################################################################
  