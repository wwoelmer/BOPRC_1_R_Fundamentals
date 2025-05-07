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

