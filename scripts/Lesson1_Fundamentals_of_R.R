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
# will use their own function (e.g., read.csv, read.table, read_excel)
wq <- read.csv('./data/BoP_WQ_formatted.csv') # HINT: hit 'tab' to see a list of files in this directory

str(WQ)
#### Woah, why didn't that work?? ####
## troubleshoot the code above so that you can look at the structure of the dataframe
  # this shows us that 'date' is listed as a charater, we need to tell R that this is a date, which has a special structure

View(wq) # this opens up the dataframe to view, 
# you can also do this by clicking on your dataframe ('wq') in the Environment at right

## by looking at the structure str() of our wq dataframe, we can see that the 'date' column
## is listed as a character...no good in R! we need to tell R it is a date
# format as date
wq$date <- as.Date(wq$date)

# look at structure again: did it change?
str(wq)

# create a new column in the wq dataframe
wq$Region <- 'Bay of Plenty'

# filter the data to select just one lake, I'll pick Rotoehu
rotoehu <- wq[wq$lake=='Rotoehu',]
mean_chl <- mean(rotoehu$chla_mgm3_top)
mean_chl #### hm that says NA, which means we need to remove the NA's before we take the mean

# look at help documentation (?mean) and add the argument na.rm, then rerun the mean calculation

# now calculate the standard deviation of chl
sd_chl <- # INSERT CODE HERE
  
############
## do the same but for a different lake of your choice 

# filter to a dataframe with just one lake

# calculate the mean of one column

# calculate the standard deviation of one column

#################################################################################
# let's look at the bathymetry of the rotorua lakes

####### read in the 'Rotlakes_bathymetry.xls' file. 
# what do you need to change from read.csv() for a .xls file? talk to your neighbor, google, or ChatGPT
bathy <- # insert code to read in the bathymetry data
library(readxl)
?read_excel  
# do your columns look funny? this is because it's reading in the first row and putting the column headers in the second row
# look at the help documentation and try using the 'skip' argument to skip the first line in the file

################################################################################
# read in data of your own: select a file on your computer that you want to read in R
# move it to this project directory and read it in, naming it something different from the dataframes above

################################################################################
  