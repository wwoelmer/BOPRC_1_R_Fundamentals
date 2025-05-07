BOPRC R Tutorial 1 - Fundamentals of R
================
Whitney Woelmer
2025-05-07

## Getting started with R

The main packages that are used in this tutorial are:

- **tidyverse**
- **readxl**

Before attempting to install these packages, make sure your Primary CRAN
Repository is set to:

- “New Zealand \[https\] - University of Auckland”.

To check this, click ‘Tools’ –\> ‘Global Options’ –\> ‘Packages’. Click
‘Change’ if you need to adjust this.

You can download most packages by clicking on the ‘Install’ button on
the ‘packages’ tab in the lower right window pane. Then in the Install
Packages popup, select ‘Repository (CRAN)’ from the ‘Install from’ drop
box and type the name of the package you wish to download (e.g., dplyr). 

You can also install packages directly using code.

``` r
install.packages('tidyverse') # typically, R needs things to be in quotes, 
# either '' or "" if it is not a recognized object in the environment
install.packages('readxl')

```
Once all packages are installed you can load them using the ‘library’
function:

``` r
# once a package in installed, you need to load in each time you open R, 
# but don't need to reinstall
library(tidyverse)
library(readxl)
```

You can check if you have loaded your package by clicking on the ‘Packages’ tab, 
and navigate to the package name you just loaded. There should be a check next
to it if it has been loaded properly. If you don't see the package at all,
that means it has not been installed.

# Create objects

Objects can be created in R using the assign <- or equal = sign keys

```r
num_participants <- # insert number of people in the room
  
num_instructors <- # insert number of instructors in the room
  
participant_instructor_ratio <- num_participants/num_instructors
```

# Read in data, understand data classes, plot data, create new column 

You can read in many different file formats into R and each
will use their own function (e.g., read.csv, read.table, read_excel) depending
on the file type

## Checking working directories

To read in files, you need to tell R where to look for the file. You can check
where R is looking by checking your working directory

``` r
getwd()
```

Running `getwd()` tells you *where* your working directory is located. Since we 
are using a project, your working directory will be where you put your project 
on your computer. If you don't use a project, you will need to set a 
working directory using `setwd()` However, I DO NOT recommend setting working 
directories for reproducibility reasons. Projects are the best way to organize 
your files. But see other resources about this if desired: https://rpubs.com/em_/wdInR

Now that we know our working directory, let's read in the data

```r
wq <- read.csv('./data/BoP_WQ_formatted.csv') # HINT: hit 'tab' to see a list of files in this directory
View(wq) # this opens up the dataframe to view, 
# you can also do this by clicking on your dataframe ('wq') in the Environment at right
```

## Dataframe structure
Now that we've read in our data, let's look at its structure. 

```r
str(WQ)
```
Woah, why didn't that work?? 
Troubleshoot the code and rerun so that you can look at the structure of the dataframe

Now that we've looked at the structure of the `wq` dataframe, this shows us that
the first three columns are of the character (chr) class, including `wq$date` 
But R has a specific data class for dates so we need to tell R that this is a date

```r
wq$date <- as.Date(wq$date)
```

Another formal class in R is a POSIXct object, which include date and time.
Because datetimes are often in UTC, we will use as.POSIXct() to specify the 
time zone and ensure the right date

In this case, we will create a new column called 'datetime' which store both date
and time zone ETC/GMT+12

```r
wq$datetime <- as.POSIXct(wq$date, tz = "ETC/GMT+12")
```

Now that we've set the `date` column as class date and created a new column of class
POSIXct, let's look at the structure again

```r
str(wq)
```

Another data class we may want to use is 'factor'. in wq, lake is listed as a character
which means the different values have no particular order, and will appear alphabetically.
Let's say we wanted to order them by increasing max depth

```r
wq$lake <- factor(wq$lake, levels = c('Rotoehu', 'Rerewhakaaitu', 'Okaro',
                                      'Tikitapu', 'Rotokakahi', 'Okareka',
                                      'Rotorua', 'Okataina', 'Rotoma',
                                      'Tarawera', 'Rotoiti', 'Rotomahana'))
```

Now look at the structure of `wq$lake` again: is lake a factor or character?

```r
str(wq)
```

## Plotting data
Now let's plot the `wq` data using the `ggplot` system. `ggplot` requires a 
dataframe (here, `wq`), and then the aesthetics or `aes()`. This tells it what 
to put on the x-axis and the y-axis. We have also told it to color the points 
based on the column `site`.

```r
ggplot(wq, aes(x = as.Date(date), y = DRP_mgm3_top, color = site)) + 
  geom_point() + # this tells R how to "map" the data: in this case, use points
  facet_wrap(~lake, scales = 'free') + # this makes a different panel for each lake, where the scale of both axes are different for each lake
  theme_bw() # this sets a 'theme' for how the plot looks, this is the 'black and white' setting
```
