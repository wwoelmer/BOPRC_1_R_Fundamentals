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
# once a package in installed, you need to load in each time you open R, 
# but don't need to reinstall
library(tidyverse)
library(readxl)

################################################################################
# creating objects
num_participants <- # insert number of people in the room
  
num_instructors <- # insert number of instructors in the room
  
participant_instructor_ratio <- num_participants/num_instructors

################################################################################
###### read in data, understand data classes, plot data, create new column #####

# you can read in many different file formats into R and each
# will use their own function (e.g., read.csv, read.table, read_excel)

getwd() # this tells you *where* your working directory is located
        # since we are using a project, it will be where you put your
        # project on your computer
        # if you don't use a project, you will need to set a working directory (setwd())
        ### NOTE: I DO NOT recommend setting working directories for reproducibility
        ### reasons. Projects are the best way to organize your files. But see other
        ### resources about this if desired: https://rpubs.com/em_/wdInR

wq <- read.csv('./data/BoP_WQ_formatted.csv') # HINT: hit 'tab' to see a list of files in this directory
View(wq) # this opens up the dataframe to view, 
# you can also do this by clicking on your dataframe ('wq') in the Environment at right

# now that we've read in our data, let's look at its structure. 
str(WQ)
#### Woah, why didn't that work?? ####
## troubleshoot the code so that you can look at the structure of the dataframe
  # this shows us that 'date' is listed as a charater, we need to tell R that this is a date, which has a special structure

## by looking at the structure str() of our wq dataframe, we can see that 
# the first three columns are 'chr' or character, including the 'date' column
# ...no good in R! We need to tell R to recognize this as a formal 'date' class
# format as date
wq$date <- as.Date(wq$date)

# another formal class in R is a POSIXct object, which include date and time
# because datetimes are often in UTC, we will use as.POSIXct() to specify the 
# time zone and ensure the right date

# in this case, we will create a new column called 'datetime' which store both dat
# and time zone ETC/GMT+12
wq$datetime <- as.POSIXct(wq$date, tz = "ETC/GMT+12")

# look at structure again: what is the class of datetime
str(wq)

# another data class we may want to use is 'factor'. in wq, lake is listed as a character
# which means the different values have no particular order, and will appear alphabetically
# let's say we wanted to order them by increasing max depth
wq$lake <- factor(wq$lake, levels = c('Rotoehu', 'Rerewhakaaitu', 'Okaro',
                                      'Tikitapu', 'Rotokakahi', 'Okareka',
                                      'Rotorua', 'Okataina', 'Rotoma',
                                      'Tarawera', 'Rotoiti', 'Rotomahana'))

# now look at the structure again: is lake a factor or character?
str(wq)

# now let's plot the data
# ggplot requires a dataframe (here, 'wq'), and then the aesthetics or aes()
# this tells it what to put on the x-axis and the y-axis
# we have also told it to color the points based on the column 'site'
ggplot(wq, aes(x = as.Date(date), y = DRP_mgm3_top, color = site)) + 
  geom_point() + # this tells R how to "map" the data: in this case, use points
  facet_wrap(~lake, scales = 'free') + # this makes a different panel for each lake, where the scale of both axes are different for each lake
  theme_bw() # this sets a 'theme' for how the plot looks, this is the 'black and white' setting


################################################################################
###### subset data, plot data, calculate summary statistics, write a csv #######

# subset the data to select just one lake, I'll pick Rotoehu
rotoehu <- wq[wq$lake=='Rotoehu',] # the == means: look for an exact match
  # this uses the base R notation of subset via brackets and indexing [rows, columns]
  # here, we are saying take the dataframe wq
  # then in brackets, we subset. here, we are saying keep only the rows where 
  # column 'lake' equals 'Rotoehu'. then we have a comma, and nothing after it,
  # which means keep all of the columns

# a more intuitive way to subset dataframe is to use the tidyverse filter()
rotoehu <- wq %>%  # this symbol is called a pipe, you can read it as 'whereby'
  filter(lake=='Rotoehu') # here we say filter out every row where the lake column
                          # equals 'Rotoehu' (remember R is sensitive to capitals)

#### let's plot the data using ggplot
# ggplot requires a dataframe (here, 'rotoehu'), and then the aesthetics or aes()
# this tells it what to put on the x-axis and the y-axis
ggplot(rotoehu, aes(x = as.Date(date), y = chla_mgm3_top)) + 
  geom_point() +
  theme_bw()

# `Now, modify the code above to plot a different variable in the rotoehu dataframe
## INSERT CODE

# now let's save this subsetted data as a csv file. First, we will bring up the 
#help documentation for the function `write.csv()` so we can see what information
#(called arguments) the function needs us to input
?write.csv # bring up the help documentation

# Based on the help documentation, we can see there are lots of arguments, but most
# of them have defaults. The information that R needs to know includes `x`, which is
# the object we are exporting (in this case, the dataframe `rotoehu`), `file` which
# corresponds to the the location where we want to save the file (in this case, './data/rotoehu_wq.csv'), 
# and we want to set the argument `row.names = FALSE` so that the file isn't written with
# an extra column naming the rows

write.csv(rotoehu, # this is the object we want to export
          file = './data/rotoehu_wq.csv',  # the . means go from the working directory, 
          row.names = FALSE) # which is our project directory (check getwd() to clarify)
                             # then we are writing inside the 'data' folder
                             # and can call the file whatever we want, with the 
                             # .csv extension. here, I've named it 'rotoehu_wq_2000_2021.csv
                             # the row.names should be set as FALSE
                             # to avoid having an extra column in the csv file which lists the row number


# now that we've subset our data, let's calculate some summary statistics and save 
# them as a new object
mean_chl <- mean(rotoehu$chla_mgm3_top)
mean_chl

# Hmmm that says the `mean_chl` is `NA`. Look at the `rotoehu` dataframe: are all the
# chla values NA? No...which means there must be some NA's in there which have thrown
# R off. We need to remove the NA's before we take the mean. Look at help 
# documentation (?mean) and read about the `na.rm` argument. We need to add the 
# argument na.rm, then rerun the mean calculation

# look at help documentation (?mean) and add the argument na.rm, then rerun the mean calculation

# now calculate the standard deviation of chl
sd_chl <- # INSERT CODE HERE
  
# calculate one other summary statistic of interest and insert the code below
#### INSERT CODE HERE  

###### repeat the above but subset for a different condition of your choice #####

# subset the wq dataframe using either indexing or filter() 
# some suggestions include: subset to lakes with high DRP, subset to a different lake, 
# subset the data within a certain time period, etc. With R, the world is your oyster!!
### INSERT CODE HERE

# plot the data
### INSERT CODE HERE

# calculate three summary statistics
### INSERT CODE HERE

# write the dataframe as a csv inside the data folder in this project
### INSERT CODE HERE

################################################################################
############### Read in an excel file ##############################

# Now we will build on our experience using `read.csv()` to use a different function
# to read in an excel file
####### read in the 'Rotlakes_bathymetry.xls' file. 
# what do you need to change from read.csv() for a .xls file? talk to your neighbor, google, or ChatGPT

# First, we will load the library and bring up the help documentation to understand 
# more about the function
library(readxl)
?read_excel 
bathy <- # insert code to read in the bathymetry data
 
# do your columns look funny? this is because it's reading in the first row and putting the column headers in the second row
# look at the help documentation and try using the 'skip' argument to skip the first line in the file

################################################################################
##### HOMEWORK/IN CLASS: repeat the exercise above using data of your own ######
# select a file on your computer that you want to read in R
# move it to this project directory and read it in as a new object using either 
# `read.csv()` or `read_excel()`. Let us know if you have a different file type and need help.

# look at structure, format dates or factors if necessary

# create a new column

# plot the data

# subset the data in some way

# calculate three summary statistics

