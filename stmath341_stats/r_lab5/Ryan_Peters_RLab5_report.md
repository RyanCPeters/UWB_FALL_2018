RLab5 report
================
Ryan Peters

-   [Exercises](#exercises)
    -   [Exercise 1:](#exercise-1)
    -   [Exercise 2:](#exercise-2)
    -   [Exercise 3:](#exercise-3)
    -   [Exercise 4:](#exercise-4)
    -   [Exercise 5:](#exercise-5)
    -   [Exercise 6:](#exercise-6)
-   [On your own](#on-your-own)
    -   [On Your Own 1:](#on-your-own-1)
    -   [On Your Own 2:](#on-your-own-2)
    -   [On Your Own 3:](#on-your-own-3)
    -   [On Your Own 4:](#on-your-own-4)
-   [Disclaimers and such](#disclaimers-and-such)

Exercises
=========

------------------------------------------------------------------------

``` r
# pkgload is a custom script that's defined inside of the shared_lab_utils folder
pkgload(c("devtools","crayon","utils"))
```

    ## Loading required package: devtools

    ## Loading required package: crayon

``` r
# Instead of forcing the script to reload the dataframe every time we run it, 
# lets do a quick check to see if it's already been instantiated from a 
# previsou run first
df_name <- 'ames'
if (exists(df_name)) is.data.frame(get(df_name)) else{
  download.file('http://www.openintro.org/stat/data/ames.RData', destfile = 'ames.RData')
  load('ames.RData')
}
```

``` r
area <- ames$Gr.Liv.Area
price <- ames$SalePrice
# getmode(vector) is a custom function defined in prep_script
area_mode <- area[which.max(tabulate(match(unique(area),area)))]
price_mode <- price[which.max(tabulate(match(unique(price),price)))]
```

``` r
sumry <- summary(area)
sumry["mode"] <- area_mode
print(sumry)
```

Min. 1st Qu. Median Mean 3rd Qu. Max. mode 334 1126 1442 1500 1743 5642 1656

``` r
hist_with_labels(area, border="yellow", col="dodgerblue", las=1, xlab="area")
```

List of 6 $ breaks : num \[1:13\] 0 500 1000 1500 2000 2500 3000 3500 4000 4500 ... $ counts : int \[1:12\] 6 433 1184 905 274 102 17 4 2 1 ... $ density : num \[1:12\] 4.10e-06 2.96e-04 8.08e-04 6.18e-04 1.87e-04 ... $ mids : num \[1:12\] 250 750 1250 1750 2250 2750 3250 3750 4250 4750 ... $ xname : chr "x" $ equidist: logi TRUE - attr(\*, "class")= chr "histogram" ![](Ryan_Peters_RLab5_report_files/figure-markdown_github/area-histogam-1.png)

### Exercise 1:

**Describe this population distribution.**

This is a right-skewed (aka right-tailed) distribution, with a mean of 1500 ft<sup>2</sup> and a median of 1442 ft<sup>2</sup>.

Jump to [Table of Contents](#top)

------------------------------------------------------------------------

``` r
samp1 <- sample(area, 50)
hist_with_labels(samp1, border="dodgerblue", col="yellow", las=1, xlab="area for sample population of 50")
```

List of 6 $ breaks : int \[1:6\] 500 1000 1500 2000 2500 3000 $ counts : int \[1:5\] 8 17 15 7 3 $ density : num \[1:5\] 0.00032 0.00068 0.0006 0.00028 0.00012 $ mids : num \[1:5\] 750 1250 1750 2250 2750 $ xname : chr "x" $ equidist: logi TRUE - attr(\*, "class")= chr "histogram" ![](Ryan_Peters_RLab5_report_files/figure-markdown_github/samp1-1.png)

### Exercise 2:

**Describe the distribution of this sample. How does it compare to the distribution of the population?**

It still appears to be right skewed, but it is definitly closer to a normal distribution than the total population Jump to [Table of Contents](#top)

------------------------------------------------------------------------

``` r
mean(samp1)
```

\[1\] 1575.82

``` r
samp2 <- sample(area, 50)
mean(samp2)
```

\[1\] 1433.06

### Exercise 3:

**Take a second sample, also of size 50, and call it samp2.**

**How does the mean of samp2 compare with the mean of samp1?**

It is definetly different, but it's hard to say if that's purely due to chance or the distribution of the population.

**Suppose we took two more samples, one of size 100 and one of size 1000. Which would you think would provide a more accurate estimate of the population mean?**

Jump to [Table of Contents](#top)

------------------------------------------------------------------------

``` r
sample_means50 <- rep(NA, 5000)

for(i in 1:5000){
  samp <- sample(area, 50)
  sample_means50[i] <- mean(samp)
}

hist_with_labels(sample_means50, text_col = "black", border="orange", col="magenta3", las=1, xlab="example means5 for sample populations of 50")
```

List of 6 $ breaks : int \[1:13\] 1250 1300 1350 1400 1450 1500 1550 1600 1650 1700 ... $ counts : int \[1:12\] 12 59 318 897 1358 1237 733 290 73 20 ... $ density : num \[1:12\] 0.000048 0.000236 0.001272 0.003588 0.005432 ... $ mids : num \[1:12\] 1275 1325 1375 1425 1475 ... $ xname : chr "x" $ equidist: logi TRUE - attr(\*, "class")= chr "histogram" ![](Ryan_Peters_RLab5_report_files/figure-markdown_github/unnamed-chunk-2-1.png)

``` r
hist_with_labels(sample_means50, text_col = "black", border="orange3", col="magenta3", las=1,breaks = 25)
```

List of 6 $ breaks : int \[1:13\] 1250 1300 1350 1400 1450 1500 1550 1600 1650 1700 ... $ counts : int \[1:12\] 12 59 318 897 1358 1237 733 290 73 20 ... $ density : num \[1:12\] 0.000048 0.000236 0.001272 0.003588 0.005432 ... $ mids : num \[1:12\] 1275 1325 1375 1425 1475 ... $ xname : chr "x" $ equidist: logi TRUE - attr(\*, "class")= chr "histogram" ![](Ryan_Peters_RLab5_report_files/figure-markdown_github/unnamed-chunk-3-1.png)

### Exercise 4:

**How many elements are there in sample\_means50? Describe the sampling distribution, and be sure to specifically note its center. Would you expect the distribution to change if we instead collected 50,000 sample means?**

Jump to [Table of Contents](#top)

------------------------------------------------------------------------

``` r
sample_means50 <- rep(NA, 5000)

samp <- sample(area, 50)
sample_means50[1] <- mean(samp)

samp <- sample(area, 50)
sample_means50[2] <- mean(samp)

samp <- sample(area, 50)
sample_means50[3] <- mean(samp)

samp <- sample(area, 50)
sample_means50[4] <- mean(samp)
```

``` r
sample_means50 <- rep(NA, 5000)

for(i in 1:5000){
  samp <- sample(area, 50)
  sample_means50[i] <- mean(samp)
  # print(i)
}
```

### Exercise 5:

**To make sure you understand what you've done in this loop, try running a smaller version. Initialize a vector of 100 zeros called sample\_means\_small. Run a loop that takes a sample of size 50 from area and stores the sample mean in sample\_means\_small, but only iterate from 1 to 100. Print the output to your screen (type sample\_means\_small into the console and press enter). How many elements are there in this object called sample\_means\_small? What does each element represent?**

Jump to [Table of Contents](#top)

------------------------------------------------------------------------

``` r
hist_with_labels(sample_means50, text_col = "black", border="red2", col="cyan", las=1)
```

List of 6 $ breaks : int \[1:12\] 1250 1300 1350 1400 1450 1500 1550 1600 1650 1700 ... $ counts : int \[1:11\] 3 49 278 858 1352 1278 778 298 86 14 ... $ density : num \[1:11\] 0.000012 0.000196 0.001112 0.003432 0.005408 ... $ mids : num \[1:11\] 1275 1325 1375 1425 1475 ... $ xname : chr "x" $ equidist: logi TRUE - attr(\*, "class")= chr "histogram" ![](Ryan_Peters_RLab5_report_files/figure-markdown_github/sample_means50-1.png)

``` r
sample_means10 <- rep(NA, 5000)
sample_means100 <- rep(NA, 5000)

for(i in 1:5000){
  samp <- sample(area, 10)
  sample_means10[i] <- mean(samp)
  samp <- sample(area, 100)
  sample_means100[i] <- mean(samp)
}
```

``` r
par(mfrow = c(3, 1),
    oma = c(0,0,0,0) + 1,
    mar = c(0,1,2,1) + 1)

xlimits <- range(sample_means10)

# hist(sample_means10, breaks = 20, xlim = xlimits)
hist_with_labels(sample_means10, text_col = "yellow", breaks = 20, xlim = xlimits, border="gray", col="dodgerblue", las=1)
```

List of 6 $ breaks : int \[1:13\] 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 ... $ counts : int \[1:12\] 15 76 389 907 1238 1118 715 344 137 40 ... $ density : num \[1:12\] 0.00003 0.000152 0.000778 0.001814 0.002476 ... $ mids : num \[1:12\] 1050 1150 1250 1350 1450 1550 1650 1750 1850 1950 ... $ xname : chr "x" $ equidist: logi TRUE - attr(\*, "class")= chr "histogram"

``` r
# hist(sample_means50, breaks = 20, xlim = xlimits)
hist_with_labels(sample_means50, text_col = "yellow", border="gray", col="dodgerblue", las=1)
```

List of 6 $ breaks : int \[1:12\] 1250 1300 1350 1400 1450 1500 1550 1600 1650 1700 ... $ counts : int \[1:11\] 3 49 278 858 1352 1278 778 298 86 14 ... $ density : num \[1:11\] 0.000012 0.000196 0.001112 0.003432 0.005408 ... $ mids : num \[1:11\] 1275 1325 1375 1425 1475 ... $ xname : chr "x" $ equidist: logi TRUE - attr(\*, "class")= chr "histogram"

``` r
# hist(sample_means100, breaks = 20, xlim = xlimits)
hist_with_labels(sample_means100, text_col = "yellow", breaks = 20, xlim = xlimits, border="gray", col="dodgerblue", las=1)
```

List of 6 $ breaks : int \[1:20\] 1300 1320 1340 1360 1380 1400 1420 1440 1460 1480 ... $ counts : int \[1:19\] 1 2 4 18 62 172 321 516 687 801 ... $ density : num \[1:19\] 0.00001 0.00002 0.00004 0.00018 0.00062 0.00172 0.00321 0.00516 0.00687 0.00801 ... $ mids : num \[1:19\] 1310 1330 1350 1370 1390 1410 1430 1450 1470 1490 ... $ xname : chr "x" $ equidist: logi TRUE - attr(\*, "class")= chr "histogram" ![](Ryan_Peters_RLab5_report_files/figure-markdown_github/sample_means10-1.png)

### Exercise 6:

**When the sample size is larger, what happens to the center? What about the spread?**

Jump to [Table of Contents](#top)

=====

On your own
===========

So far, we have only focused on estimating the mean living area in homes in Ames. Now you'll try to estimate the mean home price.

### On Your Own 1:

**Take a random sample of size 50 from price. Using this sample, what is your best point estimate of the population mean?**

``` r
price_sample <- sample(price, 50)
hist_with_labels(price_sample, 
                 border="white", 
                 col="blue1", 
                 las=1, 
                 xlab="property prices for sample population of size = 50",
                 main="Histogram for\nsingle sample population of 50 samples")
```

List of 6 $ breaks : int \[1:9\] 50000 100000 150000 200000 250000 300000 350000 400000 450000 $ counts : int \[1:8\] 3 13 18 8 2 2 2 2 $ density : num \[1:8\] 1.2e-06 5.2e-06 7.2e-06 3.2e-06 8.0e-07 8.0e-07 8.0e-07 8.0e-07 $ mids : num \[1:8\] 75000 125000 175000 225000 275000 325000 375000 425000 $ xname : chr "x" $ equidist: logi TRUE - attr(\*, "class")= chr "histogram" ![](Ryan_Peters_RLab5_report_files/figure-markdown_github/unnamed-chunk-6-1.png)

``` r
smry <- summary(price_sample)
cat("My best point estimate for the population mean is the sample mean: ***",smry[[4]],"***\n",sep="")
```

My best point estimate for the population mean is the sample mean: ***192753.2***

Jump to [Table of Contents](#top)

### On Your Own 2:

**Since you have access to the population, simulate the sampling distribution for x-bar for price data by taking 5000 samples from the population of size 50 and computing 5000 sample means.**

**Store these means in a vector called sample\_means50.**

**Plot the data, then describe the shape of this sampling distribution.**

**Based on this sampling distribution, what would you guess the mean home price of the population to be?**

**Finally, calculate and report the population mean.**

``` r
 sample_means50 <- range(5000)
for(i in 0:5000){
   sample_means50[i] <- mean(sample(price,50))
}

hist_with_labels( sample_means50, 
                  border="white", 
                  col="blue1", 
                  las=1, 
                  xlab= "property value averages from sample populations of size = 50",
                  main="Histogram of means for\n50k sample populations of 50 samples a pieace")
```

List of 6 $ breaks : int \[1:19\] 140000 145000 150000 155000 160000 165000 170000 175000 180000 185000 ... $ counts : int \[1:18\] 2 5 19 86 246 456 756 859 869 696 ... $ density : num \[1:18\] 8.00e-08 2.00e-07 7.60e-07 3.44e-06 9.84e-06 ... $ mids : num \[1:18\] 142500 147500 152500 157500 162500 ... $ xname : chr "x" $ equidist: logi TRUE - attr(\*, "class")= chr "histogram" ![](Ryan_Peters_RLab5_report_files/figure-markdown_github/unnamed-chunk-7-1.png)

``` r
smry_50k <- summary( sample_means50)

cat("The distribution is approximately normal, maybe slightly skewed to the rigt still\nFrom the histogram, I would estimate the mean home price to be approximately $180k\nThe calculated mean of 50k means on sample populations of 50... is: ***",smry_50k[[4]],"***\n",sep="")
```

The distribution is approximately normal, maybe slightly skewed to the rigt still From the histogram, I would estimate the mean home price to be approximately $180k The calculated mean of 50k means on sample populations of 50... is: ***180757.1***

Jump to [Table of Contents](#top)

### On Your Own 3:

**Change your sample size from 50 to 150, then compute the sampling distribution using the same method as above, and store these means in a new vector called sample\_means150.**

**Describe the shape of this sampling distribution, and compare it to the sampling distribution for a sample size of 50.**

**Based on this sampling distribution, what would you guess to be the meansale price of homes in Ames?**

``` r
sample_means150 <- range(5000)
for(i in 0:5000){
   sample_means150[i] <- mean(sample(price,150))
}

hist_with_labels( sample_means150, 
                  border="white", 
                  col="blue1", 
                  las=1, 
                  xlab= "property value averages from sample populations of size = 150",
                  main="Histogram of means for\n50k sample populations of 150 samples a pieace")
```

List of 6 $ breaks : int \[1:11\] 155000 160000 165000 170000 175000 180000 185000 190000 195000 200000 ... $ counts : int \[1:10\] 1 21 166 729 1373 1473 862 304 62 9 $ density : num \[1:10\] 4.00e-08 8.40e-07 6.64e-06 2.92e-05 5.49e-05 ... $ mids : num \[1:10\] 157500 162500 167500 172500 177500 ... $ xname : chr "x" $ equidist: logi TRUE - attr(\*, "class")= chr "histogram" ![](Ryan_Peters_RLab5_report_files/figure-markdown_github/unnamed-chunk-8-1.png)

``` r
smry_150k <- summary( sample_means150)

cat("The distribution is approximately normal, though it is much less skewed than the sample size of only 50\nFrom the histogram, I would estimate the mean home price to be approximately $182k\nThe calculated mean of 50k means  on sample populations of 150... is: ***",smry_150k[[4]],"***\n",sep="")
```

The distribution is approximately normal, though it is much less skewed than the sample size of only 50 From the histogram, I would estimate the mean home price to be approximately $182k The calculated mean of 50k means on sample populations of 150... is: ***180754.1***

Jump to [Table of Contents](#top)

### On Your Own 4:

**Of the sampling distributions from 2 and 3, which has a smaller spread?**

``` r
cat("The larger sample population has the smaller spread")
```

The larger sample population has the smaller spread **If we're concerned with making estimates that are more often close to the true value, would we prefer a distribution with a large or small spread?**

``` r
price_summary <- summary(price)
true_mean <- price_summary[[4]]
winner_winner_chicken_dinner = "Neither sample size has a clear advantage"
if(abs(smry_50k[[4]]-true_mean) < abs(smry_150k[[4]]-true_mean)){
  # the smaller sample size is closer to the true mean
  winner_winner_chicken_dinner = "The smaller sample size appears to yield results closer to the population parameter mean"
} else if(abs(smry_50k[[4]]-true_mean) < abs(smry_150k[[4]]-true_mean)){
  # the larger sample size is closer to the true mean
  winner_winner_chicken_dinner = "The larger sample size appears to yield results closer to the population parameter mean"
}
```

I believe we would want a distribution with a narrower spread as it will more consistently provide an approximation that is reliably close to the true mean.

After comparing samples against the true mean, it appears that the results are: *The smaller sample size appears to yield results closer to the population parameter mean*

Jump to [Table of Contents](#top)

Disclaimers and such
====================

This is a product of OpenIntro that is released under a Creative Commons Attribution-ShareAlike 3.0 Unported.

This lab was written for OpenIntro by Andrew Bray and Mine Çetinkaya-Rundel.
