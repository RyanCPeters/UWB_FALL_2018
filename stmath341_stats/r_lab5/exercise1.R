DOC = "
The data
........
We consider real estate data from the city of Ames, Iowa. The details of every real estate transaction in Ames is 
recorded by the City Assessor's office. Our particular focus for this lab will be all residential home sales in Ames 
between 2006 and 2010. This collection represents our population of interest. In this lab we would like to learn 
about these home sales by taking smaller samples from the full population. Let's load the data.

  download.file('http://www.openintro.org/stat/data/ames.RData', destfile = 'ames.RData')
  load('ames.RData')

We see that there are quite a few variables in the data set, enough to do a very in-depth analysis. For this lab, 
we'll restrict our attention to just two of the variables: the above ground living area of the house in square 
feet (Gr.Liv.Area) and the sale price (SalePrice). To save some effort throughout the lab, create two variables
with short names that represent these two variables.

  area <- ames$Gr.Liv.Area
  price <- ames$SalePrice

Let's look at the distribution of area in our population of home sales by calculating a few summary statistics 
and making a histogram.

  summary(area)
  hist(area)

====================================================================================================================
Exercise 1:
Describe this population distribution.
====================================================================================================================
"

script_num = 1
script_intro(paste("Exercise",script_num))

# script body goes here




script_outro(paste("Exercise",script_num))