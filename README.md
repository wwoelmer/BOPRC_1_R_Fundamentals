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
Once all packages are installed you can load them using the `library()`
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

## Creating objects

Objects can be created in R using the assign <- or equal = sign keys

```r
num_participants <- # insert number of people in the room
  
num_instructors <- # insert number of instructors in the room
  
participant_instructor_ratio <- num_participants/num_instructors
```

## Read in data, understand data classes, plot data, calculate summary statistics 

You can read in many different file formats into R and each
will use their own function (e.g., read.csv, read.table, read_excel) depending
on the file type

### Checking working directories

To read in files, you need to tell R where to look for the file. You can check
where R is looking by checking your working directory

``` r
getwd()
```

Running `getwd()` tells you *where* your working directory is located. Since we 
are using a project, your working directory will be where you put your project 
on your computer. If you don't use a project, you will need to set a 
working directory using `setwd()`. However, I DO NOT recommend setting working 
directories for reproducibility reasons. If someone else wanted to run my code,
they won't have a `C:/Users/wwoelmer/Desktop/uni_files/` folder and will have to
re-write the code to their own local directory...this causes lots of headaches.
Projects are the best way to organize your files. But see other resources about 
this if desired: https://rpubs.com/em_/wdInR

Now that we know our working directory, let's read in the data

```r
wq <- read.csv('./data/BoP_WQ_formatted.csv') # HINT: hit 'tab' to see a list of files in this directory
View(wq) # this opens up the dataframe to view, 
# you can also do this by clicking on your dataframe ('wq') in the Environment at right
```

### Dataframe structure
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

### Plotting data
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

## Subset data, plot data, calculate summary statistics, write a csv

We are now going to learn to subset data. Here, let's subset the `wq` dataframe
to select just one lake, I'll pick Rotoehu. Below is an example of subsetting
using the base functions in R

```r
rotoehu <- wq[wq$lake=='Rotoehu',] # the == means: look for an exact match
  # this uses the base R notation of subset via brackets and indexing [rows, columns]
  # here, we are saying take the dataframe wq
  # then in brackets, we subset. here, we are saying keep only the rows where 
  # column 'lake' equals 'Rotoehu'. then we have a comma, and nothing after it,
  # which means keep all of the columns
```


A more intuitive way to subset dataframe is to use the `tidyverse` function `filter()`

```r
rotoehu <- wq %>%  # this symbol is called a pipe, you can read it as 'whereby'
  filter(lake=='Rotoehu') # here we say filter out every row where the lake column
                          # equals 'Rotoehu' (remember R is sensitive to capitals)
```

Using our subsetted dataframe `rotoehu`, let's plot the data using ggplot

```r
ggplot(rotoehu, aes(x = as.Date(date), y = chla_mgm3_top)) + 
  geom_point() +
  theme_bw()
```

Now, modify the code above to plot a different variable in the rotoehu dataframe

```r
## INSERT CODE
```

### Writing a .csv file
Now let's save this subsetted data as a new csv file. First, we will bring up the 
help documentation for the function `write.csv()` so we can see what information
(called arguments) the function needs us to input

```r
?write.csv # bring up the help documentation
```

Based on the help documentation, we can see there are lots of arguments, but most
of them have defaults. The information that R needs to know includes what object we
are exporting `rotoehu`, the location where we want to save the file (called `file`), 
and we want to set the argument `row.names = FALSE` so that the file isn't written with
an extra column naming the rows

```r
write.csv(rotoehu, # this is the object we want to export
          file = './data/rotoehu_wq.csv',  # the . means go from the working directory, 
          row.names = FALSE) # which is our project directory (check getwd() to clarify)
                             # then we are writing inside the 'data' folder
                             # and can call the file whatever we want, with the 
                             # .csv extension. here, I've named it 'rotoehu_wq_2000_2021.csv
                             # the row.names should be set as FALSE
                             # to avoid having an extra column in the csv file which lists the row number
```

### Calculating summary statistics
Now that we've subset our data, let's calculate some summary statistics and save 
them as a new object

```r
mean_chl <- mean(rotoehu$chla_mgm3_top)
mean_chl #### hm that says NA, which means we need to remove the NA's before we take the mean
```
Hmmm that says the `mean_chl` is `NA`. Look at the `rotoehu` dataframe: are all the
chla values NA? No...which means there must be some NA's in there which have thrown
R off. We need to remove the NA's before we take the mean. Look at help 
documentation (?mean) and read about the `na.rm` argument. We need to add the 
argument na.rm, then rerun the mean calculation

```r
## INSERT CODE TO CALCULATE MEAN USING na.rm
```

What is the mean chla in Rotoehu?

Now calculate the standard deviation of chl

```r
sd_chl <- # INSERT CODE HERE
```

Now calculate one other summary statistic of your choice and insert the code below

```r
#### INSERT CODE HERE  
```

Repeat the above but subset for a different condition of your choice 

```r
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
```

## Read in an excel file 
Now we will go from our experience using `read.csv()` to read in an excel file. 
Specifically, read in the 'Rotlakes_bathymetry.xls' file. Think about: what do 
you need to change from `read.csv()` for a .xls file? Talk to your neighbor, google, or ChatGPT

First, we will load the library and bring up the help documentation to understand 
more about the function
```r
library(readxl)
?read_excel 
```

```r
bathy <- # insert code to read in the bathymetry data
```

Do your columns look funny? That might be because it's reading in the first row 
and putting the column headers in the second row. Look at the help documentation 
and try using the 'skip' argument to skip the first line in the file

```r
bathy <- # insert updated code to read bathymetry data using the `skip` argument
```

## HOMEWORK/IN CLASS: repeat the exercise above using data of your own 
Select a file on your computer that you want to read in R. Move it to this 
project directory and read it in as a new object using either `read.csv()` or
`read_excel()`. Let us know if you have a different file type.

```r
# INSERT CODE TO READ IN FILE

# look at structure, format dates or factors if necessary

# create a new column

# plot the data

# subset the data in some way

# calculate three summary statistics

```



